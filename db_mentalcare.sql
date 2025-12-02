-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2025 at 06:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_mentalcare`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assesment`
--

CREATE TABLE `assesment` (
  `id_assesment` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `skor_stress` int(11) DEFAULT NULL,
  `skor_kebahagiaan` int(11) DEFAULT NULL,
  `rekomendasi` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gamifikasi`
--

CREATE TABLE `gamifikasi` (
  `id_reward` int(11) NOT NULL,
  `id_assesment` int(11) DEFAULT NULL,
  `poin` int(11) DEFAULT NULL,
  `badge` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jurnal`
--

CREATE TABLE `jurnal` (
  `id_jurnal` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `mood` varchar(15) DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `aktivitas` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `konseling`
--

CREATE TABLE `konseling` (
  `id_konseling` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_psikolog` int(11) DEFAULT NULL,
  `jadwal_konseling` date DEFAULT NULL,
  `status` enum('aktif','nonaktif') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `konten_edukasi`
--

CREATE TABLE `konten_edukasi` (
  `id_konten` int(11) NOT NULL,
  `id_jurnal` int(11) DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `jenis_konten` varchar(50) DEFAULT NULL,
  `judul` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `psikolog`
--

CREATE TABLE `psikolog` (
  `id_psikolog` int(11) NOT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `spesialis` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `no_telepon` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `id_konten` int(11) DEFAULT NULL,
  `id_reward` int(11) DEFAULT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(10) DEFAULT NULL,
  `no_telepon` varchar(15) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `assesment`
--
ALTER TABLE `assesment`
  ADD PRIMARY KEY (`id_assesment`),
  ADD KEY `fk_assesment_user` (`id_user`);

--
-- Indexes for table `gamifikasi`
--
ALTER TABLE `gamifikasi`
  ADD PRIMARY KEY (`id_reward`),
  ADD KEY `fk_gamifikasi_assesment` (`id_assesment`);

--
-- Indexes for table `jurnal`
--
ALTER TABLE `jurnal`
  ADD PRIMARY KEY (`id_jurnal`),
  ADD KEY `fk_jurnal_user` (`id_user`);

--
-- Indexes for table `konseling`
--
ALTER TABLE `konseling`
  ADD PRIMARY KEY (`id_konseling`),
  ADD KEY `fk_konseling_user` (`id_user`),
  ADD KEY `fk_konseling_psikolog` (`id_psikolog`);

--
-- Indexes for table `konten_edukasi`
--
ALTER TABLE `konten_edukasi`
  ADD PRIMARY KEY (`id_konten`),
  ADD KEY `fk_konten_jurnal` (`id_jurnal`),
  ADD KEY `fk_konten_admin` (`id_admin`);

--
-- Indexes for table `psikolog`
--
ALTER TABLE `psikolog`
  ADD PRIMARY KEY (`id_psikolog`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `fk_user_konten` (`id_konten`),
  ADD KEY `fk_user_reward` (`id_reward`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assesment`
--
ALTER TABLE `assesment`
  ADD CONSTRAINT `fk_assesment_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `gamifikasi`
--
ALTER TABLE `gamifikasi`
  ADD CONSTRAINT `fk_gamifikasi_assesment` FOREIGN KEY (`id_assesment`) REFERENCES `assesment` (`id_assesment`);

--
-- Constraints for table `jurnal`
--
ALTER TABLE `jurnal`
  ADD CONSTRAINT `fk_jurnal_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `konseling`
--
ALTER TABLE `konseling`
  ADD CONSTRAINT `fk_konseling_psikolog` FOREIGN KEY (`id_psikolog`) REFERENCES `psikolog` (`id_psikolog`),
  ADD CONSTRAINT `fk_konseling_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `konten_edukasi`
--
ALTER TABLE `konten_edukasi`
  ADD CONSTRAINT `fk_konten_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `fk_konten_jurnal` FOREIGN KEY (`id_jurnal`) REFERENCES `jurnal` (`id_jurnal`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_konten` FOREIGN KEY (`id_konten`) REFERENCES `konten_edukasi` (`id_konten`),
  ADD CONSTRAINT `fk_user_reward` FOREIGN KEY (`id_reward`) REFERENCES `gamifikasi` (`id_reward`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
