package com.storage.securefileuploadandsharingsystem.utils;

import java.io.File;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Utility class for file operations: validation, size formatting, extension checks.
 */
public class FileUtil {

    /** Allowed file extensions (lowercase). */
    private static final Set<String> ALLOWED_EXTENSIONS = new HashSet<>(Arrays.asList(
            ".pdf", ".png", ".jpg", ".jpeg", ".gif", ".bmp",
            ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx",
            ".txt", ".csv", ".zip", ".rar", ".7z",
            ".mp3", ".mp4", ".avi", ".mov", ".mkv"
    ));

    /** Allowed MIME types. */
    private static final Set<String> ALLOWED_MIME_TYPES = new HashSet<>(Arrays.asList(
            "application/pdf",
            "image/png", "image/jpeg", "image/gif", "image/bmp",
            "application/msword",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/vnd.ms-excel",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "application/vnd.ms-powerpoint",
            "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            "text/plain", "text/csv",
            "application/zip", "application/x-rar-compressed", "application/x-7z-compressed",
            "audio/mpeg", "video/mp4", "video/x-msvideo", "video/quicktime", "video/x-matroska",
            "application/octet-stream"
    ));

    /** Maximum file size: 50 MB */
    public static final long MAX_FILE_SIZE = 50L * 1024 * 1024;

    /**
     * Formats a byte count into a human-readable size string.
     * @param bytes the size in bytes
     * @return formatted size string (e.g., "1.5 MB")
     */
    public static String formatFileSize(long bytes) {
        if (bytes < 1024) return bytes + " B";
        if (bytes < 1024 * 1024) return String.format("%.1f KB", bytes / 1024.0);
        if (bytes < 1024L * 1024 * 1024) return String.format("%.1f MB", bytes / (1024.0 * 1024));
        return String.format("%.2f GB", bytes / (1024.0 * 1024 * 1024));
    }

    /**
     * Extracts the file extension including the dot. Returns empty string if none.
     * @param filename the filename
     * @return the extension, e.g., ".pdf"
     */
    public static String getExtension(String filename) {
        if (filename == null || !filename.contains(".")) return "";
        return filename.substring(filename.lastIndexOf(".")).toLowerCase();
    }

    /**
     * Checks whether the file extension is in the allowed list.
     * @param filename the filename to check
     * @return true if the extension is allowed
     */
    public static boolean isAllowedExtension(String filename) {
        return ALLOWED_EXTENSIONS.contains(getExtension(filename));
    }

    /**
     * Checks whether the MIME type is in the allowed list.
     * @param mimeType the MIME type to check
     * @return true if the MIME type is allowed
     */
    public static boolean isAllowedMimeType(String mimeType) {
        if (mimeType == null) return false;
        return ALLOWED_MIME_TYPES.contains(mimeType.toLowerCase());
    }

    /**
     * Sanitizes a filename by removing path traversal characters and special chars.
     * @param filename the original filename
     * @return the sanitized filename
     */
    public static String sanitizeFilename(String filename) {
        if (filename == null) return "unknown";
        // Remove path separators
        filename = filename.replace("\\", "").replace("/", "");
        // Remove path traversal
        filename = filename.replace("..", "");
        // Remove non-printable and special characters (keep letters, digits, dot, hyphen, underscore, space)
        filename = filename.replaceAll("[^a-zA-Z0-9.\\-_ ]", "");
        if (filename.trim().isEmpty()) return "unknown";
        return filename.trim();
    }

    /**
     * Ensures a directory exists, creating it if necessary.
     * @param dirPath the directory path
     * @return true if the directory exists or was created successfully
     */
    public static boolean ensureDirectoryExists(String dirPath) {
        File dir = new File(dirPath);
        if (dir.exists()) return true;
        return dir.mkdirs();
    }
}
