package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.FileDAO;
import com.storage.securefileuploadandsharingsystem.models.FileMetadata;
import com.storage.securefileuploadandsharingsystem.models.User;
import com.storage.securefileuploadandsharingsystem.utils.EnvConfig;
import com.storage.securefileuploadandsharingsystem.utils.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/upload")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1 MB
        maxFileSize = 50 * 1024 * 1024,        // 50 MB
        maxRequestSize = 100 * 1024 * 1024     // 100 MB
)
public class FileUploadServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(FileUploadServlet.class);
    private final FileDAO fileDAO = new FileDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/views/upload.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        String description = req.getParameter("description");

        try {
            Part filePart = req.getPart("file");
            if (filePart == null || filePart.getSize() == 0) {
                req.setAttribute("error", "Please select a file to upload.");
                req.getRequestDispatcher("/views/upload.jsp").forward(req, resp);
                return;
            }

            String originalFilename = FileUtil.sanitizeFilename(getFileName(filePart));
            long fileSize = filePart.getSize();
            String fileType = filePart.getContentType();

            // Validate file type
            if (!FileUtil.isAllowedExtension(originalFilename)) {
                req.setAttribute("error", "File type not allowed.");
                req.getRequestDispatcher("/views/upload.jsp").forward(req, resp);
                return;
            }

            // Unique stored filename
            String extension = FileUtil.getExtension(originalFilename);
            String storedFilename = UUID.randomUUID().toString() + extension;

            // Per-user upload directory
            String uploadBase = EnvConfig.get("UPLOAD_PATH");
            String userDirPath = uploadBase + File.separator + "user_" + userId;
            FileUtil.ensureDirectoryExists(userDirPath);

            // Write file to disk
            String filePath = userDirPath + File.separator + storedFilename;
            filePart.write(filePath);

            // Persist metadata in DB
            FileMetadata meta = new FileMetadata();
            meta.setUserId(userId);
            meta.setOriginalFilename(originalFilename);
            meta.setStoredFilename(storedFilename);
            meta.setFilePath(filePath);
            meta.setFileSize(fileSize);
            meta.setFileType(fileType);
            meta.setDescription(description);

            int fileId = fileDAO.createFile(meta);

            if (fileId > 0) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?success=File+uploaded+successfully");
            } else {
                Files.deleteIfExists(Paths.get(filePath));
                req.setAttribute("error", "Failed to save file metadata.");
                req.getRequestDispatcher("/views/upload.jsp").forward(req, resp);
            }
        } catch (IllegalStateException e) {
            req.setAttribute("error", "File is too large. Maximum size is 50 MB.");
            req.getRequestDispatcher("/views/upload.jsp").forward(req, resp);
        } catch (Exception e) {
            logger.error("Upload failed", e);
            req.setAttribute("error", "Upload failed: " + e.getMessage());
            req.getRequestDispatcher("/views/upload.jsp").forward(req, resp);
        }
    }

    private String getFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        for (String token : cd.split(";")) {
            if (token.trim().startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                int i = name.lastIndexOf('\\');
                if (i >= 0) name = name.substring(i + 1);
                i = name.lastIndexOf('/');
                if (i >= 0) name = name.substring(i + 1);
                return name;
            }
        }
        return "unknown";
    }
}
