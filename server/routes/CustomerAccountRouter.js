const express = require("express");
const customerAccountController = require("../controllers/CustomerAccountController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/profile-customer/edit", auth, customerAccountController.editCustomerProfile);
router.post("/configure-delivery-information/customer", auth, customerAccountController.configureDeliveryInformation);
router.get("/fetch-delivery-information/customer", auth, customerAccountController.fetchDeliveryInformation);
module.exports = router;