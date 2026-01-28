package com.kasa.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;
import java.util.ArrayList;

/**
 * Property Entity - Represents rental properties/listings
 */
@Entity
@Table(name = "propiedades")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Property {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonProperty("propietarioId")
    @Column(name = "propietario_id", nullable = false)
    private Long ownerId;

    @JsonProperty("titulo")
    @Column(name = "titulo", nullable = false, length = 200)
    private String title;

    @JsonProperty("descripcion")
    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String description;

    @ManyToOne
    @JoinColumn(name = "tipo_propiedad_id", insertable = false, updatable = false)
    private PropertyType type;

    @JsonProperty("tipoPropiedadId")
    @Column(name = "tipo_propiedad_id", nullable = false)
    private Long propertyTypeId;

    @ManyToOne
    @JoinColumn(name = "ciudad_id", insertable = false, updatable = false)
    private City city;

    @JsonProperty("ciudadId")
    @Column(name = "ciudad_id", nullable = false)
    private Long cityId;

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonProperty("imagenes")
    private List<PropertyImage> images = new ArrayList<>();

    @JsonProperty("zona")
    @Column(name = "zona", length = 100)
    private String zone;

    @JsonProperty("direccion")
    @Column(name = "direccion", length = 255)
    private String address;

    @JsonProperty("precio")
    @Column(name = "precio", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @JsonProperty("habitaciones")
    @Column(name = "habitaciones")
    private Integer bedrooms = 0;

    @JsonProperty("banos")
    @Column(name = "banos")
    private Integer bathrooms = 0;

    @JsonProperty("areaM2")
    @Column(name = "area_m2", precision = 8, scale = 2)
    private BigDecimal areaSqm;

    @JsonProperty("numeroPlanta")
    @Column(name = "numero_planta")
    private Integer floorNumber;

    @JsonProperty("tieneAscensor")
    @Column(name = "tiene_ascensor")
    private Boolean hasElevator = false;

    @JsonProperty("tieneParking")
    @Column(name = "tiene_parking")
    private Boolean hasParking = false;

    @JsonProperty("tieneJardin")
    @Column(name = "tiene_jardin")
    private Boolean hasGarden = false;

    @JsonProperty("tienePiscina")
    @Column(name = "tiene_piscina")
    private Boolean hasPool = false;

    @JsonProperty("estaAmueblado")
    @Column(name = "esta_amueblado")
    private Boolean isFurnished = false;

    @Enumerated(EnumType.STRING)
    @JsonProperty("estado")
    @Column(name = "estado", length = 20)
    private PropertyStatus status = PropertyStatus.DISPONIBLE;

    @JsonProperty("fechaCreacion")
    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime createdAt;

    @JsonProperty("fechaActualizacion")
    @Column(name = "fecha_actualizacion")
    private LocalDateTime updatedAt;

    @JsonProperty("contadorVisitas")
    @Column(name = "contador_visitas")
    private Integer viewsCount = 0;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum PropertyStatus {
        DISPONIBLE, ALQUILADO, MANTENIMIENTO, INACTIVO
    }
}
