package com.storage.securefileuploadandsharingsystem.models;

import java.sql.Timestamp;

public class FileMetadata {
    private int fileId;
    private int userId;
    private String originalFilename;
    private String storedFilename;
    private String filePath;
    private long fileSize;
    private String fileType;
    private String description;
    private Timestamp uploadDate;

    public FileMetadata() {
    }

    public FileMetadata(int fileId, int userId, String originalFilename, String storedFilename,
                        String filePath, long fileSize, String fileType, String description,
                        Timestamp uploadDate) {
        this.fileId = fileId;
        this.userId = userId;
        this.originalFilename = originalFilename;
        this.storedFilename = storedFilename;
        this.filePath = filePath;
        this.fileSize = fileSize;
        this.fileType = fileType;
        this.description = description;
        this.uploadDate = uploadDate;
    }

    // Getters and Setters

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOriginalFilename() {
        return originalFilename;
    }

    public void setOriginalFilename(String originalFilename) {
        this.originalFilename = originalFilename;
    }

    public String getStoredFilename() {
        return storedFilename;
    }

    public void setStoredFilename(String storedFilename) {
        this.storedFilename = storedFilename;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }

    @Override
    public String toString() {
        return "FileMetadata{" +
                "fileId=" + fileId +
                ", userId=" + userId +
                ", originalFilename='" + originalFilename + '\'' +
                ", storedFilename='" + storedFilename + '\'' +
                ", fileSize=" + fileSize +
                ", fileType='" + fileType + '\'' +
                ", uploadDate=" + uploadDate +
                '}';
    }
}

