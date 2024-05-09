const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('promotional', {
        berandaImageUrl: {
            type: DataTypes.STRING,
            required: true,
        },
        // order: {
        //     type: DataTypes.INTEGER,
        //     required: true,
        // }
    });
};