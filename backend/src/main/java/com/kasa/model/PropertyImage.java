package com.kasa.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "imagenes_propiedad")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PropertyImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "propiedad_id", nullable = false)
    @JsonIgnore
    private Property property;

    @JsonProperty("urlImagen")
    @Column(name = "url_imagen", nullable = false, length = 500)
    private String imageUrl;

    @JsonProperty("esPrincipal")
    @Column(name = "es_principal")
    private Boolean isPrincipal = false;

    @JsonProperty("ordenVisualizacion")
    @Column(name = "orden_visualizacion")
    private Integer displayOrder = 0;

    @JsonProperty("fechaSubida")
    @Column(name = "fecha_subida", updatable = false)
    private LocalDateTime uploadedAt;

    @PrePersist
    protected void onCreate() {
        uploadedAt = LocalDateTime.now();
    }
}
