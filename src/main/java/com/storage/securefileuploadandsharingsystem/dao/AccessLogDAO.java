package com.storage.securefileuploadandsharingsystem.dao;

import com.storage.securefileuploadandsharingsystem.models.AccessLog;
import com.storage.securefileuploadandsharingsystem.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccessLogDAO {

    // ======================== CREATE ========================

    /**
     * Logs a file access event (view or download).
     * @return the generated log_id, or -1 on failure
     */
    public int createAccessLog(int shareId, String ipAddress, String action) throws SQLException {
        String sql = "INSERT INTO access_logs (share_id, ip_address, action) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, shareId);
            ps.setString(2, ipAddress);
            ps.setString(3, action);   // 'view' or 'download'
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
     * Gets an access log entry by log_id.
     */
    public AccessLog getAccessLogById(int logId) throws SQLException {
        String sql = "SELECT * FROM access_logs WHERE log_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, logId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapAccessLog(rs);
                }
            }
        }
        return null;
    }

    /**
     * Gets all access logs for a specific share link (newest first).
     */
    public List<AccessLog> getAccessLogsByShareId(int shareId) throws SQLException {
        String sql = "SELECT * FROM access_logs WHERE share_id = ? ORDER BY access_time DESC";
        List<AccessLog> logs = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapAccessLog(rs));
                }
            }
        }
        return logs;
    }

    /**
     * Gets all access logs for a specific file (joins through share_links).
     */
    public List<AccessLog> getAccessLogsByFileId(int fileId) throws SQLException {
        String sql = "SELECT al.* FROM access_logs al "
                   + "JOIN share_links sl ON al.share_id = sl.share_id "
                   + "WHERE sl.file_id = ? ORDER BY al.access_time DESC";
        List<AccessLog> logs = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, fileId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapAccessLog(rs));
                }
            }
        }
        return logs;
    }

    /**
     * Gets all access logs for files owned by a specific user.
     */
    public List<AccessLog> getAccessLogsByUserId(int userId) throws SQLException {
        String sql = "SELECT al.* FROM access_logs al "
                   + "JOIN share_links sl ON al.share_id = sl.share_id "
                   + "JOIN files f ON sl.file_id = f.file_id "
                   + "WHERE f.user_id = ? ORDER BY al.access_time DESC";
        List<AccessLog> logs = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapAccessLog(rs));
                }
            }
        }
        return logs;
    }

    /**
     * Gets the most recent access logs, limited to a given count.
     */
    public List<AccessLog> getRecentAccessLogs(int limit) throws SQLException {
        String sql = "SELECT * FROM access_logs ORDER BY access_time DESC LIMIT ?";
        List<AccessLog> logs = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapAccessLog(rs));
                }
            }
        }
        return logs;
    }

    /**
     * Counts total accesses for a share link.
     */
    public int getAccessCountByShareId(int shareId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM access_logs WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    /**
     * Counts accesses by action type ('view' or 'download') for a share link.
     */
    public int getAccessCountByAction(int shareId, String action) throws SQLException {
        String sql = "SELECT COUNT(*) FROM access_logs WHERE share_id = ? AND action = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            ps.setString(2, action);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // ======================== DELETE ========================

    /**
     * Deletes all access logs for a share link.
     */
    public boolean deleteAccessLogsByShareId(int shareId) throws SQLException {
        String sql = "DELETE FROM access_logs WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            return ps.executeUpdate() > 0;
        }
    }

    // ======================== HELPERS ========================

    /**
     * Maps a ResultSet row to an AccessLog object.
     */
    private AccessLog mapAccessLog(ResultSet rs) throws SQLException {
        AccessLog log = new AccessLog();
        log.setLogId(rs.getInt("log_id"));
        log.setShareId(rs.getInt("share_id"));
        log.setIpAddress(rs.getString("ip_address"));
        log.setAccessTime(rs.getTimestamp("access_time"));
        log.setAction(rs.getString("action"));
        return log;
    }
}

