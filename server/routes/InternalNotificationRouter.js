const express = require("express");
const internalNotificationController = require("../controllers/InternalNotificationController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/internal-notification/fetch-toko-notifications", auth, internalNotificationController.fetchTokoNotifications);
module.exports = router;