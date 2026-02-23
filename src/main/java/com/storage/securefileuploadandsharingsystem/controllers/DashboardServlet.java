package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.FileDAO;
import com.storage.securefileuploadandsharingsystem.dao.ShareLinkDAO;
import com.storage.securefileuploadandsharingsystem.models.FileMetadata;
import com.storage.securefileuploadandsharingsystem.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(DashboardServlet.class);
    private final FileDAO fileDAO = new FileDAO();
    private final ShareLinkDAO shareLinkDAO = new ShareLinkDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        try {
            List<FileMetadata> files = fileDAO.getFilesByUserId(userId);
            int totalFiles = fileDAO.getFileCountByUserId(userId);
            long totalStorage = fileDAO.getTotalStorageByUserId(userId);
            int activeShares = shareLinkDAO.getShareLinksByUserId(userId).size();

            req.setAttribute("files", files);
            req.setAttribute("totalFiles", totalFiles);
            req.setAttribute("totalStorage", formatFileSize(totalStorage));
            req.setAttribute("totalStorageBytes", totalStorage);
            req.setAttribute("activeShares", activeShares);
        } catch (Exception e) {
            logger.error("Failed to load dashboard data", e);
            req.setAttribute("error", "Failed to load dashboard data.");
        }

        req.getRequestDispatcher("/views/dashboard.jsp").forward(req, resp);
    }

    public static String formatFileSize(long bytes) {
        if (bytes < 1024) return bytes + " B";
        if (bytes < 1024 * 1024) return String.format("%.1f KB", bytes / 1024.0);
        if (bytes < 1024 * 1024 * 1024) return String.format("%.1f MB", bytes / (1024.0 * 1024));
        return String.format("%.2f GB", bytes / (1024.0 * 1024 * 1024));
    }
}
