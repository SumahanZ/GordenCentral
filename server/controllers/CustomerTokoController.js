const { models } = require("../models/index.js");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchTokos: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const tokos = await models.toko.findAll({
                include: [{
                    model: models.address,
                }, {
                    required: true,
                    model: models.katalogproduk,
                    as: "catalogs"
                }], transaction: t
            })

            const mappedData = tokos.map((e) => e.dataValues)

            await t.commit();

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    fetchToko: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const tokoId = req.params.tokoId
            const existingToko = await models.toko.findByPk(tokoId, {
                include: [{
                    model: models.address,
                }, {
                    model: models.promotional,
                    required: true,
                    order: [['createdAt', 'DESC']],
                    where: {
                        tokoId: tokoId
                    },
                    transaction: t
                }]
            })

            if (!existingToko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko tidak ada!" })
            }


            await t.commit();

            return res.status(200).json(existingToko.toJSON())
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },


    fetchKatalogProdukToko: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const tokoId = req.params.tokoId

            const foundToko = await models.toko.findByPk(tokoId, { transaction: t })

            if (!foundToko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko tidak ada!" })
            }

            const foundCatalogs = await models.katalogproduk.findAll({
                where: { tokoId: tokoId }, transaction: t, include: [{
                    model: models.produk,
                    as: "products",
                    include: [{
                        model: models.produkglobalimage,
                        as: "image",
                    }, {
                        model: models.promo
                    }, {
                        model: models.produkrating,
                        as: "rating",
                        // attributes: {
                        //     include: [
                        //         [sequelize.fn('AVG', sequelize.col('products.rating.rating')), 'averageRating'],
                        //         [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('products.rating.id'))), 'totalRating']
                        //     ]
                        // },
                    }]
                }]
            })

            await t.commit();

            const mappedData = foundCatalogs.map(catalog => catalog.toJSON());

            for (const [catalogIndex, catalog] of mappedData.entries()) {
                for (const [index, product] of catalog.products.entries()) {
                    const averageRating = (product.rating.map((e) => e.rating).reduce((accumulator, currentValue) => accumulator + currentValue, 0) / product.rating.length)
                    const totalBuyer = product.rating.length;
                    mappedData[catalogIndex].products[index].averageRating = averageRating;
                    mappedData[catalogIndex].products[index].totalRating = totalBuyer;
                }
            }

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    fetchProdukDetail: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const produkId = req.params.produkId
            const tokoId = req.params.tokoId

            const foundProduk = await models.produk.findOne({
                where: { tokoId: tokoId, id: produkId }, transaction: t, include: [
                    {
                        model: models.produkglobalimage,
                        as: "image",
                    },
                    {
                        model: models.produkrating,
                        required: false,
                        as: "rating",
                        // attributes: [
                        //     [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                        //     [sequelize.fn('COUNT', sequelize.col('rating.id')), 'totalRating']
                        // ],
                    },
                    {
                        model: models.produkcolor,
                        as: "color"
                    }, {
                        model: models.produksize,
                        as: "size"
                    }, {
                        model: models.toko,
                    }, {
                        model: models.productcombination,
                        as: "combination",
                        include: [{
                            model: models.produksize,
                            as: "size"
                        }, {
                            model: models.produkcolor,
                            as: "color"
                        }, {
                            model: models.produk,
                            as: "product"
                        }]
                    }, {
                        model: models.stok,
                    }, {
                        model: models.promo
                    },
                ]
            })

            const foundCategories = await foundProduk.getCategories({ transaction: t })
            const mappedFoundCategories = foundCategories.map(e => e.toJSON())

            if (!foundProduk) {
                await t.rollback();
                return res.status(400).json({ error: "Produk tidak ada" })
            }

            var mappedFoundProduk = foundProduk.toJSON()

            const averageRating = (mappedFoundProduk.rating.map((e) => e.rating).reduce((accumulator, currentValue) => accumulator + currentValue, 0) / mappedFoundProduk.rating.length)
            const totalBuyer = mappedFoundProduk.rating.length;
            mappedFoundProduk.averageRating = averageRating;
            mappedFoundProduk.totalRating = totalBuyer;
            mappedFoundProduk.categories = mappedFoundCategories;

            await t.commit();

            return res.status(200).json(mappedFoundProduk);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    addProdukToWishlist: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { produkId } = req.body;
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan dengan id ini tidak ada" })
            }

            const wishlist = await models.wishlist.findOrCreate({
                where: {
                    customerId: currentCustomer.id
                },
                defaults: {
                    customerId: currentCustomer.id
                },
                transaction: t
            })

            if (!wishlist) {
                await t.rollback();
                return res.status(400).json({ error: "Wishlist yang terkait dengan id pelanggan ini tidak ada" })
            }

            const foundProduk = await models.produk.findOne({
                where: {
                    id: produkId
                },
                transaction: t
            });


            await wishlist[0].addProducts(foundProduk, { transaction: t });

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menambahkan produk ke wishlist!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    addProdukVariantToCart: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { produkVariationId, itemQuantity } = req.body;
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Pelanggan dengan id ini tidak ada" })
            }

            const cart = await models.cart.findOrCreate({
                where: {
                    customerId: currentCustomer.id
                },
                defaults: {
                    customerId: currentCustomer.id
                },
                transaction: t
            })

            if (!cart) {
                await t.rollback();
                return res.status(400).json({ error: "Keranjang yang terkait dengan id pelanggan ini tidak ada" })
            }


            //include with the toko
            const foundProdukVariant = await models.productcombination.findOne({
                where: {
                    id: produkVariationId
                },
                include: [
                    {
                        model: models.produk,
                        as: "product",
                        include: [{
                            model: models.toko
                        }]
                    }
                ],
                transaction: t
            });

            if (!(foundProdukVariant && (foundProdukVariant.variantAmount >= itemQuantity))) {
                await t.rollback();
                return res.status(400).json({ error: "Stok tidak memenuhi jumlah yang cukup for the itemQuantity" })
            }

            const cartItem = await cart[0].getItems({
                transaction: t
            })

            if (cartItem.length < 1) {
                await cart[0].createItem({
                    variationId: foundProdukVariant.id,
                    amount: itemQuantity,
                }, { transaction: t })
            } else {
                const foundProdukCombination = await cartItem[0].getCombination({
                    transaction: t
                })

                const produk = await foundProdukCombination.getProduct({ transaction: t })
                const toko = await produk.getToko({ transaction: t });

                if (toko.name != foundProdukVariant.product.toko.name) {
                    await t.rollback();
                    return res.status(200).json({ msg: "POPUP CHANGE TOKO" })
                }

                const foundCartItem = cartItem.find(e => {
                    return e.variationId == foundProdukVariant.id
                })

                if (foundCartItem) {
                    await foundCartItem.update({
                        amount: itemQuantity
                    }, { transaction: t })
                } else {
                    await cart[0].createItem({
                        variationId: foundProdukVariant.id,
                        amount: itemQuantity,
                    }, { transaction: t })
                }

            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menambahkan produk ke keranjang!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    addProdukVariantToCartFromModal: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { produkVariationId, itemQuantity } = req.body;
            const currentCustomer = await models.customer.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            if (!currentCustomer) {
                await t.rollback();
                return res.status(400).json({ error: "Customer dengan ID ini tidak ditemukan." })
            }

            const cart = await models.cart.findOrCreate({
                where: {
                    customerId: currentCustomer.id
                },
                defaults: {
                    customerId: currentCustomer.id
                },
                transaction: t
            })

            if (!cart) {
                await t.rollback();
                return res.status(400).json({ error: "Keranjang yang terkait dengan ID pelanggan ini tidak ditemukan." })
            }

            await models.cartitem.destroy({
                where: {
                    cartId: cart[0].id,
                },
                transaction: t
            })


            //include with the toko
            const foundProdukVariant = await models.productcombination.findOne({
                where: {
                    id: produkVariationId
                },
                include: [
                    {
                        model: models.produk,
                        as: "product",
                        include: [{
                            model: models.toko
                        }]
                    }
                ],
                transaction: t
            });

            if (!(foundProdukVariant && (foundProdukVariant.variantAmount >= itemQuantity))) {
                await t.rollback();
                return res.status(400).json({ error: "Stok tidak memenuhi jumlah yang cukup for the itemQuantity" })
            }

            await cart[0].createItem({
                variationId: foundProdukVariant.id,
                amount: itemQuantity,
            }, { transaction: t })

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menambahkan produk ke keranjang!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    }
}