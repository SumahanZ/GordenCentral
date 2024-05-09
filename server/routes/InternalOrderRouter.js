const express = require("express");
const internalOrderController = require("../controllers/InternalOrderController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/internal-orders/cancel-order", auth, internalOrderController.cancelOrder);
router.post("/internal-orders/configure-order", auth, internalOrderController.configureOrder);
router.get("/internal-orders/fetch-customer-orders", auth, internalOrderController.fetchAllCustomerOrders);
router.get("/internal-orders/fetch-order-stasus", auth, internalOrderController.fetchOrderStasuses);
module.exports = router;