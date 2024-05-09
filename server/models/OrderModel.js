const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('order', {
        code: {
            type: DataTypes.STRING,
            unique: "orderCode",
        },
        finalPriceTotal: {
            type: DataTypes.DOUBLE,
            defaultValue: 0
        },
        discountAmountTotal: {
            type: DataTypes.DOUBLE,
            defaultValue: 0
        },
        originalPriceTotal: {
            type: DataTypes.DOUBLE,
            defaultValue: 0
        },
        discountPercentTotal: {
            type: DataTypes.INTEGER,
        },
        note: {
            type: DataTypes.STRING
        },
        completedAt: {
            type: DataTypes.DATE,
        },
        cancelledAt: {
            type: DataTypes.DATE,
        },
    });
};