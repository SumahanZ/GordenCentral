const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('productcombination', {
        variantAmount: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
        },
    });
};