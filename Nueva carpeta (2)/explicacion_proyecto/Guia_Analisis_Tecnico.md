# Análisis Técnico Exhaustivo: Portal Inmobiliario de Alto Nivel

Este documento ofrece un desglose paso a paso de toda la ingeniería detrás del archivo `web.html`, explicando no solo el _qué_, sino el _porqué_ de cada decisión técnica.

---

## FASE 1: El Esqueleto Estructural (HTML5 & Semántica)

### 1.1 El Contenedor de Rejilla (`.layout-grid`)

Todo el sitio está envuelto en un sistema de **CSS Grid**.

- **Por qué**: Permite definir áreas fijas (Header, Sidebar, Main) que se mantienen estables mientras el contenido interno cambia. Es la base de una aplicación robusta.

### 1.2 El Menú de Navegación Inteligente (`<header>`)

No es una simple barra. Contiene:

- **Logo Dinámico**: Enmarcado en `logo-box` para asegurar que mantenga su proporción.
- **Micro-interactividad (Dropdowns)**: El selector de idiomas ("ES") y el acceso a "Cuenta" usan clases de CSS que ocultan el contenido hasta que se hace hover. Esto ahorra espacio visual y mejora la "limpieza" del diseño.

### 1.3 El Panel de Filtrado Progresivo (`<aside>`)

Hemos implementado una barra lateral que funciona como un ordenador:

- **Selectores de Datos**: Ciudad, Zona y Tipo.
- **Input de Precio**: Un campo numérico que dispara la lógica de filtrado al instante (`oninput`).
- **Botón de Limpieza**: Esencial para la experiencia de usuario (UX); permite volver al estado inicial sin recargar la página.

---

## FASE 2: Ingeniería de la "Property Card" (La Joya de la Corona)

Cada una de las 20 casas es un objeto independiente cargado de datos:

### 2.1 Los Atributos de Datos (`data-attributes`)

Este es el concepto más avanzado del HTML. Cada tarjeta lleva "etiquetas invisibles":

- `data-ciudad`, `data-precio`, `data-zona`, `data-tipo`.
- **Nuevo: `data-booked`**: Contiene una lista de números (ej: "5,6,12") que representan los días ocupados.
- **Beneficio**: El navegador no necesita preguntar al servidor cada vez que filtras; ya tiene toda la información "en la mochila" de cada casa.

### 2.2 Galería de Fotos Infinita

Dentro de cada tarjeta hay un mini-sistema de navegación:

- **Botones Invisibles**: Solo aparecen al pasar el ratón.
- **Scroll Suave**: Al pulsar, la galería se desliza horizontalmente con efecto `smooth`, dando una sensación táctil de alta calidad.

---

## FASE 3: El Motor de Inteligencia (JavaScript & Lógica)

El código JS al final del archivo hace que la web "piense".

### 3.1 El Algoritmo de Filtrado (`applyFilters`)

Es un proceso de 4 pasos:

1. **Captura**: Lee lo que el usuario ha puesto en los selectores.
2. **Barrido**: Recorre las 20 tarjetas una a una.
3. **Validación**: Compara "Lo que el usuario quiere" vs "Lo que la casa ofrece".
4. **Respuesta**: Si pasa el filtro, la casa se muestra (`flex`). Si no, se desvanece (`none`).

### 3.2 Lógica del Modal Detallado (`openModal`)

Al hacer clic en una casa, el JS:

- **Copia el ADN**: Extrae el título, precio y fotos de la tarjeta pequeña.
- **Redacta Contenido**: Crea automáticamente el texto de descripción basado en la ubicación de la casa.
- **Inyecta en el Modal**: Lo rellena todo y lo muestra con una animación de zoom.

### 3.3 El Sistema de Reservas y Calendario (Interactividad de Nivel Pro)

Es la funcionalidad más compleja del proyecto:

- **Dibujo Dinámico**: El calendario no existe en el HTML; el JS dibuja los días del mes actual calculando qué día de la semana empieza cada mes.
- **Validación de Bloqueo**: Mientras dibuja cada día, comprueba: "¿Está este número en la lista de `data-booked`?". Si es así, tacha el día y **desactiva el botón de clic**.
- **Gestión de Selección**: Permite al usuario marcar sus fechas deseadas visualmente, cambiando el color de fondo del día.

---

## FASE 4: Experiencia de Usuario "Premium" (UX/UI)

### 4.1 Navegación por Teclado

Hemos programado "escuchadores" para que la web responda a las teclas físicas:

- **Flechas**: Para pasar las fotos del modal.
- **Esc**: Para cerrar el detalle rápidamente.
- **Resultado**: La web se siente como una aplicación nativa, no como una página estática.

### 4.2 Feedback Visual Instantáneo

- **Hover de Botones**: Cambian de color suavemente.
- **Sombras Dinámicas**: Las tarjetas "flotan" cuando pasas el ratón por encima.
- **Transiciones**: Nada aparece de golpe; todo tiene pequeñas transiciones de milisegundos que suavizan la experiencia.

---

## CONCLUSIÓN: Un Proyecto Preparado para el Futuro

Este sistema no es solo un ejercicio de diseño. La estructura que hemos creado (separando los datos en `data-attributes` y la lógica en funciones independientes) es exactamente como se construyen las aplicaciones en empresas reales.

**Estado actual**: Una herramienta de ventas inmobiliarias de alta gama, funcional, rápida y estéticamente impecable.
