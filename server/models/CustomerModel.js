const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('customer', {
        role: {
            type: DataTypes.STRING,
        },
        profilePhotoURL: {
            type: DataTypes.STRING
        },
        customerCode: {
            type: DataTypes.STRING,
            unique: "userCode",
        },
    });
};