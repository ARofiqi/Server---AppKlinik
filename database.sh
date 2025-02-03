CREATE DATABASE db_klinik;

USE db_klinik;

CREATE TABLE IF NOT EXISTS pasien (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    alamat TEXT NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    image VARCHAR(255) NOT NULL
);

INSERT INTO pasien (nama, tanggal_lahir, alamat, no_telepon, image) VALUES
('John Doe', '1990-01-01', 'Jalan A No.1', '08123456789', '/images/1.jpg'),
('Jane Doe', '1988-05-15', 'Jalan B No.2', '08198765432', '/images/2.jpg'),
('Mark Smith', '1992-03-20', 'Jalan C No.3', '08234567890', '/images/3.webp'),
('Alice Johnson', '1995-06-12', 'Jalan D No.4', '08345678901', '/images/4.jpg'),
('Robert Brown', '1985-11-02', 'Jalan E No.5', '08456789012', '/images/5.jpg'),
('Emily Davis', '1993-08-25', 'Jalan F No.6', '08567890123', '/images/6.jpg'),
('Michael Wilson', '1991-04-18', 'Jalan G No.7', '08678901234', '/images/7.jpg'),
('Laura Taylor', '1989-07-09', 'Jalan H No.8', '08789012345', '/images/8.jpeg'),
('David Moore', '1986-09-30', 'Jalan I No.9', '08890123456', '/images/9.jpg'),
('Jessica Martin', '1994-12-15', 'Jalan J No.10', '08901234567', '/images/10.jpg'),
('Daniel Thomas', '1990-05-21', 'Jalan K No.11', '08123451111', '/images/11.jpg'),
('Sarah Jackson', '1992-02-14', 'Jalan L No.12', '08234562222', '/images/12.jpg'),
('James White', '1988-08-10', 'Jalan M No.13', '08345673333', '/images/13.jpg'),
('Megan Harris', '1995-11-19', 'Jalan N No.14', '08456784444', '/images/14.jpg'),
('Kevin Clark', '1987-06-24', 'Jalan O No.15', '08567895555', '/images/15.jpeg'),
('Linda Rodriguez', '1991-03-16', 'Jalan P No.16', '08678906666', '/images/16.jpg'),
('Matthew Lewis', '1993-07-11', 'Jalan Q No.17', '08789017777', '/images/17.jpg'),
('Olivia Walker', '1989-10-05', 'Jalan R No.18', '08890128888', '/images/18.jpg'),
('Joshua Hall', '1985-12-31', 'Jalan S No.19', '08901239999', '/images/19.jpg'),
('Sophia Young', '1992-01-28', 'Jalan T No.20', '08123460000', '/images/20.jpg');

CREATE TABLE IF NOT EXISTS riwayat_penyakit (
    id_riwayat INT AUTO_INCREMENT PRIMARY KEY,
    id_pasien INT NOT NULL,
    tanggal_kunjungan DATE NOT NULL,
    diagnosa VARCHAR(255) NOT NULL,
    tindakan TEXT NOT NULL,
    dokter_penanggung_jawab VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id) ON DELETE CASCADE
);

INSERT INTO riwayat_penyakit (id_pasien, tanggal_kunjungan, diagnosa, tindakan, dokter_penanggung_jawab) VALUES
(1, '2024-10-20', 'Demam', 'Pemberian obat anti demam', 'Dr. Agus'),
(2, '2024-10-22', 'Flu', 'Istirahat dan minum banyak air', 'Dr. Budi'),
(3, '2024-10-21', 'Malaria', 'Pemberian obat malaria', 'Dr. Citra'),
(4, '2024-10-23', 'Asma', 'Nebulizer', 'Dr. David'),
(5, '2024-10-24', 'Diabetes', 'Kontrol gula darah', 'Dr. Emily'),
(6, '2024-10-25', 'Hipertensi', 'Pemberian obat antihipertensi', 'Dr. Fiona'),
(7, '2024-10-26', 'Pneumonia', 'Antibiotik dan istirahat', 'Dr. George'),
(8, '2024-10-27', 'Sakit Kepala', 'Pemberian obat pereda sakit kepala', 'Dr. Hannah'),
(9, '2024-10-28', 'Infeksi Saluran Kemih', 'Antibiotik', 'Dr. Ian'),
(10, '2024-10-29', 'Sakit Gigi', 'Cabut gigi', 'Dr. Julia'),
(11, '2024-10-30', 'Demam Berdarah', 'Rawat inap', 'Dr. Kevin'),
(12, '2024-11-01', 'Sinusitis', 'Pemberian antibiotik dan dekongestan', 'Dr. Laura'),
(13, '2024-11-02', 'Vertigo', 'Pemberian obat vertigo', 'Dr. Mike'),
(14, '2024-11-03', 'Sakit Punggung', 'Terapi fisik', 'Dr. Nancy'),
(15, '2024-11-04', 'Radang Tenggorokan', 'Pemberian antibiotik', 'Dr. Oscar'),
(16, '2024-11-05', 'Batuk Kronis', 'Pemeriksaan lanjutan', 'Dr. Paul'),
(17, '2024-11-06', 'Migraine', 'Pemberian obat migrain', 'Dr. Quinn'),
(18, '2024-11-07', 'Nyeri Lutut', 'Pemberian obat antiinflamasi', 'Dr. Rose'),
(19, '2024-11-08', 'Kolesterol Tinggi', 'Kontrol diet', 'Dr. Steve'),
(20, '2024-11-09', 'Obesitas', 'Konsultasi diet', 'Dr. Tina');

CREATE TABLE rekam_pemeriksaan (
    id_rekam INT PRIMARY KEY,
    id_pasien INT NOT NULL,
    tanggal_kunjungan DATE NOT NULL,
    tekanan_darah VARCHAR(10) NOT NULL,
    gula_darah VARCHAR(20) NOT NULL,
    suhu_tubuh VARCHAR(10) NOT NULL,
    berat_badan VARCHAR(10) NOT NULL,
    tinggi_badan VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id) ON DELETE CASCADE
);

INSERT INTO rekam_pemeriksaan (id_rekam, id_pasien, tanggal_kunjungan, tekanan_darah, gula_darah, suhu_tubuh, berat_badan, tinggi_badan) VALUES
(1, 1, '2024-10-20', '120/80', '90 mg/dL', '37°C', '70 kg', '175 cm'),
(2, 2, '2024-10-22', '110/70', '85 mg/dL', '36.5°C', '60 kg', '165 cm'),
(3, 3, '2024-10-21', '130/85', '100 mg/dL', '38°C', '80 kg', '180 cm'),
(4, 4, '2024-10-23', '115/75', '95 mg/dL', '36.8°C', '55 kg', '160 cm'),
(5, 5, '2024-10-24', '140/90', '105 mg/dL', '37.2°C', '85 kg', '170 cm'),
(6, 6, '2024-10-25', '150/95', '110 mg/dL', '37.5°C', '90 kg', '172 cm'),
(7, 7, '2024-10-26', '125/80', '88 mg/dL', '36.9°C', '78 kg', '174 cm'),
(8, 8, '2024-10-27', '110/65', '80 mg/dL', '36.6°C', '62 kg', '162 cm'),
(9, 9, '2024-10-28', '135/85', '92 mg/dL', '37.1°C', '83 kg', '178 cm'),
(10, 10, '2024-10-29', '120/80', '98 mg/dL', '36.9°C', '68 kg', '168 cm'),
(11, 11, '2024-10-30', '125/85', '85 mg/dL', '37.4°C', '74 kg', '172 cm'),
(12, 12, '2024-11-01', '135/90', '110 mg/dL', '37.6°C', '90 kg', '180 cm'),
(13, 13, '2024-11-02', '115/70', '82 mg/dL', '37.0°C', '67 kg', '170 cm'),
(14, 14, '2024-11-03', '130/85', '96 mg/dL', '37.3°C', '75 kg', '175 cm'),
(15, 15, '2024-11-04', '118/75', '89 mg/dL', '37.1°C', '69 kg', '167 cm'),
(16, 16, '2024-11-05', '140/95', '112 mg/dL', '37.7°C', '88 kg', '179 cm'),
(17, 17, '2024-11-06', '110/65', '75 mg/dL', '36.8°C', '61 kg', '160 cm'),
(18, 18, '2024-11-07', '130/85', '94 mg/dL', '37.2°C', '77 kg', '175 cm'),
(19, 19, '2024-11-08', '145/90', '120 mg/dL', '38.0°C', '92 kg', '182 cm'),
(20, 20, '2024-11-09', '135/85', '100 mg/dL', '37.4°C', '85 kg', '178 cm');

