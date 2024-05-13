const { models } = require("../models");
const { format } = require('date-fns');
const bcrypt = require("bcryptjs");
const sequelize = require("../utils/db.js");
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    fetchOrders: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan userId ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada di tabel pengguna tidak sesuai dengan jenis peran yang diberikan" });
            }

            const foundCustomer = await existingUser.getCustomer({ transaction: t });

            if (!foundCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan pengguna ini tidak ditemukan!" });
            }

            const foundOrders = await models.order.findAll({
                where: {
                    customerId: foundCustomer.id
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
                            }]
                        }]
                    }]
                }, {
                    model: models.customer,
                    include: {
                        model: models.address,
                        include: {
                            model: models.city,
                            as: "city",
                            include: {
                                model: models.province,
                                as: "province"
                            }
                        }
                    }
                }, {
                    model: models.toko
                }],
                order: [
                    ['createdAt', 'ASC']
                ],
                transaction: t
            })

            const mappedFoundOrders = foundOrders.map(e => e.toJSON())

            await t.commit();

            return res.status(200).json(mappedFoundOrders);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    cancelOrder: async (req, res) => {
        const t = await sequelize.transaction();
        const { orderId } = req.body;

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan userId ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada di tabel pengguna tidak sesuai dengan jenis peran yang diberikan" });
            }

            const foundCustomer = await models.customer.findOne({
                where: {
                    userId: existingUser.id
                },
                include: {
                    model: models.user,
                    as: "user"
                },
                transaction: t,
            });

            if (!foundCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan pengguna ini tidak ditemukan!" });
            }

            const foundOrder = await models.order.findOne({
                where: {
                    id: orderId
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
                    note: "Pesanan telah dibatalkan dan tidak akan diproses lagi."
                }, { transaction: t })
            }

            const internals = await models.internal.findAll({
                where: {
                    tokoId: foundOrder.tokoId,
                    status: "joined"
                },
                include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
                transaction: t
            });

            const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
            const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];

            await models.tokonotification.create({
                description: `Pelanggan ${foundCustomer.user.name} #${foundCustomer.customerCode} membatalkan pesanan #${foundOrder.code} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: foundOrder.tokoId,
                typeId: 2,
            }, { transaction: t })

            await t.commit();

            if (internalDevicesTokens.length > 0) {
                sendMulticastNotification(internalDevicesTokens, {
                    title: "Notifikasi Pesanan",
                    body: `Pelanggan ${foundCustomer.user.name} #${foundCustomer.customerCode} membatalkan pesanan #${foundOrder.code} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            return res.status(200).json({ msg: "Pesanan telah dibatalkan" });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchProdukOfOrders: async (req, res) => {
        const t = await sequelize.transaction();
        const orderId = req.params.orderId;
        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan userId ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada di tabel pengguna tidak sesuai dengan jenis peran yang diberikan" });
            }

            const foundCustomer = await existingUser.getCustomer({ transaction: t });

            if (!foundCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan pengguna ini tidak ditemukan!" });
            }

            //return the product of the found order
            const listOrderItems = await models.orderitem.findAll({
                where: {
                    orderId: orderId,
                },
                include: [{
                    model: models.productcombination,
                    as: "combination",
                    include: {
                        model: models.produk,
                        as: "product",
                        include: {
                            model: models.produkglobalimage,
                            as: "image",
                        }
                    }
                }],
                transaction: t
            })

            if (listOrderItems.length === 0) {
                await t.rollback();
                return res.status(400).json({ error: "Item pesanan kosong" });
            }

            var listOfProduct = [];

            for (const orderItem of listOrderItems) {
                if (!(listOfProduct.some(e => e.id === orderItem.combination.product.id))) {
                    listOfProduct.push(orderItem.combination.product);
                }
            }

            const mappedListOfProduct = listOfProduct.map(e => e.toJSON())

            await t.commit();

            return res.status(200).json(mappedListOfProduct);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },



    completeOrder: async (req, res) => {
        const t = await sequelize.transaction();
        const { orderId, produkIdRatingList } = req.body;

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan userId ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada di tabel pengguna tidak sesuai dengan jenis peran yang diberikan" });
            }


            const foundCustomer = await models.customer.findOne({
                where: {
                    userId: existingUser.id
                },
                include: {
                    model: models.user,
                    as: "user"
                },
                transaction: t,
            });

            if (!foundCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan pengguna ini tidak ditemukan!" });
            }

            const foundOrder = await models.order.findOne({
                where: {
                    id: orderId
                },
                include: {
                    model: models.orderitem,
                    as: "items",
                    include: {
                        model: models.productcombination,
                        as: "combination",
                        include: {
                            model: models.produk,
                            as: "product",
                        }
                    }
                },
                transaction: t,
            })

            if (foundOrder.statusId != 3) {
                await t.rollback();
                return res.status(400).json({ error: "Pesanan tidak dapat diselesaikan" });
            } else {
                await foundOrder.update({
                    statusId: 6,
                    completedAt: Date.now(),
                    note: "Pesanan telah berhasil diselesaikan dan tidak akan diproses lagi."
                }, { transaction: t })

                for (var produkIdRating of produkIdRatingList) {
                    await foundOrder.createRating({
                        rating: produkIdRating.rating,
                        produkId: produkIdRating.produkId,
                        customerId: foundCustomer.id,
                        orderId: orderId
                    }, { transaction: t })
                }


                for (var orderitem of foundOrder.items) {
                    await models.productcombination.decrement({ variantAmount: orderitem.amount }, {
                        where: {
                            id: orderitem.combination.id
                        },
                        transaction: t
                    })

                    await models.stok.decrement({ totalAmount: orderitem.amount }, {
                        where: {
                            produkId: orderitem.combination.product.id
                        },
                        transaction: t
                    })
                }
                var produkIdAmounts = [];

                for (const orderitem of foundOrder.items) {
                    if (produkIdAmounts.some(e => e.produkId == orderitem.combination.product.id)) {
                        const foundIndex = produkIdAmounts.findIndex(e => e.produkId == orderitem.combination.product.id)
                        produkIdAmounts[foundIndex][orderitem.combination.product.id] += orderitem.amount
                    } else {
                        const productMap = {};
                        productMap[orderitem.combination.product.id] = orderitem.amount;
                        produkIdAmounts.push(productMap);
                    }
                }

                if (produkIdAmounts.length === 0) {
                    await t.rollback();
                    return res.status(400).json({ error: "Jumlah id produk kosong" });
                }

                for (const produkIdAmount of produkIdAmounts) {
                    const produkId = Object.keys(produkIdAmount)[0];
                    const produkFound = await models.produk.findByPk(produkId, { transaction: t })
                    await produkFound.createStockout({
                        orderId: orderId,
                        amount: produkIdAmount[produkId],
                    }, { transaction: t })
                    const averageLeadTimeList = [];
                    const averageSalesList = [];

                    const laporanBarangKeluar = await models.laporanbarangkeluar.findAll({
                        transaction: t, include: {
                            model: models.produk,
                            where: {
                                id: produkFound.id
                            }
                        }
                    }) ?? [];

                    const laporanBarangMasuk = await models.laporanbarangmasuk.findAll({
                        transaction: t, include: {
                            model: models.produk,
                            where: {
                                id: produkFound.id
                            }
                        }
                    }) ?? [];

                    const earliestDeliveredAtDate = laporanBarangMasuk.length > 0 ? await models.laporanbarangmasuk.min('deliveredAt', {
                        transaction: t, include: [{
                            model: models.produk,
                            where: {
                                id: produkFound.id
                            },
                            include: [{
                                model: models.laporanbarangmasuk,
                                as: "stockin",
                                attributes: [],
                                required: true
                            }]
                        }],
                    }) : null;

                    const latestDeliveredAtDate = laporanBarangMasuk.length > 0 ? await models.laporanbarangmasuk.max('deliveredAt', {
                        transaction: t, include: [{
                            model: models.produk,
                            where: {
                                id: produkFound.id
                            },
                            include: [{
                                model: models.laporanbarangmasuk,
                                as: "stockin",
                                attributes: [],
                                required: true
                            }]
                        }],
                    }) : null;

                    if (earliestDeliveredAtDate && latestDeliveredAtDate) {
                        const startDate = new Date(earliestDeliveredAtDate);
                        const endDate = new Date(latestDeliveredAtDate);

                        let currentDate = new Date(startDate);
                        while (currentDate <= endDate) {
                            const foundLaporanBarangKeluarValue = (laporanBarangKeluar.length > 0 && laporanBarangKeluar != undefined) ? (laporanBarangKeluar.map((e) => e.amount).reduce((accumulator, value) => accumulator + value, 0) / laporanBarangKeluar.length) : 0;
                            averageSalesList.push(foundLaporanBarangKeluarValue)
                            currentDate.setDate(currentDate.getDate() + 1);
                        }
                    }

                    const foundLeadTimeValue = laporanBarangMasuk.length > 0 && laporanBarangMasuk != undefined ? ((laporanBarangMasuk.map((e) => e.deliveryTime)).reduce((accumulator, value) => accumulator + value, 0) / laporanBarangMasuk.length) : 0;
                    averageLeadTimeList.push(foundLeadTimeValue);

                    const standardDeviation = calculateStandardDeviation(averageSalesList);
                    const safetyStock = 1.645 * standardDeviation;
                    const leadTimeDemand = averageLeadTimeList.reduce((accumulator, value) => accumulator + value, 0) / averageLeadTimeList.length
                    const reorderPoint = leadTimeDemand + safetyStock;

                    const foundStock = await produkFound.getStok({ transaction: t });
                    await foundStock.update({
                        safetyStock,
                        reorderPoint
                    }, { transaction: t })
                }
            }

            const internals = await models.internal.findAll({
                where: {
                    tokoId: foundOrder.tokoId
                },
                include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
                transaction: t
            });

            const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
            const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];

            await models.tokonotification.create({
                description: `Pelanggan ${foundCustomer.user.name} #${foundCustomer.customerCode} menyelesaikan pesanan #${foundOrder.code} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: foundOrder.tokoId,
                typeId: 2,
            }, { transaction: t })

            // const foundProducts = await models.produk.findAll({
            //     where: {
            //         tokoId: toko.id
            //     },
            //     transaction: t,
            //     include: {
            //         model: models.stok,
            //     }
            // })

            // const outOfStockProductCountList = (foundProducts.filter((e) => e.stok.totalAmount === 0) ?? [])
            // const criticalStockProductCountList = foundProducts.filter((e) => {
            //     return ((e.stok.totalAmount - e.stok.safetyStock) <= e.stok.reorderPoint)
            // }) ?? []

            // if (outOfStockProductCountList.length > 0) {
            //     await models.tokonotification.create({
            //         description: `Produk ${outOfStockProductCountList.map((e) => e.name).join(", ")} habis, harap isi kembali stoknya.`,
            //         tokoId: toko.id,
            //         typeId: 3,
            //     }, { transaction: t })

            // }

            // if (criticalStockProductCountList.length > 0) {
            //     await models.tokonotification.create({
            //         description: `Produk ${criticalStockProductCountList.map((e) => e.name).join(", ")} mendekati titik pemesanan ulang dan stok segera harus dipulihkan.`,
            //         tokoId: toko.id,
            //         typeId: 4,
            //     }, { transaction: t })

            // }

            await t.commit();

            if (internalDevicesTokens.length > 0) {
                sendMulticastNotification(internalDevicesTokens, {
                    title: "Notifikasi Pesanan",
                    body: `Pelanggan ${foundCustomer.user.name} #${foundCustomer.customerCode} menyelesaikan pesanan #${foundOrder.code} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            return res.status(200).json({ msg: "Pesanan telah berhasil diselesaikan" });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    }
}

function calculateStandardDeviation(values) {
    const n = values.length;
    if (n <= 1) {
        return 0;
    }

    const mean = values.reduce((sum, value) => sum + value, 0) / n;

    const squaredDifferences = values.map(value => Math.pow(value - mean, 2));

    const variance = squaredDifferences.reduce((sum, squaredDifference) => sum + squaredDifference, 0) / n;

    const standardDeviation = Math.sqrt(variance);

    return standardDeviation;
}