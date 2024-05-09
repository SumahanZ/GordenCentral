const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('internal', {
        userCode: {
            type: DataTypes.STRING,
            unique: "userCode",
        },
        role: {
            type: DataTypes.STRING,
        },
        status: {
            type: DataTypes.STRING,
            defaultValue: "pending"
        },
        joinedAt: {
            type: DataTypes.DATE,
        },
        profilePhotoURL: {
            type: DataTypes.STRING
        }
    });
};