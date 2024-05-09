const express = require("express");
const customerDashboardController = require("../controllers/CustomerDashboardController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/customer-dashboard/fetch-most-popular-products", auth, customerDashboardController.fetchMostPopularProduks);
router.get("/customer-dashboard/fetch-new-arrival-products", auth, customerDashboardController.fetchNewArrivalProduks);
router.get("/customer-dashboard/fetch-promo-products", auth, customerDashboardController.fetchPromoProduks);
router.get("/customer-dashboard/fetch-order-completed-ongoing-count", auth, customerDashboardController.fetchOrderCompletedOngoingCount);
module.exports = router;