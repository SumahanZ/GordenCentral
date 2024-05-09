const express = require("express");
const wishlistController = require("../controllers/WishlistController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.delete("/wishlist/remove-produk-wishlist/:produkId", auth, wishlistController.removeProdukFromWishlist);
router.get("/wishlist/fetch-wishlist", auth, wishlistController.fetchWishlist);
module.exports = router;