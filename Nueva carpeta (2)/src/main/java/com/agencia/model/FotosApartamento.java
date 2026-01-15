package com.agencia.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "fotos_apartamento")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FotosApartamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "La URL de la foto es obligatoria")
    @Column(name = "url_foto", nullable = false)
    private String urlFoto;

    @Column(name = "orden")
    private int orden;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_apartamento", nullable = false)
    private Apartamentos apartamento;

    public FotosApartamento(String urlFoto, int orden) {
        this.urlFoto = urlFoto;
        this.orden = orden;
    }
}
