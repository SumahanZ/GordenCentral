const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('formulasettings', {
        windowSize: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
        },
        serviceLevel: {
            type: DataTypes.INTEGER,
            defaultValue: 95,
        }
    });
};