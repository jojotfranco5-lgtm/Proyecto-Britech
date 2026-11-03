-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20260423.63883d5432
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 02, 2026 at 08:00 PM
-- Server version: 8.4.3
-- PHP Version: 8.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `britech_v2`
--

-- --------------------------------------------------------

--
-- Table structure for table `barrio`
--

CREATE TABLE `barrio` (
  `id` int NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `costo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barrio`
--

INSERT INTO `barrio` (`id`, `nombre`, `costo`, `activo`, `creado_en`) VALUES
(1, 'Circuito 5', 5000.00, 1, '2026-08-26 20:50:18'),
(2, 'La Nueva Formosa', 5000.00, 1, '2026-08-26 20:50:18'),
(3, 'Centro de la ciudad', 2500.00, 1, '2026-08-26 20:50:18');

-- --------------------------------------------------------

--
-- Table structure for table `bloque`
--

CREATE TABLE `bloque` (
  `id` int NOT NULL,
  `tipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config` json DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `orden` int NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bloque`
--

INSERT INTO `bloque` (`id`, `tipo`, `titulo`, `config`, `activo`, `orden`, `creado_en`) VALUES
(1, 'hero', NULL, '{\"intervalo_ms\": 5000}', 1, 1, '2026-08-22 20:01:35'),
(2, 'video', NULL, '{\"url\": \"#ofertas\", \"imagen\": \"/uploads/productos/ac135fd5a5ee09cbe2e7d5de3a545de7.jpg\", \"titulo\": \"Cyber Semana\", \"subtitulo\": \"Cuotas sin interés\", \"video_url\": \"https://www.instagram.com/reel/DVOXDZ3kYb1/?igsi=MzRlODBiNWFlZA==\"}', 0, 3, '2026-08-22 20:01:35'),
(3, 'carrusel_categorias', 'Explorá por categoría', '[]', 1, 2, '2026-08-22 20:01:35'),
(4, 'carrusel_productos', 'Smartphones', '{\"banner\": {\"url\": \"#cat-Smartphones\", \"imagen\": \"/uploads/productos/537f1a1976d62dd9d61917065f41a0c1.png\", \"posicion\": \"inicio\"}, \"limite\": 10, \"categoria_id\": \"12\"}', 1, 8, '2026-08-22 20:01:35'),
(5, 'banner', NULL, '{\"url\": \"#\", \"imagen\": \"/uploads/productos/3ca4061f2cacf87b1b70a1fa98dd41de.png\"}', 0, 6, '2026-08-22 20:01:35'),
(6, 'carrusel_productos', 'Informática', '{\"limite\": 10, \"categoria_id\": 7}', 1, 9, '2026-08-22 20:01:35'),
(7, 'carrusel_productos', 'Electrónica', '{\"limite\": 10, \"categoria_id\": \"1\"}', 1, 5, '2026-08-22 20:01:35'),
(8, 'grid_productos', 'Auricualres', '{\"limite\": 8, \"categoria_id\": \"15\"}', 1, 4, '2026-08-22 20:01:35'),
(9, 'carrusel_marcas', 'Marcas', '{}', 1, 7, '2026-08-25 14:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `bloque_slide`
--

CREATE TABLE `bloque_slide` (
  `id` int NOT NULL,
  `bloque_id` int NOT NULL,
  `imagen_desktop` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen_mobile` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitulo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boton_texto` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `orden` int NOT NULL DEFAULT '0',
  `desde` date DEFAULT NULL,
  `hasta` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bloque_slide`
--

INSERT INTO `bloque_slide` (`id`, `bloque_id`, `imagen_desktop`, `imagen_mobile`, `titulo`, `subtitulo`, `boton_texto`, `url`, `activo`, `orden`, `desde`, `hasta`) VALUES
(1, 1, '/uploads/productos/e44b5c68c7a07715028910476037706b.png', NULL, 'Los mejores smartphones', 'Hasta 30% off en la línea Samsung', 'Ver ofertas', '#cat-Smartphones', 1, 1, NULL, NULL),
(2, 1, '/uploads/productos/3e0507e6d0d48ce8cbf54ef312dda78e.png', NULL, 'Gaming sin límites', 'PS5, consolas y accesorios', 'Descubrir', '#cat-Gaming', 1, 2, NULL, NULL),
(3, 1, '/uploads/productos/4b3d852bf639c2bd9503589cb4939023.png', NULL, 'Renová tu compu', 'Notebooks y monitores en cuotas', 'Ver Informática', '#cat-Informática', 1, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `caja`
--

CREATE TABLE `caja` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `monto_apertura` decimal(12,2) NOT NULL DEFAULT '0.00',
  `abierta_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('abierta','cerrada') NOT NULL DEFAULT 'abierta',
  `monto_contado` decimal(12,2) DEFAULT NULL,
  `monto_esperado` decimal(12,2) DEFAULT NULL,
  `diferencia` decimal(12,2) DEFAULT NULL,
  `observacion` varchar(250) DEFAULT NULL,
  `cerrada_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `caja`
--

INSERT INTO `caja` (`id`, `usuario_id`, `monto_apertura`, `abierta_en`, `estado`, `monto_contado`, `monto_esperado`, `diferencia`, `observacion`, `cerrada_en`) VALUES
(5, 1, 35000.00, '2026-09-18 21:14:16', 'cerrada', 85000.00, 85000.00, 0.00, 'falta 20cm', '2026-09-25 20:49:19');

-- --------------------------------------------------------

--
-- Table structure for table `caja_movimiento`
--

CREATE TABLE `caja_movimiento` (
  `id` int NOT NULL,
  `caja_id` int NOT NULL,
  `tipo` enum('retiro','ingreso') NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `motivo` varchar(200) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imagen` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orden` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `activo`, `creado_en`, `imagen`, `orden`) VALUES
(1, 'Electrónica', 1, '2026-08-21 21:07:50', '/uploads/productos/9436dd8eaa82ffee9fcfd95bb41ac485.png', 3),
(2, 'Accesorios', 1, '2026-08-21 21:07:50', '/uploads/productos/a08c2f0090563d845e32043fd246b143.png', 6),
(3, 'Audio', 1, '2026-08-21 21:07:50', '/uploads/productos/96200be09781ac5e6901dd65b4ba1c6d.png', 5),
(4, 'Hogar', 0, '2026-08-21 21:07:50', NULL, 0),
(5, 'Papelería', 0, '2026-08-21 21:07:50', NULL, 0),
(6, 'PPrueba', 0, '2026-08-21 21:40:27', NULL, 0),
(7, 'Informatica', 1, '2026-08-21 21:41:43', '/uploads/productos/b428d6d3fbf54b20fa51bd3472557df1.png', 2),
(8, 'Prendas', 0, '2026-08-21 21:41:51', NULL, 0),
(9, 'Colegio', 0, '2026-08-21 21:41:59', NULL, 0),
(10, 'Barrio', 0, '2026-08-21 21:42:03', NULL, 0),
(11, 'Categoria', 0, '2026-08-21 21:42:14', NULL, 0),
(12, 'Smartphones', 1, '2026-08-22 20:01:35', '/uploads/productos/6aa8a37bc178fd0491fbd13da8279366.png', 1),
(13, 'Gaming', 1, '2026-08-22 20:01:35', '/uploads/productos/658c451daf9f952c0b80485ac7e51171.png', 4),
(14, 'Perfumeria', 1, '2026-08-24 17:01:57', '/uploads/productos/79ebce4746e8cd695ec7a229818dc719.jpg', 0),
(15, 'Auriculares', 1, '2026-08-25 17:09:28', '/uploads/productos/39bb75536ef1dcaff990b9a2f0d432f2.png', 0);

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `id` int NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `localidad` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provincia` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cp` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verificado` tinyint(1) NOT NULL DEFAULT '0',
  `mayorista_aprobado` tinyint(1) NOT NULL DEFAULT '0',
  `lista_precio_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`id`, `nombre`, `documento`, `email`, `telefono`, `direccion`, `localidad`, `provincia`, `cp`, `password_hash`, `email_verificado`, `mayorista_aprobado`, `lista_precio_id`, `activo`, `creado_en`) VALUES
(1, 'Consumidor Final', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, '2026-08-19 17:13:11'),
(2, 'Kiosco Norte (Mayorista)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 2, 1, '2026-08-20 21:14:38'),
(3, 'Juan Perez', NULL, 'juan.perez@example.com', '011-15-2233-4455', 'Belgrano 850', 'CABA', NULL, NULL, 'juan123', 1, 0, 1, 1, '2026-08-20 21:14:38'),
(4, 'Maria Lopez', '30123456', 'maria@test.com', '011-4444-5555', 'San Juan 100', 'Rosario', NULL, NULL, NULL, 0, 0, 1, 0, '2026-08-21 21:11:54'),
(5, 'Ana Comercio', NULL, 'ana@shop.com', '011-5555', NULL, NULL, NULL, NULL, '$2y$12$IZVMsMfGOJJy0N.MtLnXY.GwiIPib41YXgJcKSy7JWQ.3tKi7Kxmq', 1, 0, 1, 1, '2026-08-21 21:35:48'),
(6, 'Carla Tienda', NULL, 'carla@shop.com', '011-6666-7777', NULL, NULL, NULL, NULL, '$2y$12$lGFfCIifVlMsqcMspn8j.uewlK.RFxz4P0Wh9MhogCqO3owOnHygW', 1, 1, 1, 1, '2026-08-22 12:57:40'),
(7, 'Beto Mayor', NULL, 'beto@shop.com', NULL, NULL, NULL, NULL, NULL, '$2y$12$ztijGYDsrCQ3tQMWuSglqu.ykoIz9TUgcyxW2wX0KCEGAzHf/DJ4u', 1, 1, 1, 1, '2026-08-22 13:36:22'),
(8, 'Eric', NULL, 'erikbritejr@gmail.com', '3704564622', NULL, NULL, NULL, NULL, '$2y$12$VVRJRyiUcX506xRRVEq28eIC9sG6m5b4.SabTzdK53BN3GedXF94C', 1, 0, 1, 1, '2026-08-22 13:42:42'),
(9, 'Diego Envio', NULL, 'diego@shop.com', NULL, NULL, NULL, NULL, NULL, '$2y$12$1d88kNvqjbWnrrcjwzPJluzrc0anvoumTsGsdl7X563L8OZ1TXNGO', 1, 0, 1, 1, '2026-08-22 14:56:55'),
(10, 'Franco', NULL, 'jojotfranco555@gmail.com', NULL, NULL, NULL, NULL, NULL, '$2y$12$lGFfCIifVlMsqcMspn8j.uewlK.RFxz4P0Wh9MhogCqO3owOnHygW', 1, 1, 1, 1, '2026-08-22 19:36:19'),
(12, 'Franco Mast', NULL, 'jojotfranco5@gmail.com', 'queteimporta', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, '2026-08-22 20:30:33'),
(17, 'Repaso Final', NULL, 'repaso@shop.com', '011-9999', NULL, NULL, NULL, NULL, '$2y$12$2fJe.v7lDK3CrknV0sXa2OjGSdL948nFX9jKmIKe3F0Kro9rj.dLy', 1, 0, 1, 1, '2026-08-22 20:58:31'),
(21, 'Eric1', NULL, 'britechfsa@gmail.com', NULL, NULL, NULL, NULL, NULL, '$2y$12$3HERkuzXEm6.fvUwInYm/.tmFjmVADsZmVzfqlMssO0rNfio6ZmRW', 1, 0, 1, 0, '2026-08-23 18:06:03'),
(22, 'Fernanda Cristaldo', '46253567', 'cristaldofernanda61@gmail.com', '03704564622', 'Hipolito Yrigoyen 3563', 'Fromosa', NULL, NULL, NULL, 0, 0, 2, 1, '2026-08-24 12:03:40'),
(24, 'tobias', NULL, 'sototobias855@gmail.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$f4AkRgpQkCII/C9gjWqa9OWLVL1rhy51xbydDjzlFZl57t121H1Z6', 1, 1, 1, 1, '2026-08-24 14:14:34'),
(25, 'Gonza', NULL, 'barbozagonzaloagustin8@gmail.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$noBBrKP3pQvlTiBXUTRopu/gEpH2CFxEbQgw0QDrKqwhkSomztDiK', 1, 1, 1, 1, '2026-08-24 20:57:44'),
(26, 'Franco', NULL, 'francojojotrocky@gmail.com', NULL, NULL, 'Formosa', NULL, NULL, '$2y$10$uoYh.V..DI4Qa8OitnYTC.hcSu7NscApn2PkAF6j//LJEj53ZsnsO', 1, 0, 1, 1, '2026-08-25 17:32:09'),
(27, 'Alan beck', NULL, 'erikbritejr@gmail.com', '03704564622', 'Hipolito Yrigoyen 3563', 'Fromosa', NULL, NULL, NULL, 0, 0, 1, 0, '2026-08-25 22:35:26'),
(28, 'Eric Britez', NULL, 'britezeric91impar@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 1, '2026-09-07 17:28:37'),
(29, 'Eric Britez', NULL, 'erikbrite@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, '2026-09-07 17:29:17');

-- --------------------------------------------------------

--
-- Table structure for table `cliente_token`
--

CREATE TABLE `cliente_token` (
  `id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `tipo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expira_en` datetime NOT NULL,
  `usado` tinyint(1) NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cliente_token`
--

INSERT INTO `cliente_token` (`id`, `cliente_id`, `tipo`, `token_hash`, `expira_en`, `usado`, `creado_en`) VALUES
(3, 12, 'verificacion', 'bc6e37b121734c589af74ffe1bbe47dc342efd6ab7b0875229a0cba642f7317d', '2026-08-24 23:30:33', 0, '2026-08-22 20:30:33'),
(13, 17, 'verificacion', 'aae635aeadc4a715e327f366d28a25dddc3ecd2ed754656eb7b42a0b98e56814', '2026-08-24 23:58:31', 1, '2026-08-22 20:58:31'),
(14, 17, 'verificacion', 'ce2f90c1efd856574c0306b7088ad09200c89fda76b2e23a9e503b8ef718d722', '2026-08-24 20:58:36', 1, '2026-08-22 20:58:36'),
(18, 9, 'reset', 'a3ca6c8e9420a61925a0e8f4ce3a91ef631804574eee2d24bc74b3c22b3122b3', '2026-08-23 22:32:46', 0, '2026-08-23 17:32:46'),
(19, 9, 'reset', 'bac003ba5bc01f1fee1390e882dbc6ae18a26e0ed58b2dad4e05eb7be500cabd', '2026-08-23 19:32:52', 1, '2026-08-23 17:32:52'),
(21, 21, 'verificacion', '0b0ceaa5fdd9b3e1ea61987e02a440b7dfa33055cd8a2084363973ab78015fbe', '2026-08-25 21:06:03', 1, '2026-08-23 18:06:03'),
(23, 24, 'verificacion', '2e54ce2ddb750a5c8c4842cfed938063a1e1b1c6209545442cd4fe5d01b52b6d', '2026-08-26 17:14:34', 0, '2026-08-24 14:14:34'),
(24, 24, 'verificacion', '68ccda9aef83a5642b4a998432f03526aea0005ed2a91482300981aec24452dd', '2026-08-26 17:19:34', 0, '2026-08-24 14:19:34'),
(25, 24, 'verificacion', 'ff561b5961f136835037bf522c7f90a990422858e8c8916bbec2dc95839d74ea', '2026-08-26 17:22:21', 1, '2026-08-24 14:22:21'),
(26, 25, 'verificacion', '1861d092ea0226fd1293c9abb9798c4fa123658f207cfd1091387d01c9ebb639', '2026-08-26 23:57:44', 1, '2026-08-24 20:57:44'),
(27, 26, 'verificacion', 'd24c98de9ccf91bb7fa91a11f45626882c60356a68d891e49e277703397e2391', '2026-08-27 20:32:09', 1, '2026-08-25 17:32:09'),
(28, 27, 'verificacion', 'ed176923555b90805bee0f072243ba4533a40eabc723820c32a47ced0d48eb5e', '2026-08-28 01:35:26', 0, '2026-08-25 22:35:26');

-- --------------------------------------------------------

--
-- Table structure for table `comprobante`
--

CREATE TABLE `comprobante` (
  `id` int NOT NULL,
  `venta_id` int NOT NULL,
  `tipo` enum('ticket_interno','factura_a','factura_b','factura_c') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ticket_interno',
  `numero` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `punto_venta` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cae` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cae_vencimiento` date DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comprobante`
--

INSERT INTO `comprobante` (`id`, `venta_id`, `tipo`, `numero`, `punto_venta`, `cae`, `cae_vencimiento`, `fecha`) VALUES
(1, 1, 'ticket_interno', 'V-000001', NULL, NULL, NULL, '2026-08-20 21:44:27'),
(2, 2, 'ticket_interno', 'V-000002', NULL, NULL, NULL, '2026-08-20 22:07:57'),
(3, 3, 'ticket_interno', 'V-000003', NULL, NULL, NULL, '2026-08-20 22:12:10'),
(4, 4, 'ticket_interno', 'V-000004', NULL, NULL, NULL, '2026-08-20 22:17:22'),
(5, 5, 'ticket_interno', 'V-000005', NULL, NULL, NULL, '2026-08-20 22:20:46'),
(6, 6, 'ticket_interno', 'V-000006', NULL, NULL, NULL, '2026-08-21 20:59:44'),
(7, 7, 'ticket_interno', 'V-000007', NULL, NULL, NULL, '2026-08-21 21:01:36'),
(8, 8, 'ticket_interno', 'V-000008', NULL, NULL, NULL, '2026-08-22 00:11:19'),
(9, 9, 'ticket_interno', 'V-000009', NULL, NULL, NULL, '2026-08-22 19:19:20'),
(10, 10, 'ticket_interno', 'V-000010', NULL, NULL, NULL, '2026-08-22 19:20:09'),
(11, 11, 'ticket_interno', 'V-000011', NULL, NULL, NULL, '2026-08-22 19:20:28'),
(12, 12, 'ticket_interno', 'V-000012', NULL, NULL, NULL, '2026-08-22 19:33:59'),
(13, 13, 'ticket_interno', 'V-000013', NULL, NULL, NULL, '2026-08-22 20:58:02'),
(14, 14, 'ticket_interno', 'V-000014', NULL, NULL, NULL, '2026-08-24 00:31:57'),
(15, 15, 'ticket_interno', 'V-000015', NULL, NULL, NULL, '2026-08-24 00:31:57'),
(16, 16, 'ticket_interno', 'V-000016', NULL, NULL, NULL, '2026-08-24 00:31:57'),
(17, 17, 'ticket_interno', 'V-000017', NULL, NULL, NULL, '2026-08-24 15:46:54'),
(18, 18, 'ticket_interno', 'V-000018', NULL, NULL, NULL, '2026-08-24 15:50:58'),
(19, 19, 'ticket_interno', 'V-000019', NULL, NULL, NULL, '2026-08-24 20:56:24'),
(20, 20, 'ticket_interno', 'V-000020', NULL, NULL, NULL, '2026-08-25 17:01:19'),
(21, 21, 'ticket_interno', 'V-000021', NULL, NULL, NULL, '2026-08-25 19:03:27'),
(22, 22, 'ticket_interno', 'V-000022', NULL, NULL, NULL, '2026-08-25 22:46:13'),
(24, 24, 'ticket_interno', 'V-000024', NULL, NULL, NULL, '2026-08-26 22:29:22'),
(26, 26, 'ticket_interno', 'V-000026', NULL, NULL, NULL, '2026-08-26 22:39:41'),
(27, 27, 'ticket_interno', 'V-000027', NULL, NULL, NULL, '2026-08-26 23:41:11'),
(28, 28, 'ticket_interno', 'V-000028', NULL, NULL, NULL, '2026-08-27 19:30:18'),
(31, 31, 'ticket_interno', 'V-000031', NULL, NULL, NULL, '2026-09-18 21:15:48'),
(32, 32, 'ticket_interno', 'V-000032', NULL, NULL, NULL, '2026-09-22 20:33:34');

-- --------------------------------------------------------

--
-- Table structure for table `config_tienda`
--

CREATE TABLE `config_tienda` (
  `clave` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `config_tienda`
--

INSERT INTO `config_tienda` (`clave`, `valor`) VALUES
('pago_alias', 'britezeric.u'),
('pago_banco', 'Uala'),
('pago_cbu', '0001112223334445556667'),
('pago_titular', 'Eric Gonzalo Britez');

-- --------------------------------------------------------

--
-- Table structure for table `empresa_envio`
--

CREATE TABLE `empresa_envio` (
  `id` int NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `costo_base` decimal(12,2) NOT NULL DEFAULT '0.00',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `es_retiro` tinyint(1) NOT NULL DEFAULT '0',
  `es_moto` tinyint(1) NOT NULL DEFAULT '0',
  `url_tracking` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `empresa_envio`
--

INSERT INTO `empresa_envio` (`id`, `nombre`, `costo_base`, `activo`, `creado_en`, `es_retiro`, `es_moto`, `url_tracking`) VALUES
(1, 'Retiro en local', 0.00, 1, '2026-08-22 14:52:30', 1, 0, NULL),
(2, 'Correo Argentino', 22000.00, 1, '2026-08-22 14:52:30', 0, 0, 'https://www.correoargentino.com.ar/formularios/oal'),
(3, 'Andreani', 17500.00, 1, '2026-08-22 14:52:30', 0, 0, 'https://www.andreani.com/#!/informacionEnvio/{tracking}'),
(4, 'OCA', 18000.00, 1, '2026-08-22 14:52:30', 0, 0, 'https://www1.oca.com.ar/OEPTrackingWeb/Tracking.aspx?numero={tracking}'),
(5, 'Moto Express(Fsa)', 4000.00, 1, '2026-08-22 14:57:15', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `envio`
--

CREATE TABLE `envio` (
  `id` int NOT NULL,
  `pedido_id` int DEFAULT NULL,
  `venta_id` int DEFAULT NULL,
  `empresa_envio_id` int DEFAULT NULL,
  `barrio_id` int DEFAULT NULL,
  `repartidor_id` int DEFAULT NULL,
  `destinatario` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referencia` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `localidad` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provincia` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cp` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `costo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estado` enum('pendiente','despachado','en_camino','entregado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `tracking` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `envio`
--

INSERT INTO `envio` (`id`, `pedido_id`, `venta_id`, `empresa_envio_id`, `barrio_id`, `repartidor_id`, `destinatario`, `telefono`, `direccion`, `numero`, `referencia`, `localidad`, `provincia`, `cp`, `costo`, `estado`, `tracking`, `creado_en`) VALUES
(1, 5, NULL, 3, NULL, NULL, NULL, NULL, 'Rivadavia 4000', NULL, NULL, 'CABA', NULL, NULL, 4800.00, 'despachado', 'AR123456789', '2026-08-22 14:56:55'),
(2, 6, NULL, 1, NULL, NULL, NULL, NULL, 'Calle 1', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-22 15:10:13'),
(3, 7, NULL, 1, NULL, NULL, NULL, NULL, 'Calle 2', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-22 15:10:13'),
(4, 8, NULL, 3, NULL, NULL, NULL, NULL, 'Hipolito Yrigoyen 3563', NULL, NULL, 'Formosa', NULL, NULL, 4800.00, 'pendiente', NULL, '2026-08-22 19:25:10'),
(5, 9, NULL, 1, NULL, NULL, NULL, NULL, 'aasdasd', NULL, NULL, 'AA', NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-22 20:44:18'),
(6, 10, NULL, 1, NULL, NULL, NULL, NULL, 'aasdasd', NULL, NULL, 'AA', NULL, NULL, 0.00, 'despachado', '12312312312', '2026-08-22 20:44:33'),
(7, 11, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-22 20:55:41'),
(8, 12, NULL, 1, NULL, NULL, NULL, NULL, 'Sucursal centro', NULL, NULL, 'CABA', NULL, NULL, 0.00, 'en_camino', 'TRK-12345', '2026-08-22 20:58:37'),
(9, 13, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-23 17:36:15'),
(10, 14, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 12:00:42'),
(11, 15, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 14:24:33'),
(12, 16, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 14:35:53'),
(13, 17, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 15:33:01'),
(14, 18, NULL, 1, NULL, NULL, NULL, NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 16:30:41'),
(16, 21, NULL, 5, NULL, NULL, 'Eric Britez', '+543704564622', 'Hipolito Yrigoyen', '3563', 'Porton Negro', 'Fromosa', 'Formosa', '3600', 4000.00, 'cancelado', NULL, '2026-08-24 18:11:21'),
(17, 22, NULL, 1, NULL, NULL, 'tobias', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 19:24:06'),
(18, 23, NULL, 1, NULL, NULL, 'Gonza', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-24 21:02:34'),
(19, 24, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-25 14:34:18'),
(20, 25, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'despachado', NULL, '2026-08-25 14:34:42'),
(21, 26, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-25 16:57:06'),
(22, 27, NULL, 1, NULL, NULL, 'tobias', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-25 17:00:34'),
(23, 28, NULL, 3, NULL, NULL, 'tobixd', '+543704564622', 'Hipolito Yrigoyen', '3563', NULL, 'Fromosa', 'Formosa', '3600', 17500.00, 'pendiente', NULL, '2026-08-25 17:27:08'),
(24, 29, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-25 19:07:04'),
(25, 30, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-25 19:07:36'),
(26, 31, NULL, 1, NULL, NULL, 'tobias', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-25 22:42:18'),
(27, 32, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-26 19:31:35'),
(33, 38, NULL, 5, 3, 6, 'Juan Manuel', '3704564622', 'Hipolito Yrigoyen 3563', '3563', 'porton negro', 'Centro de la ciudad', NULL, NULL, 2500.00, 'entregado', NULL, '2026-08-26 22:00:05'),
(35, NULL, 24, 5, 3, 6, 'tobi', NULL, 'hipolito yrigoyen 3563', '3563', 'porton engro', 'Centro de la ciudad', NULL, NULL, 2500.00, 'entregado', NULL, '2026-08-26 22:29:22'),
(38, NULL, 26, 5, 1, 6, 'Martin', NULL, 'aa', '123', NULL, 'Circuito 5', NULL, NULL, 5000.00, 'entregado', NULL, '2026-08-26 22:39:41'),
(39, NULL, 27, 5, 3, 6, 'Fernanda cristaldo', NULL, 'Hipolito yrigoyen', '3075', 'deptos bicolores xd', 'Centro de la ciudad', NULL, NULL, 2500.00, 'entregado', NULL, '2026-08-26 23:41:11'),
(40, 40, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-26 23:46:21'),
(41, 41, NULL, 5, 2, 6, 'Eric', '3704564622', 'la nueva formartinyork', '3', 'casa vivienda sin pintar', 'La Nueva Formosa', NULL, NULL, 5000.00, 'pendiente', NULL, '2026-08-26 23:47:26'),
(42, 42, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-27 00:01:19'),
(47, 51, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-08-27 00:30:58'),
(48, 52, NULL, 5, 1, 6, 'Juan', '+543704564622', 'Hipolito Yrigoyen', '3563', 'casa gris', 'Circuito 5', NULL, NULL, 5000.00, 'pendiente', NULL, '2026-08-27 00:31:36'),
(49, 54, NULL, 5, 1, 9, 'Eric Britez', '+543704564622', 'Hipolito Yrigoyen', '3563', NULL, 'Circuito 5', NULL, NULL, 5000.00, 'pendiente', NULL, '2026-08-27 00:39:15'),
(51, 56, NULL, 5, 3, 9, 'Rama', '3704564622', 'Ho\'Higgins', '420', 'porton negro', 'Centro de la ciudad', NULL, NULL, 2500.00, 'pendiente', NULL, '2026-08-27 19:31:37'),
(52, 57, NULL, 5, 1, 9, 'Eric', '345763334', 'jaja', '11', NULL, 'Circuito 5', NULL, NULL, 5000.00, 'pendiente', NULL, '2026-08-27 20:08:28'),
(53, 58, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'despachado', NULL, '2026-08-27 20:25:24'),
(54, 59, NULL, 1, NULL, NULL, 'Eric', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-09-07 21:53:11'),
(55, 60, NULL, 5, 3, 9, 'Eric Britez', '+543704564622', 'Hipolito Yrigoyen 3563', '3563', 'porton negro pared gris', 'Centro de la ciudad', NULL, NULL, 2500.00, 'pendiente', NULL, '2026-09-13 23:47:29'),
(56, 61, NULL, 1, NULL, NULL, 'Eric Britez', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'despachado', NULL, '2026-09-18 19:56:25'),
(58, 64, NULL, 5, 1, 9, 'Eric Britez', '+543704564622', 'Hipolito Yrigoyen 3563', 'dasda1', '.....', 'Circuito 5', NULL, NULL, 5000.00, 'pendiente', NULL, '2026-09-18 21:07:22'),
(59, 65, NULL, 1, NULL, NULL, 'Eric Britez', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-09-22 22:31:08'),
(61, 67, NULL, 1, NULL, NULL, 'Eric Britez', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-09-22 22:37:53'),
(62, 68, NULL, 1, NULL, NULL, 'Eric Britez', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-09-22 22:40:04'),
(64, 70, NULL, 1, NULL, NULL, 'Eric Britez', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-09-22 22:46:27'),
(65, 71, NULL, 1, NULL, NULL, 'Eric Britez', NULL, 'Retiro en local', NULL, NULL, NULL, NULL, NULL, 0.00, 'pendiente', NULL, '2026-09-22 22:47:16'),
(67, 73, NULL, 5, 1, NULL, 'Eric Britez', '34712737377', '12u3uu', '1234', 'fuego', 'Circuito 5', NULL, NULL, 5000.00, 'pendiente', NULL, '2026-09-25 21:01:14');

-- --------------------------------------------------------

--
-- Table structure for table `favorito`
--

CREATE TABLE `favorito` (
  `cliente_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favorito`
--

INSERT INTO `favorito` (`cliente_id`, `producto_id`, `creado_en`) VALUES
(8, 9, '2026-08-24 16:38:24'),
(9, 4, '2026-08-22 19:12:15'),
(10, 4, '2026-08-22 19:55:15'),
(17, 9, '2026-08-22 20:58:37'),
(25, 5, '2026-08-24 21:00:21');

-- --------------------------------------------------------

--
-- Table structure for table `gasto`
--

CREATE TABLE `gasto` (
  `id` int NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int DEFAULT NULL,
  `producto_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `periodo` varchar(7) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `concepto` varchar(200) NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `observacion` varchar(500) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `gasto`
--

INSERT INTO `gasto` (`id`, `fecha`, `proveedor_id`, `producto_id`, `usuario_id`, `periodo`, `cantidad`, `concepto`, `monto`, `observacion`, `activo`, `creado_en`) VALUES
(1, '2026-08-20', 1, NULL, NULL, NULL, NULL, 'Compra 50 auriculares JBL', 450000.00, 'Reposicion stock', 1, '2026-08-24 16:08:56'),
(2, '2026-08-22', NULL, NULL, NULL, NULL, NULL, 'Alquiler local agosto', 180000.00, 'Gasto fijo mensual', 1, '2026-08-24 16:08:56'),
(3, '2026-08-24', 1, 1, NULL, NULL, 40, 'Compra 40 auriculares JBL', 360000.00, NULL, 1, '2026-08-24 16:15:10'),
(4, '2026-08-24', NULL, NULL, NULL, NULL, NULL, 'Pago a Tobias (Mes)', 300000.00, 'Buen trabajo, +1000 de aura', 1, '2026-08-24 16:19:46'),
(11, '2026-08-24', NULL, NULL, 4, '2026-07', NULL, 'pago mes', 1000000.00, 'bien', 1, '2026-08-24 18:38:55'),
(12, '2026-08-24', NULL, NULL, NULL, NULL, NULL, 'Heladito para el team', 18000.00, 'chocolate, tramontana, marroc, granizado', 1, '2026-08-24 19:57:46');

-- --------------------------------------------------------

--
-- Table structure for table `intento_acceso`
--

CREATE TABLE `intento_acceso` (
  `id` int NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventario`
--

CREATE TABLE `inventario` (
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  `actualizado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventario`
--

INSERT INTO `inventario` (`producto_id`, `cantidad`, `actualizado_en`) VALUES
(1, 50, '2026-08-24 16:15:10'),
(2, 43, '2026-09-18 21:03:09'),
(3, 0, '2026-08-19 17:13:11'),
(4, 23, '2026-08-24 00:31:57'),
(5, 2, '2026-09-18 21:23:18'),
(6, 8, '2026-08-22 20:01:35'),
(7, 25, '2026-08-22 20:01:35'),
(8, 15, '2026-08-22 20:01:35'),
(9, 30, '2026-08-22 20:01:35'),
(10, 10, '2026-08-22 20:01:35'),
(11, 20, '2026-08-22 20:01:35'),
(12, 40, '2026-08-22 20:01:35'),
(13, 35, '2026-08-22 20:01:35'),
(14, 50, '2026-08-22 20:01:35'),
(15, 7, '2026-08-22 20:01:35'),
(16, 12, '2026-09-22 20:33:34'),
(17, 18, '2026-08-22 20:01:35'),
(18, 26, '2026-08-22 20:01:35'),
(19, 5, '2026-08-22 20:01:35'),
(20, 30, '2026-08-22 20:01:35'),
(21, 10, '2026-08-24 15:51:18'),
(22, 5, '2026-08-25 17:04:30'),
(23, 5, '2026-08-25 17:07:10'),
(24, 5, '2026-08-25 17:08:52'),
(25, 7, '2026-09-18 21:23:18');

-- --------------------------------------------------------

--
-- Table structure for table `lista_precio`
--

CREATE TABLE `lista_precio` (
  `id` int NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lista_precio`
--

INSERT INTO `lista_precio` (`id`, `nombre`, `activo`) VALUES
(1, 'Minorista', 1),
(2, 'Mayorista', 1);

-- --------------------------------------------------------

--
-- Table structure for table `marca`
--

CREATE TABLE `marca` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `marca`
--

INSERT INTO `marca` (`id`, `nombre`, `activo`, `creado_en`, `imagen`) VALUES
(1, 'Genérica', 1, '2026-08-21 21:07:50', '/assets/img/logo.svg'),
(2, 'Samsung', 1, '2026-08-21 21:07:50', '/uploads/productos/37d1fde2ce41e8f4ca3e0ef3db40f0a9.png'),
(3, 'Logitech', 1, '2026-08-21 21:07:50', '/uploads/productos/422a2fe2f22c535361bfdb6e48758217.png'),
(4, 'Philips', 1, '2026-08-21 21:07:50', '/uploads/productos/f607f2dbef5d5bcece995f78dd06da58.png'),
(5, 'Noga', 1, '2026-08-21 21:07:50', '/uploads/productos/2d478fc33958f040d551481e852f9676.png'),
(6, 'Xiaomi', 1, '2026-08-21 21:16:20', '/uploads/productos/cce55cfe7453d5468ec98e6c9dee58e5.png'),
(7, 'Apple', 1, '2026-08-25 16:12:21', '/uploads/productos/22c4c8f2b10e3a87a87bf21c80a322c0.png'),
(8, 'JBL', 1, '2026-08-25 16:13:31', '/uploads/productos/f289bbcf56b5f98815d7267e883697e8.png'),
(9, 'Hp', 1, '2026-08-25 16:20:03', '/uploads/productos/639ed178a90dc0685e52fb4ed9260ba3.png'),
(10, 'Lenovo', 1, '2026-08-25 16:20:39', '/uploads/productos/9c3604bf4c177cd88494634fa9df6d4a.png'),
(11, 'Huawei', 1, '2026-08-25 16:23:09', '/uploads/productos/62a26a4e3637d133351ee5539e31516b.png');

-- --------------------------------------------------------

--
-- Table structure for table `movimiento_inventario`
--

CREATE TABLE `movimiento_inventario` (
  `id` int NOT NULL,
  `producto_id` int NOT NULL,
  `tipo` enum('ingreso','egreso','ajuste') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int NOT NULL,
  `motivo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `venta_id` int DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `movimiento_inventario`
--

INSERT INTO `movimiento_inventario` (`id`, `producto_id`, `tipo`, `cantidad`, `motivo`, `venta_id`, `usuario_id`, `creado_en`) VALUES
(1, 1, 'egreso', 2, 'Venta V-000001', 1, 1, '2026-08-20 21:44:27'),
(2, 2, 'egreso', 1, 'Venta V-000001', 1, 1, '2026-08-20 21:44:27'),
(3, 1, 'egreso', 1, 'Venta V-000002', 2, 1, '2026-08-20 22:07:57'),
(4, 1, 'egreso', 1, 'Venta V-000003', 3, 1, '2026-08-20 22:12:10'),
(5, 2, 'egreso', 1, 'Venta V-000003', 3, 1, '2026-08-20 22:12:10'),
(6, 2, 'egreso', 2, 'Venta V-000004', 4, 1, '2026-08-20 22:17:22'),
(7, 1, 'egreso', 1, 'Venta V-000005', 5, 1, '2026-08-20 22:20:46'),
(8, 1, 'ingreso', 1, 'Anulación venta V-000005', 5, 1, '2026-08-21 20:45:53'),
(9, 1, 'egreso', 1, 'Venta V-000006', 6, 1, '2026-08-21 20:59:44'),
(10, 2, 'egreso', 1, 'Venta V-000006', 6, 1, '2026-08-21 20:59:44'),
(11, 1, 'egreso', 1, 'Venta V-000007', 7, 1, '2026-08-21 21:01:36'),
(12, 4, 'ingreso', 30, 'Stock inicial', NULL, 1, '2026-08-21 21:16:38'),
(13, 4, 'egreso', 5, 'Ajuste de stock (ABM)', NULL, 1, '2026-08-21 21:16:38'),
(14, 1, 'egreso', 1, 'Venta V-000008', 8, 3, '2026-08-22 00:11:19'),
(15, 1, 'egreso', 1, 'Venta V-000009', 9, 3, '2026-08-22 19:19:20'),
(16, 4, 'egreso', 1, 'Venta V-000010', 10, 3, '2026-08-22 19:20:09'),
(17, 1, 'egreso', 1, 'Venta V-000011', 11, 3, '2026-08-22 19:20:28'),
(18, 1, 'egreso', 1, 'Venta V-000012', 12, 1, '2026-08-22 19:33:59'),
(19, 21, 'egreso', 18, 'Ajuste de stock (ABM)', NULL, 1, '2026-08-22 20:13:44'),
(20, 16, 'egreso', 2, 'Ajuste de stock (ABM)', NULL, 1, '2026-08-22 20:20:24'),
(21, 2, 'egreso', 1, 'Venta V-000013', 13, 2, '2026-08-22 20:58:02'),
(22, 5, 'egreso', 11, 'Ajuste de stock (ABM)', NULL, 1, '2026-08-23 22:44:37'),
(23, 2, 'egreso', 1, 'Venta V-000014', 14, 1, '2026-08-24 00:31:57'),
(24, 4, 'egreso', 1, 'Venta V-000015', 15, 1, '2026-08-24 00:31:57'),
(25, 16, 'egreso', 1, 'Venta V-000017', 17, 1, '2026-08-24 15:46:54'),
(26, 2, 'egreso', 1, 'Venta V-000017', 17, 1, '2026-08-24 15:46:54'),
(27, 16, 'ingreso', 1, 'Anulación venta V-000017', 17, 1, '2026-08-24 15:49:46'),
(28, 2, 'ingreso', 1, 'Anulación venta V-000017', 17, 1, '2026-08-24 15:49:46'),
(29, 21, 'egreso', 4, 'Venta V-000018', 18, 1, '2026-08-24 15:50:58'),
(30, 21, 'ingreso', 4, 'Anulación venta V-000018', 18, 1, '2026-08-24 15:51:18'),
(31, 1, 'ingreso', 40, 'Compra a proveedor (gasto)', NULL, 1, '2026-08-24 16:15:10'),
(32, 16, 'egreso', 1, 'Venta V-000019', 19, 1, '2026-08-24 20:56:24'),
(33, 22, 'ingreso', 5, 'Stock inicial', NULL, 1, '2026-08-25 17:04:30'),
(34, 23, 'ingreso', 5, 'Stock inicial', NULL, 1, '2026-08-25 17:07:10'),
(35, 24, 'ingreso', 5, 'Stock inicial', NULL, 1, '2026-08-25 17:08:52'),
(36, 25, 'ingreso', 5, 'Stock inicial', NULL, 1, '2026-08-25 17:13:12'),
(37, 16, 'egreso', 1, 'Venta V-000021', 21, 1, '2026-08-25 19:03:27'),
(38, 16, 'egreso', 1, 'Venta V-000022', 22, 1, '2026-08-25 22:46:13'),
(39, 16, 'egreso', 1, 'Venta V-000024', 24, 1, '2026-08-26 22:29:22'),
(40, 16, 'egreso', 1, 'Venta V-000026', 26, 1, '2026-08-26 22:39:41'),
(41, 16, 'egreso', 1, 'Venta V-000027', 27, 1, '2026-08-26 23:41:11'),
(42, 25, 'egreso', 1, 'Venta V-000028', 28, 1, '2026-08-27 19:30:18'),
(47, 16, 'egreso', 1, 'Venta V-000031', 31, 1, '2026-09-18 21:15:48'),
(48, 5, 'ingreso', 1, 'Recepción OC-000001', NULL, 1, '2026-09-18 21:23:18'),
(49, 25, 'ingreso', 3, 'Recepción OC-000001', NULL, 1, '2026-09-18 21:23:18'),
(50, 16, 'egreso', 1, 'Venta V-000032', 32, 1, '2026-09-22 20:33:34');

-- --------------------------------------------------------

--
-- Table structure for table `notificacion`
--

CREATE TABLE `notificacion` (
  `id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `tipo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel` enum('info','exito','alerta','error') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `titulo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ir` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_id` int DEFAULT NULL,
  `leida` tinyint(1) NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notificacion`
--

INSERT INTO `notificacion` (`id`, `usuario_id`, `cliente_id`, `tipo`, `nivel`, `titulo`, `ir`, `ref_id`, `leida`, `creado_en`) VALUES
(8, 1, NULL, 'pedido_nuevo', 'info', 'Nuevo pedido P-000073 · 65.000', 'pedidos', 73, 0, '2026-09-25 21:01:14'),
(9, 2, NULL, 'pedido_nuevo', 'info', 'Nuevo pedido P-000073 · 65.000', 'pedidos', 73, 0, '2026-09-25 21:01:14'),
(10, 3, NULL, 'pedido_nuevo', 'info', 'Nuevo pedido P-000073 · 65.000', 'pedidos', 73, 0, '2026-09-25 21:01:14'),
(11, 4, NULL, 'pedido_nuevo', 'info', 'Nuevo pedido P-000073 · 65.000', 'pedidos', 73, 0, '2026-09-25 21:01:14'),
(12, 5, NULL, 'pedido_nuevo', 'info', 'Nuevo pedido P-000073 · 65.000', 'pedidos', 73, 0, '2026-09-25 21:01:14'),
(13, NULL, 29, 'pedido_confirmado', 'exito', 'Registramos tu pedido P-000073. ¡Gracias!', 'mis-pedidos', 73, 1, '2026-09-25 21:01:14'),
(14, 1, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000001 · pedido P-000073', 'reclamos', 1, 1, '2026-09-25 21:03:32'),
(15, 2, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000001 · pedido P-000073', 'reclamos', 1, 0, '2026-09-25 21:03:32'),
(16, 3, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000001 · pedido P-000073', 'reclamos', 1, 0, '2026-09-25 21:03:32'),
(17, 4, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000001 · pedido P-000073', 'reclamos', 1, 0, '2026-09-25 21:03:32'),
(18, 5, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000001 · pedido P-000073', 'reclamos', 1, 0, '2026-09-25 21:03:32'),
(19, NULL, 29, 'reclamo_estado', 'info', 'Tu reclamo R-000001 pasó a: en_revision', 'reclamos', 1, 1, '2026-09-25 21:04:14'),
(20, NULL, 29, 'reclamo_respuesta', 'info', 'Te respondimos el reclamo R-000001', 'reclamos', 1, 1, '2026-09-25 21:04:28'),
(27, 1, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000002 · pedido P-000074', 'reclamos', 2, 0, '2026-09-25 21:09:35'),
(28, 2, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000002 · pedido P-000074', 'reclamos', 2, 0, '2026-09-25 21:09:35'),
(29, 3, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000002 · pedido P-000074', 'reclamos', 2, 0, '2026-09-25 21:09:35'),
(30, 4, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000002 · pedido P-000074', 'reclamos', 2, 0, '2026-09-25 21:09:35'),
(31, 5, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000002 · pedido P-000074', 'reclamos', 2, 0, '2026-09-25 21:09:35'),
(33, 1, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000003 · pedido P-000073', 'reclamos', 3, 0, '2026-09-30 21:29:16'),
(34, 2, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000003 · pedido P-000073', 'reclamos', 3, 0, '2026-09-30 21:29:16'),
(35, 3, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000003 · pedido P-000073', 'reclamos', 3, 0, '2026-09-30 21:29:16'),
(36, 4, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000003 · pedido P-000073', 'reclamos', 3, 0, '2026-09-30 21:29:16'),
(37, 5, NULL, 'reclamo', 'info', 'Nuevo reclamo R-000003 · pedido P-000073', 'reclamos', 3, 0, '2026-09-30 21:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `orden_compra`
--

CREATE TABLE `orden_compra` (
  `id` int NOT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  `estado` enum('enviada','parcial','recibida','anulada') NOT NULL DEFAULT 'enviada',
  `total_estimado` decimal(12,2) NOT NULL DEFAULT '0.00',
  `observacion` varchar(250) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recibido_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orden_compra`
--

INSERT INTO `orden_compra` (`id`, `numero`, `proveedor_id`, `estado`, `total_estimado`, `observacion`, `usuario_id`, `creado_en`, `recibido_en`) VALUES
(1, 'OC-000001', 4, 'recibida', 850000.00, 'Generada desde Reposición', 1, '2026-09-18 21:19:46', '2026-09-18 21:23:18');

-- --------------------------------------------------------

--
-- Table structure for table `orden_compra_detalle`
--

CREATE TABLE `orden_compra_detalle` (
  `id` int NOT NULL,
  `orden_compra_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `costo_unitario` decimal(12,2) NOT NULL DEFAULT '0.00',
  `cantidad_recibida` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orden_compra_detalle`
--

INSERT INTO `orden_compra_detalle` (`id`, `orden_compra_id`, `producto_id`, `cantidad`, `costo_unitario`, `cantidad_recibida`) VALUES
(1, 1, 5, 1, 850000.00, 1),
(2, 1, 25, 3, 0.00, 3);

-- --------------------------------------------------------

--
-- Table structure for table `pago`
--

CREATE TABLE `pago` (
  `id` int NOT NULL,
  `venta_id` int NOT NULL,
  `tipo_pago_id` int NOT NULL,
  `monto` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pago`
--

INSERT INTO `pago` (`id`, `venta_id`, `tipo_pago_id`, `monto`) VALUES
(1, 1, 1, 38000.00),
(2, 2, 1, 15000.00),
(3, 3, 1, 23000.00),
(4, 4, 1, 6000.00),
(5, 4, 2, 4000.00),
(6, 5, 1, 6000.00),
(7, 5, 2, 4000.00),
(8, 6, 1, 23000.00),
(9, 7, 1, 15000.00),
(10, 8, 1, 10000.00),
(11, 8, 2, 5000.00),
(12, 9, 1, 14000.00),
(13, 10, 1, 20000.00),
(14, 11, 1, 10000.00),
(15, 11, 2, 2000.00),
(16, 12, 1, 10000.00),
(17, 12, 2, 5000.00),
(18, 13, 1, 8000.00),
(19, 14, 1, 38000.00),
(20, 15, 2, 25000.00),
(21, 16, 1, 280000.00),
(22, 17, 1, 33000.00),
(23, 18, 1, 100000.00),
(24, 18, 1, 20000.00),
(25, 19, 1, 25000.00),
(26, 20, 1, 15000.00),
(27, 21, 1, 25000.00),
(28, 22, 1, 25000.00),
(30, 24, 1, 25000.00),
(32, 26, 1, 30000.00),
(33, 27, 1, 27500.00),
(34, 28, 1, 180000.00),
(37, 31, 1, 25000.00),
(38, 32, 1, 25000.00);

-- --------------------------------------------------------

--
-- Table structure for table `pedido`
--

CREATE TABLE `pedido` (
  `id` int NOT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cliente_id` int NOT NULL,
  `estado` enum('pendiente','preparando','entregado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `estado_pago` enum('pendiente','en_revision','pagado','rechazado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `metodo_pago` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'transferencia',
  `comprobante_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mp_payment_id` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(12,2) NOT NULL,
  `observacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pedido`
--

INSERT INTO `pedido` (`id`, `numero`, `cliente_id`, `estado`, `estado_pago`, `metodo_pago`, `comprobante_url`, `mp_payment_id`, `total`, `observacion`, `creado_en`) VALUES
(1, 'P-000001', 5, 'preparando', 'pendiente', 'transferencia', NULL, NULL, 38000.00, 'Entregar por la tarde', '2026-08-21 21:36:01'),
(2, 'P-000002', 6, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 23000.00, NULL, '2026-08-22 12:57:48'),
(3, 'P-000003', 8, 'preparando', 'pendiente', 'transferencia', NULL, NULL, 925000.00, NULL, '2026-08-22 13:43:05'),
(4, 'P-000004', 7, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 12000.00, NULL, '2026-08-22 13:43:26'),
(5, 'P-000005', 9, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-08-22 14:56:55'),
(6, 'P-000006', 7, 'entregado', 'pendiente', 'transferencia', NULL, NULL, 72000.00, NULL, '2026-08-22 15:10:13'),
(7, 'P-000007', 9, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-08-22 15:10:13'),
(8, 'P-000008', 8, 'cancelado', 'pendiente', 'transferencia', NULL, NULL, 940000.00, 'jaja', '2026-08-22 19:25:10'),
(9, 'P-000009', 8, 'cancelado', 'pendiente', 'transferencia', NULL, NULL, 30000.00, 'a', '2026-08-22 20:44:18'),
(10, 'P-000010', 8, 'preparando', 'pendiente', 'transferencia', NULL, NULL, 55000.00, 'a', '2026-08-22 20:44:33'),
(11, 'P-000011', 9, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 8000.00, NULL, '2026-08-22 20:55:41'),
(12, 'P-000012', 17, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 280000.00, NULL, '2026-08-22 20:58:37'),
(13, 'P-000013', 9, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 16000.00, NULL, '2026-08-23 17:36:15'),
(14, 'P-000014', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 85000.00, NULL, '2026-08-24 12:00:42'),
(15, 'P-000015', 24, 'entregado', 'pendiente', 'transferencia', NULL, NULL, 30000.00, NULL, '2026-08-24 14:24:33'),
(16, 'P-000016', 24, 'preparando', 'pendiente', 'transferencia', NULL, NULL, 480000.00, NULL, '2026-08-24 14:35:53'),
(17, 'P-000017', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 1260000.00, NULL, '2026-08-24 15:33:01'),
(18, 'P-000018', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 53000.00, 'dale pues', '2026-08-24 16:30:41'),
(21, 'P-000021', 8, 'pendiente', 'rechazado', 'transferencia', '/uploads/comprobantes/c84438e7008a4cb40ba02cffaffab5eb.png', NULL, 1200000.00, NULL, '2026-08-24 18:11:21'),
(22, 'P-000022', 24, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 19500.00, NULL, '2026-08-24 19:24:06'),
(23, 'P-000023', 25, 'entregado', 'pagado', 'transferencia', '/uploads/comprobantes/95d61616085fb44e82788d9307c3c12e.png', NULL, 480000.00, NULL, '2026-08-24 21:02:34'),
(24, 'P-000024', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 1200000.00, NULL, '2026-08-25 14:34:18'),
(25, 'P-000025', 8, 'preparando', 'pagado', 'transferencia', '/uploads/comprobantes/57c3739f185cf5879fa3300fe773318e.jpg', NULL, 1200000.00, NULL, '2026-08-25 14:34:42'),
(26, 'P-000026', 8, 'pendiente', 'pendiente', 'mercadopago', NULL, NULL, 1200000.00, NULL, '2026-08-25 16:57:06'),
(27, 'P-000027', 24, 'pendiente', 'en_revision', 'transferencia', '/uploads/comprobantes/d0031996dd9b620ec06c64f965ba477f.jpg', NULL, 25000.00, NULL, '2026-08-25 17:00:34'),
(28, 'P-000028', 24, 'pendiente', 'pagado', 'transferencia', '/uploads/comprobantes/1969979ab8d19fcbd87dc3ea8126b95d.jpg', NULL, 15000.00, NULL, '2026-08-25 17:27:08'),
(29, 'P-000029', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 40000.00, NULL, '2026-08-25 19:07:04'),
(30, 'P-000030', 8, 'pendiente', 'pendiente', 'tarjeta', NULL, NULL, 8000.00, NULL, '2026-08-25 19:07:36'),
(31, 'P-000031', 24, 'pendiente', 'rechazado', 'transferencia', NULL, NULL, 72000.00, NULL, '2026-08-25 22:42:18'),
(32, 'P-000032', 8, 'preparando', 'pagado', 'transferencia', NULL, NULL, 33000.00, NULL, '2026-08-26 19:31:35'),
(38, 'P-000038', 24, 'pendiente', 'pagado', 'transferencia', '/uploads/comprobantes/459db883beaa0766d8bb2c87c2188845.jpg', NULL, 40000.00, NULL, '2026-08-26 22:00:05'),
(40, 'P-000040', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-08-26 23:46:21'),
(41, 'P-000041', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-08-26 23:47:26'),
(42, 'P-000042', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-08-27 00:01:19'),
(51, 'P-000051', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 8000.00, NULL, '2026-08-27 00:30:58'),
(52, 'P-000052', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 25000.00, NULL, '2026-08-27 00:31:36'),
(54, 'P-000054', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 25000.00, NULL, '2026-08-27 00:39:15'),
(56, 'P-000056', 24, 'pendiente', 'en_revision', 'transferencia', '/uploads/comprobantes/6537a912defb989f7fec16c2995ef034.jpg', NULL, 15000.00, NULL, '2026-08-27 19:31:37'),
(57, 'P-000057', 8, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 55000.00, NULL, '2026-08-27 20:08:28'),
(58, 'P-000058', 8, 'pendiente', 'pagado', 'transferencia', '/uploads/comprobantes/c0299a23c0921c566e40b6b584ebd314.jpg', NULL, 93000.00, NULL, '2026-08-27 20:25:24'),
(59, 'P-000059', 8, 'pendiente', 'en_revision', 'transferencia', '/uploads/comprobantes/cc381dba8d15751cb54e4f1cba345214.jpg', NULL, 30000.00, NULL, '2026-09-07 21:53:11'),
(60, 'P-000060', 29, 'pendiente', 'pagado', 'transferencia', '/uploads/comprobantes/7729cc5474bd2fcc20cf0e7ff1412124.jpg', NULL, 25000.00, NULL, '2026-09-13 23:47:29'),
(61, 'P-000061', 29, 'pendiente', 'pagado', 'transferencia', '/uploads/comprobantes/c2cf4e15cb3cb5f4d169122b19bd2782.jpg', NULL, 8000.00, NULL, '2026-09-18 19:56:25'),
(64, 'P-000064', 29, 'pendiente', 'en_revision', 'transferencia', '/uploads/comprobantes/6e23ec61810e39e3a7d037d954456b04.jpg', NULL, 30000.00, NULL, '2026-09-18 21:07:22'),
(65, 'P-000065', 29, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 30000.00, NULL, '2026-09-22 22:31:08'),
(67, 'P-000067', 29, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 30000.00, NULL, '2026-09-22 22:37:53'),
(68, 'P-000068', 29, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 30000.00, NULL, '2026-09-22 22:40:04'),
(70, 'P-000070', 29, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-09-22 22:46:27'),
(71, 'P-000071', 29, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 15000.00, NULL, '2026-09-22 22:47:16'),
(73, 'P-000073', 29, 'pendiente', 'pendiente', 'transferencia', NULL, NULL, 60000.00, NULL, '2026-09-25 21:01:14');

-- --------------------------------------------------------

--
-- Table structure for table `pedido_detalle`
--

CREATE TABLE `pedido_detalle` (
  `id` int NOT NULL,
  `pedido_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pedido_detalle`
--

INSERT INTO `pedido_detalle` (`id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 1, 1, 2, 15000.00, 30000.00),
(2, 1, 2, 1, 8000.00, 8000.00),
(3, 2, 1, 1, 15000.00, 15000.00),
(4, 2, 2, 1, 8000.00, 8000.00),
(5, 3, 4, 1, 25000.00, 25000.00),
(6, 3, 3, 1, 900000.00, 900000.00),
(7, 4, 1, 1, 12000.00, 12000.00),
(8, 5, 1, 1, 15000.00, 15000.00),
(9, 6, 1, 6, 12000.00, 72000.00),
(10, 7, 1, 1, 15000.00, 15000.00),
(11, 8, 1, 1, 15000.00, 15000.00),
(12, 8, 3, 1, 900000.00, 900000.00),
(13, 8, 4, 1, 25000.00, 25000.00),
(14, 9, 21, 1, 30000.00, 30000.00),
(15, 10, 21, 1, 30000.00, 30000.00),
(16, 10, 16, 1, 25000.00, 25000.00),
(17, 11, 2, 1, 8000.00, 8000.00),
(18, 12, 9, 1, 280000.00, 280000.00),
(19, 13, 2, 2, 8000.00, 16000.00),
(20, 14, 1, 2, 15000.00, 30000.00),
(21, 14, 21, 1, 30000.00, 30000.00),
(22, 14, 16, 1, 25000.00, 25000.00),
(23, 15, 21, 1, 30000.00, 30000.00),
(24, 16, 8, 1, 480000.00, 480000.00),
(25, 17, 21, 2, 30000.00, 60000.00),
(26, 17, 5, 1, 1200000.00, 1200000.00),
(27, 18, 12, 1, 45000.00, 45000.00),
(28, 18, 2, 1, 8000.00, 8000.00),
(30, 21, 5, 1, 1200000.00, 1200000.00),
(31, 22, 2, 3, 6500.00, 19500.00),
(32, 23, 11, 3, 160000.00, 480000.00),
(33, 24, 5, 1, 1200000.00, 1200000.00),
(34, 25, 5, 1, 1200000.00, 1200000.00),
(35, 26, 5, 1, 1200000.00, 1200000.00),
(36, 27, 4, 1, 25000.00, 25000.00),
(37, 28, 1, 1, 15000.00, 15000.00),
(38, 29, 16, 1, 25000.00, 25000.00),
(39, 29, 1, 1, 15000.00, 15000.00),
(40, 30, 2, 1, 8000.00, 8000.00),
(41, 31, 1, 6, 12000.00, 72000.00),
(42, 32, 16, 1, 25000.00, 25000.00),
(43, 32, 2, 1, 8000.00, 8000.00),
(49, 38, 16, 1, 25000.00, 25000.00),
(50, 38, 1, 1, 15000.00, 15000.00),
(52, 40, 1, 1, 15000.00, 15000.00),
(53, 41, 1, 1, 15000.00, 15000.00),
(54, 42, 1, 1, 15000.00, 15000.00),
(63, 51, 2, 1, 8000.00, 8000.00),
(64, 52, 16, 1, 25000.00, 25000.00),
(66, 54, 16, 1, 25000.00, 25000.00),
(68, 56, 1, 1, 15000.00, 15000.00),
(69, 57, 16, 1, 25000.00, 25000.00),
(70, 57, 21, 1, 30000.00, 30000.00),
(71, 58, 16, 1, 25000.00, 25000.00),
(72, 58, 1, 1, 15000.00, 15000.00),
(73, 58, 2, 1, 8000.00, 8000.00),
(74, 58, 12, 1, 45000.00, 45000.00),
(75, 59, 21, 1, 30000.00, 30000.00),
(76, 60, 16, 1, 25000.00, 25000.00),
(77, 61, 2, 1, 8000.00, 8000.00),
(79, 64, 21, 1, 30000.00, 30000.00),
(80, 65, 21, 1, 30000.00, 30000.00),
(82, 67, 21, 1, 30000.00, 30000.00),
(83, 68, 21, 1, 30000.00, 30000.00),
(85, 70, 1, 1, 15000.00, 15000.00),
(86, 71, 1, 1, 15000.00, 15000.00),
(88, 73, 21, 2, 30000.00, 60000.00);

-- --------------------------------------------------------

--
-- Table structure for table `precio`
--

CREATE TABLE `precio` (
  `id` int NOT NULL,
  `producto_id` int NOT NULL,
  `lista_precio_id` int NOT NULL,
  `precio` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `precio`
--

INSERT INTO `precio` (`id`, `producto_id`, `lista_precio_id`, `precio`) VALUES
(1, 1, 1, 15000.00),
(2, 1, 2, 12000.00),
(3, 2, 1, 8000.00),
(4, 2, 2, 6500.00),
(5, 3, 1, 900000.00),
(6, 3, 2, 850000.00),
(7, 4, 1, 25000.00),
(8, 4, 2, 20000.00),
(18, 5, 1, 1200000.00),
(19, 5, 2, 1080000.00),
(20, 6, 1, 950000.00),
(21, 6, 2, 860000.00),
(22, 7, 1, 320000.00),
(23, 7, 2, 290000.00),
(24, 8, 1, 480000.00),
(25, 8, 2, 430000.00),
(26, 9, 1, 280000.00),
(27, 9, 2, 250000.00),
(28, 10, 1, 890000.00),
(29, 10, 2, 820000.00),
(30, 11, 1, 180000.00),
(31, 11, 2, 160000.00),
(32, 12, 1, 45000.00),
(33, 12, 2, 38000.00),
(34, 13, 1, 55000.00),
(35, 13, 2, 48000.00),
(36, 14, 1, 95000.00),
(37, 14, 2, 85000.00),
(38, 15, 1, 720000.00),
(39, 15, 2, 650000.00),
(40, 16, 1, 25000.00),
(41, 16, 2, 16000.00),
(42, 17, 1, 110000.00),
(43, 17, 2, 98000.00),
(44, 18, 1, 130000.00),
(45, 18, 2, 115000.00),
(46, 19, 1, 1350000.00),
(47, 19, 2, 1250000.00),
(48, 20, 1, 120000.00),
(49, 20, 2, 105000.00),
(50, 21, 1, 30000.00),
(51, 21, 2, 23000.00),
(85, 22, 1, 115000.00),
(86, 22, 2, 89000.00),
(87, 23, 1, 60000.00),
(88, 23, 2, 53000.00),
(89, 24, 1, 60000.00),
(90, 24, 2, 54000.00),
(97, 25, 1, 180000.00),
(98, 25, 2, 180000.00);

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `id` int NOT NULL,
  `sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_barras` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  `marca_id` int DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  `es_sobre_pedido` tinyint(1) NOT NULL DEFAULT '0',
  `min_mayorista` int NOT NULL DEFAULT '1',
  `precio_anterior` decimal(12,2) DEFAULT NULL,
  `costo` decimal(12,2) DEFAULT NULL,
  `stock_minimo` int NOT NULL DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`id`, `sku`, `codigo_barras`, `nombre`, `descripcion`, `categoria_id`, `marca_id`, `proveedor_id`, `es_sobre_pedido`, `min_mayorista`, `precio_anterior`, `costo`, `stock_minimo`, `activo`, `creado_en`) VALUES
(1, NULL, NULL, 'Auricular Bluetooth JBL', NULL, 15, NULL, NULL, 1, 6, NULL, NULL, 5, 1, '2026-08-19 17:13:11'),
(2, NULL, NULL, 'Cargador USB-C 20W', NULL, 1, 1, NULL, 0, 3, NULL, NULL, 0, 1, '2026-08-19 17:13:11'),
(3, 'SKU-003', '7795555555555', 'Notebook 15 (sobre pedido)', 'Notebook 15,6\" Full HD, 8 GB RAM, 256 GB SSD. Producto sobre pedido: se encarga al confirmar la compra.', 2, 1, 1, 1, 1, NULL, NULL, 0, 0, '2026-08-19 17:13:11'),
(4, NULL, NULL, 'Teclado Mecanico', NULL, 2, 3, 1, 0, 1, NULL, NULL, 5, 1, '2026-08-21 21:16:38'),
(5, 'SP-01', NULL, 'iPhone 15 Pro', 'Pantalla OLED 6.1\", 128GB', 12, NULL, NULL, 0, 3, NULL, 850000.00, 4, 1, '2026-08-22 20:01:35'),
(6, 'SP-02', NULL, 'Samsung Galaxy S24', 'Snapdragon, 256GB', 12, 2, NULL, 0, 3, NULL, NULL, 0, 0, '2026-08-22 20:01:35'),
(7, 'SP-03', NULL, 'Xiaomi Redmi Note 13', '108MP, 8GB RAM', 12, 6, NULL, 0, 3, NULL, NULL, 0, 0, '2026-08-22 20:01:35'),
(8, 'SP-04', NULL, 'Motorola Edge 40', 'Curvo, 5G', 12, 1, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(9, NULL, NULL, 'Samsung Galaxy A15', NULL, 1, NULL, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(10, 'IN-01', NULL, 'Notebook Lenovo IdeaPad', 'Ryzen 5, 16GB, SSD 512', 7, 1, NULL, 0, 3, NULL, NULL, 0, 0, '2026-08-22 20:01:35'),
(11, 'IN-02', NULL, 'Monitor MSI 24\" IPS', 'Full 2K 144Hz', 7, NULL, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(12, 'IN-03', NULL, 'Teclado Mecánico RGB', 'Switch azul', 7, 3, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(13, 'IN-04', NULL, 'Mouse Logitech G305', 'Inalámbrico gamer', 7, 3, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(14, 'IN-05', NULL, 'SSD Kingston 1TB', 'NVMe M.2', 7, 1, NULL, 0, 3, NULL, NULL, 0, 0, '2026-08-22 20:01:35'),
(15, 'EL-01', NULL, 'Smart TV 55\" 4K', 'HDR, Google TV', 1, 2, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(16, 'EL-02', NULL, 'Airpods Pro de Segunda Generación', 'Bluetooth', 15, NULL, NULL, 0, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(17, 'EL-03', NULL, 'Cámara Instax Mini', 'Fotos instantáneas', 1, 4, NULL, 0, 3, NULL, NULL, 0, 0, '2026-08-22 20:01:35'),
(18, 'EL-04', NULL, 'Smartwatch Amazfit', 'GPS, SpO2', 1, 1, NULL, 0, 3, NULL, NULL, 0, 0, '2026-08-22 20:01:35'),
(19, 'GA-01', NULL, 'PlayStation 5 Slim', 'Consola 1TB', 13, NULL, NULL, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(20, 'GA-02', NULL, 'Joystick Xbox Series', 'Inalámbrico', 13, NULL, 1, 1, 3, NULL, NULL, 5, 1, '2026-08-22 20:01:35'),
(21, 'GA-03', NULL, 'Auriculares Airpods Pro 4', '7.1, micrófono', 15, NULL, NULL, 0, 3, 50000.00, NULL, 5, 1, '2026-08-22 20:01:35'),
(22, 'P0-01', NULL, '9PM Night Out', NULL, 14, NULL, 4, 1, 2, 160000.00, NULL, 5, 1, '2026-08-25 17:04:30'),
(23, 'P0-03', 'a', 'Lattafa Badee Al Oud Honor And Glory Eau De Parfum 100 Ml', NULL, 14, NULL, NULL, 1, 2, 76000.00, NULL, 5, 1, '2026-08-25 17:07:10'),
(24, 'P0-02', NULL, 'Perfume Odyssey Mandarin Sky Limited Edition Edp 100 Ml', NULL, 14, NULL, NULL, 1, 2, 74000.00, NULL, 5, 1, '2026-08-25 17:08:52'),
(25, 'A0-01', NULL, 'Altavoz Jbl Flip 7 Portátil, Impermeable, A Prueba De Caídas Color Purple', NULL, 3, NULL, NULL, 0, 1, 200000.00, NULL, 5, 1, '2026-08-25 17:13:12');

-- --------------------------------------------------------

--
-- Table structure for table `producto_imagen`
--

CREATE TABLE `producto_imagen` (
  `id` int NOT NULL,
  `producto_id` int NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orden` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `producto_imagen`
--

INSERT INTO `producto_imagen` (`id`, `producto_id`, `url`, `orden`) VALUES
(10, 4, '/uploads/productos/5c80f8a7ad2622cc5384de39093a8db3.png', 0),
(12, 6, 'https://picsum.photos/seed/s24/500/500', 0),
(13, 7, 'https://picsum.photos/seed/redmi/500/500', 0),
(16, 10, 'https://picsum.photos/seed/lenovo/500/500', 0),
(20, 14, 'https://picsum.photos/seed/ssd/500/500', 0),
(23, 17, 'https://picsum.photos/seed/instax/500/500', 0),
(24, 18, 'https://picsum.photos/seed/watch/500/500', 0),
(31, 20, '/uploads/productos/bb7a9c061d499313755c2846442b51fa.png', 0),
(33, 19, '/uploads/productos/0d77158d2cffb04126a8e5daaa3b5da3.png', 0),
(34, 15, '/uploads/productos/fcac4c9c652f4add153283454cd21260.png', 0),
(36, 13, '/uploads/productos/d5d533259c6ed366a4110f76b4382cb1.png', 0),
(37, 12, '/uploads/productos/7c7f36ce373c1c623c83e8140b55c70b.png', 0),
(38, 11, '/uploads/productos/c9bcefa0308c149a17bd14f22c954279.png', 0),
(39, 9, '/uploads/productos/514e42b13ca5fe51cd7a9c01691779ba.png', 0),
(40, 8, '/uploads/productos/f7ed3b93ce96bf1ce9a4dc8cb37d5e9a.png', 0),
(42, 2, '/uploads/productos/4f2e9a0102754c2b93a3a3658812595d.png', 0),
(44, 22, '/uploads/productos/8237d567b93a26e37df84e47c7be6856.png', 0),
(45, 23, '/uploads/productos/075012f8e2c4b91e4be87fa3cbc661e5.png', 0),
(46, 24, '/uploads/productos/70c8b93b0ed01b9c3d587ba26ad7a072.png', 0),
(47, 21, '/uploads/productos/71d2e0cce88ae229c9adf48971664766.png', 0),
(48, 16, '/uploads/productos/e976e7b978ac842148e5fbded1776a61.png', 0),
(49, 1, '/uploads/productos/4194f4b1d1773475c6831cf779fd957f.png', 0),
(50, 25, '/uploads/productos/d8014253281d9308084a1f5880161143.png', 0),
(51, 5, '/uploads/productos/4b34d4821eec80ef9b43dc871df44222.png', 0);

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `id` int NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proveedor`
--

INSERT INTO `proveedor` (`id`, `nombre`, `cuit`, `email`, `telefono`, `direccion`, `activo`, `creado_en`) VALUES
(1, 'Distribuidora Central', '30-71234567-9', 'ventas@central.com.ar', '011-4555-1234', 'Av. Corrientes 1234, CABA', 1, '2026-08-21 21:07:50'),
(2, 'TecnoMayorista SA', '30-70999888-1', 'pedidos@tecnomay.com', '011-4777-9900', 'San Martín 500, CABA', 1, '2026-08-21 21:07:50'),
(3, 'Importadora del Sur', '30-71555222-4', 'info@impsur.com', '0221-15-6789', 'Calle 7 456, La Plata', 1, '2026-08-21 21:07:50'),
(4, 'AttacadosUSA CDE', NULL, NULL, NULL, 'Ciudad del Este', 1, '2026-08-24 16:46:16');

-- --------------------------------------------------------

--
-- Table structure for table `reclamo`
--

CREATE TABLE `reclamo` (
  `id` int NOT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `cliente_id` int NOT NULL,
  `pedido_id` int NOT NULL,
  `asunto` varchar(150) NOT NULL,
  `estado` enum('abierto','en_revision','resuelto','rechazado') NOT NULL DEFAULT 'abierto',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reclamo`
--

INSERT INTO `reclamo` (`id`, `numero`, `cliente_id`, `pedido_id`, `asunto`, `estado`, `creado_en`, `actualizado_en`) VALUES
(1, 'R-000001', 29, 73, 'que onda con ustedes manga de estafadores', 'en_revision', '2026-09-25 21:03:32', '2026-09-25 21:13:48'),
(3, 'R-000003', 29, 73, 'que onda con ustedes manga de estafadores', 'abierto', '2026-09-30 21:29:16', '2026-09-30 21:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `reclamo_mensaje`
--

CREATE TABLE `reclamo_mensaje` (
  `id` int NOT NULL,
  `reclamo_id` int NOT NULL,
  `autor` enum('cliente','staff') NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `mensaje` text NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reclamo_mensaje`
--

INSERT INTO `reclamo_mensaje` (`id`, `reclamo_id`, `autor`, `usuario_id`, `mensaje`, `creado_en`) VALUES
(5, 1, 'cliente', NULL, 'llego y pedi un auricular biueno y este es buenardo', '2026-09-25 21:03:32'),
(6, 1, 'staff', 1, 'que onda bro. gracias pero no hacia falta un reclamo. gil', '2026-09-25 21:04:28'),
(10, 1, 'cliente', NULL, 'que deci gato de mierda. ojala te pierdas con esos auriculares BUENARDOS. saludos', '2026-09-25 21:13:48'),
(11, 3, 'cliente', NULL, 'llego roto', '2026-09-30 21:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `repartidor`
--

CREATE TABLE `repartidor` (
  `id` int NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `repartidor`
--

INSERT INTO `repartidor` (`id`, `nombre`, `telefono`, `activo`, `creado_en`) VALUES
(6, 'Fer', '+54 9 3718 46-4044', 1, '2026-08-26 22:01:47'),
(9, 'Franco', '3704246553', 1, '2026-08-27 15:32:32');

-- --------------------------------------------------------

--
-- Table structure for table `reposicion_pedido`
--

CREATE TABLE `reposicion_pedido` (
  `id` int NOT NULL,
  `producto_id` int NOT NULL,
  `proveedor_id` int DEFAULT NULL,
  `cantidad` int NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `id` int NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rol`
--

INSERT INTO `rol` (`id`, `nombre`) VALUES
(1, 'admin'),
(2, 'vendedor');

-- --------------------------------------------------------

--
-- Table structure for table `solicitud_mayorista`
--

CREATE TABLE `solicitud_mayorista` (
  `id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `estado` enum('pendiente','aprobada','rechazada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `mensaje` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resuelto_en` datetime DEFAULT NULL,
  `resuelto_por` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solicitud_mayorista`
--

INSERT INTO `solicitud_mayorista` (`id`, `cliente_id`, `estado`, `mensaje`, `creado_en`, `resuelto_en`, `resuelto_por`) VALUES
(1, 7, 'aprobada', 'Compro para mi kiosco', '2026-08-22 13:36:23', '2026-08-22 13:36:38', 1),
(2, 6, 'aprobada', 'Tengo una libreria', '2026-08-22 13:41:10', '2026-08-22 13:41:52', 1),
(3, 8, 'rechazada', 'si soi', '2026-08-22 13:43:52', '2026-08-22 13:43:59', 1),
(4, 10, 'aprobada', 'Soy emprendedor', '2026-08-22 19:37:42', '2026-08-22 19:37:59', 1),
(5, 24, 'aprobada', 'Voy a vender gil', '2026-08-24 15:52:53', '2026-08-24 15:53:31', 1),
(8, 8, 'rechazada', 'dale', '2026-08-24 15:56:42', '2026-08-24 16:05:32', 1),
(9, 25, 'aprobada', NULL, '2026-08-24 21:00:34', '2026-08-24 21:01:06', 1),
(10, 28, 'aprobada', NULL, '2026-09-18 20:05:21', '2026-09-18 20:06:16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_pago`
--

CREATE TABLE `tipo_pago` (
  `id` int NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipo_pago`
--

INSERT INTO `tipo_pago` (`id`, `nombre`, `activo`) VALUES
(1, 'Efectivo', 1),
(2, 'Transferencia', 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `email_verificado` tinyint(1) NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `email`, `password_hash`, `rol_id`, `activo`, `email_verificado`, `creado_en`) VALUES
(1, 'Administrador', 'admin@britech.local', '$2y$12$UQqBxDB26Dfs0jEIuMQxeOJ6b6Zzj1gJffBK9.lrelnEQhobb4afC', 1, 1, 1, '2026-08-19 17:13:11'),
(2, 'Vendedor Uno', 'britechfsa+vendedor1@gmail.com', '$2y$12$lGFfCIifVlMsqcMspn8j.uewlK.RFxz4P0Wh9MhogCqO3owOnHygW', 2, 1, 1, '2026-08-21 20:28:25'),
(3, 'Tobias', 'sototobias855@gmail.com', '$2y$10$HRE.Z38xuZxbp9YJJp1Zmuc6S6r3W0qmhIMxHpSj8Qz.d6l5.wv0O', 2, 1, 1, '2026-08-21 21:44:25'),
(4, 'Fer', 'cristaldofernanda61@gmail.com', '', 1, 1, 0, '2026-08-22 00:14:21'),
(5, 'Eric Admin', 'erikbritejr@gmail.com', '$2y$10$qsIViUXLMw.8mdjQ08xIL.vLV7K57CIjTQ9rIOvXo1tpBwy/HK71e', 1, 1, 1, '2026-09-07 17:12:01');

-- --------------------------------------------------------

--
-- Table structure for table `usuario_token`
--

CREATE TABLE `usuario_token` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `tipo` enum('verificacion','reset') COLLATE utf8mb4_unicode_ci NOT NULL,
  `token_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expira_en` datetime NOT NULL,
  `usado` tinyint(1) NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usuario_token`
--

INSERT INTO `usuario_token` (`id`, `usuario_id`, `tipo`, `token_hash`, `expira_en`, `usado`, `creado_en`) VALUES
(1, 2, 'verificacion', '112bed363a2a3e1cf70626a8abc4b66cef3cd0f4a08f7e65dce10f32d3218534', '2026-08-22 23:28:25', 0, '2026-08-21 20:28:25'),
(2, 2, 'verificacion', 'e694eef4a050c57cd2337d2602b00794fae186080cebfb716366a001d76aa44c', '2026-08-22 23:28:29', 1, '2026-08-21 20:28:29'),
(3, 2, 'reset', '859e1a94ff563dd92edf3134078451863d0825fb3045136b978c776d39522710', '2026-08-22 00:31:15', 0, '2026-08-21 20:31:15'),
(4, 2, 'reset', '07476153f37dd5b8e899f5e8708115445eaa3feeb027e3c21c1aaf32513218fd', '2026-08-22 23:31:20', 1, '2026-08-21 20:31:20'),
(5, 3, 'verificacion', '97957eb548630c32e1a2f117d22de801aa749b5ea3258c0fa0fb26e595efa131', '2026-08-23 00:44:25', 1, '2026-08-21 21:44:25'),
(6, 4, 'verificacion', '05dff1bd485563a04067a68f7c24f426904cc819197a7b8b03b9952c2a7b0b0c', '2026-08-23 03:14:21', 0, '2026-08-22 00:14:21'),
(7, 3, 'reset', '82850db9d8cb4bf273110d070e19c5b77d1900f214e294dfdec6129cd0e00f9a', '2026-08-24 19:07:56', 1, '2026-08-24 15:07:56'),
(8, 5, 'verificacion', '094c415ea666ec3da3dd5ea31ff06fbf3008113f06dc6275c44549644165edb9', '2026-09-08 20:12:01', 1, '2026-09-07 17:12:01');

-- --------------------------------------------------------

--
-- Table structure for table `venta`
--

CREATE TABLE `venta` (
  `id` int NOT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cliente_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `caja_id` int DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `descuento` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `estado` enum('registrada','anulada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'registrada',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venta`
--

INSERT INTO `venta` (`id`, `numero`, `cliente_id`, `usuario_id`, `caja_id`, `subtotal`, `descuento`, `total`, `estado`, `creado_en`) VALUES
(1, 'V-000001', 1, 1, NULL, 38000.00, 0.00, 38000.00, 'registrada', '2026-08-20 21:44:27'),
(2, 'V-000002', 1, 1, NULL, 15000.00, 0.00, 15000.00, 'registrada', '2026-08-20 22:07:56'),
(3, 'V-000003', 1, 1, NULL, 23000.00, 0.00, 23000.00, 'registrada', '2026-08-20 22:12:10'),
(4, 'V-000004', 1, 1, NULL, 15000.00, 5000.00, 10000.00, 'registrada', '2026-08-20 22:17:22'),
(5, 'V-000005', 1, 1, NULL, 15000.00, 5000.00, 10000.00, 'anulada', '2026-08-20 22:20:46'),
(6, 'V-000006', 1, 1, NULL, 23000.00, 0.00, 23000.00, 'registrada', '2026-08-21 20:59:44'),
(7, 'V-000007', 1, 1, NULL, 15000.00, 0.00, 15000.00, 'registrada', '2026-08-21 21:01:36'),
(8, 'V-000008', 1, 3, NULL, 15000.00, 0.00, 15000.00, 'registrada', '2026-08-22 00:11:19'),
(9, 'V-000009', 1, 3, NULL, 14000.00, 0.00, 14000.00, 'registrada', '2026-08-22 19:19:20'),
(10, 'V-000010', 2, 3, NULL, 20000.00, 0.00, 20000.00, 'registrada', '2026-08-22 19:20:09'),
(11, 'V-000011', 2, 3, NULL, 12000.00, 0.00, 12000.00, 'registrada', '2026-08-22 19:20:28'),
(12, 'V-000012', 1, 1, NULL, 15000.00, 0.00, 15000.00, 'registrada', '2026-08-22 19:33:59'),
(13, 'V-000013', 1, 2, NULL, 8000.00, 0.00, 8000.00, 'registrada', '2026-08-22 20:58:02'),
(14, 'V-000014', 1, 1, NULL, 38000.00, 0.00, 38000.00, 'registrada', '2026-08-24 00:31:57'),
(15, 'V-000015', 1, 1, NULL, 25000.00, 0.00, 25000.00, 'registrada', '2026-08-24 00:31:57'),
(16, 'V-000016', 1, 1, NULL, 280000.00, 0.00, 280000.00, 'registrada', '2026-08-24 00:31:57'),
(17, 'V-000017', 1, 1, NULL, 33000.00, 0.00, 33000.00, 'anulada', '2026-08-24 15:46:54'),
(18, 'V-000018', 1, 1, NULL, 120000.00, 0.00, 120000.00, 'anulada', '2026-08-24 15:50:58'),
(19, 'V-000019', 1, 1, NULL, 25000.00, 0.00, 25000.00, 'registrada', '2026-08-24 20:56:24'),
(20, 'V-000020', 1, 1, NULL, 15000.00, 0.00, 15000.00, 'registrada', '2026-08-25 17:01:19'),
(21, 'V-000021', 1, 1, NULL, 25000.00, 0.00, 25000.00, 'registrada', '2026-08-25 19:03:27'),
(22, 'V-000022', 1, 1, NULL, 25000.00, 0.00, 25000.00, 'registrada', '2026-08-25 22:46:13'),
(24, 'V-000024', 1, 1, NULL, 25000.00, 0.00, 25000.00, 'registrada', '2026-08-26 22:29:22'),
(26, 'V-000026', 1, 1, NULL, 25000.00, 0.00, 30000.00, 'registrada', '2026-08-26 22:39:41'),
(27, 'V-000027', 1, 1, NULL, 25000.00, 0.00, 27500.00, 'registrada', '2026-08-26 23:41:11'),
(28, 'V-000028', 1, 1, NULL, 180000.00, 0.00, 180000.00, 'registrada', '2026-08-27 19:30:18'),
(31, 'V-000031', 1, 1, 5, 25000.00, 0.00, 25000.00, 'registrada', '2026-09-18 21:15:48'),
(32, 'V-000032', 1, 1, 5, 25000.00, 0.00, 25000.00, 'registrada', '2026-09-22 20:33:34');

-- --------------------------------------------------------

--
-- Table structure for table `venta_anulacion`
--

CREATE TABLE `venta_anulacion` (
  `id` int NOT NULL,
  `venta_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venta_anulacion`
--

INSERT INTO `venta_anulacion` (`id`, `venta_id`, `usuario_id`, `motivo`, `creado_en`) VALUES
(1, 5, 1, 'Cliente se arrepintio', '2026-08-21 20:45:53'),
(2, 17, 1, 'El cliente vino con el producto intacto y pidio la devolucion', '2026-08-24 15:49:46'),
(3, 18, 1, 'no', '2026-08-24 15:51:18');

-- --------------------------------------------------------

--
-- Table structure for table `venta_detalle`
--

CREATE TABLE `venta_detalle` (
  `id` int NOT NULL,
  `venta_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `descuento_linea` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estado` enum('normal','sobre_pedido') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venta_detalle`
--

INSERT INTO `venta_detalle` (`id`, `venta_id`, `producto_id`, `cantidad`, `precio_unitario`, `descuento_linea`, `estado`, `subtotal`) VALUES
(1, 1, 1, 2, 15000.00, 0.00, 'normal', 30000.00),
(2, 1, 2, 1, 8000.00, 0.00, 'normal', 8000.00),
(3, 2, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(4, 3, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(5, 3, 2, 1, 8000.00, 0.00, 'normal', 8000.00),
(6, 4, 2, 2, 8000.00, 1000.00, 'normal', 15000.00),
(7, 5, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(8, 6, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(9, 6, 2, 1, 8000.00, 0.00, 'normal', 8000.00),
(10, 7, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(11, 8, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(12, 9, 1, 1, 15000.00, 1000.00, 'normal', 14000.00),
(13, 10, 4, 1, 20000.00, 0.00, 'normal', 20000.00),
(14, 11, 1, 1, 12000.00, 0.00, 'normal', 12000.00),
(15, 12, 1, 1, 15000.00, 0.00, 'normal', 15000.00),
(16, 13, 2, 1, 8000.00, 0.00, 'normal', 8000.00),
(17, 14, 1, 2, 15000.00, 0.00, 'sobre_pedido', 30000.00),
(18, 14, 2, 1, 8000.00, 0.00, 'normal', 8000.00),
(19, 15, 4, 1, 25000.00, 0.00, 'normal', 25000.00),
(20, 16, 9, 1, 280000.00, 0.00, 'sobre_pedido', 280000.00),
(21, 17, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(22, 17, 2, 1, 8000.00, 0.00, 'normal', 8000.00),
(23, 18, 21, 4, 30000.00, 0.00, 'normal', 120000.00),
(24, 19, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(25, 20, 1, 1, 15000.00, 0.00, 'sobre_pedido', 15000.00),
(26, 21, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(27, 22, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(29, 24, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(31, 26, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(32, 27, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(33, 28, 25, 1, 180000.00, 0.00, 'normal', 180000.00),
(36, 31, 16, 1, 25000.00, 0.00, 'normal', 25000.00),
(37, 32, 16, 1, 25000.00, 0.00, 'normal', 25000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barrio`
--
ALTER TABLE `barrio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bloque`
--
ALTER TABLE `bloque`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_bloque_orden` (`activo`,`orden`);

--
-- Indexes for table `bloque_slide`
--
ALTER TABLE `bloque_slide`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_slide_bloque` (`bloque_id`,`orden`);

--
-- Indexes for table `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_caja_usuario` (`usuario_id`),
  ADD KEY `idx_caja_estado` (`estado`,`abierta_en`);

--
-- Indexes for table `caja_movimiento`
--
ALTER TABLE `caja_movimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cajamov_usuario` (`usuario_id`),
  ADD KEY `idx_cajamov_caja` (`caja_id`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cliente_lista` (`lista_precio_id`),
  ADD KEY `idx_cliente_email` (`email`);

--
-- Indexes for table `cliente_token`
--
ALTER TABLE `cliente_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ctok_cliente` (`cliente_id`);

--
-- Indexes for table `comprobante`
--
ALTER TABLE `comprobante`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `venta_id` (`venta_id`);

--
-- Indexes for table `config_tienda`
--
ALTER TABLE `config_tienda`
  ADD PRIMARY KEY (`clave`);

--
-- Indexes for table `empresa_envio`
--
ALTER TABLE `empresa_envio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `envio`
--
ALTER TABLE `envio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pedido_id` (`pedido_id`),
  ADD UNIQUE KEY `uq_envio_venta` (`venta_id`),
  ADD KEY `fk_envio_empresa` (`empresa_envio_id`),
  ADD KEY `fk_envio_barrio` (`barrio_id`),
  ADD KEY `fk_envio_repartidor` (`repartidor_id`);

--
-- Indexes for table `favorito`
--
ALTER TABLE `favorito`
  ADD PRIMARY KEY (`cliente_id`,`producto_id`),
  ADD KEY `fk_fav_producto` (`producto_id`);

--
-- Indexes for table `gasto`
--
ALTER TABLE `gasto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_gasto_fecha` (`fecha`),
  ADD KEY `idx_gasto_proveedor` (`proveedor_id`),
  ADD KEY `fk_gasto_producto` (`producto_id`),
  ADD KEY `fk_gasto_usuario` (`usuario_id`);

--
-- Indexes for table `intento_acceso`
--
ALTER TABLE `intento_acceso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ia` (`ip`,`accion`,`creado_en`);

--
-- Indexes for table `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`producto_id`);

--
-- Indexes for table `lista_precio`
--
ALTER TABLE `lista_precio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `movimiento_inventario`
--
ALTER TABLE `movimiento_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_movinv_venta` (`venta_id`),
  ADD KEY `fk_movinv_usuario` (`usuario_id`),
  ADD KEY `idx_movinv_producto` (`producto_id`);

--
-- Indexes for table `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_usuario` (`usuario_id`,`leida`),
  ADD KEY `ix_cliente` (`cliente_id`,`leida`);

--
-- Indexes for table `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_oc_proveedor` (`proveedor_id`),
  ADD KEY `fk_oc_usuario` (`usuario_id`),
  ADD KEY `idx_oc_estado` (`estado`,`creado_en`);

--
-- Indexes for table `orden_compra_detalle`
--
ALTER TABLE `orden_compra_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ocd_producto` (`producto_id`),
  ADD KEY `idx_ocd_orden` (`orden_compra_id`);

--
-- Indexes for table `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pago_venta` (`venta_id`),
  ADD KEY `fk_pago_tipo` (`tipo_pago_id`);

--
-- Indexes for table `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`),
  ADD KEY `fk_pedido_cliente` (`cliente_id`),
  ADD KEY `idx_pedido_estado_fecha` (`estado`,`creado_en`);

--
-- Indexes for table `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pdet_pedido` (`pedido_id`),
  ADD KEY `fk_pdet_producto` (`producto_id`);

--
-- Indexes for table `precio`
--
ALTER TABLE `precio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_precio_prod_lista` (`producto_id`,`lista_precio_id`),
  ADD KEY `fk_precio_lista` (`lista_precio_id`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD UNIQUE KEY `codigo_barras` (`codigo_barras`),
  ADD KEY `fk_producto_marca` (`marca_id`),
  ADD KEY `fk_producto_proveedor` (`proveedor_id`),
  ADD KEY `idx_producto_activo` (`activo`),
  ADD KEY `idx_producto_cat` (`categoria_id`);

--
-- Indexes for table `producto_imagen`
--
ALTER TABLE `producto_imagen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_img_producto` (`producto_id`,`orden`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reclamo`
--
ALTER TABLE `reclamo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reclamo_pedido` (`pedido_id`),
  ADD KEY `idx_reclamo_estado` (`estado`,`creado_en`),
  ADD KEY `idx_reclamo_cliente` (`cliente_id`);

--
-- Indexes for table `reclamo_mensaje`
--
ALTER TABLE `reclamo_mensaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_recmsg_usuario` (`usuario_id`),
  ADD KEY `idx_recmsg_reclamo` (`reclamo_id`);

--
-- Indexes for table `repartidor`
--
ALTER TABLE `repartidor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reposicion_pedido`
--
ALTER TABLE `reposicion_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_repo_pedido_proveedor` (`proveedor_id`),
  ADD KEY `idx_repo_pedido_prod` (`producto_id`,`creado_en`);

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `solicitud_mayorista`
--
ALTER TABLE `solicitud_mayorista`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_solic_cliente` (`cliente_id`),
  ADD KEY `fk_solic_admin` (`resuelto_por`);

--
-- Indexes for table `tipo_pago`
--
ALTER TABLE `tipo_pago`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_usuario_rol` (`rol_id`);

--
-- Indexes for table `usuario_token`
--
ALTER TABLE `usuario_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `idx_token_usuario` (`usuario_id`);

--
-- Indexes for table `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`),
  ADD KEY `fk_venta_cliente` (`cliente_id`),
  ADD KEY `fk_venta_usuario` (`usuario_id`),
  ADD KEY `idx_venta_estado_fecha` (`estado`,`creado_en`),
  ADD KEY `fk_venta_caja` (`caja_id`);

--
-- Indexes for table `venta_anulacion`
--
ALTER TABLE `venta_anulacion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `venta_id` (`venta_id`),
  ADD KEY `fk_anulacion_usuario` (`usuario_id`);

--
-- Indexes for table `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detalle_venta` (`venta_id`),
  ADD KEY `idx_vdet_producto` (`producto_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barrio`
--
ALTER TABLE `barrio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bloque`
--
ALTER TABLE `bloque`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `bloque_slide`
--
ALTER TABLE `bloque_slide`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `caja`
--
ALTER TABLE `caja`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `caja_movimiento`
--
ALTER TABLE `caja_movimiento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `cliente_token`
--
ALTER TABLE `cliente_token`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `comprobante`
--
ALTER TABLE `comprobante`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `empresa_envio`
--
ALTER TABLE `empresa_envio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `envio`
--
ALTER TABLE `envio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `gasto`
--
ALTER TABLE `gasto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `intento_acceso`
--
ALTER TABLE `intento_acceso`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `lista_precio`
--
ALTER TABLE `lista_precio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `marca`
--
ALTER TABLE `marca`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `movimiento_inventario`
--
ALTER TABLE `movimiento_inventario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `orden_compra`
--
ALTER TABLE `orden_compra`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orden_compra_detalle`
--
ALTER TABLE `orden_compra_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pago`
--
ALTER TABLE `pago`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `precio`
--
ALTER TABLE `precio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `producto_imagen`
--
ALTER TABLE `producto_imagen`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reclamo`
--
ALTER TABLE `reclamo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reclamo_mensaje`
--
ALTER TABLE `reclamo_mensaje`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `repartidor`
--
ALTER TABLE `repartidor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `reposicion_pedido`
--
ALTER TABLE `reposicion_pedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `solicitud_mayorista`
--
ALTER TABLE `solicitud_mayorista`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tipo_pago`
--
ALTER TABLE `tipo_pago`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `usuario_token`
--
ALTER TABLE `usuario_token`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `venta_anulacion`
--
ALTER TABLE `venta_anulacion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `venta_detalle`
--
ALTER TABLE `venta_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bloque_slide`
--
ALTER TABLE `bloque_slide`
  ADD CONSTRAINT `fk_slide_bloque` FOREIGN KEY (`bloque_id`) REFERENCES `bloque` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `caja`
--
ALTER TABLE `caja`
  ADD CONSTRAINT `fk_caja_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `caja_movimiento`
--
ALTER TABLE `caja_movimiento`
  ADD CONSTRAINT `fk_cajamov_caja` FOREIGN KEY (`caja_id`) REFERENCES `caja` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cajamov_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_lista` FOREIGN KEY (`lista_precio_id`) REFERENCES `lista_precio` (`id`);

--
-- Constraints for table `cliente_token`
--
ALTER TABLE `cliente_token`
  ADD CONSTRAINT `fk_ctok_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comprobante`
--
ALTER TABLE `comprobante`
  ADD CONSTRAINT `fk_comprobante_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`);

--
-- Constraints for table `envio`
--
ALTER TABLE `envio`
  ADD CONSTRAINT `fk_envio_barrio` FOREIGN KEY (`barrio_id`) REFERENCES `barrio` (`id`),
  ADD CONSTRAINT `fk_envio_empresa` FOREIGN KEY (`empresa_envio_id`) REFERENCES `empresa_envio` (`id`),
  ADD CONSTRAINT `fk_envio_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `fk_envio_repartidor` FOREIGN KEY (`repartidor_id`) REFERENCES `repartidor` (`id`),
  ADD CONSTRAINT `fk_envio_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`);

--
-- Constraints for table `favorito`
--
ALTER TABLE `favorito`
  ADD CONSTRAINT `fk_fav_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_fav_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `gasto`
--
ALTER TABLE `gasto`
  ADD CONSTRAINT `fk_gasto_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `fk_gasto_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`),
  ADD CONSTRAINT `fk_gasto_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inventario_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`);

--
-- Constraints for table `movimiento_inventario`
--
ALTER TABLE `movimiento_inventario`
  ADD CONSTRAINT `fk_movinv_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `fk_movinv_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `fk_movinv_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`);

--
-- Constraints for table `notificacion`
--
ALTER TABLE `notificacion`
  ADD CONSTRAINT `fk_noti_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_noti_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD CONSTRAINT `fk_oc_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_oc_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `orden_compra_detalle`
--
ALTER TABLE `orden_compra_detalle`
  ADD CONSTRAINT `fk_ocd_orden` FOREIGN KEY (`orden_compra_id`) REFERENCES `orden_compra` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ocd_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`);

--
-- Constraints for table `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_pago_tipo` FOREIGN KEY (`tipo_pago_id`) REFERENCES `tipo_pago` (`id`),
  ADD CONSTRAINT `fk_pago_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`);

--
-- Constraints for table `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`);

--
-- Constraints for table `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD CONSTRAINT `fk_pdet_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `fk_pdet_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`);

--
-- Constraints for table `precio`
--
ALTER TABLE `precio`
  ADD CONSTRAINT `fk_precio_lista` FOREIGN KEY (`lista_precio_id`) REFERENCES `lista_precio` (`id`),
  ADD CONSTRAINT `fk_precio_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`);

--
-- Constraints for table `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`),
  ADD CONSTRAINT `fk_producto_marca` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`),
  ADD CONSTRAINT `fk_producto_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`);

--
-- Constraints for table `producto_imagen`
--
ALTER TABLE `producto_imagen`
  ADD CONSTRAINT `fk_img_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reclamo`
--
ALTER TABLE `reclamo`
  ADD CONSTRAINT `fk_reclamo_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `fk_reclamo_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`);

--
-- Constraints for table `reclamo_mensaje`
--
ALTER TABLE `reclamo_mensaje`
  ADD CONSTRAINT `fk_recmsg_reclamo` FOREIGN KEY (`reclamo_id`) REFERENCES `reclamo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_recmsg_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `reposicion_pedido`
--
ALTER TABLE `reposicion_pedido`
  ADD CONSTRAINT `fk_repo_pedido_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_repo_pedido_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `solicitud_mayorista`
--
ALTER TABLE `solicitud_mayorista`
  ADD CONSTRAINT `fk_solic_admin` FOREIGN KEY (`resuelto_por`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `fk_solic_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id`);

--
-- Constraints for table `usuario_token`
--
ALTER TABLE `usuario_token`
  ADD CONSTRAINT `fk_token_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_caja` FOREIGN KEY (`caja_id`) REFERENCES `caja` (`id`),
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `venta_anulacion`
--
ALTER TABLE `venta_anulacion`
  ADD CONSTRAINT `fk_anulacion_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `fk_anulacion_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`);

--
-- Constraints for table `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `fk_detalle_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
