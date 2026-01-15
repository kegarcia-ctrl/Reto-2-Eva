package com.agencia.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "apartamentos")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Apartamentos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El título es obligatorio")
    @Column(nullable = false)
    private String titulo;

    @Column(name = "descripcion_larga", columnDefinition = "TEXT")
    private String descripcionLarga;

    @Column(name = "direccion_completa")
    private String direccionCompleta;

    @NotBlank(message = "La ciudad es obligatoria")
    private String ciudad;

    private String provincia;

    @Column(name = "zona_turistica")
    private String zonaTuristica;

    @NotNull(message = "El precio es obligatorio")
    @DecimalMin(value = "0.0", inclusive = false)
    @Column(name = "precio_base_noche", precision = 10, scale = 2, nullable = false)
    private BigDecimal precioBaseNoche;

    @Min(value = 1, message = "La capacidad mínima es de 1 persona")
    @Column(name = "capacidad_maxima", nullable = false)
    private int capacidadMaxima;

    private Integer habitaciones;
    private Integer banios;

    @Column(name = "metros_cuadrados")
    private Integer metrosCuadrados;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('disponible', 'mantenimiento', 'oculto')")
    private Estado estado;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @OneToMany(mappedBy = "apartamento", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<FotosApartamento> fotos = new ArrayList<>();

    @ManyToMany
    @JoinTable(name = "apartamento_servicios", joinColumns = @JoinColumn(name = "id_apartamento"), inverseJoinColumns = @JoinColumn(name = "id_servicio"))
    private Set<Servicios> servicios = new HashSet<>();

    public enum Estado {
        disponible, mantenimiento, oculto
    }

    @PrePersist
    protected void onCreate() {
        if (this.estado == null)
            this.estado = Estado.disponible;
        if (this.fechaCreacion == null)
            this.fechaCreacion = LocalDateTime.now();
    }

    // Métodos helper para sincronizar relaciones bidireccionales
    public void addFoto(FotosApartamento foto) {
        fotos.add(foto);
        foto.setApartamento(this);
    }

    public void removeFoto(FotosApartamento foto) {
        fotos.remove(foto);
        foto.setApartamento(null);
    }

    public void addServicio(Servicios servicio) {
        servicios.add(servicio);
        servicio.getApartamentos().add(this);
    }

    public void removeServicio(Servicios servicio) {
        servicios.remove(servicio);
        servicio.getApartamentos().remove(this);
    }
}
