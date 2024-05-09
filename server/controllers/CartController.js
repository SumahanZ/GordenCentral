const { models } = require("../models");
const sequelize = require("../utils/db.js");
const { format } = require('date-fns');
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    fetchCustomerCart: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan ID tidak ada" })
            }

            const cart = await models.cart.findOne({
                where: {
                    customerId: currentCustomer.id,
                },
                transaction: t,
                include: [{
                    model: models.cartitem,
                    as: "items",
                    include: [{
                        model: models.productcombination,
                        as: "combination",
                        include: [{
                            model: models.produk,
                            as: "product",
                            include: [
                                {
                                    model: models.produkglobalimage,
                                    as: "image",
                                }, {
                                    model: models.produkcategory,
                                    as: "categories"
                                }, {
                                    model: models.toko,
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
                                    model: models.promo
                                }
                            ]
                        }, {
                            model: models.produkcolor,
                            as: "color"
                        }, {
                            model: models.produksize,
                            as: "size"
                        }]
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
                    }],
                }]
            })

            console.log(cart);

            if (!cart) {
                await t.rollback();
                return res.status(400).json({ error: "keranjang yang terkait dengan pelanggan tidak ada" })
            }

            await t.commit();

            return res.status(200).json(cart.toJSON())
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    increaseCartItemQuantity: async (req, res) => {
        const t = await sequelize.transaction();

        const { cartItemId } = req.body;

        try {
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan ID tidak ada" })
            }

            const cartItem = await models.cartitem.findByPk(cartItemId, {
                transaction: t,
                include: [{
                    model: models.productcombination,
                    as: "combination"
                }]
            })

            if (cartItem.amount < cartItem.combination.variantAmount) {
                await cartItem.increment(['amount'], { by: 1, transaction: t })
            }

            await t.commit();

            return res.status(200).json({ msg: "Berhasil menambah jumlah barang di keranjang" })
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    decreaseCartItemQuantity: async (req, res) => {
        const t = await sequelize.transaction();

        const { cartItemId } = req.body;

        try {
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan ID tidak ada" })
            }

            const cartItem = await models.cartitem.findByPk(cartItemId, {
                transaction: t,
            })

            if (cartItem.amount == 1) {
                await cartItem.destroy({ transaction: t });
            } else {
                await cartItem.decrement(['amount'], { by: 1, transaction: t })
            }

            await t.commit();

            return res.status(200).json({ msg: "Berhasil mengurangi jumlah barang di keranjang" })
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    createOrder: async (req, res) => {
        const t = await sequelize.transaction();
        const { items, discountAmountTotal, originalPriceTotal, finalPriceTotal, discountPercentTotal } = req.body;

        try {
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                include: {
                    model: models.user,
                    as: "user"
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan ID tidak ada" })
            }

            const foundCart = await currentCustomer.getCart({ transaction: t });

            if (!foundCart) {
                await t.rollback();
                return res.status(400).json({ error: "Keranjang yang terkait dengan pelanggan tidak ada" })
            }

            var code = generateOrderCode(8);

            var checkOrder = await models.order.findOne({
                where: {
                    code: code
                },
                transaction: t
            })

            if (checkOrder) {
                do {
                    code = generateOrderCode(8);
                    checkOrder = await models.order.findOne({
                        where: {
                            code: code
                        },
                        transaction: t
                    })
                } while (code == checkOrder.code)
            }

            const createdOrder = await models.order.create({
                code: code,
                status: "awaiting payment",
                note: "Pesanan menunggu pembayaran. Jika pembayaran tidak diselesaikan dalam 24 jam, pesanan akan dibatalkan.",
                customerId: currentCustomer.id,
                finalPriceTotal: finalPriceTotal,
                discountAmountTotal: discountAmountTotal,
                originalPriceTotal: originalPriceTotal,
                statusId: 1,
                tokoId: items[0].combination.product.toko.id
            }, { transaction: t });

            for (const item of items) {
                await models.orderitem.create({
                    orderId: createdOrder.id,
                    variationId: item.combination.id,
                    amount: item.amount
                }, { transaction: t });
            }

            await models.cartitem.destroy({
                where: {
                    cartId: foundCart.id
                },
                transaction: t
            })

            const internals = await models.internal.findAll({
                where: {
                    tokoId: createdOrder.tokoId
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
                description: `Pelanggan ${currentCustomer.user.name} #${currentCustomer.customerCode} melakukan pesanan #${createdOrder.code} dan menunggu pembayaran pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: createdOrder.tokoId,
                typeId: 2,
            }, { transaction: t })

            if (internalDevicesTokens.length > 0) {
                sendMulticastNotification(internalDevicesTokens, {
                    title: "Notifikasi Pesanan",
                    body: `Pelanggan ${currentCustomer.user.name} #${currentCustomer.customerCode} melakukan pesanan #${createdOrder.code} dan menunggu pembayaran pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            await t.commit();

            return res.status(200).json({ msg: "Berhasil membuat pesanan!" })
        } catch (error) {
            console.log(error);
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },
}

function generateOrderCode(length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let code = '';
    for (let i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
}