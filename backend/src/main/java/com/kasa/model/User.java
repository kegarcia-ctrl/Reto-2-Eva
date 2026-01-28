package com.kasa.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * User Entity - Represents clients who rent properties
 */
@Entity
@Table(name = "usuarios")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonProperty("nombre")
    @Column(name = "nombre", nullable = false, length = 100)
    private String name;

    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @JsonProperty("contrasena")
    @Column(name = "contrasena", nullable = false)
    private String password;

    @JsonProperty("telefono")
    @Column(name = "telefono", length = 20)
    private String phone;

    @JsonProperty("fechaCreacion")
    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime createdAt;

    @JsonProperty("ultimoAcceso")
    @Column(name = "ultimo_acceso")
    private LocalDateTime lastLogin;

    @JsonProperty("estaActivo")
    @Column(name = "esta_activo")
    private Boolean isActive = true;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
