const { models } = require("../models");
const sequelize = require("../utils/db.js");
const { format } = require('date-fns');
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    fetchInternals: async (req, res) => {
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
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }


            const internalsFound = await models.internal.findAll({
                where: { tokoId: toko.id },
                transaction: t,
                include: [{
                    model: models.user,
                    as: "user"
                }, { model: models.toko, as: "toko" }]
            })

            if (!internalsFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal toko tidak dapat ditemukan" })
            }

            await t.commit();

            const mappedInternalFoundJSON = internalsFound.map((e) => {
                return e.toJSON();
            });

            return res.status(200).json(mappedInternalFoundJSON)
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },


    acceptJoinRequestPemilik: async (req, res) => {
        const t = await sequelize.transaction();
        const { targetInternalId } = req.body;
        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user,
                    role: "pemilik",
                },
                transaction: t
            });


            if (currentInternal.role != "pemilik") {
                await t.rollback();
                return res.status(400).json({ error: "Internal yang terkait tidak memiliki peran sebagai pemilik" })
            }

            const toko = await currentInternal.getToko({ transaction: t });

            if (!toko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko yang terkait dengan internal tidak ada" })
            }

            const targetInternalFound = await models.internal.findOne({
                where: {
                    tokoId: toko.id,
                    id: targetInternalId,
                }, transaction: t, include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
            })

            if (!targetInternalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Target internal tidak dapat ditemukan" })
            }

            await targetInternalFound.update({
                joinedAt: Date.now(),
                status: "joined"
            }, { transaction: t })

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
                transaction: t
            });

            const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
            const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];

            await models.tokonotification.create({
                description: `Internal dengan kode pengguna #${targetInternalFound.userCode} telah bergabung dengan toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: toko.id,
                typeId: 1,
            }, { transaction: t })

            if (internalDevicesTokens.length > 0) {
                sendMulticastNotification(internalDevicesTokens, {
                    title: "Notifikasi Internal",
                    body: `Internal dengan kode pengguna #${targetInternalFound.userCode} telah bergabung dengan toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            if (targetInternalFound.user.device.deviceToken != null && targetInternalFound.user.device.deviceToken != "") {
                sendNormalNotification(targetInternalFound.user.device.deviceToken, {
                    title: "Notifikasi Internal",
                    body: `Join request anda telah diterima oleh toko ${toko.name} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menerima permintaan bergabung dari internal!"
            });
        } catch (error) {

            console.log(error)
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },


    declineJoinRequestPemilik: async (req, res) => {
        const t = await sequelize.transaction();
        const { targetInternalId } = req.body;
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

            const targetInternalFound = await models.internal.findOne({
                where: {
                    tokoId: toko.id,
                    id: targetInternalId,
                }, transaction: t, include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
            })

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
                transaction: t
            });

            if (!targetInternalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal target tidak ditemukan" })
            }

            await toko.removeInternal(targetInternalFound, { transaction: t });

            const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
            const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];

            await models.tokonotification.create({
                description: `Internal dengan kode pengguna #${targetInternalFound.userCode} permintaan untuk bergabung ke toko telah ditolak pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: toko.id,
                typeId: 1,
            }, { transaction: t })


            await t.commit();

            if (internalDevicesTokens.length > 0) {
                sendMulticastNotification(internalDevicesTokens, {
                    title: "Notifikasi Internal",
                    body: `Internal dengan kode pengguna #${targetInternalFound.userCode} permintaan untuk bergabung ke toko telah ditolak pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            if (targetInternalFound.user.device.deviceToken != null && targetInternalFound.user.device.deviceToken != "") {
                sendNormalNotification(targetInternalFound.user.device.deviceToken, {
                    title: "Notifikasi Internal",
                    body: `Join request anda ke toko ${toko.name} telah ditolak pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            return res.status(200).json({
                msg: "Berhasil menolak permintaan bergabung internal target!"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },


    addInternalThroughUserCode: async (req, res) => {
        const t = await sequelize.transaction();
        const { targetUserCode } = req.body;
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

            const targetInternalFound = await models.internal.findOne({
                where: {
                    userCode: targetUserCode
                }, transaction: t, include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
            })

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
                transaction: t
            });

            const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
            const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];


            if (!targetInternalFound) {
                await t.rollback();
                return res.status(400).json({ error: "Internal dengan kode pengguna tertentu tidak ditemukan" })
            }

            if (targetInternalFound.status == "joined") {
                await t.rollback();
                if (targetInternalFound.tokoId == toko.id) {
                    return res.status(400).json({ error: "Internal sudah menjadi bagian dari toko Anda" })
                } else {
                    return res.status(400).json({ error: "Internal sudah menjadi bagian dari toko lain" })
                }
            } else {
                if (targetInternalFound.tokoId != toko.id) {
                    await toko.addInternal(targetInternalFound, { transaction: t })
                }

                await targetInternalFound.update({
                    joinedAt: Date.now(),
                    status: "joined"
                }, { transaction: t })

                if (internalDevicesTokens.length > 0) {
                    sendMulticastNotification(internalDevicesTokens, {
                        title: "Notifikasi Internal",
                        body: `Internal dengan kode pengguna #${targetInternalFound.userCode} telah bergabung dengan toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                    });
                }

                if (targetInternalFound.user.device.deviceToken != null && targetInternalFound.user.device.deviceToken != "") {
                    sendNormalNotification(targetInternalFound.user.device.deviceToken, {
                        title: "Notifikasi Internal",
                        body: `Anda telah ditambahkan oleh toko ${toko.name} pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                    });
                }
            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil menambahkan internal ke internal toko"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    },

    joinInternalThroughInviteCode: async (req, res) => {
        const t = await sequelize.transaction();
        const { inviteCode } = req.body;
        try {
            const currentInternal = await models.internal.findOne({
                where: {
                    userId: req.user
                },
                include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
                transaction: t
            });

            if (currentInternal.status == "pending" && currentInternal.tokoId != null) {
                await t.rollback();
                return res.status(400).json({ error: "Anda sudah mengirim permintaan bergabung ke sebuah toko" })
            }

            const foundToko = await models.toko.findOne({
                where: {
                    inviteCode: inviteCode
                },
                transaction: t
            })

            if (!foundToko) {
                await t.rollback();
                return res.status(400).json({ error: "Toko dengan kode undangan tertentu tidak ditemukan" })
            }

            if (currentInternal.status == "pending" && currentInternal.tokoId == foundToko.id) {
                await t.rollback();
                return res.status(400).json({ error: "Anda sudah mengirim permintaan bergabung ke toko tertentu" })
            }

            const internals = await models.internal.findAll({
                where: {
                    tokoId: foundToko.id,
                    status: "joined"
                },
                include: {
                    model: models.user,
                    include: {
                        model: models.device
                    }
                },
                transaction: t
            });

            await foundToko.addInternal(currentInternal, { transaction: t })

            const internalUsers = internals.map(e => e.user).filter(e => e.device != null && e.device.deviceToken != null) ?? [];
            const internalDevicesTokens = internalUsers.length > 0 ? internalUsers.map(e => e.device.deviceToken) : [];

            await models.tokonotification.create({
                description: `Internal dengan kode pengguna #${currentInternal.userCode} telah meminta untuk bergabung ke toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                tokoId: foundToko.id,
                typeId: 1,
            }, { transaction: t })

            if (internalDevicesTokens.length > 0) {
                sendMulticastNotification(internalDevicesTokens, {
                    title: "Notifikasi Internal",
                    body: `Internal dengan kode pengguna #${currentInternal.userCode} telah meminta untuk bergabung ke toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                });
            }

            await t.commit();

            return res.status(200).json({
                msg: "Berhasil mengirim permintaan bergabung ke toko"
            });
        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            })
        }
    }

}