const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchInternalInformation: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const internalFound = await models.internal.findOne({
                where: { userId: req.user },
                transaction: t,
                include: [{
                    model: models.user,
                    as: "user"
                }, { model: models.toko, as: "toko" }]
            })

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            await t.commit();

            const internalFoundJSON = internalFound.toJSON();

            return res.status(200).json(internalFoundJSON)
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },
}