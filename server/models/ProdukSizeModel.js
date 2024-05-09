const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('produksize', {
        name: {
            type: DataTypes.STRING,
        },
    });
};