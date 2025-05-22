package com.roomease.util;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RedirectionUtil {

	private static final String baseUrl = "/WEB-INF/pages/";
	public static final String registerUrl = baseUrl + "register.jsp";
	public static final String loginUrl = baseUrl + "login.jsp";
	public static final String aboutUrl = baseUrl + "aboutus.jsp";
	public static final String contactUrl = baseUrl + "contactus.jsp";
	public static final String roomsUrl = baseUrl + "rooms.jsp";
	public static final String dboardUrl = baseUrl + "dashboard.jsp";
	public static final String logoutUrl = baseUrl + "login.jsp";
	public static final String custUrl = baseUrl + "user.jsp";
	public static final String updateUrl = baseUrl + "update.jsp";
	public static final String profileUrl = baseUrl + "profile.jsp";
	public static final String roomdUrl = baseUrl + "roomd.jsp";
	public static final String contactdetailsUrl = baseUrl + "contactdetails.jsp";

	public void setMsgAttribute(HttpServletRequest req, String msgType, String msg) {
		req.setAttribute(msgType, msg);
	}

	public void redirectToPage(HttpServletRequest req, HttpServletResponse resp, String page)
			throws ServletException, IOException {
		req.getRequestDispatcher(page).forward(req, resp);
	}

	public void setMsgAndRedirect(HttpServletRequest req, HttpServletResponse resp, String msgType, String msg,
			String page) throws ServletException, IOException {
		setMsgAttribute(req, msgType, msg);
		redirectToPage(req, resp, page);
	}

}