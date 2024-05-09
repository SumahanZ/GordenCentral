const { where, Op } = require("sequelize");
const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchOrderCompletedOngoingCount: async (req, res) => {
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

            const processingOrdersCount = await models.order.count({
                where: {
                    statusId: {
                        [Op.notIn]: [6, 4]
                    },
                    tokoId: toko.id
                },
                transaction: t
            })

            const completedOrdersCount = await models.order.count({
                where: {
                    statusId: {
                        [Op.eq]: 6
                    },
                    tokoId: toko.id
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
