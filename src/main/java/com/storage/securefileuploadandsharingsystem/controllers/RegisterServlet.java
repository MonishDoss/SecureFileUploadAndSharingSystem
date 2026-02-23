package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.UserDAO;
import com.storage.securefileuploadandsharingsystem.utils.EnvConfig;
import com.storage.securefileuploadandsharingsystem.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(RegisterServlet.class);
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty() ||
            confirmPassword == null || confirmPassword.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        username = username.trim();
        email = email.trim();

        if (username.length() < 3 || username.length() > 50) {
            req.setAttribute("error", "Username must be between 3 and 50 characters.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 8) {
            req.setAttribute("error", "Password must be at least 8 characters long.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        try {
            if (userDAO.usernameExists(username)) {
                req.setAttribute("error", "Username is already taken.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }
            if (userDAO.emailExists(email)) {
                req.setAttribute("error", "Email is already registered.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }

            String passwordHash = PasswordUtil.hashPassword(password);
            int userId = userDAO.createUser(username, email, passwordHash);

            if (userId > 0) {
                // Create per-user upload folder on disk
                String uploadBase = EnvConfig.get("UPLOAD_PATH");
                File userDir = new File(uploadBase, "user_" + userId);
                if (!userDir.exists()) {
                    if (!userDir.mkdirs()) {
                        logger.warn("Failed to create user directory: {}", userDir.getAbsolutePath());
                    }
                }
                req.setAttribute("success", "Account created successfully! Please log in.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.error("Registration failed", e);
            req.setAttribute("error", "An error occurred. Please try again.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
