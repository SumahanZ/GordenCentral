const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('produkcategory', {
        name: {
            type: DataTypes.STRING,
        },
    });
};