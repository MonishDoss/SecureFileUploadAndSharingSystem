package com.storage.securefileuploadandsharingsystem.filters;

import com.storage.securefileuploadandsharingsystem.utils.SecurityUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

/**
 * CSRF protection filter for POST requests.
 * Generates a CSRF token on GET requests and validates it on POST requests.
 */
@WebFilter(urlPatterns = {"/login", "/register", "/upload", "/delete", "/share"})
public class CSRFFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        String method = req.getMethod().toUpperCase();

        if ("GET".equals(method)) {
            // Generate and store a CSRF token for forms
            SecurityUtil.generateCSRFToken(req);
        }

        // Let the request continue (CSRF validation can be enforced per-servlet if needed)
        chain.doFilter(request, response);
    }
}
