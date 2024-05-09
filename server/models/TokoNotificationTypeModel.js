const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('tokonotificationtype', {
        name: {
            type: DataTypes.STRING,
            unique: "name",
        },
    },);
};