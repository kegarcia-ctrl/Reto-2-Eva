package com.agencia.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Entidad que representa a los usuarios del sistema.
 * Utilizamos Lombok para eliminar el código repetitivo (Getters/Setters).
 */
@Entity
@Table(name = "usuarios")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuarios {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El nombre completo es obligatorio")
    @Size(max = 100)
    @Column(name = "nombre_completo", nullable = false)
    private String nombreCompleto;

    @Email(message = "El formato del email no es válido")
    @NotBlank(message = "El email es obligatorio")
    @Column(unique = true, nullable = false)
    private String email;

    @NotBlank(message = "La contraseña es obligatoria")
    @Column(nullable = false)
    private String password;

    private String telefono;

    @Column(name = "dni_nie")
    private String dniNie;

    @Column(name = "foto_perfil")
    private String fotoPerfil;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('admin', 'cliente')")
    private Rol rol;

    @Column(name = "fecha_registro", updatable = false)
    private LocalDateTime fechaRegistro;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY)
    private List<Reservas> reservas;

    public enum Rol {
        admin, cliente
    }

    @PrePersist
    protected void onCreate() {
        this.fechaRegistro = LocalDateTime.now();
        if (this.rol == null)
            this.rol = Rol.cliente;
    }
}
