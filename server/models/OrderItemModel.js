const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('orderitem', {
        amount: {
            type: DataTypes.INTEGER,
        },
    });
};