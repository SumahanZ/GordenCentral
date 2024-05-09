const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('cart', {
        name: {
            type: DataTypes.STRING,
        },
    });
};