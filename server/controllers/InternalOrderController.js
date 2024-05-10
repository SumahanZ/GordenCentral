const { where, Op } = require("sequelize");
const { models } = require("../models");
const bcrypt = require("bcryptjs");
const { format } = require('date-fns');
const sequelize = require("../utils/db.js");
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    fetchAllCustomerOrders: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan ID pengguna ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada dalam tabel pengguna tidak cocok dengan tipe peran yang diberikan" });
            }

            const internalFound = await existingUser.getInternal({ transaction: t })

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            const toko = await internalFound.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const foundOrders = await models.order.findAll({
                where: {
                    tokoId: toko.id,
                },
                include: [{
                    model: models.orderstatus,
                    as: "status",
                }, {
                    model: models.orderitem,
                    as: "items",
                    include: [{
                        model: models.productcombination,
                        as: "combination",
                        include: [{
                            model: models.produksize,
                            as: "size"
                        }, {
                            model: models.produkcolor,
                            as: "color"
                        }, {
                            model: models.produk,
                            as: "product",
                            include: [{
                                model: models.promo,
                            }, {
                                model: models.toko,
                            }]
                        }]
                    }, {
                        model: models.order
                    }]
                }, {
                    model: models.customer,
                    include: [{
                        model: models.address,
                        include: {
                            model: models.city,
                            as: "city",
                            include: {
                                model: models.province,
                                as: "province"
                            }
                        }
                    }, {
                        model: models.user,
                        as: "user"
                    }]
                }, {
                    model: models.toko,
                }],
                order: [
                    ['createdAt', 'ASC']
                ],
                transaction: t
            })

            var needToBeRemovedOrders = []
            var filteredOrders = []

            for (const order of foundOrders) {
                const timeDifference = Date.now() - order.createdAt;
                if ((timeDifference > (24 * 60 * 60 * 1000)) && order.status === "Unpaid") {
                    needToBeRemovedOrders.push(order);
                } else {
                    filteredOrders.push(order);
                }
            }

            for (const removedOrder of needToBeRemovedOrders) {
                await removedOrder.destroy({ transaction: t });
            }

            const joinedCodes = needToBeRemovedOrders.map(e => '#' + e.code).join(', ');

            if (needToBeRemovedOrders.length > 0 && joinedCodes.length > 0) {
                await models.tokonotification.create({
                    description: `Pesanan ${joinedCodes} telah dihapus pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                    tokoId: toko.id,
                    typeId: 2,
                }, { transaction: t })
            }

            await t.commit();

            const mappedFoundOrders = filteredOrders.map(e => e.toJSON())

            return res.status(200).json(mappedFoundOrders);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchOrderStasuses: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan ID pengguna ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada dalam tabel pengguna tidak cocok dengan tipe peran yang diberikan" });
            }

            const internalFound = await existingUser.getInternal({ transaction: t })

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            const toko = await internalFound.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const orderStatuses = await models.orderstatus.findAll({
                where: {
                    name: {
                        [Op.notIn]: ["Completed", "Cancelled"]
                    }
                },

                transaction: t
            });

            await t.commit();

            const mappedStatus = orderStatuses.map(e => e.toJSON())

            return res.status(200).json(mappedStatus);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    //here notifikasi pesanan telah dibatalkan
    cancelOrder: async (req, res) => {
        const t = await sequelize.transaction();
        const { orderId } = req.body;

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan ID pengguna ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada dalam tabel pengguna tidak cocok dengan tipe peran yang diberikan" });
            }

            const internalFound = await existingUser.getInternal({ transaction: t })

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            const toko = await internalFound.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const foundOrder = await models.order.findOne({
                where: {
                    id: orderId,
                    tokoId: toko.id
                },
                transaction: t,
            })

            if (foundOrder.statusId == 5 || foundOrder.statusId == 6 || foundOrder.statusId == 4 || foundOrder.statusId == 3) {
                await t.rollback();
                return res.status(400).json({ error: "Pesanan tidak dapat dibatalkan" });
            } else {
                await foundOrder.update({
                    statusId: 4,
                    cancelledAt: Date.now(),
                    note: "Pesanan telah dibatalkan dan tidak akan diproses lagi"
                }, { transaction: t })

                const foundCustomer = await foundOrder.getCustomer({ transaction: t });
                const foundUser = await foundCustomer.getUser({ transaction: t });
                const foundDevice = await foundUser.getDevice({ transaction: t });

                await models.customernotification.create({
                    description: `Pesanan #${foundOrder.code} telah dibatalkan pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}`,
                    customerId: foundOrder.customerId,
                    typeId: 1,
                }, { transaction: t })

                if (foundDevice.deviceToken != null && foundDevice.deviceToken != "") {
                    sendNormalNotification(foundDevice.deviceToken, {
                        title: "Notifikasi Pesanan",
                        body: `Pesanan #${foundOrder.code} telah dibatalkan pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}`
                    });
                }
            }

            await t.commit();

            return res.status(200).json({ msg: "Pesanan telah dibatalkan" });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    configureOrder: async (req, res) => {
        const t = await sequelize.transaction();
        const { orderId, statusId, logNote } = req.body;

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan ID pengguna ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada dalam tabel pengguna tidak cocok dengan tipe peran yang diberikan" });
            }

            const internalFound = await existingUser.getInternal({ transaction: t })

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            const toko = await internalFound.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const foundOrder = await models.order.findOne({
                where: {
                    id: orderId,
                    tokoId: toko.id
                },
                transaction: t,
            })

            if (foundOrder.statusId == 6 || foundOrder.statusId == 4) {
                await t.rollback();
                return res.status(400).json({ error: "Pesanan tidak bisa dikonfigurasikan" });
            } else {
                await foundOrder.update({
                    statusId: statusId,
                    note: logNote
                }, { transaction: t })

                const foundCustomer = await foundOrder.getCustomer({ transaction: t });
                const foundUser = await foundCustomer.getUser({ transaction: t });
                const foundDevice = await foundUser.getDevice({ transaction: t });
                const foundStatus = await models.orderstatus.findOne({
                    where: {
                        id: foundOrder.statusId
                    },
                    transaction: t
                })

                await models.customernotification.create({
                    description: `Pesanan #${foundOrder.code} telah dikonfigurasikan pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")} dengan status ${foundStatus.name.toLowerCase()}.`,
                    customerId: foundOrder.customerId,
                    typeId: 1,
                }, { transaction: t })

                if (foundDevice.deviceToken != null && foundDevice.deviceToken != "") {
                    sendNormalNotification(foundDevice.deviceToken, {
                        title: "Notifikasi Pesanan",
                        body: `Pesanan #${foundOrder.code} telah dikonfigurasikan pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")} dengan status ${foundStatus.name.toLowerCase()}.`
                    });
                }
            }


            await t.commit();

            return res.status(200).json({ msg: "Pesanan telah dikonfigurasikan" });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },
}