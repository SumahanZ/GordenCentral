const { where, Op } = require("sequelize");
const { models } = require("../models");
const sequelize = require("../utils/db.js");

module.exports = {
    fetchAllProducts: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const products = await models.produk.findAll({
                transaction: t, include: [{
                    model: models.produkglobalimage,
                    as: "image",
                }, {
                    model: models.promo,
                }, {
                    model: models.produkrating,
                    required: false,
                    // separate: true,
                    as: "rating",
                    attributes: {
                        include: [
                            [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                            [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('rating.id'))), 'totalRating']
                        ]
                    },
                }, {
                    model: models.katalogproduk,
                    as: "catalogs",
                    required: true
                }, {
                    model: models.toko,
                }],

                order: [['name', 'DESC']],
            })

            if (products.length === 0) {
                await t.rollback();
                return res.status(400).json({ error: "Tidak ada produk yang ditemukan" });
            }
            await t.commit();

            const mappedFoundProducts = products.map(e => e.toJSON())

            return res.status(200).json(mappedFoundProducts);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    fetchSearchSelectionOptions: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const foundTokos = await models.toko.findAll({
                transaction: t,
                include: [{
                    model: models.address,
                    required: true,
                    include: {
                        model: models.city,
                        as: "city",
                        required: true,
                    }
                }]
            },)

            const foundLocations = foundTokos.map(e => e.address.city);

            const maxProdukPriceAmount = await models.produk.max("price", {
                include: {
                    model: models.katalogproduk,
                    as: "catalogs",
                    required: true
                },
                transaction: t
            })

            const categories = await models.produkcategory.findAll({
                transaction: t
            })

            const mappedData = {
                "availableLocations": foundLocations.map(e => e.toJSON()),
                "maxProdukPriceAmount": maxProdukPriceAmount,
                "tokoList": foundTokos.map(e => e.toJSON()),
                "categories": categories.map(e => e.toJSON())
            }

            await t.commit();

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchFilteredProducts: async (req, res) => {
        const t = await sequelize.transaction();
        const { name, priceRange, ratingRange, categoriesList, selectionTokoId } = req.body;

        try {
            const products = await models.produk.findAll({
                where: {
                    price: {
                        [Op.and]: {
                            [Op.gte]: priceRange.min,
                            [Op.lte]: priceRange.max,
                        }
                    },
                    ...(name && name !== "" ? {
                        name: {
                            [Op.like]: `%${name}%`
                        }
                    } : {}),
                },
                transaction: t, include: [{
                    model: models.produkglobalimage,
                    as: "image",
                }, {
                    model: models.promo,
                }, {
                    model: models.produkrating,
                    where: {
                        rating: {
                            [Op.and]: {
                                [Op.gte]: ratingRange.min,
                                [Op.lte]: ratingRange.max,
                            }
                        }
                    },
                    as: "rating",
                    required: ratingRange.min == 0.0 ? false : true,
                    attributes: {
                        include: [
                            [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                            [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('rating.id'))), 'totalRating']
                        ]
                    },
                }, {
                    model: models.katalogproduk,
                    as: "catalogs",
                    required: true
                }, {
                    model: models.produkcategory,
                    as: "categories",
                    required: categoriesList.length > 0 ? true : false,
                    where: categoriesList.length > 0 ? {
                        name: {
                            [Op.in]: categoriesList
                        }
                    } : {}
                }, {
                    model: models.toko,
                    required: selectionTokoId ? true : false,
                    where: selectionTokoId ? {
                        id: selectionTokoId
                    } : {}
                }],

                order: [['name', 'DESC']],
            })

            if (products[0].id == null) {
                await t.commit();
                return res.status(200).json([]);
            }

            await t.commit();

            const mappedFoundProducts = products.map(e => e.toJSON())
            console.log(mappedFoundProducts)

            return res.status(200).json(mappedFoundProducts);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },
}