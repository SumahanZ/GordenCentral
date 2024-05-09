const { models } = require("../models");
const sequelize = require("../utils/db.js");
const { admin, sendMulticastNotification, sendNormalNotification } = require("../utils/firebaseAdmin.js");

module.exports = {
    updateUserDeviceToken: async (req, res) => {
        const t = await sequelize.transaction();
        const { deviceToken } = req.body;

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

            const currentDevice = await models.device.findOrCreate({
                where: {
                    userId: req.user
                },
                defaults: {
                    userId: req.user,
                    deviceToken: deviceToken,
                }
            });

            if (currentDevice && (currentDevice.deviceToken != deviceToken)) {
                await currentDevice.update({
                    deviceToken: deviceToken
                })
            }

            await t.commit();

            return res.status(200).json({ msg: "Success updating user device token" })
        } catch (error) {
            return res.status(500).json({
                error: error.message
            })
        }
    },


    testPushNotification: async (req, res) => {
        const notificationData = {
            title: "New Message",
            body: "You have a new message from the server."
        };
        try {
            sendMulticastNotification(
                ["czP-wTiRSRqFWJigMl06y6:APA91bEK-N4x2XWINIcwGsfx1c3vdF-h8CVv8yTRAzGLAfyh5ZkfPzFIQD0t5PczGgaarP12708POG1r0WHSArLPGWtcJcAfPVdf86d_suYIZZHUNyPo2qsgjv1YS_Ly6GhP7mbZhLcr"]
                , notificationData)

            return res.status(200).json({
                msg: "Notification send successfully!"
            })

        } catch (error) {
            return res.status(500).json({ error: error })
        }
    }

}