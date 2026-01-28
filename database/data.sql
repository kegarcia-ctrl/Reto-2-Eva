-- ============================================
-- DATOS DE EJEMPLO PARA LA BASE DE DATOS KASA
-- Ejecutar esto después de schema.sql
-- ============================================

USE kasa_db;

-- Insertar propietarios de ejemplo
INSERT INTO
    propietarios (
        nombre,
        email,
        contrasena,
        telefono,
        nombre_empresa,
        esta_verificado
    )
VALUES (
        'Juan García',
        'juan@propiedades.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 600 111 222',
        'Propiedades García',
        TRUE
    ),
    (
        'María López',
        'maria@inmobiliaria.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 600 333 444',
        'Inmobiliaria López',
        TRUE
    ),
    (
        'Pedro Martínez',
        'pedro@casas.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 600 555 666',
        'Casas Premium',
        TRUE
    );

-- Insertar usuarios de ejemplo
INSERT INTO
    usuarios (
        nombre,
        email,
        contrasena,
        telefono
    )
VALUES (
        'Ana Rodríguez',
        'ana@email.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 611 222 333'
    ),
    (
        'Carlos Sánchez',
        'carlos@email.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 622 333 444'
    ),
    (
        'Laura Fernández',
        'laura@email.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 633 444 555'
    ),
    (
        'David Gómez',
        'david@email.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        '+34 644 555 666'
    );

-- Insertar propiedades de ejemplo
INSERT INTO
    propiedades (
        propietario_id,
        titulo,
        descripcion,
        tipo_propiedad_id,
        ciudad_id,
        zona,
        direccion,
        precio,
        habitaciones,
        banos,
        area_m2,
        tiene_parking,
        esta_amueblado,
        estado
    )
VALUES (
        1,
        'Piso céntrico en Donosti',
        'Precioso piso en el centro de San Sebastián, totalmente reformado',
        1,
        1,
        'Centro',
        'C/ Mayor, 15',
        850.00,
        2,
        1,
        65.00,
        FALSE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        1,
        'Ático con terraza en Madrid',
        'Espectacular ático con terraza de 40m² en pleno centro',
        4,
        2,
        'Centro',
        'Gran Vía, 28',
        1200.00,
        3,
        2,
        90.00,
        TRUE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        2,
        'Estudio moderno en Donosti',
        'Estudio completamente equipado en zona norte',
        3,
        1,
        'Norte',
        'Av. Libertad, 45',
        700.00,
        1,
        1,
        40.00,
        FALSE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        2,
        'Piso en Barcelona',
        'Piso en el casco antiguo de Barcelona',
        1,
        3,
        'Casco Antiguo',
        'C/ Gotico, 12',
        950.00,
        2,
        1,
        70.00,
        FALSE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        3,
        'Casa con jardín en Valencia',
        'Adosado con jardín privado y garaje',
        2,
        4,
        'Sur',
        'Urbanización Las Flores, 8',
        1500.00,
        4,
        2,
        150.00,
        TRUE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        3,
        'Loft industrial en Murcia',
        'Loft tipo industrial completamente reformado',
        5,
        5,
        'Centro',
        'C/ Industrial, 22',
        600.00,
        1,
        1,
        55.00,
        FALSE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        1,
        'Piso familiar en Donosti',
        'Amplio piso familiar con 3 habitaciones',
        1,
        1,
        'Centro',
        'C/ Urbieta, 33',
        1100.00,
        3,
        2,
        85.00,
        TRUE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        2,
        'Piso cerca universidad Madrid',
        'Ideal para estudiantes, cerca del campus',
        1,
        2,
        'Norte',
        'C/ Universitaria, 67',
        890.00,
        2,
        1,
        60.00,
        FALSE,
        TRUE,
        'DISPONIBLE'
    ),
    (
        3,
        'Villa de lujo en Valencia',
        'Villa con piscina privada y vistas al mar',
        7,
        4,
        'Costa',
        'Paseo Marítimo, 100',
        2000.00,
        5,
        3,
        250.00,
        TRUE,
        TRUE,
        'DISPONIBLE'
    );

-- Insertar imágenes de las propiedades
INSERT INTO
    imagenes_propiedad (
        propiedad_id,
        url_imagen,
        es_principal,
        orden_visualizacion
    )
VALUES (
        1,
        '../images/piso1.png',
        TRUE,
        1
    ),
    (
        1,
        '../images/piso1.2.png',
        FALSE,
        2
    ),
    (
        2,
        '../images/piso2.png',
        TRUE,
        1
    ),
    (
        2,
        '../images/piso2.1.png',
        FALSE,
        2
    ),
    (
        3,
        '../images/piso3.png',
        TRUE,
        1
    ),
    (
        3,
        '../images/piso3.1.png',
        FALSE,
        2
    ),
    (
        4,
        '../images/piso4.png',
        TRUE,
        1
    ),
    (
        4,
        '../images/piso4.1.png',
        FALSE,
        2
    ),
    (
        5,
        '../images/piso5.png',
        TRUE,
        1
    ),
    (
        5,
        '../images/piso5.1.png',
        FALSE,
        2
    ),
    (
        6,
        '../images/piso6ç.png',
        TRUE,
        1
    ),
    (
        6,
        '../images/piso6.1.png',
        FALSE,
        2
    ),
    (
        7,
        '../images/piso7.png',
        TRUE,
        1
    ),
    (
        7,
        '../images/piso7.1.png',
        FALSE,
        2
    ),
    (
        8,
        '../images/piso8.png',
        TRUE,
        1
    ),
    (
        8,
        '../images/piso8.1.png',
        FALSE,
        2
    ),
    (
        9,
        '../images/piso9.png',
        TRUE,
        1
    ),
    (
        9,
        '../images/piso9.1.png',
        FALSE,
        2
    );

-- Asignar servicios a propiedades
INSERT INTO
    servicios_propiedad (propiedad_id, servicio_id)
VALUES
    -- Propiedad 1
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 10),
    -- Propiedad 2
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (2, 9),
    (2, 10),
    (2, 12),
    -- Propiedad 3
    (3, 1),
    (3, 2),
    (3, 4),
    (3, 5),
    (3, 8),
    -- Propiedad 4
    (4, 1),
    (4, 3),
    (4, 4),
    (4, 5),
    (4, 11),
    -- Propiedad 5
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (5, 5),
    (5, 6),
    (5, 7),
    (5, 9),
    (5, 13),
    (5, 14),
    -- Propiedad 6
    (6, 1),
    (6, 2),
    (6, 4),
    (6, 8),
    -- Propiedad 7
    (7, 1),
    (7, 2),
    (7, 3),
    (7, 4),
    (7, 5),
    (7, 9),
    (7, 10),
    -- Propiedad 8
    (8, 1),
    (8, 2),
    (8, 4),
    (8, 5),
    (8, 8),
    (8, 10),
    -- Propiedad 9
    (9, 1),
    (9, 2),
    (9, 3),
    (9, 4),
    (9, 5),
    (9, 6),
    (9, 7),
    (9, 9),
    (9, 13),
    (9, 14),
    (9, 15),
    (9, 16);

-- Insertar reservas de ejemplo
INSERT INTO
    reservas (
        propiedad_id,
        usuario_id,
        fecha_entrada,
        fecha_salida,
        precio_total,
        estado
    )
VALUES (
        1,
        1,
        '2026-02-02',
        '2026-02-05',
        2550.00,
        'CONFIRMADA'
    ),
    (
        1,
        2,
        '2026-02-10',
        '2026-02-15',
        4250.00,
        'CONFIRMADA'
    ),
    (
        2,
        3,
        '2026-02-15',
        '2026-02-20',
        6000.00,
        'PENDIENTE'
    ),
    (
        3,
        1,
        '2026-03-01',
        '2026-03-10',
        6300.00,
        'CONFIRMADA'
    ),
    (
        5,
        4,
        '2026-03-15',
        '2026-03-20',
        7500.00,
        'CONFIRMADA'
    );

-- Insertar pagos de ejemplo
INSERT INTO
    pagos (
        reserva_id,
        monto,
        metodo_pago,
        estado_pago,
        transaccion_id,
        fecha_pago
    )
VALUES (
        1,
        2550.00,
        'TARJETA_CREDITO',
        'COMPLETADO',
        'TXN001234567',
        '2026-01-20 10:30:00'
    ),
    (
        2,
        4250.00,
        'paypal',
        'COMPLETADO',
        'TXN001234568',
        '2026-01-22 14:15:00'
    ),
    (
        4,
        6300.00,
        'TARJETA_CREDITO',
        'COMPLETADO',
        'TXN001234569',
        '2026-01-25 09:45:00'
    ),
    (
        5,
        7500.00,
        'TARJETA_DEBITO',
        'COMPLETADO',
        'TXN001234570',
        '2026-01-26 16:20:00'
    );

-- Insertar reseñas de ejemplo
INSERT INTO
    resenas (
        propiedad_id,
        usuario_id,
        reserva_id,
        calificacion,
        titulo,
        comentario,
        esta_verificado
    )
VALUES (
        1,
        1,
        1,
        5,
        'Excelente piso',
        'Todo perfecto, muy limpio y bien ubicado. El propietario muy atento.',
        TRUE
    ),
    (
        1,
        2,
        2,
        4,
        'Muy buena ubicación',
        'El piso está muy bien, solo le falta un poco más de luz natural.',
        TRUE
    ),
    (
        3,
        1,
        4,
        5,
        'Perfecto para una persona',
        'Estudio muy acogedor y con todo lo necesario. Lo recomiendo.',
        TRUE
    );

-- Insertar favoritos de ejemplo
INSERT INTO
    favoritos (usuario_id, propiedad_id)
VALUES (1, 2),
    (1, 5),
    (2, 3),
    (3, 1),
    (3, 9),
    (4, 5);

-- Insertar mensajes de ejemplo
INSERT INTO
    mensajes (
        emisor_id,
        tipo_emisor,
        receptor_id,
        tipo_receptor,
        propiedad_id,
        asunto,
        mensaje
    )
VALUES (
        1,
        'USUARIO',
        1,
        'PROPIETARIO',
        1,
        'Consulta sobre disponibilidad',
        '¿Está disponible para el mes de abril?'
    ),
    (
        1,
        'PROPIETARIO',
        1,
        'USUARIO',
        1,
        'Re: Consulta sobre disponibilidad',
        'Sí, está disponible. ¿Qué fechas necesitas?'
    ),
    (
        2,
        'USUARIO',
        2,
        'PROPIETARIO',
        4,
        'Pregunta sobre mascotas',
        '¿Se permiten mascotas en el piso?'
    );

-- Actualizar contador de visitas
UPDATE propiedades SET contador_visitas = 45 WHERE id = 1;

UPDATE propiedades SET contador_visitas = 32 WHERE id = 2;

UPDATE propiedades SET contador_visitas = 28 WHERE id = 3;

UPDATE propiedades SET contador_visitas = 51 WHERE id = 4;

UPDATE propiedades SET contador_visitas = 67 WHERE id = 5;

UPDATE propiedades SET contador_visitas = 19 WHERE id = 6;

UPDATE propiedades SET contador_visitas = 38 WHERE id = 7;

UPDATE propiedades SET contador_visitas = 42 WHERE id = 8;

UPDATE propiedades SET contador_visitas = 89 WHERE id = 9;