const express = require("express");
const internalSettingsController = require("../controllers/InternalSettingsController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/settings-internal", auth, internalSettingsController.fetchInternalInformation);
module.exports = router;