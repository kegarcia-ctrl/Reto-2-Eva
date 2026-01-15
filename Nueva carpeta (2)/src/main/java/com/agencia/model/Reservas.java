package com.agencia.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.io.Serializable;

@Entity
@Table(name = "reservas")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservas implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El código de reserva es obligatorio")
    @Size(max = 20)
    @Column(name = "codigo_reserva", length = 20, unique = true, nullable = false)
    private String codigoReserva;

    @NotNull(message = "La fecha de entrada es obligatoria")
    @FutureOrPresent(message = "La fecha de entrada no puede ser pasada")
    @Column(name = "fecha_entrada", nullable = false)
    private LocalDate fechaEntrada;

    @NotNull(message = "La fecha de salida es obligatoria")
    @Future(message = "La fecha de salida debe ser en el futuro")
    @Column(name = "fecha_salida", nullable = false)
    private LocalDate fechaSalida;

    @Min(value = 1, message = "Debe haber al menos 1 huésped")
    @Column(name = "numero_huespedes", nullable = false)
    private Integer numeroHuespedes;

    @NotNull(message = "El precio total es obligatorio")
    @Column(name = "precio_total", precision = 10, scale = 2, nullable = false)
    private BigDecimal precioTotal;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('pendiente', 'confirmada', 'cancelada')")
    private EstadoReserva estado = EstadoReserva.pendiente;

    @Column(name = "fecha_creacion", nullable = false, updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(columnDefinition = "TEXT")
    private String notas;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario", nullable = false, foreignKey = @ForeignKey(name = "FK_reservas_usuarios"))
    private Usuarios usuario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_apartamento", nullable = false, foreignKey = @ForeignKey(name = "FK_reservas_apartamentos"))
    private Apartamentos apartamento;

    public enum EstadoReserva {
        pendiente, confirmada, cancelada
    }

    @PrePersist
    protected void onCreate() {
        if (this.fechaCreacion == null) {
            this.fechaCreacion = LocalDateTime.now();
        }
        if (this.estado == null) {
            this.estado = EstadoReserva.pendiente;
        }
    }
}
