package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.FileDAO;
import com.storage.securefileuploadandsharingsystem.models.FileMetadata;
import com.storage.securefileuploadandsharingsystem.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/delete")
public class FileDeleteServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(FileDeleteServlet.class);
    private final FileDAO fileDAO = new FileDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fileIdStr = req.getParameter("fileId");
        if (fileIdStr == null || fileIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/dashboard?error=File+ID+required");
            return;
        }

        try {
            int fileId = Integer.parseInt(fileIdStr);
            User user = (User) session.getAttribute("user");
            FileMetadata meta = fileDAO.getFileById(fileId);

            if (meta == null) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?error=File+not+found");
                return;
            }
            if (meta.getUserId() != user.getUserId() && !"admin".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?error=Access+denied");
                return;
            }

            // Delete from disk
            try { Files.deleteIfExists(Paths.get(meta.getFilePath())); } catch (Exception ignored) {}

            // Delete from DB (cascades to share_links & access_logs)
            fileDAO.deleteFile(fileId);
            resp.sendRedirect(req.getContextPath() + "/dashboard?success=File+deleted+successfully");
        } catch (Exception e) {
            logger.error("Delete failed", e);
            resp.sendRedirect(req.getContextPath() + "/dashboard?error=Delete+failed");
        }
    }
}
