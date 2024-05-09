var admin = require("firebase-admin");
var serviceAccount = require("./push_notification_key.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

async function sendMulticastNotification(token, notificationData) {
    try {
        const message = {
            android: {
                priority: "high"
            },
            tokens: token,
            notification: {
                title: notificationData.title,
                body: notificationData.body
            },
        };
        const response = await admin.messaging().sendEachForMulticast(message);
        console.log("Successfully sent notification to device:", response);
        return response;
    } catch (error) {
        console.error("Error sending notification to device:", error);
        throw error;
    }
}

async function sendNormalNotification(token, notificationData) {
    try {
        const message = {
            android: {
                priority: "high"
            },
            token: token,
            notification: {
                title: notificationData.title,
                body: notificationData.body
            },
        };
        const response = await admin.messaging().send(message);
        console.log("Successfully sent notification to device:", response);
        return response;
    } catch (error) {
        console.error("Error sending notification to device:", error);
        throw error;
    }
}

module.exports = {
    admin: admin,
    sendMulticastNotification,
    sendNormalNotification
};