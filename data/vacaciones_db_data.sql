-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-07-2025 a las 16:46:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vacaciones_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_administrador` int(11) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_administrador`, `nombre_completo`, `email`) VALUES
(1, 'Ana Castro Flores', 'ana.castro@empresa.com'),
(2, 'José Rodríguez Peña', 'jose.rodriguez@empresa.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `politica_vacacional`
--

CREATE TABLE `politica_vacacional` (
  `id_politica` int(11) NOT NULL,
  `anios_antiguedad_min` int(11) NOT NULL,
  `anios_antiguedad_max` int(11) NOT NULL,
  `dias_vacacion_anuales` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `politica_vacacional`
--

INSERT INTO `politica_vacacional` (`id_politica`, `anios_antiguedad_min`, `anios_antiguedad_max`, `dias_vacacion_anuales`) VALUES
(1, 0, 1, 10.00),
(2, 2, 4, 15.00),
(3, 5, 9, 20.00),
(4, 10, 50, 25.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_vacaciones`
--

CREATE TABLE `solicitud_vacaciones` (
  `id_solicitud` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `cantidad_dias` decimal(5,2) NOT NULL,
  `tipo_solicitud` enum('día','hora') NOT NULL,
  `estado` enum('pendiente','aprobada','rechazada') DEFAULT 'pendiente',
  `id_administrador` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitud_vacaciones`
--

INSERT INTO `solicitud_vacaciones` (`id_solicitud`, `id_trabajador`, `fecha_solicitud`, `fecha_inicio`, `fecha_fin`, `cantidad_dias`, `tipo_solicitud`, `estado`, `id_administrador`, `observaciones`) VALUES
(1, 1, '2025-07-20', '2025-08-05', '2025-08-09', 5.00, 'día', 'aprobada', 1, 'Solicitud aprobada sin conflictos.'),
(2, 2, '2025-07-25', '2025-08-12', '2025-08-13', 2.00, 'día', 'pendiente', NULL, NULL),
(3, 3, '2025-07-15', '2025-08-01', '2025-08-03', 3.00, 'día', 'rechazada', 2, 'Ya tiene vacaciones ese mes.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador`
--

CREATE TABLE `trabajador` (
  `id_trabajador` int(11) NOT NULL,
  `ci` varchar(20) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `area_trabajo` varchar(50) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `dias_disponibles` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajador`
--

INSERT INTO `trabajador` (`id_trabajador`, `ci`, `nombre_completo`, `fecha_ingreso`, `area_trabajo`, `cargo`, `dias_disponibles`) VALUES
(1, '7894561', 'Luis Pericena Choque', '2020-03-15', 'Desarrollo', 'Backend Developer', 15.00),
(2, '1234567', 'María López Mendoza', '2023-08-01', 'Recursos Humanos', 'Analista RRHH', 10.00),
(3, '6543210', 'Carlos Quispe Vargas', '2015-02-20', 'Soporte Técnico', 'Técnico de Sistemas', 20.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_administrador`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `politica_vacacional`
--
ALTER TABLE `politica_vacacional`
  ADD PRIMARY KEY (`id_politica`);

--
-- Indices de la tabla `solicitud_vacaciones`
--
ALTER TABLE `solicitud_vacaciones`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `id_trabajador` (`id_trabajador`),
  ADD KEY `id_administrador` (`id_administrador`);

--
-- Indices de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD PRIMARY KEY (`id_trabajador`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_administrador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `politica_vacacional`
--
ALTER TABLE `politica_vacacional`
  MODIFY `id_politica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `solicitud_vacaciones`
--
ALTER TABLE `solicitud_vacaciones`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  MODIFY `id_trabajador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `solicitud_vacaciones`
--
ALTER TABLE `solicitud_vacaciones`
  ADD CONSTRAINT `solicitud_vacaciones_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajador` (`id_trabajador`),
  ADD CONSTRAINT `solicitud_vacaciones_ibfk_2` FOREIGN KEY (`id_administrador`) REFERENCES `administrador` (`id_administrador`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
