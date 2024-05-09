const express = require("express");
const produkStokController = require("../controllers/ProdukStokController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/produk/input-stok-produk", auth, produkStokController.inputStokProduk);
router.post("/produk/add-stok-produk", auth, produkStokController.addStokProduk);
//router.post("/produk/add-produk-category", auth, produkStokController.addProdukCategory);
router.get("/produk/fetch-categories", auth, produkStokController.fetchCategories);
router.get("/produk/fetch-produk-add-stok", auth, produkStokController.fetchProduks);
router.post("/produk/calculate-safety-stock-reorder-point", auth, produkStokController.calculateSafetyStockAndReorderPoint);
router.post("/produk/check-safety-stock-reorder-point", auth, produkStokController.checkSafetyStockReorderPoint);
router.get("/produk/fetch-produk-outofstok-critical-count", auth, produkStokController.fetchProductOutOfStockAndCriticalCount);

module.exports = router;