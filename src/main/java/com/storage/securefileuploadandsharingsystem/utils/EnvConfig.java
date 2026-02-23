package com.storage.securefileuploadandsharingsystem.utils;

import io.github.cdimascio.dotenv.Dotenv;

import java.io.InputStream;
import java.util.Properties;

/**
 * Loads configuration from .env file, classpath db.properties, or system environment variables.
 */
public class EnvConfig {

    private static Dotenv dotenv;
    private static Properties fallbackProps;

    static {
        // 1. Try loading .env via dotenv-java
        try {
            dotenv = Dotenv.configure()
                    .ignoreIfMissing()
                    .load();
        } catch (Exception e) {
            System.err.println("EnvConfig: dotenv load skipped: " + e.getMessage());
            dotenv = null;
        }

        // 2. Load db.properties from classpath as fallback
        fallbackProps = new Properties();
        try (InputStream is = EnvConfig.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is != null) {
                fallbackProps.load(is);
                System.out.println("EnvConfig: Loaded db.properties from classpath");
            }
        } catch (Exception e) {
            System.err.println("EnvConfig: Could not load db.properties: " + e.getMessage());
        }
    }

    /**
     * Gets a configuration value by key.
     * Priority: .env file → db.properties → system environment variables.
     */
    public static String get(String key) {
        // 1. Check dotenv
        if (dotenv != null) {
            try {
                String value = dotenv.get(key);
                if (value != null && !value.isEmpty()) return value;
            } catch (Exception ignored) {}
        }

        // 2. Check db.properties
        String prop = fallbackProps.getProperty(key);
        if (prop != null && !prop.isEmpty()) return prop;

        // 3. Fallback to system environment variable
        return System.getenv(key);
    }
}
