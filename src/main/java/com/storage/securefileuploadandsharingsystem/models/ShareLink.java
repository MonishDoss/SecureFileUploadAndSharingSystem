package com.storage.securefileuploadandsharingsystem.models;

import java.sql.Timestamp;

public class ShareLink {
    private int shareId;
    private int fileId;
    private String shareToken;
    private int createdBy;
    private String passwordHash;
    private Timestamp expiresAt;
    private Integer maxDownloads;   // nullable
    private int downloadCount;
    private boolean isActive;
    private Timestamp createdAt;

    public ShareLink() {
    }

    public ShareLink(int shareId, int fileId, String shareToken, int createdBy,
                     String passwordHash, Timestamp expiresAt, Integer maxDownloads,
                     int downloadCount, boolean isActive, Timestamp createdAt) {
        this.shareId = shareId;
        this.fileId = fileId;
        this.shareToken = shareToken;
        this.createdBy = createdBy;
        this.passwordHash = passwordHash;
        this.expiresAt = expiresAt;
        this.maxDownloads = maxDownloads;
        this.downloadCount = downloadCount;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    // Getters and Setters

    public int getShareId() {
        return shareId;
    }

    public void setShareId(int shareId) {
        this.shareId = shareId;
    }

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getShareToken() {
        return shareToken;
    }

    public void setShareToken(String shareToken) {
        this.shareToken = shareToken;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Timestamp getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Timestamp expiresAt) {
        this.expiresAt = expiresAt;
    }

    public Integer getMaxDownloads() {
        return maxDownloads;
    }

    public void setMaxDownloads(Integer maxDownloads) {
        this.maxDownloads = maxDownloads;
    }

    public int getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Checks if this share link is currently valid (active, not expired, within download limit).
     */
    public boolean isValid() {
        if (!isActive) return false;
        if (expiresAt != null && expiresAt.before(new Timestamp(System.currentTimeMillis()))) return false;
        if (maxDownloads != null && downloadCount >= maxDownloads) return false;
        return true;
    }

    @Override
    public String toString() {
        return "ShareLink{" +
                "shareId=" + shareId +
                ", fileId=" + fileId +
                ", shareToken='" + shareToken + '\'' +
                ", createdBy=" + createdBy +
                ", expiresAt=" + expiresAt +
                ", maxDownloads=" + maxDownloads +
                ", downloadCount=" + downloadCount +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}

