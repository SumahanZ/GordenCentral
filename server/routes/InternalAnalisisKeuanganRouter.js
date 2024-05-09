const express = require("express");
const internalAnalisisKeuanganController = require("../controllers/InternalAnalisisKeuanganController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/internal-analisis-keuangan/fetch-analisis-keuangan-information", auth, internalAnalisisKeuanganController.fetchAnalisisKeuanganGeneralInformation);
router.get("/internal-analisis-keuangan/fetch-recent-transactions", auth, internalAnalisisKeuanganController.fetchRecentTransactions);
router.get("/internal-analisis-keuangan/fetch-sales-report", auth, internalAnalisisKeuanganController.fetchSalesReport);
module.exports = router;