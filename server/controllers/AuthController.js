const { models } = require("../models");
const bcrypt = require("bcryptjs");
var jwt = require('jsonwebtoken');
const { format } = require('date-fns');
const sequelize = require("../utils/db.js");
const { sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    signUpCustomer: async (req, res) => {
        const { name, email, password } = req.body;

        try {
            const existingUser = await models.user.findOne({ where: { email: email } })
            if (existingUser) {
                return res.status(400).json({ error: "Gagal mendaftar sebagai pelanggan karena email sudah ada!" })
            }
            const hashedPassword = bcrypt.hashSync(password, 8);

            const createdUser = await models.user.create({
                name,
                email,
                password: hashedPassword,
                type: "customer"
            },)
            const createdUserJSON = createdUser.toJSON();


            const token = jwt.sign({ id: createdUser.id, type: createdUser.type }, "passwordKey", { expiresIn: '1d' });

            return res.status(200).json({
                token,
                ...createdUserJSON,
            })
        } catch (error) {
            return res.status(500).json({
                error: error.message
            })
        }

    },

    signUpInternal: async (req, res) => {
        const { name, email, password, role } = req.body;
        try {
            const existingUser = await models.user.findOne({ where: { email: email } })
            if (existingUser) {
                return res.status(400).json({ error: "Gagal mendaftar sebagai internal toko karena email sudah ada!" })
            }
            const hashedPassword = bcrypt.hashSync(password, 8);
            const createdUser = await models.user.create({
                name,
                email,
                password: hashedPassword,
                type: role
            })

            const createdUserJSON = createdUser.toJSON();

            const token = jwt.sign({ id: createdUser.id, type: createdUser.type }, "passwordKey", { expiresIn: '1d' });
            return res.status(200).json({
                token,
                ...createdUserJSON,
            })

        } catch (error) {
            return res.status(500).json({
                error: error.message
            })
        }

    },

    completeKaryawanPersonalization: async (req, res) => {
        const t = await sequelize.transaction();
        const { inviteCode, name, password, email, role, deviceToken } = req.body;

        try {
            const existingUser = await models.user.findOne({ where: { email: email }, transaction: t })
            if (existingUser) {
                await t.rollback();
                return res.status(400).json({ error: "Gagal mendaftar sebagai pelanggan karena email sudah ada!" })
            }
            const hashedPassword = bcrypt.hashSync(password, 8);
            const createdUser = await models.user.create({
                name,
                email,
                password: hashedPassword,
                type: "karyawan"
            }, { transaction: t })

            const createdUserJSON = createdUser.toJSON();

            var code = generateUserCode(8);

            var checkInternal = await models.internal.findOne({
                where: {
                    userCode: code
                },
                transaction: t
            })

            if (checkInternal) {
                do {
                    code = generateUserCode(8);
                    checkInternal = await models.internal.findOne({
                        where: {
                            userCode: code
                        },
                        transaction: t
                    })
                } while (code == checkInternal.userCode)
            }

            const newInternal = await createdUser.createInternal({
                role: role,
                userCode: code,
            }, { transaction: t });

            await models.user.update({
                personalizationFinished: true,
            }, { where: { id: createdUser.id }, transaction: t });

            if (inviteCode != null && inviteCode != "") {
                var queryToko = await models.toko.findOne({
                    where: {
                        inviteCode: inviteCode
                    },
                    transaction: t
                });

                if (queryToko == null) {
                    await t.rollback();
                    return res.status(400).json({ error: "Toko dengan kode undangan ini tidak ditemukan" });
                }
                await queryToko.addInternal(newInternal, { transaction: t });


                const internals = await models.internal.findAll({
                    where: {
                        tokoId: queryToko.id
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

                //create notification for internal request join
                await models.tokonotification.create({
                    description: `Internal dengan kode pengguna #${newInternal.userCode} telah meminta untuk bergabung dengan toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`,
                    tokoId: queryToko.id,
                    typeId: 1,
                }, { transaction: t })

                if (internalDevicesTokens.length > 0) {
                    sendMulticastNotification(internalDevicesTokens, {
                        title: "Notifikasi Internal",
                        body: `Internal dengan kode pengguna #${newInternal.userCode} telah meminta untuk bergabung dengan toko pada ${format(Date.now(), "EEEE, MMMM d, yyyy h:mm a")}.`
                    });
                }
            }

            const [currentDevice, created] = await models.device.findOrCreate({
                where: {
                    userId: createdUser.id
                },
                defaults: {
                    userId: createdUser.id,
                    deviceToken: deviceToken,
                },
                transaction: t
            });

            if (!created && currentDevice && currentDevice.deviceToken !== deviceToken) {
                await currentDevice.update({
                    deviceToken: deviceToken,
                }, { transaction: t })
            }

            const token = jwt.sign({ id: createdUser.id, type: createdUser.type }, "passwordKey", { expiresIn: '1d' });

            await t.commit();

            return res.status(200).json({
                token,
                ...createdUserJSON,
            });

        } catch (error) {
            await t.rollback();
            return res.status(500).json({
                error: error.message
            });
        }

    },

    completePemilikPersonalization: async (req, res) => {
        const { name, password, email, role, tokoName, tokoPhoneNumber, tokoStreetAddress, cityId, tokoCountry, tokoPostalCode, tokoBio, tokoWhatsAppUrl, tokoInviteCode, tokoProfilePhotoUrl, deviceToken } = req.body;

        try {
            const existingUser = await models.user.findOne({ where: { email: email } })
            if (existingUser) {
                return res.status(400).json({ error: "Gagal mendaftar sebagai pelanggan karena email sudah ada!" })
            }
            const hashedPassword = bcrypt.hashSync(password, 8);
            const createdUser = await models.user.create({
                name,
                email,
                password: hashedPassword,
                type: "pemilik"
            },)

            const createdUserJSON = createdUser.toJSON();

            const token = jwt.sign({ id: createdUser.id, type: createdUser.type }, "passwordKey", { expiresIn: '1d' });

            var code = generateUserCode(8);

            var checkInternal = await models.internal.findOne({
                where: {
                    userCode: code
                },
            })

            if (checkInternal) {
                do {
                    code = generateUserCode(8);
                    checkInternal = await models.internal.findOne({
                        where: {
                            userCode: code
                        },
                    })
                } while (code == checkInternal.userCode)
            }

            const createdInternal = await createdUser.createInternal({
                role: role,
                userCode: code,
            });

            await models.user.update({
                personalizationFinished: true,
            }, { where: { id: createdUser.id } });

            var tokoResults;

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
                })

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
                })
            }

            const [currentDevice, created] = await models.device.findOrCreate({
                where: {
                    userId: createdUser.id
                },
                defaults: {
                    userId: createdUser.id,
                    deviceToken: deviceToken,
                }
            });

            if (!created && currentDevice && currentDevice.deviceToken !== deviceToken) {
                await currentDevice.update({
                    deviceToken: deviceToken
                })
            }

            await createdInternal.update({ joinedAt: Date.now(), tokoId: tokoResults.id, status: "joined" })
            return res.status(200).json({
                token,
                ...createdUserJSON,
            });

        } catch (error) {
            return res.status(500).json({
                error: error.message
            });
        }

    },


    completeCustomerPersonalization: async (req, res) => {
        const { streetAddress, cityId, country, postalCode, name, password, role, email, deviceToken } = req.body;

        try {
            const existingUser = await models.user.findOne({ where: { email: email } })

            if (existingUser) {
                return res.status(400).json({ error: "Gagal mendaftar sebagai pelanggan karena email sudah ada!" })
            }
            const hashedPassword = bcrypt.hashSync(password, 8);
            const createdUser = await models.user.create({
                name,
                email,
                password: hashedPassword,
                type: "customer"
            },)

            const createdUserJSON = createdUser.toJSON();

            const token = jwt.sign({ id: createdUser.id, type: createdUser.type }, "passwordKey", { expiresIn: '1d' });

            var code = generateUserCode(8);

            var checkCustomer = await models.customer.findOne({
                where: {
                    customerCode: code
                },
            })

            if (checkCustomer) {
                do {
                    code = generateUserCode(8);
                    checkCustomer = await models.customer.findOne({
                        where: {
                            customerCode: code
                        },
                    })
                } while (code == checkCustomer.customerCode)
            }

            await createdUser.createCustomer({
                role: req.type,
                customerCode: code,
                address: {
                    streetAddress: streetAddress,
                    country: country,
                    cityId: cityId,
                    postalCode: postalCode,
                },
            }, {
                include: [{
                    model: models.address,
                }]
            });

            const [currentDevice, created] = await models.device.findOrCreate({
                where: {
                    userId: createdUser.id
                },
                defaults: {
                    userId: createdUser.id,
                    deviceToken: deviceToken,
                }
            });

            if (!created && currentDevice && currentDevice.deviceToken !== deviceToken) {
                await currentDevice.update({
                    deviceToken: deviceToken
                })
            }

            await models.user.update({
                personalizationFinished: true,
            }, { where: { id: createdUser.id, } })

            return res.status(200).json({
                token,
                ...createdUserJSON,
            });

        } catch (error) {
            return res.status(500).json({
                error: error.message
            });
        }

    },

    login: async (req, res) => {
        try {
            const { password, email, deviceToken } = req.body;
            let user = await models.user.findOne({ where: { email: email } });

            if (!user) {
                return res.status(400).json({ error: "Pengguna dengan email ini tidak ditemukan" })
            }

            const isMatch = await bcrypt.compare(password, user.password);

            if (!isMatch) {
                return res.status(500).json({ error: "Password yang dimasukkan tidak valid" });
            }

            const createdUserJSON = user.toJSON();


            const [currentDevice, created] = await models.device.findOrCreate({
                where: {
                    userId: user.id
                },
                defaults: {
                    userId: user.id,
                    deviceToken: deviceToken,
                }
            });

            if (!created && currentDevice && currentDevice.deviceToken !== deviceToken) {
                await currentDevice.update({
                    deviceToken: deviceToken
                })
            }

            const token = jwt.sign({ id: user.id, type: user.type }, "passwordKey", { expiresIn: '1d' });

            return res.status(200).json({
                token,
                ...createdUserJSON,
            })
        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    },

    logout: async (req, res) => {
        try {
            await models.device.update({
                deviceToken: null
            }, {
                where: {
                    userId: req.user
                }
            })

            return res.status(200).json({ msg: "Sukses logout!" })
        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    },

    getUserInformation: async (req, res) => {
        try {
            const queryUser = await models.user.findByPk(req.user)
            const createdUserJSON = queryUser.toJSON();
            const token = req.token;


            return res.status(200).json({
                token,
                ...createdUserJSON,
            })
        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    },


    getEnrolledToko: async (req, res) => {
        try {
            const queryInternal = await models.internal.findOne({ where: { userId: req.user } })
            const toko = await queryInternal.getToko();

            return res.status(200).json(toko.dataValues)
        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    },


    getListProvince: async (req, res) => {
        try {
            const provinceList = await models.province.findAll();

            const mappedProvinceList = provinceList.map(e => e.toJSON());

            return res.status(200).json(mappedProvinceList)
        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    },

    getListCities: async (req, res) => {
        try {
            const provinceId = req.params.provinceId;

            const citiesList = await models.city.findAll({
                where: {
                    provinceId: provinceId
                }
            });

            const mappedCitiesList = citiesList.map(e => e.toJSON());
            return res.status(200).json(mappedCitiesList)

        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    }

}


function generateUserCode(length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let code = '';
    for (let i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
}
