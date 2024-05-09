const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('produkrating', {
        rating: {
            type: DataTypes.FLOAT,
            allowNull: false,
            validate: {
                min: 1,
                max: 5,
                isNumeric: true,
            }
        }
    });
};