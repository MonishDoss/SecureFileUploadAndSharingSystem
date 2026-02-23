package com.storage.securefileuploadandsharingsystem.utils;

import at.favre.lib.crypto.bcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt.
 */
public class PasswordUtil {

    private static final int BCRYPT_COST = 12;

    /**
     * Hashes a plaintext password using BCrypt.
     * @param plainPassword the plaintext password
     * @return the BCrypt hash string
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.withDefaults().hashToString(BCRYPT_COST, plainPassword.toCharArray());
    }

    /**
     * Verifies a plaintext password against a BCrypt hash.
     * @param plainPassword the plaintext password to check
     * @param hashedPassword the stored BCrypt hash
     * @return true if the password matches the hash
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        BCrypt.Result result = BCrypt.verifyer().verify(plainPassword.toCharArray(), hashedPassword);
        return result.verified;
    }
}
