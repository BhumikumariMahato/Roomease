package com.roomease.controller;

import java.io.IOException;

import com.roomease.model.UserModel;
import com.roomease.service.LoginService;
import com.roomease.util.CookiesUtil;
import com.roomease.util.SessionUtil;
import com.roomease.util.RedirectionUtil;
import com.roomease.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, urlPatterns = { "/login", "/" })
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ValidationUtil validationUtil;
	private RedirectionUtil redirectionUtil;
	private LoginService loginService;

	@Override
	public void init() throws ServletException {
		this.validationUtil = new ValidationUtil();
		this.redirectionUtil = new RedirectionUtil();
		this.loginService = new LoginService();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher(RedirectionUtil.loginUrl).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String user_name = req.getParameter("user_name");
		String user_password = req.getParameter("user_password");

		if (!validationUtil.isNullOrEmpty(user_name) && !validationUtil.isNullOrEmpty(user_password)) {
			UserModel userModel = new UserModel(user_name, user_password);
			UserModel loggedInUser = loginService.loginUser(userModel);

			if (loggedInUser != null) {
				String role = loggedInUser.getUser_role();
				SessionUtil.setAttribute(req, "user_name", user_name);
				SessionUtil.setAttribute(req, "customer", loggedInUser);
				CookiesUtil.addCookie(resp, "role", role, 5 * 60);

				if ("admin".equalsIgnoreCase(role)) {
					resp.sendRedirect(req.getContextPath() + "/dashboard");
				} else {
					resp.sendRedirect(req.getContextPath() + "/home");

				}
			} else {
				handleLoginFailure(req, resp, loggedInUser != null);
			}
		} else {
			redirectionUtil.setMsgAndRedirect(req, resp, "error", "Please fill all the fields!",
					RedirectionUtil.loginUrl);
		}
	}

	private void handleLoginFailure(HttpServletRequest req, HttpServletResponse resp, Boolean loginStatus)
			throws ServletException, IOException {
		String errorMessage;
		if (loginStatus == null) {
			errorMessage = "Our server is under maintenance. Please try again later!";
		} else {
			errorMessage = "User credential mismatch. Please try again!";
		}
		req.setAttribute("error", errorMessage);
		req.getRequestDispatcher(RedirectionUtil.loginUrl).forward(req, resp);
	}
}