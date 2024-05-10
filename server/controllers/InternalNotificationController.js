const { models } = require("../models/index.js");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchTokoNotifications: async (req, res) => {
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

            const tokoNotifications = await models.tokonotification.findAll({
                where: {
                    tokoId: toko.id
                },
                include: {
                    model: models.tokonotificationtype,
                },
                transaction: t
            })

            await t.commit();

            const mappedFoundNotifications = tokoNotifications.map(e => e.toJSON())

            return res.status(200).json(mappedFoundNotifications);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },
}