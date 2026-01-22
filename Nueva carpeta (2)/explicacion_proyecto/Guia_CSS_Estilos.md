# Guía Detallada: estiloweb.css - El Diseño y la Experiencia

El CSS es lo que convierte un documento aburrido en una experiencia "Premium". Aquí te explico las técnicas que he usado.

## 1. El Sistema de Diseño (Tokens)

He definido reglas generales para que todo sea coherente:

- **Tipografía**: Uso 'Segoe UI', que es la fuente por defecto de Windows y se ve muy nítida en pantallas.
- **Colores**: He elegido el `#1a8997` (un tono petróleo/aguamarina) para los precios y botones importantes. Es un color que transmite confianza y modernidad.
- **Sombras (`box-shadow`)**: Las tarjetas no son planas. Tienen una sombra sutil que se acentúa al pasar el ratón (`:hover`), dando una sensación de profundidad.

## 2. Técnicas de Layout Avanzadas

### Grid Layout: El Formato "Gigante"

Para dar protagonismo a las casas, hemos configurado:
`grid-template-columns: repeat(auto-fill, minmax(450px, 1fr))`

- **Impacto Visual**: Al subir de 200px a **450px**, reducimos el número de casas por fila (normalmente a 1 o 2). Esto hace que las fotos sean enormes y se vean con total claridad.
- **Espaciado Premium**: El `gap: 60px` y `padding: 50px` enmarcan cada casa como si fuera una obra de arte, eliminando la sensación de "revoltijo" y obligando al usuario a hacer scroll para descubrir el catálogo.

### Aspect Ratio: Cine en tu Pantalla

He fijado en las fotos un `aspect-ratio: 16 / 9`.

- Esto garantiza que todas las fotos de todas las casas tengan exactamente la misma proporción rectangular, dándole una armonía visual perfecta a toda la galería.

## 3. Efectos Visuales y UI "Glassmorphism"

### El Modal y el Blur

Para el fondo del Modal he usado `backdrop-filter: blur(5px)`.

- Esto no solo pone un fondo oscuro, sino que **desenfoca** lo que hay detrás.
- Da un efecto de "cristal" muy actual que hace que el usuario se centre al 100% en la propiedad que está viendo.

### Botones de Acción (`Reservar`)

He diseñado un contenedor de botones (`.modal-btn-container`) que usa **Flexbox** para equilibrar los botones de "Ver Disponibilidad" y el de "Reservar".

- Al usar `flex: 1`, ambos botones miden lo mismo, creando una simetría muy agradable a la vista.

### El Calendario de Disponibilidad

El calendario no es una imagen, es una **cuadrícula CSS** viva:

- **Estados Visuales**: Uso clases como `.ocupado` (con `text-decoration: line-through`) y `.seleccionado` (con fondo turquesa) para dar feedback instantáneo.
- **Micro-animaciones**: El calendario aparece con un efecto de `slideDown`, deslizándose suavemente desde arriba para no asustar al usuario.

## 4. Animaciones

He añadido `@keyframes zoomIn` al Modal.

- Cuando se abre, no aparece de golpe; hace un pequeño efecto de "crecimiento" desde el 90% hasta su tamaño real.
- Estos detalles son los que hacen que una web se sienta "Premium" y no una simple plantilla.
