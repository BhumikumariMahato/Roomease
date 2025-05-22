package com.roomease.controller;

import com.roomease.model.ContactModel;
import com.roomease.model.UserModel;
import com.roomease.service.ContactusService;
import com.roomease.util.RedirectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/contact" })
public class ContactusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ContactusService contactService;

	public ContactusController() {
		super();
		contactService = new ContactusService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UserModel user = (session != null) ? (UserModel) session.getAttribute("customer") : null;

		if (user == null) {
			request.setAttribute("errorMessage", "You must be logged in.");
			request.getRequestDispatcher(RedirectionUtil.contactUrl).forward(request, response);
			return;
		}

		String role = user.getUser_role();

		if ("admin".equalsIgnoreCase(role)) {
			String action = request.getParameter("action");
			if ("delete".equalsIgnoreCase(action)) {
				try {
					int contactId = Integer.parseInt(request.getParameter("id"));
					contactService.deleteContactById(contactId);
					request.setAttribute("successMessage", "Contact message deleted.");
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("errorMessage", "Failed to delete contact message.");
				}
			}

			List<ContactModel> contacts = contactService.getContacts();
			request.setAttribute("contactMessages", contacts);
			request.getRequestDispatcher(RedirectionUtil.contactdetailsUrl).forward(request, response);

		} else {
			request.getRequestDispatcher(RedirectionUtil.contactUrl).forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UserModel user = (session != null) ? (UserModel) session.getAttribute("customer") : null;

		if (user == null) {
			request.setAttribute("errorMessage", "You must be logged in to submit the contact form.");
			request.getRequestDispatcher(RedirectionUtil.contactUrl).forward(request, response);
			return;
		}

		if (!"admin".equalsIgnoreCase(user.getUser_role())) {
			String firstName = request.getParameter("first_name");
			String lastName = request.getParameter("last_name");
			String email = request.getParameter("form_email");
			String message = request.getParameter("form_message");

			ContactModel contact = new ContactModel();
			contact.setFirst_name(firstName);
			contact.setLast_name(lastName);
			contact.setForm_email(email);
			contact.setForm_message(message);
			contact.setUser_ID(user);

			try {
				contactService.insertContact(contact);
				request.setAttribute("successMessage", "Your message has been submitted.");
			} catch (SQLException e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", "Failed to submit your message.");
			}
		} else {
			request.setAttribute("errorMessage", "Admins are not allowed to submit contact messages.");
		}

		request.getRequestDispatcher(RedirectionUtil.contactUrl).forward(request, response);
	}
}
