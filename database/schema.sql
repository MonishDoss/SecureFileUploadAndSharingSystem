-- =============================================
-- Secure File Upload System - Database Schema
-- =============================================
-- MySQL 8.0+
-- Created: 2024
-- Description: Complete database schema for secure file upload and sharing system
-- =============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS secure_file_upload;
USE secure_file_upload;

-- =============================================
-- Table: users
-- Description: Stores user account information
-- =============================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: files
-- Description: Stores file metadata
-- =============================================
CREATE TABLE files (
    file_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) UNIQUE NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size BIGINT NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    description TEXT,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_upload_date (upload_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: share_links
-- Description: Manages file sharing with access controls
-- =============================================
CREATE TABLE share_links (
    share_id INT AUTO_INCREMENT PRIMARY KEY,
    file_id INT NOT NULL,
    share_token VARCHAR(255) UNIQUE NOT NULL,
    created_by INT NOT NULL,
    password_hash VARCHAR(255),
    expires_at TIMESTAMP NULL,
    max_downloads INT NULL,
    download_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (file_id) REFERENCES files(file_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_share_token (share_token),
    INDEX idx_file_id (file_id),
    INDEX idx_created_by (created_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: access_logs
-- Description: Tracks file access for security auditing
-- =============================================
CREATE TABLE access_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    share_id INT NOT NULL,
    ip_address VARCHAR(50),
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action ENUM('view', 'download') NOT NULL,
    FOREIGN KEY (share_id) REFERENCES share_links(share_id) ON DELETE CASCADE,
    INDEX idx_share_id (share_id),
    INDEX idx_access_time (access_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Optional: Create a view for user statistics
-- =============================================
CREATE VIEW user_file_stats AS
SELECT 
    u.user_id,
    u.username,
    COUNT(f.file_id) as total_files,
    SUM(f.file_size) as total_storage,
    COUNT(sl.share_id) as total_shares
FROM users u
LEFT JOIN files f ON u.user_id = f.user_id
LEFT JOIN share_links sl ON f.file_id = sl.file_id
GROUP BY u.user_id, u.username;

-- =============================================
-- Display confirmation message
-- =============================================
SELECT 'Database schema created successfully!' as Status;
SELECT 'Tables created: users, files, share_links, access_logs' as Tables;
SELECT 'View created: user_file_stats' as Views;
