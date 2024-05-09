const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('customernotification', {
        description: {
            type: DataTypes.STRING,
        },
    },);
};