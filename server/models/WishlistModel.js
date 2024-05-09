const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('wishlist', {
        name: {
            type: DataTypes.STRING,
        },
    });
};