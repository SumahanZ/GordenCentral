const express = require("express");
const internalDashboardController = require("../controllers/InternalDashboardController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/internal-dashboard/fetch-order-completed-ongoing-count", auth, internalDashboardController.fetchOrderCompletedOngoingCount);
module.exports = router;