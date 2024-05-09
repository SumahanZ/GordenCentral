const jwt = require("jsonwebtoken")
const { models } = require("../models");

// MIDDLEWARE: PERIKSA TOKEN DAN JENIS PENGGUNA ADALAH PELANGGAN
const auth = async (req, res, next) => {
    try {
        const token = req.header("token");

        if (!token)
            return res.status(401).json({ error: "Tidak ada token otentikasi, akses ditolak" });
        const decodedTokenData = jwt.verify(token, "passwordKey");

        if (!decodedTokenData)
            return res.status(401).json({ error: "Verifikasi token gagal, otorisasi ditolak." });

        const existingUser = await models.user.findByPk(decodedTokenData.id);

        if (!existingUser) {
            return res.status(401).json({ error: "Pengguna dengan id token ini tidak ditemukan." });
        }

        const tokenExpiration = decodedTokenData.exp * 1000; 
        const currentTimestamp = Date.now();

        if (currentTimestamp > tokenExpiration) {
            await models.device.update({
                deviceToken: null
            }, {
                where: {
                    userId: decodedTokenData.id
                }
            })
            return res.status(401).json({ error: "Token telah kedaluwarsa, harap masuk kembali." });
        }

        req.user = decodedTokenData.id;
        req.type = decodedTokenData.type;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

module.exports = auth;
