package com.roomease.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.roomease.service.CustomerService;
import com.roomease.util.RedirectionUtil;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(asyncSupported = true, urlPatterns = { "/CustomerController" })
public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(CustomerController.class.getName());

    private final CustomerService customerService = new CustomerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var userList = customerService.getAllUserInfo();
        if (userList.isEmpty()) {
            request.setAttribute("error", "No users found.");
        } else {
            request.setAttribute("userList", userList);
        }
        request.getRequestDispatcher(RedirectionUtil.custUrl).forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST not supported.");
    }

	public static Logger getLogger() {
		return logger;
	}
}
