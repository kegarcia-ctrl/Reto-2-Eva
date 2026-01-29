package com.kasa.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "pagos")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reserva_id", nullable = false)
    private Booking booking;

    @Column(nullable = false)
    private BigDecimal monto;

    @Enumerated(EnumType.STRING)
    @Column(name = "metodo_pago", nullable = false)
    private PaymentMethod metodoPago;

    @Enumerated(EnumType.STRING)
    @Column(name = "estado_pago")
    private PaymentStatus estadoPago = PaymentStatus.PENDIENTE;

    @Column(name = "transaccion_id", unique = true, length = 100)
    private String transaccionId;

    @Column(name = "fecha_pago")
    private LocalDateTime fechaPago;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
    }

    public enum PaymentMethod {
        TARJETA_CREDITO, TARJETA_DEBITO, PAYPAL, TRANSFERENCIA, EFECTIVO
    }

    public enum PaymentStatus {
        PENDIENTE, COMPLETADO, FALLIDO, REEMBOLSADO
    }
}
