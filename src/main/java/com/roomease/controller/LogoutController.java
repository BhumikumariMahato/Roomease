package com.roomease.controller;

import java.io.IOException;

import com.roomease.util.CookiesUtil;
import com.roomease.util.RedirectionUtil;
import com.roomease.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, urlPatterns = { "/logout" })
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 💡 Prevent browser caching of the previous pages
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // Invalidate session and delete cookies
        CookiesUtil.deleteCookie(response, "role");
        SessionUtil.invalidateSession(request);
        
        // Redirect to login page
        request.getRequestDispatcher(RedirectionUtil.loginUrl).forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // For POST requests, do the same as GET
        doGet(request, response);
    }
}
