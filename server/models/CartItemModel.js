const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('cartitem', {
        amount: {
            type: DataTypes.INTEGER,
        },
    });
};