const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('device', {
        deviceToken: {
            type: DataTypes.STRING,
        },
    });
};