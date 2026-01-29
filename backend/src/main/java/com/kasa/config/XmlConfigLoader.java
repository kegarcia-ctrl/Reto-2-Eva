package com.kasa.config;

import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.Unmarshaller;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import java.io.InputStream;

/**
 * XML Configuration Loader
 * Reads database-config.xml and makes it available as a Spring Bean
 */
@Configuration
public class XmlConfigLoader {

    @Bean
    public DatabaseConfig loadDatabaseConfig() {
        try {
            JAXBContext context = JAXBContext.newInstance(DatabaseConfig.class);
            Unmarshaller unmarshaller = context.createUnmarshaller();

            InputStream inputStream = new ClassPathResource("database-config.xml").getInputStream();
            DatabaseConfig config = (DatabaseConfig) unmarshaller.unmarshal(inputStream);

            System.out.println("✓ XML Configuration loaded successfully");
            System.out.println("  Database URL: " + config.getConnection().getUrl());

            return config;
        } catch (Exception e) {
            System.err.println("Error loading XML configuration: " + e.getMessage());
            return null;
        }
    }
}
