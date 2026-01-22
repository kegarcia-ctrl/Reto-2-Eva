# Guía Detallada: pom.xml - La Configuración Maestra

El archivo `pom.xml` es la receta de cocina del proyecto. Maven lo usa para descargar y configurar todo lo necesario.

## 1. El ADN del Proyecto

- **groupId**: `com.agencia` (la "familia" del código).
- **artifactId**: `agencia-alquiler` (el nombre del "hijo").
- **version**: `1.0-SNAPSHOT` (estamos en la primera versión de desarrollo).

## 2. Las "Piezas" del Puzzle (Dependencies)

### Hibernate Core: El Traductor

Es la pieza más pesada e importante. Es el software que traduce tus objetos Java a comandos SQL complicados. Tú solo dices `save(piso)` y Hibernate escribe el `INSERT INTO...`.

### JPA API: El Estándar

Es como el "enchufe universal". Usamos JPA para que, si el día de mañana quieres cambiar Hibernate por otra herramienta, no tengas que cambiar todo tu código.

### Lombok: El Escritor Automático

Como te conté, es el que escribe el código aburrido por nosotros. Es una herramienta de "tiempo de compilación".

### Bean Validation / Hibernate Validator

Son las herramientas que leen etiquetas como `@Email` o `@Min`. Sin ellas, esas etiquetas serían simples comentarios que no harían nada.

### MySQL Connector: El Puente

Java no sabe hablar con MySQL por defecto. Necesita este "driver" o controlador para poder enviar los datos a través de la red.

## 3. ¿Por qué usamos Maven?

Imagina que cada una de estas herramientas tiene a su vez otras herramientas que necesita. Maven se encarga de:

1. Descargarlas de internet automáticamente.
2. Asegurar que las versiones sean compatibles entre sí.
3. Organizar cómo se construye el archivo final del programa.
