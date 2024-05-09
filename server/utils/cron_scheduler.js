const { models } = require("../models");
const sequelize = require("../utils/db.js");
const cron = require('node-cron');
const { sendMulticastNotification } = require("./firebaseAdmin.js");

cron.schedule("0 3,10,17 * * *", async () => {
    try {
        await sequelize.transaction(async (t) => {
            const foundTokosWithProducts = await models.toko.findAll({
                include: {
                    required: true,
                    model: models.produk,
                    as: "products",
                    include: {
                        model: models.stok
                    }
                },
                transaction: t
            });

            for (const toko of foundTokosWithProducts) {
                const outOfStockProductCountList = toko.products.filter((e) => e.stok.totalAmount === 0) ?? [];
                const criticalStockProductCountList = toko.products.filter((e) => (e.stok.totalAmount - e.stok.safetyStock) <= e.stok.reorderPoint) ?? [];
                await sendStockNotifications(toko, outOfStockProductCountList, criticalStockProductCountList, t);
            }

            console.log("Success sending notification")
        });
    } catch (error) {
        console.log(error);
        throw error;
    }
}, {
    scheduled: true,
    timezone: "Asia/Jakarta"
});

async function sendStockNotifications(toko, outOfStockProducts, criticalStockProducts, transaction) {
    if (outOfStockProducts.length > 0 || criticalStockProducts.length > 0) {
        const internals = await models.internal.findAll({
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

        if (outOfStockProducts.length > 0) {
            await sendNotification(toko, outOfStockProducts, 3, "stok habis, harap isi kembali stoknya.", internalDevicesTokens, transaction);
        }

        if (criticalStockProducts.length > 0) {
            await sendNotification(toko, criticalStockProducts, 3, "mendekati titik pemesanan ulang dan stok segera harus dipulihkan.", internalDevicesTokens, transaction);
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
