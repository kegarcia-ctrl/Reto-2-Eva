-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-01-2026 a las 09:51:32
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
-- Base de datos: `kasa_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `mail`, `contrasena`) VALUES
(1, 'ib.richard@nazaret.team', 'NZ2526nz'),
(2, 'yu.nava@nazaret.team', 'NZ2526nz'),
(3, 'ke.garcia@nazaret.team', 'NZ2526nz'),
(4, 'na.jaen@nazaret.team', 'NZ2526nz'),
(5, 'lu.urdampilleta@nazaret.team', 'NZ2526nz');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `pais` varchar(100) DEFAULT 'España',
  `esta_activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`id`, `nombre`, `pais`, `esta_activo`) VALUES
(1, 'Donosti', 'España', 1),
(2, 'Madrid', 'España', 1),
(3, 'Barcelona', 'España', 1),
(4, 'Valencia', 'España', 1),
(5, 'Murcia', 'España', 1),
(6, 'Bilbao', 'España', 1),
(7, 'Sevilla', 'España', 1),
(8, 'Málaga', 'España', 1),
(21, 'Zaragoza', 'España', 1),
(22, 'Palma', 'España', 1),
(23, 'Las Palmas', 'España', 1),
(24, 'Granada', 'España', 1),
(25, 'Alicante', 'España', 1),
(26, 'Córdoba', 'España', 1),
(27, 'Valladolid', 'España', 1),
(28, 'Vigo', 'España', 1),
(29, 'Gijón', 'España', 1),
(30, 'Vitoria', 'España', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id` bigint(20) NOT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `propiedad_id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_propiedad`
--

CREATE TABLE `imagenes_propiedad` (
  `id` bigint(20) NOT NULL,
  `propiedad_id` int(11) NOT NULL,
  `url_imagen` varchar(500) NOT NULL,
  `es_principal` tinyint(1) DEFAULT 0,
  `orden_visualizacion` int(11) DEFAULT 0,
  `fecha_subida` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` bigint(20) NOT NULL,
  `asunto` varchar(200) DEFAULT NULL,
  `emisor_id` bigint(20) NOT NULL,
  `esta_leido` bit(1) DEFAULT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `mensaje` text NOT NULL,
  `receptor_id` bigint(20) NOT NULL,
  `tipo_emisor` enum('USUARIO','PROPIETARIO') NOT NULL,
  `tipo_receptor` enum('USUARIO','PROPIETARIO') NOT NULL,
  `propiedad_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint(20) NOT NULL,
  `reserva_id` int(11) NOT NULL,
  `monto` decimal(38,2) NOT NULL,
  `metodo_pago` enum('TARJETA_CREDITO','TARJETA_DEBITO','PAYPAL','TRANSFERENCIA','EFECTIVO') NOT NULL,
  `estado_pago` enum('PENDIENTE','COMPLETADO','FALLIDO','REEMBOLSADO') DEFAULT 'PENDIENTE',
  `transaccion_id` varchar(100) DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propiedades`
--

CREATE TABLE `propiedades` (
  `id` int(11) NOT NULL,
  `propietario_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo_propiedad_id` int(11) NOT NULL,
  `ciudad_id` int(11) NOT NULL,
  `zona` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `habitaciones` int(11) DEFAULT 0,
  `banos` int(11) DEFAULT 0,
  `area_m2` decimal(8,2) DEFAULT NULL,
  `numero_planta` int(11) DEFAULT NULL,
  `tiene_ascensor` tinyint(1) DEFAULT 0,
  `tiene_parking` tinyint(1) DEFAULT 0,
  `tiene_jardin` tinyint(1) DEFAULT 0,
  `tiene_piscina` tinyint(1) DEFAULT 0,
  `esta_amueblado` tinyint(1) DEFAULT 0,
  `estado` enum('DISPONIBLE','ALQUILADO','MANTENIMIENTO','INACTIVO') DEFAULT 'DISPONIBLE',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `contador_visitas` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `propiedades`
--

INSERT INTO `propiedades` (`id`, `propietario_id`, `titulo`, `descripcion`, `tipo_propiedad_id`, `ciudad_id`, `zona`, `direccion`, `precio`, `habitaciones`, `banos`, `area_m2`, `numero_planta`, `tiene_ascensor`, `tiene_parking`, `tiene_jardin`, `tiene_piscina`, `esta_amueblado`, `estado`, `fecha_creacion`, `fecha_actualizacion`, `contador_visitas`) VALUES
(2, 1, 'Piso en Gros', 'sdgsdgsa', 1, 1, 'Gros', 'dagsas', 2500.00, 3, 1, 62.00, 4, 1, 0, 0, 0, 1, 'DISPONIBLE', '2026-01-28 07:31:03', '2026-01-28 07:32:01', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propietarios`
--

CREATE TABLE `propietarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `nombre_empresa` varchar(150) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `esta_verificado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `propietarios`
--

INSERT INTO `propietarios` (`id`, `nombre`, `email`, `contrasena`, `telefono`, `nombre_empresa`, `fecha_creacion`, `esta_verificado`) VALUES
(1, 'Iban', 'ib.richard@nazaret.team', 'Nz2526nz', '656688729', 'Kasa', '2026-01-27 12:43:34', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_auditoria`
--

CREATE TABLE `registro_auditoria` (
  `id` bigint(20) NOT NULL,
  `accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `valores_nuevos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_nuevos`)),
  `valores_antiguos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_antiguos`)),
  `registro_id` bigint(20) NOT NULL,
  `nombre_tabla` varchar(50) NOT NULL,
  `tipo_usuario` enum('USUARIO','PROPIETARIO','ADMIN') DEFAULT NULL,
  `usuario_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenas`
--

CREATE TABLE `resenas` (
  `id` bigint(20) NOT NULL,
  `calificacion` int(11) NOT NULL,
  `comentario` text DEFAULT NULL,
  `esta_verificado` bit(1) DEFAULT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `reserva_id` bigint(20) DEFAULT NULL,
  `propiedad_id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `propiedad_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_entrada` date NOT NULL,
  `fecha_salida` date NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  `estado` enum('PENDIENTE','CONFIRMADA','CANCELADA','COMPLETADA') DEFAULT 'PENDIENTE',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `motivo_cancelacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `propiedad_id`, `usuario_id`, `fecha_entrada`, `fecha_salida`, `precio_total`, `estado`, `fecha_creacion`, `fecha_actualizacion`, `motivo_cancelacion`) VALUES
(2, 2, 1, '2026-02-23', '2026-02-27', 2500.00, 'PENDIENTE', '2026-01-28 07:32:17', '2026-01-28 07:32:17', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `icono` varchar(50) DEFAULT NULL,
  `categoria` enum('BASICO','CONFORT','SEGURIDAD','ENTRETENIMIENTO') DEFAULT 'BASICO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_propiedad`
--

CREATE TABLE `servicios_propiedad` (
  `propiedad_id` int(11) NOT NULL,
  `servicio_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_propiedad`
--

CREATE TABLE `tipos_propiedad` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipos_propiedad`
--

INSERT INTO `tipos_propiedad` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Piso', 'Apartamento en edificio'),
(2, 'Casa', 'Casa independiente'),
(3, 'Estudio', 'Estudio o apartamento pequeño'),
(4, 'Ático', 'Piso en la última planta con terraza'),
(5, 'Loft', 'Espacio abierto tipo industrial'),
(6, 'Chalet', 'Casa con jardín'),
(7, 'Villa', 'Casa de lujo'),
(8, 'Duplex', 'Vivienda de dos plantas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  `esta_activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contrasena`, `telefono`, `fecha_creacion`, `ultimo_acceso`, `esta_activo`) VALUES
(1, 'Iban', 'ibanrichi2@gmail.com', 'N118y546.123', NULL, '2026-01-27 11:33:58', '2026-01-28 07:31:36', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- Indices de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKh64vw5816i29stlc7pfnwb48p` (`usuario_id`,`propiedad_id`);

--
-- Indices de la tabla `imagenes_propiedad`
--
ALTER TABLE `imagenes_propiedad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_propiedad` (`propiedad_id`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaccion_id` (`transaccion_id`),
  ADD KEY `idx_reserva` (`reserva_id`),
  ADD KEY `idx_estado` (`estado_pago`);

--
-- Indices de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `propietario_id` (`propietario_id`),
  ADD KEY `tipo_propiedad_id` (`tipo_propiedad_id`),
  ADD KEY `idx_ciudad` (`ciudad_id`),
  ADD KEY `idx_precio` (`precio`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `propietarios`
--
ALTER TABLE `propietarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indices de la tabla `registro_auditoria`
--
ALTER TABLE `registro_auditoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_propiedad` (`propiedad_id`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_fechas` (`fecha_entrada`,`fecha_salida`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `servicios_propiedad`
--
ALTER TABLE `servicios_propiedad`
  ADD PRIMARY KEY (`propiedad_id`,`servicio_id`),
  ADD KEY `servicio_id` (`servicio_id`);

--
-- Indices de la tabla `tipos_propiedad`
--
ALTER TABLE `tipos_propiedad`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagenes_propiedad`
--
ALTER TABLE `imagenes_propiedad`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `propiedades`
--
ALTER TABLE `propiedades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `propietarios`
--
ALTER TABLE `propietarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `registro_auditoria`
--
ALTER TABLE `registro_auditoria`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `tipos_propiedad`
--
ALTER TABLE `tipos_propiedad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `imagenes_propiedad`
--
ALTER TABLE `imagenes_propiedad`
  ADD CONSTRAINT `imagenes_propiedad_ibfk_1` FOREIGN KEY (`propiedad_id`) REFERENCES `propiedades` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `propiedades`
--
ALTER TABLE `propiedades`
  ADD CONSTRAINT `propiedades_ibfk_1` FOREIGN KEY (`propietario_id`) REFERENCES `propietarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `propiedades_ibfk_2` FOREIGN KEY (`tipo_propiedad_id`) REFERENCES `tipos_propiedad` (`id`),
  ADD CONSTRAINT `propiedades_ibfk_3` FOREIGN KEY (`ciudad_id`) REFERENCES `ciudades` (`id`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`propiedad_id`) REFERENCES `propiedades` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `servicios_propiedad`
--
ALTER TABLE `servicios_propiedad`
  ADD CONSTRAINT `servicios_propiedad_ibfk_1` FOREIGN KEY (`propiedad_id`) REFERENCES `propiedades` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `servicios_propiedad_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
