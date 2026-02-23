package com.storage.securefileuploadandsharingsystem.controllers;

import com.storage.securefileuploadandsharingsystem.dao.UserDAO;
import com.storage.securefileuploadandsharingsystem.models.User;
import com.storage.securefileuploadandsharingsystem.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(LoginServlet.class);
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Username and password are required.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userDAO.getActiveUserByUsername(username.trim());
            if (user == null) {
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            if (!PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60);

            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (Exception e) {
            logger.error("Login failed", e);
            req.setAttribute("error", "An error occurred. Please try again.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
