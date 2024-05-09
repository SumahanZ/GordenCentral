const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('tokonotification', {
        description: {
            type: DataTypes.STRING,
        },
    },);
};