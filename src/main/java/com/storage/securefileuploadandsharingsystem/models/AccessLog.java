package com.storage.securefileuploadandsharingsystem.models;

import java.sql.Timestamp;

public class AccessLog {
    private int logId;
    private int shareId;
    private String ipAddress;
    private Timestamp accessTime;
    private String action;       // 'view' or 'download'

    public AccessLog() {
    }

    public AccessLog(int logId, int shareId, String ipAddress, Timestamp accessTime, String action) {
        this.logId = logId;
        this.shareId = shareId;
        this.ipAddress = ipAddress;
        this.accessTime = accessTime;
        this.action = action;
    }

    // Getters and Setters

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getShareId() {
        return shareId;
    }

    public void setShareId(int shareId) {
        this.shareId = shareId;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public Timestamp getAccessTime() {
        return accessTime;
    }

    public void setAccessTime(Timestamp accessTime) {
        this.accessTime = accessTime;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    @Override
    public String toString() {
        return "AccessLog{" +
                "logId=" + logId +
                ", shareId=" + shareId +
                ", ipAddress='" + ipAddress + '\'' +
                ", accessTime=" + accessTime +
                ", action='" + action + '\'' +
                '}';
    }
}

