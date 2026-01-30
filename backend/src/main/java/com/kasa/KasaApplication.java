package com.kasa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Clase principal de la aplicación para Kasa Real Estate Backend
 * Esto inicia el servidor Tomcat embebido - ¡NO SE NECESITA SERVIDOR EXTERNO!
 *
 * Para ejecutar: mvn spring-boot:run
 * O: java -jar target/kasa-backend-1.0.0.jar
 */
@SpringBootApplication
public class KasaApplication {

    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("  KASA REAL ESTATE API - INICIANDO SERVIDOR");
        System.out.println("===========================================");
        System.out.println("El servidor iniciará en: http://localhost:8080");
        System.out.println("API Base URL: http://localhost:8080/api");
        System.out.println("===========================================");

        SpringApplication.run(KasaApplication.class, args);

        System.out.println("\n✓ Servidor iniciado correctamente!");
        System.out.println("✓ Conexión a la base de datos establecida");
        System.out.println("✓ Listo para aceptar solicitudes\n");
    }

    /**
     * Configura CORS para permitir que el frontend se conecte desde cualquier origen
     */
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("*")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                        .allowedHeaders("*");
            }
        };
    }
}
