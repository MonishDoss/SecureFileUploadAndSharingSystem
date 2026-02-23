package com.storage.securefileuploadandsharingsystem.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static String url;
    private static String username;
    private static String password;
    private static boolean initialized = false;
    private static String initError = null;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            url = EnvConfig.get("DB_URL");
            username = EnvConfig.get("DB_USERNAME");
            password = EnvConfig.get("DB_PASSWORD");

            if (url == null || url.isEmpty()) {
                initError = "DB_URL is not set. Check your .env file or environment variables.";
                System.err.println("DBConnection ERROR: " + initError);
            } else {
                initialized = true;
                System.out.println("DBConnection initialized with URL: " + url);
            }
        } catch (ClassNotFoundException e) {
            initError = "MySQL JDBC Driver not found: " + e.getMessage();
            System.err.println("DBConnection ERROR: " + initError);
        } catch (Exception e) {
            initError = "Failed to initialize DB connection: " + e.getMessage();
            System.err.println("DBConnection ERROR: " + initError);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (!initialized) {
            throw new SQLException("Database not initialized. " + (initError != null ? initError : "Unknown error."));
        }
        return DriverManager.getConnection(url, username, password);
    }
}
