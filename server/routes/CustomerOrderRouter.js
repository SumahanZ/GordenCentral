const express = require("express");
const customerOrderController = require("../controllers/CustomerOrderController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/customer-orders/complete-order", auth, customerOrderController.completeOrder);
router.post("/customer-orders/cancel-order", auth, customerOrderController.cancelOrder);
router.get("/customer-orders/fetch-orders", auth, customerOrderController.fetchOrders);
router.get("/customer-orders/fetch-orders-produk/:orderId", auth, customerOrderController.fetchProdukOfOrders);
module.exports = router;