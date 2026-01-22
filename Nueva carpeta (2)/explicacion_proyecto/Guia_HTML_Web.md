# Guía Detallada: web.html - El Escaparate Digital

Este archivo no es solo una página, es una aplicación completa en el lado del cliente. Combina estructura (HTML) y lógica de interacción (JavaScript).

## 1. Estructura de Bloques (Cuerpo de la Web)

### El Contenedor Maestro (`.layout-grid`)

Todo el contenido vive dentro de un "div" con la clase `layout-grid`. Esto le dice al navegador que use un sistema de rejilla para organizar el espacio.

- **Header**: Ocupa toda la parte superior. Aquí hemos implementado menús desplegables (`dropdown`) para que la navegación sea limpia pero funcional.
- **Aside (Barra de Filtros)**: Situada a la izquierda. Su función es filtrar, no solo mostrar. He usado etiquetas `<select>` e `<input>` para que el usuario pueda filtrar por **Ciudad**, **Zona**, **Precio Máximo** y **Tipo de Propiedad**.
- **Main (Galería)**: Es el área central dinámica. Con el catálogo ampliado a **20 casas**, usa una rejilla de **"Gran Formato"** (mínimo 450px) para que las fotos sean las protagonistas absolutas, obligando a un scroll vertical más visual y relajado.

## 2. Las Tarjetas de Propiedad (`.property-card`)

Son piezas de ingeniería en miniatura. Cada una contiene:

- **Metadatos (`data-attributes`)**: Atributos como `data-precio`, `data-ciudad`, `data-zona` y el nuevo `data-booked`. Esto es **fundamental**; son etiquetas invisibles que el código lee para filtrar o para saber qué días están ocupados en el calendario.
- **El Marco de Fotos (`.marco-fotos`)**: Un contenedor que alberga la galería infinita en formato panorámico (16/9).
- **Botones de Navegación**: Flechas que usan `moverGaleria(event, this, 1)`. Fíjate en el `event`; lo pasamos para usar `event.stopPropagation()`, lo que impide que la web crea que has clicado en la casa entera cuando solo querías pasar una foto.

## 3. El Motor JavaScript: La Inteligencia de la Página

### Filtrado Dinámico (`applyFilters()`)

Esta función se activa cada vez que cambias un filtro.

1. Recoge los valores que has elegido (Ciudad, Zona, Precio, Tipo).
2. "Bucea" por todas las tarjetas de la página.
3. Compara las etiquetas `data-` de la tarjeta con lo que tú has pedido.
4. Si coincide (por ejemplo, es de "Donosti" y cuesta menos de "900€"), le dice a CSS `display: flex`. Si no, `display: none`.

### El Sistema de Modal y Reservas (`openModal()`)

Cuando tocas una casa o el botón **Reservar**, ocurre lo siguiente:

1. El código "lee" la información de esa tarjeta específica (incluyendo la ciudad y los días ocupados).
2. "Inyecta" los datos en la ventana Modal y los personaliza (ej: "Espectacular piso en Madrid...").
3. **Calendario Interactivo**: Al pulsar "Ver Disponibilidad", se activa una función que dibuja un calendario del mes.
4. **Lógica de Bloqueo**: El sistema cruza los datos de `data-booked` con el calendario y deshabilita los días ocupados, impidiendo que el usuario los seleccione.
5. **Clonación de Imágenes**: Copia las fotos de la tarjeta y las pega en el Modal.

### Control de Teclado y Clic

He añadido "oyentes" (`EventListeners`).

- **Navegación Intuitiva**: Puedes usar las flechas del teclado para pasar las fotos del modal o la tecla `Esc` para cerrar, como en las aplicaciones más profesionales.
- **Selección de Fecha**: Al hacer clic en un día libre, se marca visualmente, permitiendo al usuario "preparar" su reserva antes de contactar.
