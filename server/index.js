const express = require("express");
const http = require("http");
const sequelize = require("./models/index.js");
const cors = require("cors");
const dotenv = require("dotenv");
var cron = require('node-cron');
const authRouter = require("./routes/AuthRouter.js");
// const cronScheduler = require("./utils/cron_scheduler.js");
const profileTokoRouter = require("./routes/ProfileTokoRouter.js");
const internalSettingsRouter = require("./routes/InternalSettingsRouter.js");
const internalAccountRouter = require("./routes/InternalAccountRouter.js");
const produkStokRouter = require("./routes/ProdukStokRouter.js");
const customerTokoRouter = require("./routes/CustomerTokoRouter.js");
const wishlistRouter = require("./routes/WishlistRouter.js");
const customerSettingsRouter = require("./routes/CustomerSettingsRouter.js");
const customerAccountRouter = require("./routes/CustomerAccountRouter.js");
const customerCartRouter = require("./routes/CartRouter.js");
const internalTokoRouter = require("./routes/InternalTokoRouter.js");
const customerOrderRouter = require("./routes/CustomerOrderRouter.js");
const internalOrderRouter = require("./routes/InternalOrderRouter.js");
const customerDashboardRouter = require("./routes/CustomerDashboardRouter.js");
const customerSearchRouter = require("./routes/CustomerSearchRouter.js");
const internalNotificationRouter = require("./routes/InternalNotificationRouter.js");
const internalDashboardRouter = require("./routes/InternalDashboardRouter.js");
const internalLaporanBarangRouter = require("./routes/InternalLaporanBarangRouter.js");
const internalAnalisisKeuanganRouter = require("./routes/InternalAnalisisKeuanganRouter.js");
const customerNotificationRouter = require("./routes/CustomerNotificationRouter.js");
const pushNotificationRouter = require("./routes/PushNotificationRouter.js");

dotenv.config();

const app = express();
const PORT = process.env.PORT | 3001;

var server = http.createServer(app);

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
//we have to make index.js know about the routers using a middleware
app.use(authRouter);
app.use(profileTokoRouter);
app.use(internalSettingsRouter);
app.use(internalAccountRouter);
app.use(produkStokRouter);
app.use(customerTokoRouter);
app.use(wishlistRouter);
app.use(customerSettingsRouter);
app.use(customerAccountRouter);
app.use(customerCartRouter);
app.use(internalTokoRouter);
app.use(customerOrderRouter);
app.use(internalOrderRouter);
app.use(customerDashboardRouter);
app.use(customerSearchRouter);
app.use(internalNotificationRouter);
app.use(internalDashboardRouter);
app.use(internalLaporanBarangRouter);
app.use(internalAnalisisKeuanganRouter);
app.use(customerNotificationRouter);
app.use(pushNotificationRouter);

//0.0.0.0 means that we can access the site from any ip address
//we start listening with server variable instead of app now
server.listen(PORT, "0.0.0.0", () => {
    console.log(`connected listened at ${process.env.PORT}`);
});
