const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('produkglobalimage', {
        globalImageUrl: {
            type: DataTypes.STRING,
            unique: "unique_global_image",
        },
    });
};