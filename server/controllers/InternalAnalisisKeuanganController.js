const { where, Op } = require("sequelize");
const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchAnalisisKeuanganGeneralInformation: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const transactionsCompleted = await models.order.findAll({
                where: {
                    statusId: {
                        [Op.eq]: 6
                    },
                    tokoId: toko.id
                },
                transaction: t
            })

            const totalAmountBarangKeluar = await models.laporanbarangkeluar.findAll({
                include: {
                    model: models.produk,
                    where: {
                        tokoId: toko.id
                    }
                },
                transaction: t
            })

            await t.commit();

            return res.status(200).json({
                "transactionsCompleted": transactionsCompleted.length,
                "productSold": totalAmountBarangKeluar.map(e => parseInt(e.amount)).reduce((accumulator, value) => accumulator + value, 0),
                "totalSalesPrice": transactionsCompleted.map(e => e.finalPriceTotal).reduce((accumulator, value) => accumulator + value, 0)
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchRecentTransactions: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const transactionsCompleted = await models.order.findAll({
                where: {
                    statusId: {
                        [Op.eq]: 6
                    },
                    tokoId: toko.id,
                },
                limit: 5,
                include: {
                    model: models.customer,
                    include: {
                        model: models.user,
                        as: "user"
                    }
                },
                transaction: t,
                order: [
                    ["createdAt", "DESC"]
                ]
            })

            await t.commit();

            return res.status(200).json(transactionsCompleted.map(e => e.toJSON()));

        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchSalesReport: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const transactionsCompleted = await models.order.findAll({
                where: {
                    statusId: {
                        [Op.eq]: 6
                    },
                    tokoId: toko.id,
                },
                include: {
                    model: models.customer
                },
                transaction: t,
                order: [
                    ["createdAt", "DESC"]
                ]
            })

            await t.commit();

            return res.status(200).json(transactionsCompleted.map(e => e.toJSON()));
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    }
}
