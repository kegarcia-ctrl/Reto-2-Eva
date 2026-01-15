# Guía Detallada: database.sql - El Corazón de los Datos

Este archivo es el manual de instrucciones para MySQL. Define cómo se estructura la memoria a largo plazo de tu sistema.

## 1. Tablas y su Función Social

### Tabla `usuarios`

No solo guarda nombres. Define roles.

- El campo `rol` es de tipo `ENUM`. Esto impide errores: o eres 'admin' o eres 'cliente', no puedes ser nada inventado.
- El `dni_nie` tiene una restricción `UNIQUE`, lo que significa que el sistema jamás permitirá que dos personas tengan el mismo documento.

### Tabla `apartamentos`

Es la tabla más rica en datos.

- `precio_base_noche`: Usa `DECIMAL(10,2)` porque el dinero nunca debe ser `float` (para evitar errores de céntimos).
- `estado`: Otro `ENUM` para saber si la casa se puede alquilar hoy mismo.

### Tabla `reservas`

Esta tabla es un "nexo". No existe por sí sola, necesita datos de otras.

- `total_precio`: Aquí guardamos cuánto pagó el cliente finalmente por si el precio base cambia en el futuro.
- **Relación con el Calendario**: Los datos que ves en el calendario de `web.html` (días ocupados) vendrían directamente de esta tabla en un sistema real. Cada fila de esta tabla "bloquearía" una fecha en la web.

## 2. Las "Cuerdas" (Relaciones)

El SQL usa `FOREIGN KEY` (Claves Foráneas). Es como una cuerda que ata dos tablas:

- La tabla `fotos_apartamento` tiene una cuerda llamada `id_apartamento` que la ata a la tabla de apartamentos. Si borras un apartamento con el comando adecuado, sus fotos caerán con él (esto se llama `ON DELETE CASCADE`, aunque aquí lo manejaremos desde Java para mayor control).
- La tabla `apartamento_servicios` es una tabla de "muchos a muchos". Sirve para decir: "Este apartamento tiene WiFi, Piscina y Garaje". Es la forma más limpia de organizar extras.

## 3. Seguridad e Integridad

- **NOT NULL**: Muchos campos tienen esta marca; significa que Java te dará un error si intentas guardar algo vacío. Por ejemplo, una casa no puede no tener precio.
- **DEFAULT**: Algunos campos tienen valores automáticos. Por ejemplo, la `fecha_creacion` se pone sola con el momento exacto en que registras la casa.
- **Autoincremento**: El `id` de cada tabla sube solo (1, 2, 3...). Nosotros no tenemos que preocuparnos de elegir un número para cada nueva entrada.
