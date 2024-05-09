const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('produkcolor', {
        name: {
            type: DataTypes.STRING,
        },
        produkColorImageUrl: {
            type: DataTypes.STRING,
            unique: "unique_produk_color_image",
        }
    });
};