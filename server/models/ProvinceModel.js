const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('province', {
        name: {
            type: DataTypes.STRING,
        },
    }, { timestamps: false, });
};