package com.kasa.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Booking Entity - Represents property reservations
 */
@Entity
@Table(name = "reservas")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonProperty("propiedadId")
    @Column(name = "propiedad_id", nullable = false)
    private Long propertyId;

    @JsonProperty("usuarioId")
    @Column(name = "usuario_id", nullable = false)
    private Long userId;

    @JsonProperty("fechaEntrada")
    @Column(name = "fecha_entrada", nullable = false)
    private LocalDate checkIn;

    @JsonProperty("fechaSalida")
    @Column(name = "fecha_salida", nullable = false)
    private LocalDate checkOut;

    @JsonProperty("precioTotal")
    @Column(name = "precio_total", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalPrice;

    @Enumerated(EnumType.STRING)
    @JsonProperty("estado")
    @Column(name = "estado", length = 20)
    private BookingStatus status = BookingStatus.PENDIENTE;

    @JsonProperty("fechaCreacion")
    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime createdAt;

    @JsonProperty("fechaActualizacion")
    @Column(name = "fecha_actualizacion")
    private LocalDateTime updatedAt;

    @JsonProperty("motivoCancelacion")
    @Column(name = "motivo_cancelacion", columnDefinition = "TEXT")
    private String cancellationReason;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum BookingStatus {
        PENDIENTE, CONFIRMADA, CANCELADA, COMPLETADA
    }
}
