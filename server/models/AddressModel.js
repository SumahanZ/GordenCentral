const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('address', {
        streetAddress: {
            type: DataTypes.STRING,
        },
        country: {
            type: DataTypes.STRING,
        },
        postalCode: {
            type: DataTypes.STRING,
        },
    });
};