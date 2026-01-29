package com.kasa.config;

import jakarta.xml.bind.annotation.*;
import lombok.Data;

/**
 * XML Configuration Reader for database-config.xml
 * Uses JAXB to parse XML configuration
 */
@XmlRootElement(name = "database-config")
@XmlAccessorType(XmlAccessType.FIELD)
@Data
public class DatabaseConfig {

    @XmlElement(name = "connection")
    private Connection connection;

    @XmlElement(name = "pool")
    private Pool pool;

    @XmlElement(name = "jpa")
    private Jpa jpa;

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class Connection {
        @XmlElement
        private String url;

        @XmlElement
        private String username;

        @XmlElement
        private String password;

        @XmlElement
        private String driver;
    }

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class Pool {
        @XmlElement
        private Integer maxConnections;

        @XmlElement
        private Integer minConnections;
    }

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class Jpa {
        @XmlElement
        private Boolean showSql;

        @XmlElement
        private String ddlAuto;

        @XmlElement
        private String dialect;
    }
}
