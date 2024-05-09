const { DataTypes } = require('sequelize');
module.exports = (sequelize) => {
    sequelize.define('toko', {
        name: {
            type: DataTypes.STRING,
            unique: "name",
        },
        phoneNumber: {
            type: DataTypes.STRING,
        },
        bio: {
            type: DataTypes.STRING,
        },
        whatsAppURL: {
            type: DataTypes.STRING,
            unique: "whatsapp_url",
        },
        profilePhotoURL: {
            type: DataTypes.STRING,
        },
        inviteCode: {
            type: DataTypes.STRING,
            unique: "toko_invite_code",
        }
    },);
};