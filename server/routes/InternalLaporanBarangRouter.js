const express = require("express");
const internalLaporanBarangController = require("../controllers/InternalLaporanBarangController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/internal-laporan-barang/fetch-laporan-barang-masuk", auth, internalLaporanBarangController.fetchLaporanBarangMasuk);
router.get("/internal-laporan-barang/fetch-laporan-barang-keluar", auth, internalLaporanBarangController.fetchLaporanBarangKeluar);
router.get("/internal-laporan-barang/fetch-laporan-general-information", auth, internalLaporanBarangController.fetchLaporanGeneralInformation);
module.exports = router;