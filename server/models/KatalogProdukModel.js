const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('katalogproduk', {
        name: {
            type: DataTypes.STRING,
            required: true,
        },
    });
};