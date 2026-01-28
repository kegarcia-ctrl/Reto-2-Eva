package com.kasa.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "servicios")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PropertyServiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String nombre;

    @Column(length = 50)
    private String icono;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private ServiceCategory categoria = ServiceCategory.BASICO;

    public enum ServiceCategory {
        BASICO, CONFORT, SEGURIDAD, ENTRETENIMIENTO
    }
}
