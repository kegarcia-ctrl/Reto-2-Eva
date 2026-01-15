package com.agencia.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Table(name = "valoraciones")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Valoraciones {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "La valoración debe estar asociada a una reserva")
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_reserva", nullable = false, unique = true, foreignKey = @ForeignKey(name = "fk_valoraciones_reservas"))
    private Reservas reserva;

    @Min(1)
    @Max(5)
    @Column(name = "puntuacion_limpieza")
    private Integer puntuacionLimpieza;

    @Min(1)
    @Max(5)
    @Column(name = "puntuacion_ubicacion")
    private Integer puntuacionUbicacion;

    @Min(1)
    @Max(5)
    @Column(name = "puntuacion_calidad")
    private Integer puntuacionCalidad;

    @Column(name = "comentario", columnDefinition = "TEXT")
    private String comentario;

    @Column(name = "fecha", nullable = false, updatable = false)
    private LocalDateTime fecha;

    @PrePersist
    protected void onCreate() {
        if (this.fecha == null) {
            this.fecha = LocalDateTime.now();
        }
    }
}
