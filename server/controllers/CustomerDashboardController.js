const { where, Op } = require("sequelize");
const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchMostPopularProduks: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const products = await models.produk.findAll({
                transaction: t, include: [{
                    model: models.produkglobalimage,
                    as: "image",
                }, {
                    model: models.promo,
                }, {
                    model: models.produkrating,
                    required: true,
                    as: "rating",
                    // attributes: {
                    //     include: [
                    //         [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                    //         [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('rating.id'))), 'totalRating']
                    //     ]
                    // },
                }, {
                    model: models.katalogproduk,
                    as: "catalogs",
                    required: true
                }, {
                    model: models.toko,
                }],
                order: [['createdAt', 'DESC']],
            })


            if (!products) {
                await t.rollback();
                return res.status(400).json({ error: "Produk tidak ditemukan" })
            }

            await t.commit();

            const productsWithValid = products.filter(product => product.id !== null);

            const mappedData = productsWithValid.map((e) => e.toJSON())

            for (const [index, product] of mappedData.entries()) {
                const averageRating = (product.rating.map((e) => e.rating).reduce((accumulator, currentValue) => accumulator + currentValue, 0) / product.rating.length)
                const totalBuyer = product.rating.length;
                mappedData[index].averageRating = averageRating;
                mappedData[index].totalRating = totalBuyer;
            }

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchNewArrivalProduks: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const products = await models.produk.findAll({
                where: {
                    createdAt: {
                        [Op.gte]: sequelize.literal(`DATE_SUB(NOW(), INTERVAL 1 WEEK)`)
                    }
                },
                transaction: t, include: [{
                    model: models.produkglobalimage,
                    as: "image",
                }, {
                    model: models.promo,
                    required: false,
                }, {
                    model: models.produkrating,
                    required: false,
                    as: "rating",
                    // attributes: {
                    //     include: [
                    //         [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                    //         [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('rating.id'))), 'totalRating']
                    //     ]
                    // },
                }, {
                    model: models.katalogproduk,
                    as: "catalogs",
                    required: true
                }, {
                    model: models.toko,
                }],

                order: [['createdAt', 'DESC']],
            })

            if (products.length === 0) {
                await t.rollback();
                return res.status(400).json({ error: "Tidak ada produk yang ditemukan dengan promosi yang valid" });
            }

            const productsWithValid = products.filter(product => product.id !== null);
            const mappedData = productsWithValid.map((e) => e.toJSON())

            for (const [index, product] of mappedData.entries()) {
                console.log(product)
                const averageRating = (product.rating.map((e) => e.rating).reduce((accumulator, currentValue) => accumulator + currentValue, 0) / product.rating.length)
                const totalBuyer = product.rating.length;
                mappedData[index].averageRating = averageRating;
                mappedData[index].totalRating = totalBuyer;
            }

            await t.commit();
            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchPromoProduks: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const products = await models.produk.findAll({
                transaction: t, include: [{
                    model: models.produkglobalimage,
                    as: "image",
                }, {
                    model: models.promo,
                    where: {
                        expiredAt: {
                            [Op.gt]: Date.now()
                        }
                    },
                }, {
                    model: models.produkrating,
                    as: "rating",
                    required: false,
                    // attributes: {
                    //     include: [
                    //         [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                    //         [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('rating.id'))), 'totalRating']
                    //     ]
                    // },
                }, {
                    model: models.katalogproduk,
                    as: "catalogs",
                    required: true
                }, {
                    model: models.toko,
                }],
                order: [['createdAt', 'DESC']],
            })

            if (products.length === 0) {
                await t.rollback();
                return res.status(400).json({ error: "Tidak ada produk yang ditemukan dengan promosi yang valid" });
            }

            const productsWithValidPromo = products.filter(product => product.promo !== null);

            const mappedData = productsWithValidPromo.map((e) => e.toJSON())

            for (const [index, product] of mappedData.entries()) {
                const averageRating = (product.rating.map((e) => e.rating).reduce((accumulator, currentValue) => accumulator + currentValue, 0) / product.rating.length)
                const totalBuyer = product.rating.length;
                mappedData[index].averageRating = averageRating;
                mappedData[index].totalRating = totalBuyer;
            }

            await t.commit();

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    fetchOrderCompletedOngoingCount: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const customerFound = await models.customer.findOne({
                where: { userId: req.user },
                transaction: t,
                include: [{
                    model: models.user,
                    as: "user"
                },]
            })

            if (!customerFound) {
                await t.rollback();
                return res.status(400).json({ error: "pelanggan tidak ditemukan dengan id pengguna tertentu!" })
            }

            const processingOrdersCount = await models.order.count({
                where: {
                    statusId: {
                        [Op.notIn]: [6, 4]
                    },
                    customerId: customerFound.id
                },
                transaction: t
            })

            const completedOrdersCount = await models.order.count({
                where: {
                    statusId: {
                        [Op.eq]: 6
                    },
                    customerId: customerFound.id
                },
                transaction: t
            })

            await t.commit();

            return res.status(200).json({
                "completedOrdersCount": completedOrdersCount,
                "processingOrdersCount": processingOrdersCount
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    }
}
