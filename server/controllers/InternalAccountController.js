const { models } = require("../models");
const bcrypt = require("bcryptjs");
const sequelize = require("../utils/db.js");

module.exports = {
    editInternalProfile: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { name, email, password, phoneNumber, profilePhotoUrl } = req.body;
            var hashedPassword;
            const internalFound = await models.internal.findOne({
                where: { userId: req.user },
                transaction: t
            });

            const userFound = await models.user.findOne({
                where: { id: req.user }, transaction: t
            });

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            if (internalFound.profilePhotoUrl != profilePhotoUrl) {
                await internalFound.update({
                    profilePhotoURL: profilePhotoUrl
                }, { transaction: t })
            }

            if (password != null) {
                hashedPassword = bcrypt.hashSync(password, 8);
                console.log(hashedPassword);
            }

            const updatedUser = await userFound.update({
                name, email, password: hashedPassword, phoneNumber
            }, { transaction: t })

            await t.commit();

            const updatedUserJSON = updatedUser.toJSON();

            return res.status(200).json(updatedUserJSON)
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },
}