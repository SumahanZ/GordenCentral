const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('user', {
        name: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        email: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: "unique_email",
        },
        password: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        type: {
            type: DataTypes.STRING,
        },
        personalizationFinished: {
            type: DataTypes.BOOLEAN,
            defaultValue: false,
        }
    });
};