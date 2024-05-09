const express = require("express");
const customerSettingsController = require("../controllers/CustomerSettingsController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/settings-customer", auth, customerSettingsController.fetchCustomerInformation);
module.exports = router;