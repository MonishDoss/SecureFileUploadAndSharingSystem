# Secure File Upload System - Setup Guide

## Complete Installation and Configuration Guide

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Environment Setup](#environment-setup)
3. [Database Configuration](#database-configuration)
4. [Project Setup](#project-setup)
5. [Tomcat Configuration](#tomcat-configuration)
6. [Running the Application](#running-the-application)
7. [Troubleshooting](#troubleshooting)
8. [Production Deployment](#production-deployment)

---

## Prerequisites

### Required Software

| Software | Version | Download Link |
|----------|---------|---------------|
| Java JDK | 17 or 21 (LTS) | https://www.oracle.com/java/technologies/downloads/ |
| Apache Maven | 3.8+ | https://maven.apache.org/download.cgi |
| MySQL | 8.0+ | https://dev.mysql.com/downloads/mysql/ |
| Apache Tomcat | 9.0+ | https://tomcat.apache.org/download-90.cgi |
| IntelliJ IDEA | 2023+ (Community or Ultimate) | https://www.jetbrains.com/idea/download/ |
| Git | Latest | https://git-scm.com/downloads |

### System Requirements

- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: 2GB free space
- **OS**: Windows 10/11, macOS, or Linux

---

## Environment Setup

### 1. Install Java JDK

#### Windows
```bash
# Download JDK 17 installer from Oracle
# Run installer and follow prompts

# Set JAVA_HOME environment variable
setx JAVA_HOME "C:\Program Files\Java\jdk-17"
setx PATH "%PATH%;%JAVA_HOME%\bin"

# Verify installation
java -version
```

#### macOS
```bash
# Using Homebrew
brew install openjdk@17

# Add to PATH
echo 'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
java -version
```

#### Linux (Ubuntu/Debian)
```bash
# Update package list
sudo apt update

# Install OpenJDK 17
sudo apt install openjdk-17-jdk

# Verify installation
java -version
```

### 2. Install Maven

#### Windows
```bash
# Download Maven binary from Apache
# Extract to C:\Program Files\apache-maven-3.9.x

# Set environment variables
setx M2_HOME "C:\Program Files\apache-maven-3.9.x"
setx PATH "%PATH%;%M2_HOME%\bin"

# Verify installation
mvn -version
```

#### macOS
```bash
# Using Homebrew
brew install maven

# Verify installation
mvn -version
```

#### Linux
```bash
# Install Maven
sudo apt install maven

# Verify installation
mvn -version
```

### 3. Install MySQL

#### Windows
```bash
# Download MySQL Installer from MySQL website
# Run installer and choose "Developer Default"
# Set root password during installation
# Remember this password!

# Start MySQL Service
net start MySQL80
```

#### macOS
```bash
# Using Homebrew
brew install mysql

# Start MySQL service
brew services start mysql

# Secure installation
mysql_secure_installation
```

#### Linux
```bash
# Install MySQL
sudo apt install mysql-server

# Start MySQL service
sudo systemctl start mysql

# Secure installation
sudo mysql_secure_installation
```

### 4. Install Apache Tomcat

#### Download and Extract
```bash
# Download Tomcat 9.0.x from Apache website
# Extract to desired location

# Windows: C:\apache-tomcat-9.0.x
# macOS/Linux: /usr/local/apache-tomcat-9.0.x
```

#### Set Permissions (macOS/Linux)
```bash
cd /usr/local/apache-tomcat-9.0.x/bin
chmod +x *.sh
```

---

## Database Configuration

### 1. Create Database

```bash
# Login to MySQL
mysql -u root -p

# Enter your root password
```

```sql
-- Create database
CREATE DATABASE secure_file_upload;

-- Create dedicated user (recommended for production)
CREATE USER 'fileupload_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';

-- Grant privileges
GRANT ALL PRIVILEGES ON secure_file_upload.* TO 'fileupload_user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- Exit MySQL
EXIT;
```

### 2. Import Database Schema

```bash
# Navigate to project directory
cd /path/to/project

# Import schema
mysql -u root -p secure_file_upload < database/schema.sql

# Import sample data (optional)
mysql -u root -p secure_file_upload < database/sample-data.sql
```

### 3. Verify Database Setup

```bash
# Login to MySQL
mysql -u root -p

# Use database
USE secure_file_upload;

# Check tables
SHOW TABLES;

# Check sample data
SELECT * FROM users;

# Exit
EXIT;
```

---

## Project Setup

### 1. Clone Repository

```bash
# Clone from GitHub
git clone https://github.com/yourusername/secure-file-upload-system.git

# Navigate to project directory
cd secure-file-upload-system
```

### 2. Configure Database Connection

Edit `src/main/java/com/securefileupload/utils/DBConnection.java`:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/secure_file_upload";
private static final String DB_USER = "fileupload_user";  // or "root"
private static final String DB_PASSWORD = "YourPassword";
```

### 3. Create Upload Directory

#### Windows
```bash
# Create directory
mkdir C:\secure-storage\uploads

# Update FileUploadServlet.java
private static final String UPLOAD_DIR = "C:\\secure-storage\\uploads";
```

#### macOS/Linux
```bash
# Create directory
sudo mkdir -p /secure-storage/uploads

# Set permissions
sudo chmod 755 /secure-storage/uploads

# Update FileUploadServlet.java
private static final String UPLOAD_DIR = "/secure-storage/uploads";
```

### 4. Build Project

```bash
# Clean and build
mvn clean install

# If tests fail, skip them
mvn clean install -DskipTests

# Verify WAR file created
ls target/SecureFileUpload.war
```

---

## Tomcat Configuration

### 1. Configure Tomcat in IntelliJ IDEA

#### Add Tomcat Server
1. Open IntelliJ IDEA
2. Click **Run → Edit Configurations**
3. Click **+** (Add New Configuration)
4. Select **Tomcat Server → Local**

#### Configure Server
1. Click **Configure...** next to Application Server
2. Click **+** → Browse to Tomcat installation directory
3. Click **OK**

#### Configure Deployment
1. Go to **Deployment** tab
2. Click **+** → **Artifact**
3. Select **SecureFileUpload:war exploded**
4. Set **Application context** to `/` or `/secure-file-upload`

#### Set VM Options (Optional)
1. Go to **Server** tab
2. In **VM options**, add:
```
-Xms512m -Xmx1024m
```

### 2. Manual Tomcat Configuration (Alternative)

#### Deploy WAR file
```bash
# Copy WAR to Tomcat webapps
cp target/SecureFileUpload.war /path/to/tomcat/webapps/

# Tomcat will auto-deploy when started
```

#### Configure Tomcat Users (for Manager App)
Edit `tomcat/conf/tomcat-users.xml`:

```xml
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="admin-gui"/>
  <user username="admin" password="admin123" roles="manager-gui,admin-gui"/>
</tomcat-users>
```

---

## Running the Application

### Method 1: Using IntelliJ IDEA

1. Click **Run** button (Green triangle)
2. Wait for Tomcat to start
3. Browser opens automatically

### Method 2: Using Maven

```bash
# Start embedded Tomcat
mvn tomcat7:run

# Access application
# http://localhost:8080
```

### Method 3: Manual Tomcat Start

#### Windows
```bash
cd C:\apache-tomcat-9.0.x\bin
startup.bat
```

#### macOS/Linux
```bash
cd /usr/local/apache-tomcat-9.0.x/bin
./startup.sh
```

Access application at: `http://localhost:8080/SecureFileUpload`

### Default Test Credentials

If you loaded sample data:
- **Username**: `testuser`
- **Password**: `Test@123`

---

## Troubleshooting

### Common Issues

#### 1. Port 8080 Already in Use

**Solution:**
```bash
# Find process using port 8080
# Windows
netstat -ano | findstr :8080
taskkill /PID <process_id> /F

# macOS/Linux
lsof -i :8080
kill -9 <process_id>

# Or change Tomcat port in server.xml
```

#### 2. MySQL Connection Failed

**Check:**
- MySQL service is running
- Credentials in DBConnection.java are correct
- Database exists: `SHOW DATABASES;`
- User has proper privileges

**Solution:**
```sql
-- Grant all privileges again
GRANT ALL PRIVILEGES ON secure_file_upload.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
```

#### 3. ClassNotFoundException: com.mysql.cj.jdbc.Driver

**Solution:**
```bash
# Ensure MySQL connector is in pom.xml
# Re-build project
mvn clean install

# Check if dependency is downloaded
ls ~/.m2/repository/com/mysql/mysql-connector-j/
```

#### 4. File Upload Failed

**Check:**
- Upload directory exists
- Directory has write permissions
- Path in FileUploadServlet.java is correct

**Solution (Linux/macOS):**
```bash
sudo chmod 777 /secure-storage/uploads
```

#### 5. 404 Error on Servlets

**Check:**
- WAR file deployed correctly
- Servlet annotations are correct: `@WebServlet("/uploadFile")`
- web.xml configuration

#### 6. Session Timeout Issues

**Solution:**
Edit `web.xml`:
```xml
<session-config>
    <session-timeout>60</session-timeout> <!-- Increase to 60 min -->
</session-config>
```

---

## Production Deployment

### Security Hardening

#### 1. Change Default Passwords
```sql
-- Update all default user passwords
UPDATE users SET password_hash = '$2a$12$NewHashHere' WHERE username = 'testuser';
```

#### 2. Enable HTTPS

Edit Tomcat's `server.xml`:
```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/keystore.jks"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
```

Update `web.xml`:
```xml
<cookie-config>
    <http-only>true</http-only>
    <secure>true</secure>
</cookie-config>
```

#### 3. Database Security
```sql
-- Remove sample data
TRUNCATE TABLE access_logs;
TRUNCATE TABLE share_links;
TRUNCATE TABLE files;
DELETE FROM users WHERE username LIKE 'test%';

-- Create limited privilege user
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT SELECT, INSERT, UPDATE, DELETE ON secure_file_upload.* TO 'app_user'@'localhost';
```

#### 4. Environment Variables

Instead of hardcoding credentials, use environment variables:

```java
private static final String DB_URL = System.getenv("DB_URL");
private static final String DB_USER = System.getenv("DB_USER");
private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");
```

Set environment variables:
```bash
# Linux/macOS
export DB_URL="jdbc:mysql://localhost:3306/secure_file_upload"
export DB_USER="app_user"
export DB_PASSWORD="StrongPassword123!"

# Windows
setx DB_URL "jdbc:mysql://localhost:3306/secure_file_upload"
setx DB_USER "app_user"
setx DB_PASSWORD "StrongPassword123!"
```

#### 5. Backup Strategy

```bash
# Create backup script
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u root -p secure_file_upload > backup_$DATE.sql
tar -czf uploads_backup_$DATE.tar.gz /secure-storage/uploads/
```

### Performance Optimization

#### 1. Connection Pooling

Add HikariCP to `pom.xml`:
```xml
<dependency>
    <groupId>com.zaxxer</groupId>
    <artifactId>HikariCP</artifactId>
    <version>5.0.1</version>
</dependency>
```

#### 2. Increase Tomcat Memory

```bash
# Set JAVA_OPTS
export JAVA_OPTS="-Xms1024m -Xmx2048m -XX:PermSize=256m -XX:MaxPermSize=512m"
```

#### 3. Enable Compression

Edit `server.xml`:
```xml
<Connector port="8080" protocol="HTTP/1.1"
           compression="on"
           compressionMinSize="2048"
           noCompressionUserAgents="gozilla, traviata"
           compressableMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json"/>
```

---

## Monitoring and Maintenance

### Log Files Locations

- **Tomcat Logs**: `tomcat/logs/catalina.out`
- **Application Logs**: Check servlet logs
- **MySQL Logs**: `/var/log/mysql/error.log`

### Regular Maintenance Tasks

1. Clean up expired share links
2. Remove old access logs
3. Monitor disk space in upload directory
4. Review security logs
5. Update dependencies regularly

---

## Next Steps

1. ✅ Verify application is running
2. ✅ Test all features (upload, download, share)
3. ✅ Run security tests
4. ✅ Configure backup system
5. ✅ Set up monitoring
6. ✅ Create documentation for users

---

## Support

For issues or questions:
- Check [GitHub Issues](https://github.com/yourusername/secure-file-upload-system/issues)
- Read [FAQ](FAQ.md)
- Contact: your.email@example.com

---

**Last Updated**: 2024
**Version**: 1.0
