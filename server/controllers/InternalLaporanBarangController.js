const { models } = require("../models/index.js");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchLaporanBarangMasuk: async (req, res) => {
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

            const laporanbarangmasuk = await models.laporanbarangmasuk.findAll({
                include: {
                    model: models.produk,
                    where: {
                        tokoId: toko.id
                    }
                },
                transaction: t
            })


            const mappedFoundLaporan = laporanbarangmasuk.map(e => e.toJSON()) ?? []

            await t.commit();

            return res.status(200).json(mappedFoundLaporan);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchLaporanBarangKeluar: async (req, res) => {
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

            const laporanbarangkeluar = await models.laporanbarangkeluar.findAll({
                include: [{
                    model: models.produk,
                    where: {
                        tokoId: toko.id
                    }
                }, {
                    model: models.order,
                    as: "order",
                }],
                transaction: t
            })

            await t.commit();

            const mappedFoundLaporan = laporanbarangkeluar.map(e => e.toJSON())

            return res.status(200).json(mappedFoundLaporan);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    fetchLaporanGeneralInformation: async (req, res) => {
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

            //GET TOTAL STOCK OF ALL THE AMOUNT
            const getTotalStockAmount = await models.stok.findAll({
                include: {
                    model: models.produk,
                    where: {
                        tokoId: toko.id
                    }
                },
                transaction: t
            })


            //COUNT TOTAL AMOUNT FROM BARANG MASUK
            const totalAmountBarangMasuk = await models.laporanbarangmasuk.findAll({
                include: {
                    model: models.produk,
                    where: {
                        tokoId: toko.id
                    }
                },
                transaction: t
            })

            //COUNT TOTAL AMOUNT FROM BARANG KELUAR
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
                getTotalStockAmount: getTotalStockAmount.map(e => parseInt(e.totalAmount)).reduce((accumulator, value) => accumulator + value, 0),
                totalAmountBarangMasuk: totalAmountBarangMasuk.length,
                totalAmountBarangKeluar: totalAmountBarangKeluar.length,
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },
}