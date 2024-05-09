const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('promo', {
        discountPercent: {
            type: DataTypes.INTEGER,
        },
        expiredAt: {
            type: DataTypes.DATE
        }
    });
};