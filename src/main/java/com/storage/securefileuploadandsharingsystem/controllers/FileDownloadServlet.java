package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.FileDAO;
import com.storage.securefileuploadandsharingsystem.models.FileMetadata;
import com.storage.securefileuploadandsharingsystem.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;

@WebServlet("/download")
public class FileDownloadServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(FileDownloadServlet.class);
    private final FileDAO fileDAO = new FileDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fileIdStr = req.getParameter("id");
        if (fileIdStr == null || fileIdStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "File ID required.");
            return;
        }

        try {
            int fileId = Integer.parseInt(fileIdStr);
            User user = (User) session.getAttribute("user");
            FileMetadata meta = fileDAO.getFileById(fileId);

            if (meta == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
                return;
            }
            if (meta.getUserId() != user.getUserId() && !"admin".equals(user.getRole())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
                return;
            }

            File file = new File(meta.getFilePath());
            if (!file.exists()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found on disk.");
                return;
            }

            resp.setContentType(meta.getFileType());
            resp.setContentLengthLong(meta.getFileSize());
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + meta.getOriginalFilename() + "\"");

            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = resp.getOutputStream()) {
                byte[] buf = new byte[8192];
                int len;
                while ((len = fis.read(buf)) != -1) {
                    os.write(buf, 0, len);
                }
                os.flush();
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file ID.");
        } catch (Exception e) {
            logger.error("Download failed", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Download failed.");
        }
    }
}
