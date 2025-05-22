package com.roomease.controller;

import com.roomease.model.UserModel;
import com.roomease.service.CustomerService;
import com.roomease.util.PasswordUtil;
import com.roomease.util.RedirectionUtil;
import com.roomease.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = { "/Profile" })
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CustomerService customerService = new CustomerService();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = (String) SessionUtil.getAttribute(request, "user_name");

		if (username == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		UserModel user = customerService.getUserByUsername(username);
		if (user != null) {
			String decryptedPassword = PasswordUtil.decrypt(user.getUser_password(), username);
			user.setUser_password(decryptedPassword);
			request.setAttribute("user", user);
		} else {
			request.setAttribute("error", "User not found.");
		}

		UserModel customer = (UserModel) SessionUtil.getAttribute(request, "customer");
		request.setAttribute("customer", customer);

		request.getRequestDispatcher(RedirectionUtil.profileUrl).forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String username = (String) SessionUtil.getAttribute(request, "user_name");

	    if (username == null) {
	        response.sendRedirect(request.getContextPath() + "/login");
	        return;
	    }

	    UserModel existingUser = customerService.getUserByUsername(username);
	    if (existingUser == null) {
	        request.setAttribute("error", "Unable to load user data.");
	        request.getRequestDispatcher(RedirectionUtil.profileUrl).forward(request, response);
	        return;
	    }

	    String name = request.getParameter("user_name");
	    String email = request.getParameter("user_email");
	    String password = request.getParameter("user_password");
	    String confirmPassword = request.getParameter("confirm_password");
	    String contact = request.getParameter("user_contact_number");

	    if (!password.equals(confirmPassword)) {
	        request.setAttribute("error", "Passwords do not match.");
	        existingUser.setUser_name(name);
	        existingUser.setUser_email(email);
	        existingUser.setUser_password(password);
	        existingUser.setUser_contact_number(contact);

	        request.setAttribute("user", existingUser);
	        request.setAttribute("customer", SessionUtil.getAttribute(request, "customer"));
	        request.getRequestDispatcher(RedirectionUtil.profileUrl).forward(request, response);
	        return;
	    }

	    try {
	        String encryptedPassword = PasswordUtil.encrypt(name, password);

	        existingUser.setUser_name(name);
	        existingUser.setUser_email(email);
	        existingUser.setUser_password(encryptedPassword);
	        existingUser.setUser_contact_number(contact);

	        boolean updated = customerService.updateUserinfo(existingUser);

	        if (updated) {
	            request.setAttribute("success", "Profile updated successfully!");
	        } else {
	            request.setAttribute("error", "Profile update failed.");
	        }

	        String decryptedPassword = PasswordUtil.decrypt(encryptedPassword, name);
	        existingUser.setUser_password(decryptedPassword);

	    } catch (Exception e) {
	        request.setAttribute("error", "Encryption error: " + e.getMessage());

	        existingUser.setUser_password(password);
	    }

	    request.setAttribute("user", existingUser);
	    request.setAttribute("customer", SessionUtil.getAttribute(request, "customer"));
	    request.getRequestDispatcher(RedirectionUtil.profileUrl).forward(request, response);
	}
}
