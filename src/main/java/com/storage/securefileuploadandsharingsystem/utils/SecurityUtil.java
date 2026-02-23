package com.storage.securefileuploadandsharingsystem.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class for security operations: CSRF tokens, XSS sanitization, and IP extraction.
 */
public class SecurityUtil {

    private static final SecureRandom secureRandom = new SecureRandom();
    private static final String CSRF_TOKEN_ATTR = "csrfToken";

    /**
     * Generates a cryptographically secure random token.
     * @return a Base64-encoded random token string
     */
    public static String generateToken() {
        byte[] bytes = new byte[32];
        secureRandom.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    /**
     * Generates and stores a CSRF token in the user's session.
     * @param request the HTTP request
     * @return the generated CSRF token
     */
    public static String generateCSRFToken(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String token = generateToken();
        session.setAttribute(CSRF_TOKEN_ATTR, token);
        return token;
    }

    /**
     * Validates the CSRF token from the request against the one stored in the session.
     * @param request the HTTP request
     * @return true if the token is valid
     */
    public static boolean validateCSRFToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        String requestToken = request.getParameter("_csrf");
        if (requestToken == null) {
            requestToken = request.getHeader("X-CSRF-Token");
        }

        return sessionToken != null && sessionToken.equals(requestToken);
    }

    /**
     * Sanitizes a string to prevent XSS attacks by escaping HTML special characters.
     * @param input the raw input string
     * @return the sanitized string
     */
    public static String sanitizeHtml(String input) {
        if (input == null) return null;
        return input
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }

    /**
     * Extracts the client IP address, accounting for proxy headers.
     * @param request the HTTP request
     * @return the client IP address
     */
    public static String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip != null && !ip.isEmpty() && !"unknown".equalsIgnoreCase(ip)) {
            // X-Forwarded-For can contain multiple IPs; take the first one
            return ip.split(",")[0].trim();
        }
        ip = request.getHeader("X-Real-IP");
        if (ip != null && !ip.isEmpty() && !"unknown".equalsIgnoreCase(ip)) {
            return ip;
        }
        return request.getRemoteAddr();
    }
}
