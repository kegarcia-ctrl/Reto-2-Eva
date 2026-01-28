-- ============================================
-- ESQUEMA DE BASE DE DATOS KASA (ESPAÑOL)
-- Compatible con XAMPP MySQL
-- ============================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS kasa_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE kasa_db;

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- Tabla de usuarios (clientes que alquilan propiedades)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP NULL,
    esta_activo BOOLEAN DEFAULT TRUE,
    INDEX idx_email (email)
) ENGINE = InnoDB;

-- Propietarios de las viviendas
CREATE TABLE propietarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    nombre_empresa VARCHAR(150),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    esta_verificado BOOLEAN DEFAULT FALSE,
    INDEX idx_email (email)
) ENGINE = InnoDB;

-- Usuarios administradores para el panel de control
CREATE TABLE administradores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    nombre_completo VARCHAR(100),
    rol ENUM(
        'SUPER_ADMIN',
        'ADMIN',
        'MODERADOR'
    ) DEFAULT 'ADMIN',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP NULL,
    esta_activo BOOLEAN DEFAULT TRUE
) ENGINE = InnoDB;

-- Catálogo de ciudades
CREATE TABLE ciudades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    pais VARCHAR(100) DEFAULT 'España',
    esta_activo BOOLEAN DEFAULT TRUE
) ENGINE = InnoDB;

-- Catálogo de tipos de propiedad
CREATE TABLE tipos_propiedad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT
) ENGINE = InnoDB;

-- Propiedades / Anuncios
CREATE TABLE propiedades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    propietario_id INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    tipo_propiedad_id INT NOT NULL,
    ciudad_id INT NOT NULL,
    zona VARCHAR(100),
    direccion VARCHAR(255),
    precio DECIMAL(10, 2) NOT NULL,
    habitaciones INT DEFAULT 0,
    banos INT DEFAULT 0,
    area_m2 DECIMAL(8, 2),
    numero_planta INT,
    tiene_ascensor BOOLEAN DEFAULT FALSE,
    tiene_parking BOOLEAN DEFAULT FALSE,
    tiene_jardin BOOLEAN DEFAULT FALSE,
    tiene_piscina BOOLEAN DEFAULT FALSE,
    esta_amueblado BOOLEAN DEFAULT FALSE,
    estado ENUM(
        'DISPONIBLE',
        'ALQUILADO',
        'MANTENIMIENTO',
        'INACTIVO'
    ) DEFAULT 'DISPONIBLE',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    contador_visitas INT DEFAULT 0,
    FOREIGN KEY (propietario_id) REFERENCES propietarios (id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_propiedad_id) REFERENCES tipos_propiedad (id),
    FOREIGN KEY (ciudad_id) REFERENCES ciudades (id),
    INDEX idx_ciudad (ciudad_id),
    INDEX idx_precio (precio),
    INDEX idx_estado (estado)
) ENGINE = InnoDB;

-- Imágenes de las propiedades
CREATE TABLE imagenes_propiedad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    url_imagen VARCHAR(500) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    orden_visualizacion INT DEFAULT 0,
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades (id) ON DELETE CASCADE,
    INDEX idx_propiedad (propiedad_id)
) ENGINE = InnoDB;

-- Catálogo de servicios / características
CREATE TABLE servicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    icono VARCHAR(50),
    categoria ENUM(
        'BASICO',
        'CONFORT',
        'SEGURIDAD',
        'ENTRETENIMIENTO'
    ) DEFAULT 'BASICO'
) ENGINE = InnoDB;

-- Servicios de las propiedades (muchos a muchos)
CREATE TABLE servicios_propiedad (
    propiedad_id INT NOT NULL,
    servicio_id INT NOT NULL,
    PRIMARY KEY (propiedad_id, servicio_id),
    FOREIGN KEY (propiedad_id) REFERENCES propiedades (id) ON DELETE CASCADE,
    FOREIGN KEY (servicio_id) REFERENCES servicios (id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Reservas
CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    precio_total DECIMAL(10, 2) NOT NULL,
    estado ENUM(
        'PENDIENTE',
        'CONFIRMADA',
        'CANCELADA',
        'COMPLETADA'
    ) DEFAULT 'PENDIENTE',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    motivo_cancelacion TEXT,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades (id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    INDEX idx_propiedad (propiedad_id),
    INDEX idx_usuario (usuario_id),
    INDEX idx_fechas (fecha_entrada, fecha_salida),
    INDEX idx_estado (estado)
) ENGINE = InnoDB;

-- Pagos
CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    metodo_pago ENUM(
        'TARJETA_CREDITO',
        'TARJETA_DEBITO',
        'PAYPAL',
        'TRANSFERENCIA',
        'EFECTIVO'
    ) NOT NULL,
    estado_pago ENUM(
        'PENDIENTE',
        'COMPLETADO',
        'FALLIDO',
        'REEMBOLSADO'
    ) DEFAULT 'PENDIENTE',
    transaccion_id VARCHAR(100) UNIQUE,
    fecha_pago TIMESTAMP NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reserva_id) REFERENCES reservas (id) ON DELETE CASCADE,
    INDEX idx_reserva (reserva_id),
    INDEX idx_estado (estado_pago)
) ENGINE = InnoDB;

-- Reseñas / Calificaciones
CREATE TABLE resenas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    usuario_id INT NOT NULL,
    reserva_id INT,
    calificacion INT NOT NULL CHECK (
        calificacion >= 1
        AND calificacion <= 5
    ),
    titulo VARCHAR(200),
    comentario TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    esta_verificado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades (id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    FOREIGN KEY (reserva_id) REFERENCES reservas (id) ON DELETE SET NULL,
    INDEX idx_propiedad (propiedad_id),
    INDEX idx_calificacion (calificacion)
) ENGINE = InnoDB;

-- Favoritos de usuarios
CREATE TABLE favoritos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    propiedad_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades (id) ON DELETE CASCADE,
    UNIQUE KEY unico_favorito (usuario_id, propiedad_id),
    INDEX idx_usuario (usuario_id)
) ENGINE = InnoDB;

-- Mensajes entre usuarios y propietarios
CREATE TABLE mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emisor_id INT NOT NULL,
    tipo_emisor ENUM('USUARIO', 'PROPIETARIO') NOT NULL,
    receptor_id INT NOT NULL,
    tipo_receptor ENUM('USUARIO', 'PROPIETARIO') NOT NULL,
    propiedad_id INT,
    asunto VARCHAR(200),
    mensaje TEXT NOT NULL,
    esta_leido BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades (id) ON DELETE SET NULL,
    INDEX idx_receptor (receptor_id, tipo_receptor),
    INDEX idx_emisor (emisor_id, tipo_emisor)
) ENGINE = InnoDB;

-- Log de auditoría para seguimiento de cambios
CREATE TABLE registro_auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tabla VARCHAR(50) NOT NULL,
    registro_id INT NOT NULL,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    usuario_id INT,
    tipo_usuario ENUM(
        'USUARIO',
        'PROPIETARIO',
        'ADMIN'
    ),
    valores_antiguos JSON,
    valores_nuevos JSON,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tabla (nombre_tabla, registro_id),
    INDEX idx_creacion (fecha_creacion)
) ENGINE = InnoDB;

-- ============================================
-- DATOS INICIALES BÁSICOS
-- ============================================

-- Insertar administrador por defecto (password: admin123)
INSERT INTO
    administradores (
        nombre_usuario,
        contrasena,
        email,
        nombre_completo,
        rol
    )
VALUES (
        'admin',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        'admin@kasa.com',
        'Administrador',
        'super_admin'
    );

-- Insertar ciudades
INSERT INTO
    ciudades (nombre)
VALUES ('Donosti'),
    ('Madrid'),
    ('Barcelona'),
    ('Valencia'),
    ('Murcia'),
    ('Bilbao'),
    ('Sevilla'),
    ('Málaga');

-- Insertar tipos de propiedad
INSERT INTO
    tipos_propiedad (nombre, descripcion)
VALUES (
        'Piso',
        'Apartamento en edificio'
    ),
    ('Casa', 'Casa independiente'),
    (
        'Estudio',
        'Estudio o apartamento pequeño'
    ),
    (
        'Ático',
        'Piso en la última planta con terraza'
    ),
    (
        'Loft',
        'Espacio abierto tipo industrial'
    ),
    ('Chalet', 'Casa con jardín'),
    ('Villa', 'Casa de lujo'),
    (
        'Duplex',
        'Vivienda de dos plantas'
    );

-- Insertar servicios
INSERT INTO
    servicios (nombre, icono, categoria)
VALUES ('WiFi', '📶', 'BASICO'),
    (
        'Aire Acondicionado',
        '❄️',
        'CONFORT'
    ),
    (
        'Calefacción',
        '🔥',
        'CONFORT'
    ),
    (
        'Cocina Equipada',
        '🍳',
        'basico'
    ),
    ('Lavadora', '🧺', 'basico'),
    ('Secadora', '👕', 'CONFORT'),
    (
        'Lavavajillas',
        '🍽️',
        'CONFORT'
    ),
    ('TV', '📺', 'ENTRETENIMIENTO'),
    ('Parking', '🚗', 'basico'),
    ('Ascensor', '🛗', 'basico'),
    ('Balcón', '🏞️', 'CONFORT'),
    ('Terraza', '🌅', 'CONFORT'),
    ('Jardín', '🌳', 'CONFORT'),
    ('Piscina', '🏊', 'CONFORT'),
    (
        'Gimnasio',
        '💪',
        'ENTRETENIMIENTO'
    ),
    (
        'Seguridad 24h',
        '🔒',
        'SEGURIDAD'
    ),
    ('Alarma', '🚨', 'SEGURIDAD'),
    (
        'Portero Automático',
        '🔔',
        'SEGURIDAD'
    ),
    (
        'Mascotas Permitidas',
        '🐕',
        'basico'
    ),
    (
        'Acceso Discapacitados',
        '♿',
        'basico'
    );