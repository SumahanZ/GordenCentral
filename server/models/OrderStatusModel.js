const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('orderstatus', {
        name: {
            type: DataTypes.STRING,
        },
    }, { timestamps: false });
};