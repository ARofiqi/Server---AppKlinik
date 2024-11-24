// server.js
const express = require("express");
const { dataPasien, riwayatPenyakitPasien, rekamPemeriksaan } = require("./data");
const path = require("path");

const app = express();
const PORT = 3000;

app.use(express.json());

app.get("/pasien", (req, res) => {
  res.json(dataPasien);
});

app.get("/pasien/:id", (req, res) => {
  const { id } = req.params;
  const pasien = dataPasien.find((p) => p.id === parseInt(id));
  if (pasien) {
    res.json(pasien);
  } else {
    res.status(404).json({ message: "Pasien tidak ditemukan" });
  }
});

app.get("/riwayat/:idPasien", (req, res) => {
  const { idPasien } = req.params;
  const riwayat = riwayatPenyakitPasien.filter((r) => r.idPasien === parseInt(idPasien));
  res.json(riwayat[0]);
});

app.get("/rekam/:idPasien", (req, res) => {
  const { idPasien } = req.params;
  const rekam = rekamPemeriksaan.filter((r) => r.idPasien === parseInt(idPasien));
  res.json(rekam);
});

app.get("/pasien-riwayat", (req, res) => {
  const result = dataPasien
    .map((pasien) => {
      const riwayat = riwayatPenyakitPasien.filter((r) => r.idPasien === pasien.id);

      const riwayatOutput = riwayat.map((r) => ({
        id: pasien.id,
        nama: pasien.nama,
        tanggalKunjungan: r.tanggalKunjungan,
        diagnosa: r.diagnosa,
        dokterPenanggungJawab: r.dokterPenanggungJawab,
        image: pasien.image,
      }));

      return riwayatOutput;
    })
    .flat();

  res.json(result);
});

app.get("/penyakit-total", (req, res) => {
  const penyakitCount = {};

  riwayatPenyakitPasien.forEach((riwayat) => {
    const { diagnosa } = riwayat;
    if (penyakitCount[diagnosa]) {
      penyakitCount[diagnosa]++;
    } else {
      penyakitCount[diagnosa] = 1;
    }
  });

  const result = Object.entries(penyakitCount).map(([penyakit, total]) => ({
    penyakit,
    totalPasien: total,
  }));

  res.json(result);
});

app.get("/images/:imageName", (req, res) => {
  const imageName = req.params.imageName;
  const imagePath = path.join(__dirname, "images", imageName);
  res.sendFile(imagePath);
});

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});
