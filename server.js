const express = require("express");
const mysql = require("mysql2");
const path = require("path");

const app = express();
const PORT = 3000;

app.use(express.json());

// Koneksi ke MySQL
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "", // Ganti dengan password MySQL Anda
  database: "db_klinik",
});

db.connect((err) => {
  if (err) {
    console.error("Koneksi database gagal:", err);
    return;
  }
  console.log("Terhubung ke database MySQL");
});

// Endpoint untuk mendapatkan semua pasien
app.get("/pasien", (req, res) => {
  db.query("SELECT * FROM pasien", (err, results) => {
    if (err) {
      res.status(500).json({ error: "Gagal mengambil data pasien" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint untuk mendapatkan pasien berdasarkan ID
app.get("/pasien/:id", (req, res) => {
  const { id } = req.params;
  db.query("SELECT * FROM pasien WHERE id = ?", [id], (err, results) => {
    if (err) {
      res.status(500).json({ error: "Gagal mengambil data pasien" });
    } else if (results.length === 0) {
      res.status(404).json({ message: "Pasien tidak ditemukan" });
    } else {
      res.json(results[0]);
    }
  });
});

// Endpoint untuk mendapatkan riwayat penyakit pasien
app.get("/riwayat/:idPasien", (req, res) => {
  const { idPasien } = req.params;
  db.query("SELECT * FROM riwayat_penyakit WHERE id_pasien = ?", [idPasien], (err, results) => {
    if (err) {
      res.status(500).json({ error: "Gagal mengambil riwayat penyakit" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint untuk mendapatkan rekam pemeriksaan pasien
app.get("/rekam/:idPasien", (req, res) => {
  const { idPasien } = req.params;
  db.query("SELECT * FROM rekam_pemeriksaan WHERE id_pasien = ?", [idPasien], (err, results) => {
    if (err) {
      res.status(500).json({ error: "Gagal mengambil rekam pemeriksaan" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint untuk mendapatkan daftar pasien dan riwayat penyakitnya
app.get("/pasien-riwayat", (req, res) => {
  const query = `
    SELECT pasien.id, pasien.nama, pasien.image, riwayat_penyakit.tanggal_kunjungan, 
           riwayat_penyakit.diagnosa, riwayat_penyakit.dokter_penanggung_jawab
    FROM pasien
    JOIN riwayat_penyakit ON pasien.id = riwayat_penyakit.id_pasien
  `;

  db.query(query, (err, results) => {
    if (err) {
      res.status(500).json({ error: "Gagal mengambil data pasien dan riwayat penyakit" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint untuk menghitung total penyakit
app.get("/penyakit-total", (req, res) => {
  const query = `
    SELECT diagnosa, COUNT(*) as totalPasien 
    FROM riwayat_penyakit 
    GROUP BY diagnosa
  `;

  db.query(query, (err, results) => {
    if (err) {
      res.status(500).json({ error: "Gagal menghitung total penyakit" });
    } else {
      res.json(results);
    }
  });
});

// Endpoint untuk menampilkan gambar pasien
app.get("/images/:imageName", (req, res) => {
  const imageName = req.params.imageName;
  const imagePath = path.join(__dirname, "images", imageName);
  res.sendFile(imagePath);
});

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});
