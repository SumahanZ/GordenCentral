const express = require("express");
const profileTokoController = require("../controllers/ProfileTokoController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/profiletoko/create-toko-information", auth, profileTokoController.configureTokoInformation);
router.get("/profiletoko/fetch-toko-information", auth, profileTokoController.fetchPreviewTokoInformation);
router.post("/profiletoko/configure-beranda-toko", auth, profileTokoController.configureBerandaToko);
router.get("/profiletoko/fetch-beranda-toko-information", auth, profileTokoController.fetchBerandaInformation);
router.get("/profiletoko/katalog-produk-produk-items", auth, profileTokoController.fetchCategoryItemProdukList);
router.post("/profiletoko/add-katalog-produk", auth, profileTokoController.addKatalogProduk);
router.post("/profiletoko/edit-katalog-produk", auth, profileTokoController.editKatalogProduk);
router.get("/profiletoko/fetch-katalog-produk", auth, profileTokoController.fetchKatalogProdukToko);
router.get("/profiletoko/fetch-katalog-produk-preview", auth, profileTokoController.fetchKatalogProdukTokoPreview);
router.get("/profiletoko/fetch-katalog-produk-single/:id", auth, profileTokoController.fetchSingleKatalogProduk);
router.get("/profiletoko/fetch-produk-detail/:produkId", auth, profileTokoController.fetchProdukDetail);
router.post("/profiletoko/configure-beranda-toko", auth, profileTokoController.configureBerandaToko);
router.post("/profiletoko/edit-produk/:produkId", auth, profileTokoController.editProduk);
router.get("/profiletoko/fetch-available-promo-items", auth, profileTokoController.fetchAvailablePromoItems);
router.get("/profiletoko/fetch-promos", auth, profileTokoController.fetchPromos);
router.delete("/profiletoko/remove-promo/:promoId", auth, profileTokoController.removePromo);
router.post("/profiletoko/edit-promo/:promoId", auth, profileTokoController.editPromo);
router.post("/profiletoko/add-promo", auth, profileTokoController.addPromo);
module.exports = router;