const jwt = require("jsonwebtoken")
const { models } = require("../models");

// MIDDLEWARE: PERIKSA TOKEN DAN JENIS PENGGUNA ADALAH PELANGGAN
const customer = async (req, res, next) => {
    try {
        const token = req.header("token");

        if (!token)
            return res.status(401).json({ error: "Tidak ada token otentikasi, akses ditolak" });
        const decodedTokenData = jwt.verify(token, "passwordKey");

        if (!decodedTokenData)
            return res.status(401).json({ error: "Verifikasi token gagal, otorisasi ditolak." });

        // Verifikasi apakah id decodedTokenData sesuai dengan yang ada di database
        const existingUser = await models.user.findByPk(decodedTokenData.id);

        if (!existingUser) {
            return res.status(401).json({ error: "Pengguna dengan id token ini tidak ditemukan." });
        }

        if (!(existingUser.type == "customer"))
            return res.status(401).json({ error: "Anda bukan pelanggan, otorisasi ditolak." });

        req.user = decodedTokenData.id;
        req.type = decodedTokenData.type;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

module.exports = customer;
