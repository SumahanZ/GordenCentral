const express = require("express");
const pushNotificationController = require("../controllers/PushNotificationController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/user/update-device-token", auth, pushNotificationController.updateUserDeviceToken);
router.get("/user/test-token-notification", pushNotificationController.testPushNotification);
module.exports = router;