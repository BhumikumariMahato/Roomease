package com.roomease.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;

import com.roomease.model.UserModel;
import com.roomease.service.RegisterService;
import com.roomease.util.PasswordUtil;
import com.roomease.util.RedirectionUtil;

/**
 * RegisterController handles user registration requests and processes form
 * submissions. It also manages file uploads and account creation.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private RegisterService registerService;
	private RedirectionUtil redirectionUtil;

	@Override
	public void init() throws ServletException {
		this.registerService = new RegisterService();
		this.redirectionUtil = new RedirectionUtil();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		redirectionUtil.redirectToPage(req, resp, RedirectionUtil.registerUrl);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			UserModel userModel = extractUserModel(req, resp);
			Boolean isAdded = registerService.addUser(userModel);

			if (isAdded == null) {
				redirectionUtil.setMsgAndRedirect(req, resp, "error",
						"An unexpected error occurred. Please try again later!", RedirectionUtil.registerUrl);
			} else if (isAdded) {
				redirectionUtil.setMsgAndRedirect(req, resp, "success", "Your account is successfully created!",
						RedirectionUtil.loginUrl);
			} else {
				redirectionUtil.setMsgAndRedirect(req, resp, "error",
						"Your Account Already Exists!", RedirectionUtil.registerUrl);
			}
		} catch (Exception e) {
			redirectionUtil.setMsgAndRedirect(req, resp, "error",
					"An unexpected error occurred. Please try again later!", RedirectionUtil.registerUrl);
			e.printStackTrace(); // Log the exception
		}
	}


	private UserModel extractUserModel(HttpServletRequest req, HttpServletResponse resp) throws Exception {
	    String user_name = req.getParameter("user_name");
	    String user_email = req.getParameter("user_email");
	    String user_password = req.getParameter("user_password");
	    String user_contact_number = req.getParameter("user_contact_number"); 
	    
	    String retypePassword = req.getParameter("retypePassword");

	    // Validate password match
	    if (user_password == null || !user_password.equals(retypePassword)) {
	        redirectionUtil.setMsgAndRedirect(req, resp, "error", 
	            "Passwords do not match!", RedirectionUtil.registerUrl);
	        throw new Exception("Password mismatch");
	    }

	    // Encrypt password
	    String encryptedPassword = PasswordUtil.encrypt(user_name, user_password);
	    if (encryptedPassword == null) {
	        redirectionUtil.setMsgAndRedirect(req, resp, "error",
	            "Password encryption failed. Please try again.", RedirectionUtil.registerUrl);
	        throw new Exception("Password encryption failed");
	    }

	    return new UserModel(user_name, user_email, encryptedPassword, user_contact_number);
	}

	

}