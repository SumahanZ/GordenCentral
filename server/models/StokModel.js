const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('stok', {
        totalAmount: {
            type: DataTypes.INTEGER,
        },
        safetyStock: {
            type: DataTypes.INTEGER,
        },
        reorderPoint: {
            type: DataTypes.INTEGER,
        }
    });
};