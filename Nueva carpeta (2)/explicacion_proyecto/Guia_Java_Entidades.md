# Guía Detallada: El Código Java (Entidades JPA)

Esta es la parte más técnica del proyecto. Aquí es donde los datos se vuelven "vivos" y se preparan para ser procesados. He usado un patrón llamado **JPA (Java Persistence API)**.

## 1. ¿Cómo funciona la "Traducción"? (ORM)

ORM significa _Object-Relational Mapping_.

- En la base de datos tienes una fila con `id=5` y `nombre='Juan'`.
- En Java, gracias a JPA, tienes un objeto `Usuario` con `id=5` y `nombre='Juan'`.
- No tienes que escribir código para buscar a Juan; Java y Hibernate lo hacen por ti.

## 2. Anatomía de una Clase Entidad (Ejemplo: `Apartamentos.java`)

### Las Etiquetas (`Annotations`)

- `@Entity` y `@Table`: Le dicen a Java: "Esta clase es un espejo de la tabla 'apartamentos' en MySQL".
- `@Id` y `@GeneratedValue`: Definen que ese campo es el número único y que sube solo.
- `@Column`: Para decirle a Java que un campo se llama distinto en la base de datos (por ejemplo, `fechaCreacion` en Java vs `fecha_creacion` en SQL).

### Validaciones de Seguridad (Bean Validation)

He añadido etiquetas para evitar que entren datos "basura":

- `@NotBlank`: El título no puede ser espacios en blanco.
- `@Min(1)`: No puedes tener una casa con 0 habitaciones.
- `@DecimalMin("0.0")`: El precio no puede ser negativo.
  Esto es vital: si alguien intenta guardar una casa gratis desde la web, Java detendrá el proceso y dará un error antes de que llegue a la base de datos.

## 3. Relaciones Complejas: El Mundo Real en Java

### `@OneToMany` (Uno a Muchos)

Un apartamento tiene **muchas** fotos.

- En `Apartamentos.java` hay una lista (`List<FotosApartamento>`).
- He añadido métodos como `addFoto()` que aseguran que la foto sepa a qué apartamento pertenece. Esto se llama **bidireccionalidad**.

### `@ManyToMany` (Muchos a Muchos)

Un apartamento tiene muchos servicios (WiFi, TV) y el servicio WiFi puede estar en muchos apartamentos.

- Esto se maneja con una tabla intermedia. He creado un sistema para que puedas añadir servicios a una casa sin romper nada.

## 4. El Toque Mágico de Lombok

¿Te has fijado que las clases no tienen los típicos bloques de `public String getNombre()`?

- Uso `@Data`. Lombok genera esos métodos en el aire cuando compilas.
- Esto hace que el código sea 80% más corto y mucho más fácil de leer para un programador humano.
