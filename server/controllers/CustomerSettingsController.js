const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchCustomerInformation: async (req, res) => {
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

            await t.commit();

            const customerFoundJSON = customerFound.toJSON();

            return res.status(200).json(customerFoundJSON)
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },
}