const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('produk', {
        name: {
            type: DataTypes.STRING,
            unique: "unique_produk_name",
        },
        description: {
            type: DataTypes.STRING,
        },
        price: {
            type: DataTypes.DOUBLE,
        },
        code: {
            type: DataTypes.STRING
        }
    });
};