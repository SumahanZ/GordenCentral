const express = require("express");
const internalTokoController = require("../controllers/InternalTokoController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.get("/internal-toko/fetch", auth, internalTokoController.fetchInternals);
router.post("/internal-toko/accept-join-request", auth, internalTokoController.acceptJoinRequestPemilik);
router.post("/internal-toko/decline-join-request", auth, internalTokoController.declineJoinRequestPemilik);
router.post("/internal-toko/add-internal-through-user-code", auth, internalTokoController.addInternalThroughUserCode);
router.post("/internal-toko/join-internal-through-invite-code", auth, internalTokoController.joinInternalThroughInviteCode);
module.exports = router;