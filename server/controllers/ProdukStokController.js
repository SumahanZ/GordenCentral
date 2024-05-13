const { models } = require("../models");
const sequelize = require("../utils/db.js");
const { format } = require('date-fns');
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    inputStokProduk: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const { produkSaved, produkStok, issuedAt, deliveredAt, deliveryTime, totalAmount } = req.body;
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

            var code = generateProductCode(8);

            var checkProduk = await models.produk.findOne({
                where: {
                    code: code
                },
                transaction: t
            })

            if (checkProduk) {
                do {
                    code = generateProductCode(8);
                    checkProduk = await models.produk.findOne({
                        where: {
                            code: code
                        },
                        transaction: t
                    })
                } while (code == checkProduk.code)
            }

            const createdProduk = await models.produk.create({
                code: code,
                name: produkSaved.name,
                description: produkSaved.description,
                price: produkSaved.price,
            }, {
                transaction: t
            })

            for (const category of produkSaved.productSelection.categories) {
                const foundCategory = await models.produkcategory.findOne({ where: { name: category }, transaction: t })

                if (foundCategory) {
                    createdProduk.addCategories(foundCategory, { transaction: t });
                }
            }

            await createdProduk.setToko(toko, { transaction: t });

            for (const imageUrl of produkSaved.globalImageUrls) {
                await createdProduk.createImage({ globalImageUrl: imageUrl }, { transaction: t })
            }

            await createdProduk.createStok({ totalAmount: totalAmount }, { transaction: t });
            await createdProduk.createStockin({ amount: totalAmount, issuedFrom: new Date(issuedAt), deliveredAt: new Date(deliveredAt), deliveryTime: deliveryTime }, { transaction: t });

            for (const color of produkSaved.productSelection.colors) {
                const createdColor = await models.produkcolor.create({ name: color.name, produkColorImageUrl: color.imagePath }, { transaction: t });
                await createdProduk.addColor(createdColor, { transaction: t });
            }

            for (const size of produkSaved.productSelection.sizes) {
                const createdSize = await models.produksize.create({ name: size }, { transaction: t });
                await createdProduk.addSize(createdSize, { transaction: t });
            }

            const foundColors = await models.produkcolor.findAll({ where: { produkId: createdProduk.id }, transaction: t });
            const foundSizes = await models.produksize.findAll({ where: { produkId: createdProduk.id }, transaction: t });

            for (const color of foundColors) {
                for (const size of foundSizes) {
                    let totalAmount = 0;

                    for (const selection of produkStok) {
                        if (color.name == selection.produkColor.name && size.name == selection.produkSize) {
                            totalAmount = selection.stokAmount;
                        }
                    }

                    await models.productcombination.create({
                        produkId: createdProduk.id,
                        sizeId: size.id,
                        colorId: color.id,
                        variantAmount: totalAmount,
                    }, { transaction: t });
                }
            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil memasukkan produk"
            });
        } catch (error) {
            await t.rollback();
            console.error("Terjadi kesalahan:", error);
            return res.status(500).json({
                error: error.message
            });
        }
    },


    fetchProductOutOfStockAndCriticalCount: async (req, res) => {
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

            const foundProducts = await models.produk.findAll({
                where: {
                    tokoId: toko.id
                },
                transaction: t,
                include: {
                    model: models.stok,
                }
            })

            await t.commit();

            const outOfStockProductCountList = foundProducts.filter((e) => e.stok.totalAmount === 0) ?? []

            const criticalStockProductCountList = foundProducts.filter((e) => {
                return ((e.stok.totalAmount - e.stok.safetyStock) <= e.stok.reorderPoint)
            }) ?? []

            return res.status(200).json({
                outOfStockProductCount: outOfStockProductCountList.length,
                criticalStockProductCount: criticalStockProductCountList.length,
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    // checkProductsSafetyStockAndReorderPointLevels: async (req, res) => {
    //     const t = await sequelize.transaction();
    //     try {
    //         const currentInternal = await models.internal.findOne({
    //             where: {
    //                 userId: req.user
    //             },
    //             transaction: t
    //         });

    //         const toko = await currentInternal.getToko({ transaction: t });

    //         if (!toko) {
    //             await t.rollback();
    //             return res.status(400).json({ error: "Toko associated with the internal doesnt exist" })
    //         }

    //         const products = await models.produk.findAll({
    //             where: {
    //                 tokoId: toko.id
    //             },
    //             transaction: t
    //         })

    //         if (products.length  === 0) {
    //             await t.rollback();
    //             return res.status(400).json({ error: "Products associated with the toko doesn't exist. Please consider adding a product" })
    //         }

    //         await t.commit();

    //         return res.status(200).json({
    //             msg: "Successfully calculated safety stock and reorder point"
    //         });
    //     } catch (error) {
    //         await t.rollback();
    //         return res.status(500).json({
    //             error: error.message
    //         });
    //     }
    // },

    calculateSafetyStockAndReorderPoint: async (req, res) => {
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
                },
                transaction: t
            })

            if (products.length == 0) {
                await t.rollback();
                return res.status(400).json({ error: "Produk yang terkait dengan toko tidak ada. Mohon pertimbangkan untuk menambahkan produk." })
            }

            for (var product of products) {
                const averageLeadTimeList = [];
                const averageSalesList = [];

                const laporanBarangKeluar = await product.getStockout({ transaction: t }) ?? []
                const laporanBarangMasuk = await product.getStockin({ transaction: t }) ?? []

                const earliestDeliveredAtDate = laporanBarangMasuk.length > 0 ? await models.laporanbarangmasuk.min('deliveredAt', {
                    transaction: t, include: [{
                        model: models.produk,
                        where: {
                            id: product.id
                        },
                        include: [{
                            model: models.laporanbarangmasuk,
                            as: "stockin",
                            attributes: [],
                            required: true
                        }]
                    }],
                }) : null;
                const latestDeliveredAtDate = laporanBarangMasuk.length > 0 ? await models.laporanbarangmasuk.max('deliveredAt', {
                    transaction: t, include: [{
                        model: models.produk,
                        where: {
                            id: product.id
                        },
                        include: [{
                            model: models.laporanbarangmasuk,
                            as: "stockin",
                            attributes: [],
                            required: true
                        }]
                    }],
                }) : null;


                if (earliestDeliveredAtDate && latestDeliveredAtDate) {
                    const startDate = new Date(earliestDeliveredAtDate);
                    const endDate = new Date(latestDeliveredAtDate);

                    let currentDate = new Date(startDate);
                    while (currentDate <= endDate) {
                        const foundLaporanBarangKeluarValue = (laporanBarangKeluar.length > 0 && laporanBarangKeluar != undefined) ? (laporanBarangKeluar.map((e) => e.amount).reduce((accumulator, value) => accumulator + value, 0) / laporanBarangKeluar.length) : 0;
                        averageSalesList.push(foundLaporanBarangKeluarValue)
                        currentDate.setDate(currentDate.getDate() + 1);
                    }
                }

                const foundLeadTimeValue = laporanBarangMasuk.length > 0 && laporanBarangMasuk != undefined ? ((laporanBarangMasuk.map((e) => {
                    return e.deliveryTime;
                })).reduce((accumulator, value) => accumulator + value, 0) / laporanBarangMasuk.length) : 0;
                averageLeadTimeList.push(foundLeadTimeValue);

                const standardDeviation = calculateStandardDeviation(averageSalesList);
                const safetyStock = 1.645 * standardDeviation;
                const leadTimeDemand = averageLeadTimeList.reduce((accumulator, value) => accumulator + value, 0) / averageLeadTimeList.length
                const reorderPoint = leadTimeDemand + safetyStock;

                const foundStock = await product.getStok({ transaction: t });
                await foundStock.update({
                    safetyStock,
                    reorderPoint
                }, { transaction: t })
            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menghitung stok aman dan titik pemesanan ulang."
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchCategories: async (req, res) => {
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

            const categories = await models.produkcategory.findAll({
                transaction: t
            })

            await t.commit();

            if (!categories) {
                await t.rollback();
                return res.status(400).json({ error: "Kategori tidak ditemukan." })
            }

            const mappedData = categories.map((e) => e.dataValues)

            return res.status(200).json(mappedData);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    fetchProduks: async (req, res) => {
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
                }, transaction: t, include: [{
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


            const mappedProducts = products.map(e => e.toJSON())


            for (var [index, foundProduk] of mappedProducts.entries()) {
                const foundCategories = await products[index].getCategories({ transaction: t })
                const mappedFoundCategories = foundCategories.map(e => e.toJSON())
                foundProduk.categories = mappedFoundCategories;
            }

            await t.commit();

            return res.status(200).json(mappedProducts);
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },

    checkSafetyStockReorderPoint: async (req, res) => {
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

            const foundProducts = await models.produk.findAll({
                where: {
                    tokoId: toko.id
                },
                transaction: t,
                include: {
                    model: models.stok,
                }
            })

            if (foundProducts.length == 0) {
                await t.rollback();
                return res.status(400).json({ error: "Produk yang terkait dengan toko tidak ada. Mohon pertimbangkan untuk menambahkan produk." })
            }

            const outOfStockProductCountList = foundProducts.filter((e) => e.stok.totalAmount === 0) ?? [];
            const criticalStockProductCountList = foundProducts.filter((e) => (e.stok.totalAmount - e.stok.safetyStock) <= e.stok.reorderPoint) ?? [];
            await sendStockNotifications(toko, outOfStockProductCountList, criticalStockProductCountList, t);

            await t.commit();

            return res.status(200).json({ msg: "Sukses cek status safety stock dan reorder point" });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }
    },


    addStokProduk: async (req, res) => {
        const t = await sequelize.transaction();

        try {
            const { produkId, produkStok, issuedAt, deliveredAt, deliveryTime, totalAmount } = req.body;
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
                }, transaction: t
            })

            const foundStock = await foundProduk.getStok({ transaction: t });

            const averageLeadTimeList = [];
            const averageSalesList = [];
            const laporanBarangKeluar = await models.laporanbarangkeluar.findAll({
                transaction: t, include: {
                    model: models.produk,
                    where: {
                        id: produkId
                    }
                }
            }) ?? [];
            const laporanBarangMasuk = await models.laporanbarangmasuk.findAll({
                transaction: t, include: {
                    model: models.produk,
                    where: {
                        id: produkId
                    }
                }
            }) ?? [];

            const earliestDeliveredAtDate = laporanBarangMasuk.length > 0 ? await models.laporanbarangmasuk.min('deliveredAt', {
                transaction: t, 
                include: [{
                    model: models.produk,
                    where: {
                        id: produkId
                    },
                    include: [{
                        model: models.laporanbarangmasuk,
                        as: "stockin",
                        attributes: [],
                        required: true
                    }]
                }],
            }) : null;

            const latestDeliveredAtDate = laporanBarangMasuk.length > 0 ? await models.laporanbarangmasuk.max('deliveredAt', {
                transaction: t, 
                include: [{
                    model: models.produk,
                    where: {
                        id: produkId
                    },
                    include: [{
                        model: models.laporanbarangmasuk,
                        as: "stockin",
                        attributes: [],
                        required: true
                    }]
                }],
            }) : null;

            if (earliestDeliveredAtDate && latestDeliveredAtDate) {
                const startDate = new Date(earliestDeliveredAtDate);
                const endDate = new Date(latestDeliveredAtDate);

                let currentDate = new Date(startDate);
                while (currentDate <= endDate) {
                    const foundLaporanBarangKeluarValue = (laporanBarangKeluar.length > 0 && laporanBarangKeluar != undefined) ? (laporanBarangKeluar.map((e) => e.amount).reduce((accumulator, value) => accumulator + value, 0) / laporanBarangKeluar.length) : 0;
                    averageSalesList.push(foundLaporanBarangKeluarValue)
                    currentDate.setDate(currentDate.getDate() + 1);
                }
            }

            const foundLeadTimeValue = laporanBarangMasuk.length > 0 && laporanBarangMasuk != undefined ? ((laporanBarangMasuk.map((e) => e.deliveryTime)).reduce((accumulator, value) => accumulator + value, 0) / laporanBarangMasuk.length) : 0;
            averageLeadTimeList.push(foundLeadTimeValue);

            const standardDeviation = calculateStandardDeviation(averageSalesList);
            const safetyStock = 1.645 * standardDeviation;
            const leadTimeDemand = averageLeadTimeList.reduce((accumulator, value) => accumulator + value, 0) / averageLeadTimeList.length
            const reorderPoint = leadTimeDemand + safetyStock;

            await foundStock.update({
                totalAmount: foundStock.totalAmount + totalAmount,
                safetyStock,
                reorderPoint
            }, { transaction: t })

            await models.tokonotification.create({
                description: `Produk ${foundProduk.name} telah diisi kembali sebanyak ${totalAmount} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: toko.id,
                typeId: 3,
            }, { transaction: t })

            await foundProduk.createStockin({ amount: totalAmount, issuedFrom: new Date(issuedAt), deliveredAt: new Date(deliveredAt), deliveryTime: deliveryTime }, { transaction: t });

            const foundColors = await models.produkcolor.findAll({ where: { produkId: foundProduk.id }, transaction: t });
            const foundSizes = await models.produksize.findAll({ where: { produkId: foundProduk.id }, transaction: t });

            for (const color of foundColors) {
                for (const size of foundSizes) {
                    var foundColor;
                    var foundSize;
                    let totalAmount = 0;
                    for (const selection of produkStok) {
                        if (color.name == selection.produkColor.name && size.name == selection.produkSize) {
                            totalAmount = selection.stokAmount;
                            foundColor = color;
                            foundSize = size;
                            const foundVariant = await models.productcombination.findOne({
                                where: {
                                    produkId: produkId,
                                }, transaction: t, include: [
                                    {
                                        model: models.produksize,
                                        as: "size",
                                        where: {
                                            id: foundSize.dataValues.id
                                        }
                                    },
                                    {
                                        model: models.produkcolor,
                                        as: "color",
                                        where: {
                                            id: foundColor.dataValues.id
                                        }
                                    }
                                ]
                            })

                            await foundVariant.update({
                                variantAmount: foundVariant.variantAmount + totalAmount
                            }, { transaction: t })
                        }
                    }
                }
            }

            // const foundProducts = await models.produk.findAll({
            //     where: {
            //         tokoId: toko.id
            //     },
            //     transaction: t,
            //     include: {
            //         model: models.stok,
            //     }
            // })

            // const outOfStockProductCountList = (foundProducts.filter((e) => e.stok.totalAmount === 0) ?? [])
            // const criticalStockProductCountList = foundProducts.filter((e) => {
            //     return ((e.stok.totalAmount - e.stok.safetyStock) <= e.stok.reorderPoint)
            // }) ?? []

            // if (outOfStockProductCountList.length > 0) {
            //     await models.tokonotification.create({
            //         description: `Produk ${outOfStockProductCountList.map((e) => e.name).join(", ")} habis, harap isi kembali stoknya.`,
            //         tokoId: toko.id,
            //         typeId: 3,
            //     }, { transaction: t })

            // }

            // if (criticalStockProductCountList.length > 0) {
            //     await models.tokonotification.create({
            //         description: `Produk ${criticalStockProductCountList.map((e) => e.name).join(", ")} mendekati titik pemesanan ulang dan stok segera harus dipulihkan.`,
            //         tokoId: toko.id,
            //         typeId: 4,
            //     }, { transaction: t })

            // }

            await t.commit();

            return res.status(200).json({
                msg: "Sukses menambahkan stok ke produk"
            });
        } catch (error) {
            await t.rollback();
            console.error("Error occurred:", error);
            return res.status(500).json({
                error: error.message
            });
        }
    },


}

function generateProductCode(length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let code = '';
    for (let i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
}

function calculateStandardDeviation(values) {
    const n = values.length;
    if (n <= 1) {
        return 0;
    }

    const mean = values.reduce((sum, value) => sum + value, 0) / n;

    const squaredDifferences = values.map(value => Math.pow(value - mean, 2));

    const variance = squaredDifferences.reduce((sum, squaredDifference) => sum + squaredDifference, 0) / n;

    const standardDeviation = Math.sqrt(variance);

    return standardDeviation;
}

async function sendStockNotifications(toko, outOfStockProducts, criticalStockProducts, transaction) {
    const internals = await models.internal.findAll({
        where: {
            tokoId: toko.id,
            status: "joined"
        },
        include: {
            model: models.user,
            include: {
                model: models.device
            }
        },
        transaction: transaction
    });

    const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
    const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];

    if (outOfStockProducts.length > 0 || criticalStockProducts.length > 0) {
        if (outOfStockProducts.length > 0) {
            await sendNotification(toko, outOfStockProducts, 3, "stok habis, harap isi kembali stoknya.", internalDevicesTokens, transaction);
        }

        if (criticalStockProducts.length > 0) {
            await sendNotification(toko, criticalStockProducts, 3, "mendekati titik pemesanan ulang dan stok segera harus dipulihkan.", internalDevicesTokens, transaction);
        }

    } else if (outOfStockProducts.length == 0 && criticalStockProducts.length == 0) {
        if (internalDevicesTokens.length > 0) {
            sendMulticastNotification(internalDevicesTokens, {
                title: "Notifikasi Stok",
                body: "Pengecekan level stok. Tidak ada stok habis atau mendekati titik pemesanan ulang."
            });
        }
    }
}

async function sendNotification(toko, products, typeId, descriptionSuffix, tokens, transaction) {
    const description = `Produk ${products.map((e) => e.name).join(", ")} ${descriptionSuffix}`;

    await models.tokonotification.create({
        description: description,
        tokoId: toko.id,
        typeId: typeId,
    }, { transaction: transaction });

    if (tokens.length > 0) {
        sendMulticastNotification(tokens, {
            title: "Notifikasi Stok",
            body: description
        });
    }
}
