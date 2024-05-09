const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('laporanbarangmasuk', {
        amount: {
            type: DataTypes.STRING,
        },
        issuedFrom: {
            type: DataTypes.DATE,
        },
        deliveredAt: {
            type: DataTypes.DATE,
        },
        deliveryTime: {
            type: DataTypes.INTEGER,
        },
    }, {
        timestamps: false
    });
};