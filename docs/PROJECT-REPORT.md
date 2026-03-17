# SECURE FILE UPLOAD AND SHARING SYSTEM
## Project Report

**Submitted By:** [Your Name]  
**Roll Number:** [Your Roll Number]  
**Department:** Computer Science and Engineering  
**College:** [Your Institution Name]  
**Academic Year:** 2024-2025  

**Under the Guidance of:**  
[Guide Name]  
[Designation]  

---

## ABSTRACT

The Secure File Upload and Sharing System is a production-ready web application designed to address critical security vulnerabilities in file sharing platforms. Built using Java 21 (LTS), Jakarta EE 10, and MySQL 8, the system implements enterprise-grade security measures including BCrypt password hashing, CSRF protection, XSS prevention, SQL injection defense, and comprehensive file validation.

The application provides users with a secure platform to upload, manage, and share files with controlled access permissions. Key features include password-protected shareable links, expiration dates, download limits, and detailed access logging. Files are stored outside the web root directory with servlet-controlled access, implementing a defense-in-depth security architecture.

The system utilizes HikariCP for database connection pooling, Apache Commons FileUpload for file handling, and SLF4J with Logback for logging. The frontend is built with JSP, HTML5, CSS3, and JavaScript, providing a responsive and intuitive interface.

This project demonstrates practical implementation of secure coding practices, addressing real-world challenges in file sharing security while maintaining high performance and user experience.

**Keywords:** File Upload Security, Jakarta EE, BCrypt Encryption, CSRF Protection, Access Control, Defense-in-Depth

---

# 1. INTRODUCTION

## 1.1 OVERVIEW OF THE PROJECT

In today's digital landscape, file sharing has become integral to business operations and collaboration. However, traditional file sharing systems often suffer from critical security vulnerabilities including unrestricted file uploads, lack of access control, insecure authentication, and inadequate logging.

The Secure File Upload and Sharing System addresses these vulnerabilities through a comprehensive security-first approach. This production-ready web application combines robust security measures with user-friendly functionality.

### Technology Stack:
- **Backend:** Java 21 (LTS), Jakarta EE 10
- **Database:** MySQL 8.0 with HikariCP connection pooling
- **Server:** Apache Tomcat 10.1
- **Build Tool:** Maven 3.9

### Core Features:
- User authentication with BCrypt password hashing (12 rounds)
- Session management with automatic timeout
- File validation using whitelist approach and MIME verification
- Controlled sharing with token-based links and expiration dates
- Comprehensive access logging
- Role-based access control

### Problem Statement:
Organizations require a secure platform for sharing sensitive files without compromising data security. This project provides enterprise-grade security without sacrificing usability, granular access controls, and audit capabilities through comprehensive logging.

---

## 1.2 OBJECTIVE

### Primary Objectives:

**1. Develop Secure File Upload System**
- Implement comprehensive file validation (type, size, MIME)
- Prevent malicious uploads through whitelist approach
- Store files securely outside web-accessible directories
- Generate unique filenames using UUID

**2. Implement Robust Authentication**
- Secure registration with password validation
- BCrypt password hashing (12 rounds)
- Session-based authentication with timeout
- Session fixation prevention
- Role-based access control

**3. Create Controlled File Sharing**
- Generate unique shareable links
- Implement password protection
- Set expiration dates
- Limit downloads per link
- Enable link revocation
- Track access with logging

**4. Prevent Common Web Vulnerabilities**
- SQL Injection: PreparedStatements
- XSS: Input sanitization and output encoding
- CSRF: Unique tokens per session
- Path Traversal: Filename sanitization
- Session Hijacking: Secure cookies

**5. Build Production-Ready Infrastructure**
- HikariCP connection pooling
- Comprehensive logging (SLF4J + Logback)
- Automated database maintenance
- OWASP Dependency Check
- Performance optimization

### Expected Outcomes:
- ✅ Secure platform for file storage and sharing
- ✅ Protection against OWASP Top 10 vulnerabilities
- ✅ Granular control over file access
- ✅ Security auditing through logging
- ✅ Support for concurrent users
- ✅ Professional responsive interface

---

# 2. SYSTEM DESIGN

## 2.1 MODULES

The system is architected using a modular approach with clear separation of concerns.

### Module 1: User Management
**Purpose:** Handle registration, authentication, and profile management

**Components:**
- User Registration: Username validation, email verification, password strength checking, BCrypt hashing
- User Authentication: Credential verification, session creation, login attempt tracking
- Profile Management: View/update profile, change password, activity history

**Key Classes:** User.java, UserDAO.java, LoginServlet.java, RegisterServlet.java

**Security:** BCrypt hashing, session timeout, CSRF protection, input sanitization

### Module 2: File Management
**Purpose:** Handle secure file upload, storage, retrieval, and deletion

**Components:**
- File Upload: Client/server validation, extension whitelist, MIME verification, filename sanitization, UUID naming
- File Retrieval: Access control, servlet-controlled download, streaming, tracking
- File Deletion: Ownership verification, cascade deletion, physical file removal
- File Listing: Display, search, filter, pagination

**Key Classes:** FileMetadata.java, FileDAO.java, FileUploadServlet.java, FileDownloadServlet.java

**Security:** Whitelist validation, MIME verification, storage outside webroot, access control

### Module 3: File Sharing
**Purpose:** Enable controlled file sharing with granular permissions

**Components:**
- Link Generation: UUID tokens, sharing parameters
- Access Control: Token validation, expiration check, password verification
- Share Management: Active shares list, revocation, updates
- Public Access: Minimal interface, token-based access

**Key Classes:** ShareLink.java, ShareLinkDAO.java, ShareFileServlet.java

**Security:** Random tokens, password protection, expiration enforcement, access logging

### Module 4: Security
**Purpose:** Implement comprehensive security measures

**Components:**
- Authentication Filter: Session validation, timeout check
- CSRF Protection: Token generation and validation
- Security Headers: X-Frame-Options, CSP, HSTS
- Input Validation: Sanitization, encoding

**Key Classes:** AuthenticationFilter.java, CSRFFilter.java, SecurityUtil.java

### Module 5: Database Access (DAO)
**Purpose:** Provide abstraction for database operations

**Components:**
- Connection Management: HikariCP pooling
- Data Access Objects: UserDAO, FileDAO, ShareLinkDAO
- Security: PreparedStatements, error handling

### Module 6: Utility
**Purpose:** Provide reusable functions

**Components:**
- Environment Configuration
- File Utilities
- Security Utilities
- Logging

---

## 2.2 SOFTWARE COMPONENTS

### Backend Components:

**1. Java 21 (LTS)**
- Modern language features
- Long-term support
- Performance improvements

**2. Jakarta EE 10**
- Servlet 6.0 for request handling
- JSP 4.0 for dynamic pages
- Latest stable specification

**3. Apache Tomcat 10.1**
- Jakarta EE 10 support
- Production-ready server

**4. MySQL 8.0**
- InnoDB storage engine
- Foreign key constraints
- Stored procedures

**5. HikariCP 5.1.0**
- Fast connection pooling
- Efficient resource usage
- Connection leak detection

**6. BCrypt 0.10.2**
- Adaptive hashing
- Built-in salt generation
- Industry standard

**7. Apache Commons FileUpload 1.5**
- Streaming file upload
- Memory-efficient
- Progress monitoring

**8. SLF4J + Logback**
- Multiple log levels
- File rotation
- Performance optimized

### Frontend Components:

**1. HTML5**
- Semantic elements
- Form validation
- Drag and drop API

**2. CSS3**
- Flexbox/Grid layouts
- Transitions/animations
- Responsive design

**3. JavaScript (ES6+)**
- Fetch API for AJAX
- DOM manipulation
- Event handling

### Development Tools:

**1. Apache Maven 3.9**
- Dependency management
- Build automation

**2. IntelliJ IDEA**
- Code completion
- Debugging tools
- Integration support

**3. Git**
- Version control
- Collaboration

---

## 2.3 METHODOLOGY

### Software Development Life Cycle

**Model:** Iterative and Incremental with Agile Principles

**Phase 1: Requirements Analysis (Week 1)**
- Identified security requirements
- Defined functional requirements
- Established non-functional requirements
- Selected technology stack

**Phase 2: System Design (Week 2)**
- Designed database schema
- Created architecture diagrams
- Planned security architecture
- Designed UI wireframes

**Phase 3: Implementation (Week 3-8)**

**Iteration 1:** Core infrastructure and user management
**Iteration 2:** File management module
**Iteration 3:** File sharing module
**Iteration 4:** Security hardening

**Phase 4: Testing (Week 8-9)**
- Unit testing
- Integration testing
- Security testing
- Performance testing

**Phase 5: Documentation (Week 9-10)**
- Code documentation
- User manual
- Deployment guide

### Design Patterns Used:

**1. MVC Pattern**
- Model: POJOs
- View: JSP pages
- Controller: Servlets

**2. DAO Pattern**
- Abstraction of database operations

**3. Singleton Pattern**
- Database connection pool

**4. Filter Chain Pattern**
- Request processing

### Security Methodology:

**Defense-in-Depth Architecture (7 Layers):**
1. Client-Side Validation
2. CSRF Protection
3. Session Authentication
4. Input Validation
5. File Content Validation
6. Authorization
7. Secure Storage

---

# 3. SYSTEM DEVELOPMENT

## 3.1 IMPLEMENTATION

### Database Implementation:

**users Table:**
```sql
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**files Table:**
```sql
CREATE TABLE files (
    file_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) UNIQUE NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size BIGINT NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
```

**share_links Table:**
```sql
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
    FOREIGN KEY (file_id) REFERENCES files(file_id) ON DELETE CASCADE
);
```

### Backend Implementation:

**Key Implementation Highlights:**

**1. Password Hashing:**
```java
public static String hashPassword(String plainPassword) {
    return BCrypt.withDefaults()
            .hashToString(12, plainPassword.toCharArray());
}
```

**2. File Validation:**
```java
private boolean validateFile(Part filePart, String filename) {
    // Extension check
    String ext = getFileExtension(filename);
    if (!ALLOWED_EXTENSIONS.contains(ext)) return false;
    
    // MIME check
    if (!ALLOWED_MIME_TYPES.contains(filePart.getContentType())) 
        return false;
    
    // Size check
    if (filePart.getSize() > MAX_FILE_SIZE) return false;
    
    return true;
}
```

**3. CSRF Protection:**
```java
// Generate token
String csrfToken = UUID.randomUUID().toString();
session.setAttribute("csrfToken", csrfToken);

// Validate token
if (!sessionToken.equals(requestToken)) {
    response.sendError(403, "Invalid CSRF token");
}
```

### Challenges and Solutions:

**Challenge 1:** Session Management
**Solution:** Implemented session persistence in Tomcat

**Challenge 2:** Large File Upload
**Solution:** Streaming upload with chunked transfer

**Challenge 3:** MIME Type Spoofing
**Solution:** Apache Tika for content-based detection

---

# 4. OUTPUT AND EXPLANATION

## 4.1 SCREENSHOTS

### 1. Landing Page
Modern landing page with hero section, features showcase, and clear CTAs. Professional design emphasizing security.

### 2. Registration Page
User registration with password strength meter, real-time validation, and security indicators.

### 3. Login Page
Secure login interface with show/hide password toggle, remember me option, and error handling.

### 4. Dashboard
Comprehensive file management interface with quick stats, file list, search, and action buttons.

### 5. File Upload
Drag-and-drop upload interface with progress tracking, file validation, and success/error states.

### 6. Share Modal
Advanced sharing options with password protection, expiration dates, download limits, and active shares management.

### 7. Shared File Access
Public file access page with password prompt, file information, download button, and security indicators.

### 8. Settings Page
Tabbed settings interface for profile management, security options, storage analytics, and notifications.

### 9. Mobile View
Responsive mobile interface with slide-in menu, optimized layouts, and touch-friendly controls.

---

## Output Explanation:

### System Flows:

**User Registration:** Landing → Register → Validate → Hash Password → Create User → Dashboard

**Login:** Login Page → Validate → Verify Password → Create Session → Dashboard

**File Upload:** Upload Page → Validate → Sanitize → Generate UUID → Store File → Save Metadata → Success

**File Sharing:** Dashboard → Share Modal → Configure → Generate Token → Store → Display Link

**Access Shared File:** Open Link → Validate Token → Check Password → Log Access → Download

### Security Measures:
- All inputs sanitized
- Passwords hashed with BCrypt
- CSRF tokens on all forms
- Session timeout enforced
- Files outside webroot
- Access logging enabled

---

# 5. CONCLUSION

The Secure File Upload and Sharing System successfully demonstrates enterprise-grade security implementation in a production-ready web application. The project achieves all primary objectives:

✅ Robust security against OWASP Top 10 vulnerabilities
✅ User-friendly interface with modern design
✅ Controlled file sharing with granular permissions
✅ Production-ready infrastructure with connection pooling
✅ Comprehensive logging and audit trails

### Key Achievements:
- Seven-layer defense-in-depth architecture
- BCrypt password hashing with configurable rounds
- MIME-based file validation preventing spoofing
- HikariCP connection pooling for performance
- Responsive design across all devices

### Technical Excellence:
- Full-stack development proficiency
- Database design with proper normalization
- Security engineering best practices
- Modular architecture with design patterns
- Production deployment considerations

### Future Enhancements:
- Two-factor authentication (2FA)
- End-to-end encryption
- Mobile applications
- Cloud storage integration
- Advanced analytics

### Final Remarks:
This project validates the importance of security-first development and demonstrates that secure systems can also be user-friendly. It provides a solid foundation for real-world deployment and future enhancements.

---

## REFERENCES

1. OWASP Foundation. (2021). "OWASP Top 10 - 2021"
2. Oracle Corporation. (2024). "Java SE 21 Documentation"
3. Jakarta EE Platform. (2022). "Jakarta EE 10 Specification"
4. MySQL AB. (2024). "MySQL 8.0 Reference Manual"
5. Brettwooldridge. (2024). "HikariCP Documentation"

---

**Project Repository:** https://github.com/yourusername/secure-file-upload-system

**Date of Submission:** [Current Date]
**Academic Year:** 2024-2025
