const { models } = require("../models");
const bcrypt = require("bcryptjs");
const sequelize = require("../utils/db.js");

module.exports = {
    editCustomerProfile: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { name, email, password, phoneNumber, profilePhotoUrl } = req.body;
            var hashedPassword;
            const customerFound = await models.customer.findOne({
                where: { userId: req.user },
                transaction: t
            });

            const userFound = await models.user.findOne({
                where: { id: req.user }, transaction: t
            });

            if (!customerFound) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan tidak ditemukan dengan ID pengguna tertentu!" })
            }

            if (customerFound.profilePhotoUrl != profilePhotoUrl) {
                await customerFound.update({
                    profilePhotoURL: profilePhotoUrl
                }, { transaction: t })
            }

            if (password != null) {
                hashedPassword = bcrypt.hashSync(password, 8);
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


    configureDeliveryInformation: async (req, res) => {

        const t = await sequelize.transaction();
        const { streetAddress, cityId, country, postalCode } = req.body;
        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan userId ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada dalam tabel pengguna tidak cocok dengan jenis peran yang diberikan" });
            }

            const foundCustomer = await existingUser.getCustomer({ transaction: t });

            if (!foundCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan pengguna ini tidak ditemukan!" });
            }

            const foundAddress = await foundCustomer.getAddress({ transaction: t });

            await foundAddress.update({
                streetAddress, country, postalCode,
                cityId: cityId,
                where: {
                    id: foundAddress.id
                },
                transaction: t
            })

            await t.commit();

            return res.status(200).json({ msg: "Konfigurasi informasi pengiriman pelanggan berhasil!" });

        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchDeliveryInformation: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const existingUser = await models.user.findByPk(req.user, { transaction: t });

            if (!existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna dengan userId ini tidak ditemukan" });
            }

            if (existingUser.type != req.type) {
                await t.rollback();
                return res.status(400).json({ error: "Pengguna yang ada dalam tabel pengguna tidak cocok dengan jenis peran yang diberikan" });
            }

            const foundCustomer = await existingUser.getCustomer({ transaction: t });

            if (!foundCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan pengguna ini tidak ditemukan!" });
            }

            const foundAddress = await foundCustomer.getAddress({
                transaction: t, include: [{
                    model: models.city,
                    as: "city",
                    include: [{
                        model: models.province,
                        as: "province"
                    }]
                }]
            })

            await t.commit();

            return res.status(200).json(foundAddress.toJSON());
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    }
}