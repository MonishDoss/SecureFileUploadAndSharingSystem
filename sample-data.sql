-- =============================================
-- Secure File Upload System - Sample Data
-- =============================================
-- Description: Sample data for testing the application
-- =============================================

USE secure_file_upload;

-- =============================================
-- Sample Users
-- =============================================
-- Password for all test users: Test@123
-- BCrypt hash generated with 12 rounds

INSERT INTO users (username, email, password_hash, role, is_active) VALUES
('testuser', 'test@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYKq3Wy.vlC', 'user', TRUE),
('admin', 'admin@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYKq3Wy.vlC', 'admin', TRUE),
('john_doe', 'john@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYKq3Wy.vlC', 'user', TRUE),
('jane_smith', 'jane@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYKq3Wy.vlC', 'user', TRUE),
('demo_user', 'demo@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYKq3Wy.vlC', 'user', TRUE);

-- =============================================
-- Sample Files (Optional - adjust paths)
-- =============================================
-- Note: These are sample entries. Actual files need to exist on the server.

INSERT INTO files (user_id, original_filename, stored_filename, file_path, file_size, file_type, description) VALUES
(1, 'project_report.pdf', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890.pdf', '/secure-storage/uploads/user_1/a1b2c3d4-e5f6-7890-abcd-ef1234567890.pdf', 2048576, 'pdf', 'Annual project report for Q4 2024'),
(1, 'vacation_photo.jpg', 'b2c3d4e5-f6a7-8901-bcde-f12345678901.jpg', '/secure-storage/uploads/user_1/b2c3d4e5-f6a7-8901-bcde-f12345678901.jpg', 1536000, 'jpg', 'Family vacation photo'),
(3, 'meeting_notes.docx', 'c3d4e5f6-a7b8-9012-cdef-123456789012.docx', '/secure-storage/uploads/user_3/c3d4e5f6-a7b8-9012-cdef-123456789012.docx', 512000, 'docx', 'Team meeting notes from December'),
(4, 'presentation.pptx', 'd4e5f6a7-b8c9-0123-def1-234567890123.pptx', '/secure-storage/uploads/user_4/d4e5f6a7-b8c9-0123-def1-234567890123.pptx', 3072000, 'pptx', 'Sales presentation for new product launch');

-- =============================================
-- Sample Share Links
-- =============================================

INSERT INTO share_links (file_id, share_token, created_by, password_hash, expires_at, max_downloads, is_active) VALUES
-- Shareable link with no password, expires in 7 days
(1, 'abc123def456ghi789jkl012mno345pqr', 1, NULL, DATE_ADD(NOW(), INTERVAL 7 DAY), NULL, TRUE),

-- Shareable link with password "Share@123", no expiration, max 5 downloads
(2, 'xyz987wvu654tsr321qpo098nml876klj', 1, '$2a$12$xGvQ1pJzPqT0bVcDkLmN3OyKzN8lQwErTyHiOpMnBvCxAsZdFgHuK', NULL, 5, TRUE),

-- Shareable link with password, expires in 1 day
(3, 'mno456pqr789stu012vwx345yza678bcd', 3, '$2a$12$xGvQ1pJzPqT0bVcDkLmN3OyKzN8lQwErTyHiOpMnBvCxAsZdFgHuK', DATE_ADD(NOW(), INTERVAL 1 DAY), 10, TRUE),

-- Expired share link (for testing)
(4, 'efg901hij234klm567nop890qrs123tuv', 4, NULL, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL, FALSE);

-- =============================================
-- Sample Access Logs
-- =============================================

INSERT INTO access_logs (share_id, ip_address, action, access_time) VALUES
(1, '192.168.1.100', 'view', DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(1, '192.168.1.100', 'download', DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(2, '10.0.0.50', 'view', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, '10.0.0.50', 'download', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(3, '172.16.0.25', 'view', DATE_SUB(NOW(), INTERVAL 3 HOUR));

-- =============================================
-- Update download counts
-- =============================================

UPDATE share_links SET download_count = 1 WHERE share_id = 1;
UPDATE share_links SET download_count = 1 WHERE share_id = 2;

-- =============================================
-- Display confirmation
-- =============================================

SELECT 'Sample data inserted successfully!' as Status;
SELECT COUNT(*) as user_count FROM users;
SELECT COUNT(*) as file_count FROM files;
SELECT COUNT(*) as share_link_count FROM share_links;
SELECT COUNT(*) as access_log_count FROM access_logs;

-- =============================================
-- Display test credentials
-- =============================================

SELECT '=== TEST CREDENTIALS ===' as Info;
SELECT username, email, 'Test@123' as password, role FROM users;
