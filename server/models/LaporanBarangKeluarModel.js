const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('laporanbarangkeluar', {
        amount: {
            type: DataTypes.STRING,
        },
    });
};