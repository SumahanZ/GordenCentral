const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('customernotificationtype', {
        name: {
            type: DataTypes.STRING,
            unique: "name",
        },
    },);
};