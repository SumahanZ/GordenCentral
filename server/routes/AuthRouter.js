const express = require("express");
const authController = require("../controllers/AuthController")
const auth = require("../middlewares/AuthMiddleware");

const router = express.Router();

router.post("/login", authController.login);
router.post("/logout", auth, authController.logout);
router.post("/signup-customer", authController.signUpCustomer);
router.post("/signup-internal", authController.signUpInternal);
router.post("/complete-customer-personalization", authController.completeCustomerPersonalization);
router.post("/complete-karyawan-personalization", authController.completeKaryawanPersonalization);
router.post("/complete-pemilik-personalization", authController.completePemilikPersonalization);
router.get("/get-userdata", auth, authController.getUserInformation);
router.get("/get-toko", auth, authController.getEnrolledToko);
router.get("/get-provinces", authController.getListProvince);
router.get("/get-cities/:provinceId", authController.getListCities);
module.exports = router;