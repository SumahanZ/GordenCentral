const express = require("express");
const customerTokoController = require("../controllers/CustomerTokoController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/browsetoko/fetch-tokos", auth, customerTokoController.fetchTokos);
router.get("/toko/fetch-toko/:tokoId", auth, customerTokoController.fetchToko);
router.get("/toko/katalog-produk/:tokoId", auth, customerTokoController.fetchKatalogProdukToko);
router.get("/toko/produk-detail/:tokoId/:produkId", auth, customerTokoController.fetchProdukDetail);
router.post("/wishlist/add-produk-wishlist", auth, customerTokoController.addProdukToWishlist);
router.post("/cart/add-produk-cart", auth, customerTokoController.addProdukVariantToCart);
router.post("/cart/add-produk-cart-modal", auth, customerTokoController.addProdukVariantToCartFromModal);
module.exports = router;
