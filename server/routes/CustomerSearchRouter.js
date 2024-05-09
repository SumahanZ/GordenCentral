const express = require("express");
const customerSearchController = require("../controllers/CustomerSearchController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/customer-search/fetch-produks", auth, customerSearchController.fetchAllProducts);
router.get("/customer-search/fetch-search-option", auth, customerSearchController.fetchSearchSelectionOptions);
router.post("/customer-search/fetch-filtered-products", auth, customerSearchController.fetchFilteredProducts);
module.exports = router;