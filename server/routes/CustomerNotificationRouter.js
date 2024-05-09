const express = require("express");
const customerNotificationController = require("../controllers/CustomerNotificationController.js")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/customer-notification/fetch-customer-notifications", auth, customerNotificationController.fetchCustomerNotifications);
module.exports = router;