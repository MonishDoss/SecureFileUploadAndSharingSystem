package com.storage.securefileuploadandsharingsystem.dao;

import com.storage.securefileuploadandsharingsystem.models.ShareLink;
import com.storage.securefileuploadandsharingsystem.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShareLinkDAO {

    // ======================== CREATE ========================

    /**
     * Creates a new share link for a file.
     * @return the generated share_id, or -1 on failure
     */
    public int createShareLink(ShareLink link) throws SQLException {
        String sql = "INSERT INTO share_links (file_id, share_token, created_by, password_hash, expires_at, max_downloads) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, link.getFileId());
            ps.setString(2, link.getShareToken());
            ps.setInt(3, link.getCreatedBy());
            ps.setString(4, link.getPasswordHash());         // nullable
            ps.setTimestamp(5, link.getExpiresAt());          // nullable
            if (link.getMaxDownloads() != null) {
                ps.setInt(6, link.getMaxDownloads());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
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
     * Gets a share link by share_id.
     */
    public ShareLink getShareLinkById(int shareId) throws SQLException {
        String sql = "SELECT * FROM share_links WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapShareLink(rs);
                }
            }
        }
        return null;
    }

    /**
     * Gets a share link by its unique token.
     */
    public ShareLink getShareLinkByToken(String shareToken) throws SQLException {
        String sql = "SELECT * FROM share_links WHERE share_token = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, shareToken);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapShareLink(rs);
                }
            }
        }
        return null;
    }

    /**
     * Gets all share links for a specific file.
     */
    public List<ShareLink> getShareLinksByFileId(int fileId) throws SQLException {
        String sql = "SELECT * FROM share_links WHERE file_id = ? ORDER BY created_at DESC";
        List<ShareLink> links = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, fileId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    links.add(mapShareLink(rs));
                }
            }
        }
        return links;
    }

    /**
     * Gets all share links created by a specific user.
     */
    public List<ShareLink> getShareLinksByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM share_links WHERE created_by = ? ORDER BY created_at DESC";
        List<ShareLink> links = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    links.add(mapShareLink(rs));
                }
            }
        }
        return links;
    }

    /**
     * Finds a valid (active, not expired, within download limit) share link by token.
     * Returns null if the link is invalid.
     */
    public ShareLink getValidShareLinkByToken(String shareToken) throws SQLException {
        String sql = "SELECT * FROM share_links WHERE share_token = ? AND is_active = TRUE "
                   + "AND (expires_at IS NULL OR expires_at > NOW()) "
                   + "AND (max_downloads IS NULL OR download_count < max_downloads)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, shareToken);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapShareLink(rs);
                }
            }
        }
        return null;
    }

    // ======================== UPDATE ========================

    /**
     * Increments the download count for a share link.
     */
    public boolean incrementDownloadCount(int shareId) throws SQLException {
        String sql = "UPDATE share_links SET download_count = download_count + 1 WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Activates or deactivates a share link.
     */
    public boolean setActive(int shareId, boolean isActive) throws SQLException {
        String sql = "UPDATE share_links SET is_active = ? WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, isActive);
            ps.setInt(2, shareId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Updates the expiration date of a share link.
     */
    public boolean updateExpiration(int shareId, Timestamp expiresAt) throws SQLException {
        String sql = "UPDATE share_links SET expires_at = ? WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, expiresAt);
            ps.setInt(2, shareId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Updates the max downloads limit.
     */
    public boolean updateMaxDownloads(int shareId, Integer maxDownloads) throws SQLException {
        String sql = "UPDATE share_links SET max_downloads = ? WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (maxDownloads != null) {
                ps.setInt(1, maxDownloads);
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setInt(2, shareId);
            return ps.executeUpdate() > 0;
        }
    }

    // ======================== DELETE ========================

    /**
     * Deletes a share link by share_id. Cascades to access_logs.
     */
    public boolean deleteShareLink(int shareId) throws SQLException {
        String sql = "DELETE FROM share_links WHERE share_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shareId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Deletes all share links for a given file.
     */
    public boolean deleteShareLinksByFileId(int fileId) throws SQLException {
        String sql = "DELETE FROM share_links WHERE file_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, fileId);
            return ps.executeUpdate() > 0;
        }
    }

    // ======================== HELPERS ========================

    /**
     * Maps a ResultSet row to a ShareLink object.
     */
    private ShareLink mapShareLink(ResultSet rs) throws SQLException {
        ShareLink link = new ShareLink();
        link.setShareId(rs.getInt("share_id"));
        link.setFileId(rs.getInt("file_id"));
        link.setShareToken(rs.getString("share_token"));
        link.setCreatedBy(rs.getInt("created_by"));
        link.setPasswordHash(rs.getString("password_hash"));
        link.setExpiresAt(rs.getTimestamp("expires_at"));
        link.setMaxDownloads((Integer) rs.getObject("max_downloads"));
        link.setDownloadCount(rs.getInt("download_count"));
        link.setActive(rs.getBoolean("is_active"));
        link.setCreatedAt(rs.getTimestamp("created_at"));
        return link;
    }
}

