-- Borrar tablas si existen (para empezar de cero limpio)
DROP DATABASE IF EXISTS agencia_alquiler;
CREATE DATABASE agencia_alquiler;
USE agencia_alquiler;

-- 1. USUARIOS (Solo Clientes y Personal de la empresa)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    dni_nie VARCHAR(20), -- Para cumplir normativa legal
    foto_perfil VARCHAR(255),
    rol ENUM('admin', 'cliente') DEFAULT 'cliente', -- Simplificado
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_nacimiento DATE -- Campo adicional para verificar edad si es necesario
);

-- 2. SERVICIOS (Catálogo: Wifi, Piscina...)
CREATE TABLE servicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    icono_css VARCHAR(50) -- Clase de FontAwesome ej: 'fa-wifi'
);

-- 3. APARTAMENTOS (Gestión directa de la agencia)
CREATE TABLE apartamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion_larga TEXT,
    direccion_completa VARCHAR(255),
    ciudad VARCHAR(100),
    provincia VARCHAR(50),
    zona_turistica VARCHAR(100), -- Ej: Costa del Sol
    precio_base_noche DECIMAL(10, 2) NOT NULL,
    capacidad_maxima INT NOT NULL,
    habitaciones INT,
    banios INT,
    metros_cuadrados INT,
    estado ENUM('disponible', 'mantenimiento', 'oculto') DEFAULT 'disponible',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP -- Campo adicional para rastrear creación
    -- Eliminado id_propietario
);

-- 4. FOTOS (Galería)
CREATE TABLE fotos_apartamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_apartamento INT NOT NULL,
    url_foto VARCHAR(255) NOT NULL,
    orden INT DEFAULT 0, -- 0 es la portada
    FOREIGN KEY (id_apartamento) REFERENCES apartamentos(id) ON DELETE CASCADE
);

-- 5. RELACIÓN APARTAMENTO-SERVICIOS
CREATE TABLE apartamento_servicios (
    id_apartamento INT NOT NULL,
    id_servicio INT NOT NULL,
    PRIMARY KEY (id_apartamento, id_servicio),
    FOREIGN KEY (id_apartamento) REFERENCES apartamentos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_servicio) REFERENCES servicios(id) ON DELETE CASCADE
);

-- 6. RESERVAS
CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_reserva VARCHAR(20) UNIQUE NOT NULL,
    id_usuario INT NOT NULL,
    id_apartamento INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    numero_huespedes INT NOT NULL,
    precio_total DECIMAL(10, 2) NOT NULL,
    estado ENUM('pendiente', 'confirmada', 'cancelada') DEFAULT 'pendiente',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    notas TEXT, -- Campo adicional para comentarios internos
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE, -- Si borras usuario, cuidado con sus reservas
    FOREIGN KEY (id_apartamento) REFERENCES apartamentos(id) ON DELETE CASCADE
);

-- 7. VALORACIONES
CREATE TABLE valoraciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT UNIQUE NOT NULL,
    puntuacion_limpieza INT CHECK (puntuacion_limpieza BETWEEN 1 AND 5),
    puntuacion_ubicacion INT CHECK (puntuacion_ubicacion BETWEEN 1 AND 5),
    puntuacion_calidad INT CHECK (puntuacion_calidad BETWEEN 1 AND 5),
    comentario TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id) ON DELETE CASCADE
);

-- Índices para optimizar búsquedas
CREATE INDEX idx_ciudad ON apartamentos(ciudad);
CREATE INDEX idx_provincia ON apartamentos(provincia);
CREATE INDEX idx_zona_turistica ON apartamentos(zona_turistica);
CREATE INDEX idx_fecha_entrada ON reservas(fecha_entrada);
CREATE INDEX idx_fecha_salida ON reservas(fecha_salida);

-- Datos de ejemplo para servicios
INSERT INTO servicios (nombre, icono_css) VALUES
('Wifi', 'fa-wifi'),
('Piscina', 'fa-swimming-pool'),
('Aire acondicionado', 'fa-snowflake'),
('Cocina equipada', 'fa-utensils'),
('Parking', 'fa-car'),
('Terraza', 'fa-sun'),
('Lavadora', 'fa-tshirt'),
('TV', 'fa-tv');