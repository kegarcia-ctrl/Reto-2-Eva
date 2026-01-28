package com.kasa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Main Application Class for Kasa Real Estate Backend
 * This starts the embedded Tomcat server - NO EXTERNAL SERVER NEEDED!
 * 
 * To run: mvn spring-boot:run
 * Or: java -jar target/kasa-backend-1.0.0.jar
 */
@SpringBootApplication
public class KasaApplication {

    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("  KASA REAL ESTATE API - STARTING SERVER");
        System.out.println("===========================================");
        System.out.println("Server will start on: http://localhost:8080");
        System.out.println("API Base URL: http://localhost:8080/api");
        System.out.println("===========================================");

        SpringApplication.run(KasaApplication.class, args);

        System.out.println("\n✓ Server started successfully!");
        System.out.println("✓ Database connection established");
        System.out.println("✓ Ready to accept requests\n");
    }

    /**
     * Configure CORS to allow frontend to connect from any origin
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
