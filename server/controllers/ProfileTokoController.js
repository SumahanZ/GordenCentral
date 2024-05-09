const { where, Op } = require("sequelize");
const { models } = require("../models");
const sequelize = require("../utils/db.js");
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    configureTokoInformation: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { tokoId, tokoName, tokoPhoneNumber, tokoStreetAddress, cityId, tokoCountry, tokoPostalCode, tokoBio, tokoWhatsAppUrl, tokoInviteCode, tokoProfilePhotoUrl } = req.body;
            const existingToko = await models.toko.findByPk(tokoId, { transaction: t })
            const internalFound = await models.internal.findOne({ where: { userId: req.user }, transaction: t })
            var tokoResults;

            if (!internalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal tidak ditemukan dengan ID pengguna tertentu!" })
            }

            if (existingToko) {
                if (tokoProfilePhotoUrl == null) {
                    tokoResults = await existingToko.update({
                        name: tokoName,
                        phoneNumber: tokoPhoneNumber,
                        bio: tokoBio,
                        whatsAppURL: tokoWhatsAppUrl,
                        inviteCode: tokoInviteCode,
                    }, { transaction: t })

                    const address = await tokoResults.getAddress({ transaction: t });

                    await address.update({
                        streetAddress: tokoStreetAddress,
                        country: tokoCountry,
                        postalCode: tokoPostalCode,
                        cityId: cityId,
                    }, { transaction: t })
                } else {
                    tokoResults = await existingToko.update({
                        name: tokoName,
                        phoneNumber: tokoPhoneNumber,
                        bio: tokoBio,
                        whatsAppURL: tokoWhatsAppUrl,
                        profilePhotoURL: tokoProfilePhotoUrl,
                        inviteCode: tokoInviteCode,
                    }, { transaction: t })

                    const address = await tokoResults.getAddress({ transaction: t });

                    await address.update({
                        streetAddress: tokoStreetAddress,
                        country: tokoCountry,
                        postalCode: tokoPostalCode,
                        cityId: cityId,
                    }, { transaction: t })
                }

            } else {
                if (tokoProfilePhotoUrl == null) {
                    tokoResults = await models.toko.create({
                        name: tokoName,
                        phoneNumber: tokoPhoneNumber,
                        bio: tokoBio,
                        whatsAppURL: tokoWhatsAppUrl,
                        inviteCode: tokoInviteCode,
                        address: {
                            streetAddress: tokoStreetAddress,
                            country: tokoCountry,
                            postalCode: tokoPostalCode,
                            cityId: cityId,
                        }
                    }, {
                        include: [{
                            model: models.address,
                        }],
                        transaction: t
                    })

                    await tokoResults.createFormulaSetting();

                } else {
                    tokoResults = await models.toko.create({
                        name: tokoName,
                        phoneNumber: tokoPhoneNumber,
                        bio: tokoBio,
                        whatsAppURL: tokoWhatsAppUrl,
                        profilePhotoURL: tokoProfilePhotoUrl,
                        inviteCode: tokoInviteCode,
                        address: {
                            streetAddress: tokoStreetAddress,
                            country: tokoCountry,
                            postalCode: tokoPostalCode,
                            cityId: cityId,
                        }
                    }, {
                        include: [{
                            model: models.address,
                        }],
                        transaction: t
                    })

                    await tokoResults.createFormulaSetting();
                }

                await internalFound.update({ joinedAt: Date.now(), tokoId: tokoResults.id }, { transaction: t })
            }

            await t.commit();

            return res.status(200).json(tokoResults.toJSON())
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    configureBerandaToko: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            //check if the internal right now 
            const { imageUrls } = req.body;

            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const searchedToko = await models.toko.findByPk(toko.id, { transaction: t });

            await models.promotional.destroy({
                where: {
                    tokoId: toko.id,
                }, transaction: t
            });

            for (let imageUrl of imageUrls) {
                await searchedToko.createPromotional({ berandaImageUrl: imageUrl, }, { transaction: t });
            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil membuat/ memperbarui beranda toko"
            })
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    fetchPreviewTokoInformation: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            //check if the internal right now 
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },

                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });


            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const existingToko = await models.toko.findByPk(toko.id, {
                include: {
                    model: models.address,
                    include: {
                        model: models.city,
                        as: "city",
                        include: {
                            model: models.province,
                            as: "province"
                        }
                    }
                },
                transaction: t
            })

            if (!existingToko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko tidak ditemukan" })
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

    fetchBerandaInformation: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            //check if the internal right now 
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const beranda = await models.promotional.findAll({
                order: [['createdAt', 'ASC']],
                where: {
                    tokoId: toko.id
                },
                transaction: t
            });

            if (!beranda) {
                await t.rollback();
                return res.status(400).json({ error: "Beranda toko tidak ditemukan" })
            }

            const mappedData = beranda.map((e) => e.dataValues)

            await t.commit();

            return res.status(200).json(mappedData)
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    fetchCategoryItemProdukList: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const listProduk = await models.produk.findAll({
                where: { tokoId: toko.id },
                transaction: t,
                include: [{
                    model: models.produkcolor,
                    as: "color"
                }, {
                    model: models.produksize,
                    as: "size"
                }, {
                    model: models.produkglobalimage,
                    as: "image"
                }, {
                    model: models.promo
                }]
            });

            const mappedData = listProduk.map(produk => {
                const produkJSON = produk.dataValues;
                produkJSON.color = produkJSON.color.map(color => color.dataValues);
                produkJSON.size = produkJSON.size.map(size => size.dataValues);
                produkJSON.image = produkJSON.image.map(image => image.dataValues);
                return produkJSON;
            });

            await t.commit();

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    addKatalogProduk: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { name, produkIdList } = req.body;
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const createdCatalog = await toko.createCatalog({ name: name }, { transaction: t })

            for (const produkId of produkIdList) {
                const foundProduk = await models.produk.findOne({ where: { id: produkId }, transaction: t })
                await createdCatalog.addProduct(foundProduk, { transaction: t })
            }

            await t.commit();

            return res.status(200).json({
                msg: "Sukses menambahkan katalog produk"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchKatalogProdukToko: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }


            //get katalogProduk from the toko and then fetch all include with the produk (no need the association of produk because we notshowing anything here)
            // const foundCatalogs = await toko.getCatalogs();

            const foundCatalogs = await models.katalogproduk.findAll({
                where: { tokoId: toko.id }, transaction: t, include: {
                    model: models.produk,
                    as: "products",
                    include: [{
                        model: models.promo
                    }, {
                        model: models.produkrating,
                        as: "rating",
                        attributes: {
                            include: [
                                [sequelize.fn('AVG', sequelize.col('products.rating.rating')), 'averageRating'],
                                [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('products.rating.id'))), 'totalRating']
                            ]
                        },
                    }],
                }
            })

            if (foundCatalogs[0].id === null) {
                await t.rollback();
                return res.status(404).json({ error: "Katalog produk toko kosong" });
            }

            const mappedData = foundCatalogs.map(catalog => {
                const catalogJSON = catalog.dataValues;
                catalogJSON.products = catalogJSON.products.map(product => product.dataValues);
                return catalogJSON;
            });

            await t.commit();

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchKatalogProdukTokoPreview: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const foundCatalogs = await models.katalogproduk.findAll({
                where: { tokoId: toko.id }, transaction: t, include: [{
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
                        attributes: {
                            include: [
                                [sequelize.fn('AVG', sequelize.col('products.rating.rating')), 'averageRating'],
                                [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('products.rating.id'))), 'totalRating']
                            ]
                        },
                    }]
                }]
            })

            console.log(foundCatalogs)

            if (foundCatalogs[0].id === null) {
                await t.commit();
                return res.status(200).json([]);
            }


            await t.commit();

            const mappedData = foundCatalogs.map(catalog => {
                const catalogJSON = catalog.dataValues;
                catalogJSON.products = catalogJSON.products.map(product => product.dataValues);
                // catalogJSON.products.image = catalogJSON.products.image(image => image.dataValues);
                return catalogJSON;
            });

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    editKatalogProduk: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const { name, produkIdList, katalogId } = req.body;
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const queryCatalog = await models.katalogproduk.findOne({
                where: {
                    id: katalogId,
                    tokoId: toko.id,
                },
                transaction: t,
            })

            if (name) {
                await queryCatalog.update({
                    name: name,
                }, { transaction: t })
            }

            const queryCurrentProducts = await queryCatalog.getProducts({ transaction: t });
            const currentProductsCatalogIdList = queryCurrentProducts.map((e) => e.id);
            const combinedList = [...currentProductsCatalogIdList, ...produkIdList];
            const uniqueSet = new Set(combinedList);
            const uniqueListIds = Array.from(uniqueSet);

            for (const uniqueId of uniqueListIds) {
                if (!produkIdList.includes(uniqueId)) {
                    const foundProduk = queryCurrentProducts.filter((e) => e.id == uniqueId);
                    await queryCatalog.removeProducts(foundProduk)
                } else {
                    const result = queryCurrentProducts.find((e) => e.id == uniqueId);
                    if (!result) {
                        const queryProduk = await models.produk.findOne({ where: { id: uniqueId, tokoId: toko.id } })
                        await queryCatalog.addProducts(queryProduk, { transaction: t })
                    }
                }
            }

            await t.commit();

            return res.status(200).json({
                msg: "Success mengkonfigurasikan katalog produk"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchSingleKatalogProduk: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const katalogId = req.params.id;

            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const foundKatalog = await models.katalogproduk.findOne({
                where: {
                    id: katalogId,
                    tokoId: toko.id,
                },
                transaction: t,
                include: [{
                    model: models.produk,
                    as: "products",
                    include: [{
                        model: models.produkglobalimage,
                        as: "image",
                    }, {
                        model: models.produkcolor,
                        as: "color"
                    }, {
                        model: models.produksize,
                        as: "size"
                    }, {
                        model: models.promo
                    }, {
                        model: models.produkrating,
                        as: "rating",
                        required: false,
                        attributes: {
                            include: [
                                [sequelize.fn('AVG', sequelize.col('products.rating.rating')), 'averageRating'],
                                [sequelize.fn('COUNT', sequelize.fn('DISTINCT', sequelize.col('products.rating.id'))), 'totalRating']
                            ]
                        },
                    }]
                }]
            })

            await t.commit();

            var tempMappedData = foundKatalog.dataValues;

            const mappedData = tempMappedData.products.map(produk => {
                const produkJSON = produk.dataValues;
                produkJSON.color = produkJSON.color.map(color => color.dataValues);
                produkJSON.size = produkJSON.size.map(size => size.dataValues);
                produkJSON.image = produkJSON.image.map(image => image.dataValues);
                return produkJSON;
            });

            tempMappedData.products = mappedData;

            return res.status(200).json(tempMappedData);
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
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const produkId = req.params.produkId

            const foundProduk = await models.produk.findOne({
                where: { id: produkId },
                transaction: t,
                include: [
                    {
                        model: models.produkrating,
                        required: false,
                        as: "rating",
                        attributes: [
                            [sequelize.fn('AVG', sequelize.col('rating.rating')), 'averageRating'],
                            [sequelize.fn('COUNT', sequelize.col('rating.id')), 'totalRating']
                        ],
                    },
                    {
                        model: models.produkglobalimage,
                        as: "image",
                    },
                    {
                        model: models.produkcolor,
                        as: "color"
                    },
                    {
                        model: models.produksize,
                        as: "size"
                    },
                    {
                        model: models.toko,
                    },
                    {
                        model: models.productcombination,
                        as: "combination",
                        include: [
                            {
                                model: models.produksize,
                                as: "size"
                            },
                            {
                                model: models.produkcolor,
                                as: "color"
                            },
                            {
                                model: models.produk,
                                as: "product"
                            }
                        ]
                    },
                    {
                        model: models.stok,
                    },
                    {
                        model: models.promo
                    },
                ]
            });

            const foundCategories = await foundProduk.getCategories({ transaction: t })
            const mappedFoundCategories = foundCategories.map(e => e.toJSON())

            if (!foundProduk) {
                await t.rollback();
                return res.status(400).json({ error: "Produk tidak ada" })
            }

            var mappedFoundProduk = foundProduk.toJSON()

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

    editProduk: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const produkId = req.params.produkId;
            const { produkSaved } = req.body;
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const foundProduk = await models.produk.findOne({
                where: {
                    id: produkId,
                    tokoId: toko.id
                },
                transaction: t
            });

            await foundProduk.update({
                name: produkSaved.name,
                description: produkSaved.description,
                price: produkSaved.price,
            }, { transaction: t })

            for (const category of produkSaved.productSelection.categories) {
                const foundCategory = await models.produkcategory.findOne({ where: { name: category }, transaction: t })
                if (foundCategory) {
                    foundProduk.addCategories(foundCategory, { transaction: t });
                }
            }

            const categoriesToBeRemoved = await models.produkcategory.findAll({
                where: {
                    name: {
                        [Op.notIn]: produkSaved.productSelection.categories
                    }
                },
                transaction: t
            });

            await foundProduk.removeCategories(
                categoriesToBeRemoved,
                { transaction: t }
            );

            if (produkSaved.globalImageUrls.length > 0) {
                await models.produkglobalimage.destroy({
                    where: {
                        produkId: foundProduk.id
                    },
                    transaction: t
                })

                for (const imageUrl of produkSaved.globalImageUrls) {
                    await foundProduk.createImage({ globalImageUrl: imageUrl }, { transaction: t })
                }
            }

            for (const color of produkSaved.productSelection.colors) {
                const foundColor = await models.produkcolor.findOne({
                    where: {
                        name: color.name,
                        produkColorImageUrl: color.imagePath
                    },
                    transaction: t
                });

                if (!foundColor) {
                    const createdColor = await models.produkcolor.create(
                        { name: color.name, produkColorImageUrl: color.imagePath },
                        { transaction: t }
                    );
                    await foundProduk.addColor(createdColor, { transaction: t });
                }
            }

            await models.produkcolor.destroy({
                where: {
                    produkId: foundProduk.id,
                    [Op.and]: [
                        {
                            name: {
                                [Op.notIn]: produkSaved.productSelection.colors.map((e) => e.name)
                            }
                        },
                        {
                            produkColorImageUrl: {
                                [Op.notIn]: produkSaved.productSelection.colors.map((e) => e.imagePath)
                            }
                        }
                    ]
                },
                transaction: t
            })

            for (const size of produkSaved.productSelection.sizes) {
                const foundSize = await models.produksize.findOne({
                    where: {
                        name: size
                    },
                    transaction: t
                })

                if (!foundSize) {
                    const createdSize = await models.produksize.create({ name: size }, { transaction: t });
                    await foundProduk.addSize(createdSize, { transaction: t });
                }
            }

            await models.produksize.destroy({
                where: {
                    produkId: foundProduk.id,
                    name: {
                        [Op.notIn]: produkSaved.productSelection.sizes
                    }
                }, transaction: t
            })

            const foundColors = await models.produkcolor.findAll({ where: { produkId: foundProduk.id }, transaction: t });
            const foundSizes = await models.produksize.findAll({ where: { produkId: foundProduk.id }, transaction: t });

            const existingCombinations = await models.productcombination.findAll({
                where: {
                    produkId: foundProduk.id
                },
                transaction: t,
            });

            const foundStok = await foundProduk.getStok({ transaction: t });

            for (const color of foundColors) {
                for (const size of foundSizes) {
                    const foundVariation = existingCombinations.find(combination => combination.colorId === color.id && combination.sizeId === size.id);

                    if (!foundVariation) {
                        await models.productcombination.create({
                            produkId: foundProduk.id,
                            sizeId: size.id,
                            colorId: color.id,
                        }, { transaction: t });
                    }
                }
            }

            //when remove i want to reduce the stok from the combination i removed
            const combinationsToRemove = existingCombinations.filter(combination =>
                !foundColors.some(color => color.id === combination.colorId) ||
                !foundSizes.some(size => size.id === combination.sizeId)
            );


            await Promise.all(combinationsToRemove.map(async (combination) => {
                await foundStok.decrement('totalAmount', { by: combination.variantAmount, transaction: t });
                await combination.destroy({ transaction: t })
            }));

            await t.commit();

            return res.status(200).json({
                msg: "Sukses edit produk!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchAvailablePromoItems: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const products = await models.produk.findAll({
                where: {
                    tokoId: toko.id
                }, transaction: t, include: [
                    {
                        model: models.produkglobalimage,
                        as: "image",
                    }, {
                        model: models.produkcolor,
                        as: "color"
                    }, {
                        model: models.produksize,
                        as: "size"
                    }, {
                        model: models.stok,
                    }, {
                        model: models.productcombination,
                        as: "combination",
                        include: [{
                            model: models.produkcolor,
                            as: "color"
                        }, {
                            model: models.produksize,
                            as: "size"
                        }]
                    }, {
                        model: models.promo
                    }],

                order: [
                    ['name', 'ASC'],
                ]
            })

            await t.commit();

            if (!products) {
                await t.rollback();
                return res.status(400).json({ error: "Produk tidak ditemukan" })
            }

            const productsWithoutPromo = products.filter((product) => {
                return product.promoId === null || product.promoId === undefined || (!product.expiredDate > Date.now());
            });

            const mappedData = productsWithoutPromo.map((e) => e.toJSON())

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchPromos: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const promos = await models.promo.findAll({
                include: {
                    model: models.produk,
                    where: {
                        tokoId: toko.id,
                    },
                    include: [{
                        model: models.toko,
                    }, {
                        model: models.produkglobalimage,
                        as: "image",
                    }, {
                        model: models.produkcolor,
                        as: "color"
                    }, {
                        model: models.produksize,
                        as: "size"
                    }, {
                        model: models.stok,
                    }, {
                        model: models.productcombination,
                        as: "combination",
                        include: [{
                            model: models.produkcolor,
                            as: "color"
                        }, {
                            model: models.produksize,
                            as: "size"
                        }]
                    }]
                }
            })

            if (!promos) {
                await t.rollback();
                return res.status(400).json({ error: "Promo tidak ditemukan" })
            }

            await t.commit();

            const mappedData = promos.map((e) => e.toJSON())

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    addPromo: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const { discountPercent, expiredDate, produkId } = req.body;
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const foundProduk = await models.produk.findOne({
                where: {
                    tokoId: toko.id,
                    id: produkId
                },
                transaction: t
            })

            if (!foundProduk) {
                await t.rollback();
                return res.status(400).json({ error: "Produk tidak ditemukan" })
            }

            const foundPromo = await foundProduk.getPromo({ transaction: t });

            if (foundPromo) {
                await t.rollback();
                return res.status(400).json({ error: "Promo produk sudah ada, pertimbangkan untuk memperbarui daripada menambahkannya" })
            }

            await foundProduk.createPromo({
                discountPercent: discountPercent,
                expiredAt: new Date(expiredDate),
            }, { transaction: t });


            const wishlists = await foundProduk.getWishlists({
                transaction: t
            })

            for (var wishlist of wishlists) {
                const foundCustomerWithWishlist = await wishlist.getCustomer({ transaction: t });
                const foundUserWithWishlist = await foundCustomerWithWishlist.getUser({ transaction: t });
                const foundDevice = await foundUserWithWishlist.getDevice({ transaction: t })

                await models.customernotification.create({
                    description: `Produk ${foundProduk.name} dari toko ${toko.name} di daftar keinginan Anda sedang diskon ${discountPercent}%.`,
                    customerId: foundCustomerWithWishlist.id,
                    typeId: 1,
                }, { transaction: t })

                if (foundDevice.deviceToken != null && foundDevice.deviceToken != "") {
                    sendNormalNotification(foundDevice.deviceToken, {
                        title: "Notifikasi Promo",
                        body: `Produk ${foundProduk.name} dari toko ${toko.name} di daftar keinginan Anda sedang diskon ${discountPercent}%.`
                    });
                }
            }

            await t.commit();

            return res.status(200).json({
                msg: "Sukses menambahkan promo"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    editPromo: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const promoId = req.params.promoId;
            const { discountPercent, expiredDate, produkId } = req.body;
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const foundPromo = await models.promo.findOne({
                where: {
                    id: promoId,
                },
                transaction: t
            });

            if (!foundPromo) {
                await t.rollback();
                return res.status(400).json({ error: "Promo dengan id terkait tidak ada" })
            }

            const foundProduk = await models.produk.findOne({
                where: {
                    tokoId: toko.id,
                    id: produkId
                },
                transaction: t
            })

            if (!foundProduk) {
                await t.rollback();
                return res.status(400).json({ error: "Produk tidak ditemukan" })
            }

            await foundPromo.update({
                discountPercent: discountPercent,
                expiredAt: new Date(expiredDate),
            }, { transaction: t })

            await foundPromo.setProduk(foundProduk, { transaction: t });

            const wishlists = await foundProduk.getWishlists({
                transaction: t
            })

            for (var wishlist of wishlists) {
                const foundCustomerWithWishlist = await wishlist.getCustomer({ transaction: t });
                const foundUserWithWishlist = await foundCustomerWithWishlist.getUser({ transaction: t });
                const foundDevice = await foundUserWithWishlist.getDevice({ transaction: t })

                await models.customernotification.create({
                    description: `Produk ${foundProduk.name} dari toko ${toko.name} di daftar keinginan Anda sedang diskon ${discountPercent}%.`,
                    customerId: foundCustomerWithWishlist.id,
                    typeId: 1,
                }, { transaction: t })

                if (foundDevice.deviceToken != null && foundDevice.deviceToken != "") {
                    sendNormalNotification(foundDevice.deviceToken, {
                        title: "Notifikasi Promo",
                        body: `Produk ${foundProduk.name} dari toko ${toko.name} di daftar keinginan Anda sedang diskon ${discountPercent}%.`
                    });
                }
            }

            await t.commit();

            return res.status(200).json({
                msg: "Sukses menambahkan promo!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    removePromo: async (req, res) => {
        const t = await sequelize.transaction();
        try {
            const promoId = req.params.promoId;
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                transaction: t
            });

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ditemukan" })
            }

            const foundPromo = await models.promo.findOne({
                where: {
                    id: promoId
                },

                transaction: t
            })

            if (!foundPromo) {
                await t.rollback();
                return res.status(400).json({ error: "Promo tidak ditemukan" })
            }

            await foundPromo.destroy({ transaction: t });

            await t.commit();

            return res.status(200).json({
                msg: "Sukses menghapus promo!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    }
}