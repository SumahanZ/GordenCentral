const { Sequelize } = require('sequelize');
const { applyAssociations } = require('./defineassociation.js');
const sequelize = require("../utils/db.js");

// In a real app, you should keep the database connection URL as an environment variable.
// But for this example, we will just use a local SQLite database.
// const sequelize = new Sequelize(process.env.DB_CONNECTION_URL);

const modelDefiners = [
    require('./UserModel.js'),
    require("./AddressModel.js"),
    require("./CustomerModel.js"),
    require("./InternalModel.js"),
    require("./TokoModel.js"),
    require("./BerandaTokoModel.js"),
    require("./ProdukModel.js"),
    require("./ProdukGlobalImageModel.js"),
    require("./ProdukSizeModel.js"),
    require("./ProdukColorModel.js"),
    require("./ProdukCategoryModel.js"),
    require("./StokModel.js"),
    require("./ProdukCombinationModel.js"),
    require("./LaporanBarangMasukModel.js"),
    require("./LaporanBarangKeluarModel.js"),
    require("./KatalogProdukModel.js"),
    require("./WishlistModel.js"),
    require("./CartModel.js"),
    require("./CartItemModel.js"),
    require("./ProvinceModel.js"),
    require("./CityModel.js"),
    require("./PromoModel.js"),
    require("./OrderModel.js"),
    require("./OrderItemModel.js"),
    require("./OrderStatusModel.js"),
    require("./ProductRatingModel.js"),
    require("./CustomerNotificationModel.js"),
    require("./CustomerNotificationTypeModel.js"),
    require("./TokoNotificationModel.js"),
    require("./TokoNotificationTypeModel.js"),
    require("./FormulaSettingsModel.js"),
    require("./DeviceModel.js")
    // require('./models/instrument.model'),
    // require('./models/orchestra.model'),
    // Add more models here...
    // require('./models/item'),
];

// We define all models according to their files.
for (const modelDefiner of modelDefiners) {
    modelDefiner(sequelize);
}

// We execute any extra setup after the models are defined, such as adding associations.
applyAssociations(sequelize);
sequelize.sync().then(() => console.log("All models were synchronized successfully.")).catch((error) => console.log('Models fail', error));
// We export the sequelize connection instance to be used around our app.
module.exports = sequelize;