package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.AccessLogDAO;
import com.storage.securefileuploadandsharingsystem.dao.FileDAO;
import com.storage.securefileuploadandsharingsystem.dao.ShareLinkDAO;
import com.storage.securefileuploadandsharingsystem.models.FileMetadata;
import com.storage.securefileuploadandsharingsystem.models.ShareLink;
import com.storage.securefileuploadandsharingsystem.models.User;
import com.storage.securefileuploadandsharingsystem.utils.PasswordUtil;
import com.storage.securefileuploadandsharingsystem.utils.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@WebServlet("/share/*")
public class ShareFileServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(ShareFileServlet.class);

    private final FileDAO fileDAO = new FileDAO();
    private final ShareLinkDAO shareLinkDAO = new ShareLinkDAO();
    private final AccessLogDAO accessLogDAO = new AccessLogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        // /share/access/<token>  — public share access page
        if (pathInfo != null && pathInfo.startsWith("/access/")) {
            String token = pathInfo.substring("/access/".length());
            handlePublicAccess(req, resp, token);
            return;
        }

        // /share/download/<token>  — public download (after password verified)
        if (pathInfo != null && pathInfo.startsWith("/download/")) {
            String token = pathInfo.substring("/download/".length());
            handlePublicDownload(req, resp, token);
            return;
        }

        // /share/revoke?shareId=X&fileId=Y  — revoke via GET link
        if (pathInfo != null && pathInfo.equals("/revoke")) {
            handleRevoke(req, resp);
            return;
        }

        // /share?fileId=X  — authenticated share creation page
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fileIdStr = req.getParameter("fileId");
        if (fileIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        try {
            int fileId = Integer.parseInt(fileIdStr);
            User user = (User) session.getAttribute("user");
            FileMetadata file = fileDAO.getFileById(fileId);

            if (file == null || (file.getUserId() != user.getUserId() && !"admin".equals(user.getRole()))) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?error=Access+denied");
                return;
            }

            List<ShareLink> existingLinks = shareLinkDAO.getShareLinksByFileId(fileId);
            req.setAttribute("file", file);
            req.setAttribute("shareLinks", existingLinks);
            req.getRequestDispatcher("/views/share.jsp").forward(req, resp);
        } catch (Exception e) {
            logger.error("Error loading share page", e);
            resp.sendRedirect(req.getContextPath() + "/dashboard?error=Error+loading+share+page");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        // /share/verify/<token>  — password verification for public access
        if (pathInfo != null && pathInfo.startsWith("/verify/")) {
            String token = pathInfo.substring("/verify/".length());
            handlePasswordVerify(req, resp, token);
            return;
        }

        // /share/revoke  — revoke a share link
        if (pathInfo != null && pathInfo.equals("/revoke")) {
            handleRevoke(req, resp);
            return;
        }

        // POST /share  — create new share link (authenticated)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fileIdStr = req.getParameter("fileId");
        String password = req.getParameter("sharePassword");
        String expiresStr = req.getParameter("expiresAt");
        String maxDownloadsStr = req.getParameter("maxDownloads");

        try {
            int fileId = Integer.parseInt(fileIdStr);
            User user = (User) session.getAttribute("user");
            FileMetadata file = fileDAO.getFileById(fileId);

            if (file == null || (file.getUserId() != user.getUserId() && !"admin".equals(user.getRole()))) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?error=Access+denied");
                return;
            }

            ShareLink link = new ShareLink();
            link.setFileId(fileId);
            link.setShareToken(UUID.randomUUID().toString());
            link.setCreatedBy(user.getUserId());

            if (password != null && !password.trim().isEmpty()) {
                link.setPasswordHash(PasswordUtil.hashPassword(password.trim()));
            }
            if (expiresStr != null && !expiresStr.trim().isEmpty()) {
                link.setExpiresAt(Timestamp.valueOf(expiresStr + " 23:59:59"));
            }
            if (maxDownloadsStr != null && !maxDownloadsStr.trim().isEmpty()) {
                link.setMaxDownloads(Integer.parseInt(maxDownloadsStr));
            }

            int shareId = shareLinkDAO.createShareLink(link);
            if (shareId > 0) {
                resp.sendRedirect(req.getContextPath() + "/share?fileId=" + fileId + "&success=Share+link+created");
            } else {
                resp.sendRedirect(req.getContextPath() + "/share?fileId=" + fileId + "&error=Failed+to+create+link");
            }
        } catch (Exception e) {
            logger.error("Share creation failed", e);
            resp.sendRedirect(req.getContextPath() + "/dashboard?error=Share+creation+failed");
        }
    }

    private void handlePublicAccess(HttpServletRequest req, HttpServletResponse resp, String token) throws ServletException, IOException {
        try {
            ShareLink link = shareLinkDAO.getShareLinkByToken(token);
            if (link == null || !link.isActive()) {
                req.setAttribute("error", "This share link is invalid or has been revoked.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }
            if (!link.isValid()) {
                req.setAttribute("error", "This share link has expired or reached its download limit.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }

            FileMetadata file = fileDAO.getFileById(link.getFileId());
            req.setAttribute("shareLink", link);
            req.setAttribute("file", file);
            req.setAttribute("token", token);
            req.setAttribute("needsPassword", link.getPasswordHash() != null);

            // Log the view
            accessLogDAO.createAccessLog(link.getShareId(), SecurityUtil.getClientIp(req), "view");

            req.getRequestDispatcher("/views/share_access.jsp").forward(req, resp);
        } catch (Exception e) {
            logger.error("Public access failed", e);
            req.setAttribute("error", "An error occurred.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    private void handlePasswordVerify(HttpServletRequest req, HttpServletResponse resp, String token) throws ServletException, IOException {
        String password = req.getParameter("password");
        try {
            ShareLink link = shareLinkDAO.getShareLinkByToken(token);
            if (link == null || !link.isActive() || !link.isValid()) {
                req.setAttribute("error", "Invalid or expired share link.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }

            if (!PasswordUtil.verifyPassword(password, link.getPasswordHash())) {
                FileMetadata file = fileDAO.getFileById(link.getFileId());
                req.setAttribute("shareLink", link);
                req.setAttribute("file", file);
                req.setAttribute("token", token);
                req.setAttribute("needsPassword", true);
                req.setAttribute("error", "Incorrect password.");
                req.getRequestDispatcher("/views/share_access.jsp").forward(req, resp);
                return;
            }

            // Password correct - set session flag and redirect to download
            HttpSession session = req.getSession(true);
            session.setAttribute("verified_" + token, true);
            resp.sendRedirect(req.getContextPath() + "/share/download/" + token);
        } catch (Exception e) {
            logger.error("Password verification failed", e);
            req.setAttribute("error", "Verification failed.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    private void handlePublicDownload(HttpServletRequest req, HttpServletResponse resp, String token) throws ServletException, IOException {
        try {
            ShareLink link = shareLinkDAO.getShareLinkByToken(token);
            if (link == null || !link.isActive() || !link.isValid()) {
                req.setAttribute("error", "Invalid or expired share link.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }

            // If password protected, check session verification
            if (link.getPasswordHash() != null) {
                HttpSession session = req.getSession(false);
                if (session == null || session.getAttribute("verified_" + token) == null) {
                    resp.sendRedirect(req.getContextPath() + "/share/access/" + token);
                    return;
                }
            }

            FileMetadata meta = fileDAO.getFileById(link.getFileId());
            File file = new File(meta.getFilePath());
            if (!file.exists()) {
                req.setAttribute("error", "File not found on server.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }

            // Increment download count
            shareLinkDAO.incrementDownloadCount(link.getShareId());
            accessLogDAO.createAccessLog(link.getShareId(), SecurityUtil.getClientIp(req), "download");

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
        } catch (Exception e) {
            logger.error("Public download failed", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Download failed.");
        }
    }

    private void handleRevoke(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String shareIdStr = req.getParameter("shareId");
        String fileIdStr = req.getParameter("fileId");
        try {
            int shareId = Integer.parseInt(shareIdStr);
            shareLinkDAO.setActive(shareId, false);
            resp.sendRedirect(req.getContextPath() + "/share?fileId=" + fileIdStr + "&success=Link+revoked");
        } catch (Exception e) {
            logger.error("Revoke failed", e);
            resp.sendRedirect(req.getContextPath() + "/dashboard?error=Revoke+failed");
        }
    }
}
