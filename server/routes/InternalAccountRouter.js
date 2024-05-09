const express = require("express");
const internalAccountController = require("../controllers/InternalAccountController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/profile-internal/edit", auth, internalAccountController.editInternalProfile);
module.exports = router;