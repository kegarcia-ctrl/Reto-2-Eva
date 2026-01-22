package com.agencia.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "servicios")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Servicios {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El nombre del servicio es obligatorio")
    @Column(nullable = false, unique = true)
    private String nombre;

    @Column(name = "icono_css")
    private String iconoCss;

    @ManyToMany(mappedBy = "servicios")
    private Set<Apartamentos> apartamentos = new HashSet<>();

    public Servicios(String nombre, String iconoCss) {
        this.nombre = nombre;
        this.iconoCss = iconoCss;
    }
}
