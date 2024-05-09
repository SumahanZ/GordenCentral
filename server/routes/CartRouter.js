const express = require("express");
const cartController = require("../controllers/CartController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/cart/fetch-cart", auth, cartController.fetchCustomerCart);
router.post("/cart/increase-quantity-cartitem", auth, cartController.increaseCartItemQuantity);
router.post("/cart/decrease-quantity-cartitem", auth, cartController.decreaseCartItemQuantity);
router.post("/cart/create-order", auth, cartController.createOrder);
module.exports = router;