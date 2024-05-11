const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    removeProdukFromWishlist: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const produkId = req.params.produkId

            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan yang terkait dengan ID tersebut tidak ada" })
            }

            const wishlist = await models.wishlist.findOne({
                where: {
                    customerId: currentCustomer.id,
                },
                transaction: t,
            })

            const foundProduct = await models.produk.findOne({ where: { id: produkId }, transaction: t })

            await wishlist.removeProduct(foundProduct, { transaction: t })

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menghapus kategori produk"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchWishlist: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Customer yang terkait dengan ID tidak ada." })
            }

            const wishlist = await models.wishlist.findOne({
                where: {
                    customerId: currentCustomer.id,
                },
                transaction: t,
                include: [{
                    model: models.produk,
                    as: "products",
                    include: [{
                        model: models.produkglobalimage,
                        as: "image",
                    }, {
                        model: models.promo,
                    }, {
                        model: models.produkrating,
                        as: "rating",
                        // attributes: {
                        //     include: [
                        //         [sequelize.fn('AVG', sequelize.col('products.rating.rating')), 'averageRating'],
                        //         [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('products.rating.id'))), 'totalRating']
                        //     ]
                        // },
                    }, {
                        model: models.toko
                    }],
                }]
            })

            if (!wishlist) {
                await t.rollback();
                return res.status(400).json({ error: "Wishlist yang terkait dengan customer tidak ada." })
            }

            await t.commit();

            const mappedWishlist = wishlist.toJSON();

            for (const [index, product] of mappedWishlist.products.entries()) {
                const averageRating = (product.rating.map((e) => e.rating).reduce((accumulator, currentValue) => accumulator + currentValue, 0) / product.rating.length)
                const totalBuyer = product.rating.length;
                mappedWishlist.products[index].averageRating = averageRating;
                mappedWishlist.products[index].totalRating = totalBuyer;
            }


            return res.status(200).json(mappedWishlist)
        } catch (error) {
            return res.status(500).json({
                error: error.message
            })
        }
    }
}