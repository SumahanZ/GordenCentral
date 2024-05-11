const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('customer', {
        profilePhotoURL: {
            type: DataTypes.STRING
        },
        customerCode: {
            type: DataTypes.STRING,
            unique: "userCode",
        },
    });
};