const { models } = require("../models/index.js");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchCustomerNotifications: async (req, res) => {
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

            const customerNotifications = await models.customernotification.findAll({
                where: {
                    customerId: customerFound.id
                },
                include: {
                    model: models.customernotificationtype
                },
                transaction: t,
                order: [
                    ["createdAt", "DESC"]
                ]
            })

            await t.commit();

            const mappedFoundNotifications = customerNotifications.map(e => e.toJSON())

            return res.status(200).json(mappedFoundNotifications);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },
}