package com.storage.securefileuploadandsharingsystem.dao;

import com.storage.securefileuploadandsharingsystem.models.FileMetadata;
import com.storage.securefileuploadandsharingsystem.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FileDAO {

    // ======================== CREATE ========================

    /**
     * Stores metadata for a newly uploaded file.
     * @return the generated file_id, or -1 on failure
     */
    public int createFile(FileMetadata file) throws SQLException {
        String sql = "INSERT INTO files (user_id, original_filename, stored_filename, file_path, file_size, file_type, description) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, file.getUserId());
            ps.setString(2, file.getOriginalFilename());
            ps.setString(3, file.getStoredFilename());
            ps.setString(4, file.getFilePath());
            ps.setLong(5, file.getFileSize());
            ps.setString(6, file.getFileType());
            ps.setString(7, file.getDescription());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    // ======================== READ ========================

    /**
     * Gets a file record by file_id.
     */
    public FileMetadata getFileById(int fileId) throws SQLException {
        String sql = "SELECT * FROM files WHERE file_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, fileId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapFile(rs);
                }
            }
        }
        return null;
    }

    /**
     * Gets a file record by its unique stored filename.
     */
    public FileMetadata getFileByStoredFilename(String storedFilename) throws SQLException {
        String sql = "SELECT * FROM files WHERE stored_filename = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, storedFilename);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapFile(rs);
                }
            }
        }
        return null;
    }

    /**
     * Gets all files belonging to a specific user (newest first).
     */
    public List<FileMetadata> getFilesByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM files WHERE user_id = ? ORDER BY upload_date DESC";
        List<FileMetadata> files = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    files.add(mapFile(rs));
                }
            }
        }
        return files;
    }

    /**
     * Gets all files in the system (admin use).
     */
    public List<FileMetadata> getAllFiles() throws SQLException {
        String sql = "SELECT * FROM files ORDER BY upload_date DESC";
        List<FileMetadata> files = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                files.add(mapFile(rs));
            }
        }
        return files;
    }

    /**
     * Counts total files for a user.
     */
    public int getFileCountByUserId(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM files WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    /**
     * Gets total storage used by a user (in bytes).
     */
    public long getTotalStorageByUserId(int userId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(file_size), 0) FROM files WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        }
        return 0;
    }

    // ======================== UPDATE ========================

    /**
     * Updates a file's description.
     */
    public boolean updateDescription(int fileId, String description) throws SQLException {
        String sql = "UPDATE files SET description = ? WHERE file_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, description);
            ps.setInt(2, fileId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Renames a file (updates original_filename).
     */
    public boolean updateOriginalFilename(int fileId, String newFilename) throws SQLException {
        String sql = "UPDATE files SET original_filename = ? WHERE file_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newFilename);
            ps.setInt(2, fileId);
            return ps.executeUpdate() > 0;
        }
    }

    // ======================== DELETE ========================

    /**
     * Deletes a file record by file_id. Cascades to share_links and access_logs.
     */
    public boolean deleteFile(int fileId) throws SQLException {
        String sql = "DELETE FROM files WHERE file_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, fileId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Deletes all file records for a given user.
     */
    public boolean deleteFilesByUserId(int userId) throws SQLException {
        String sql = "DELETE FROM files WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ======================== HELPERS ========================

    /**
     * Checks if a file belongs to a specific user.
     */
    public boolean isFileOwner(int fileId, int userId) throws SQLException {
        String sql = "SELECT 1 FROM files WHERE file_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, fileId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Maps a ResultSet row to a FileMetadata object.
     */
    private FileMetadata mapFile(ResultSet rs) throws SQLException {
        FileMetadata file = new FileMetadata();
        file.setFileId(rs.getInt("file_id"));
        file.setUserId(rs.getInt("user_id"));
        file.setOriginalFilename(rs.getString("original_filename"));
        file.setStoredFilename(rs.getString("stored_filename"));
        file.setFilePath(rs.getString("file_path"));
        file.setFileSize(rs.getLong("file_size"));
        file.setFileType(rs.getString("file_type"));
        file.setDescription(rs.getString("description"));
        file.setUploadDate(rs.getTimestamp("upload_date"));
        return file;
    }
}

