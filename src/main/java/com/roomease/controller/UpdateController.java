package com.roomease.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.roomease.model.UserModel;
import com.roomease.service.CustomerService;
import com.roomease.util.RedirectionUtil;
import com.roomease.util.ValidationUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/Update" })
public class UpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final CustomerService customerService = new CustomerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int user_ID;
        try {
            user_ID = Integer.parseInt(request.getParameter("user_ID"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID.");
            return;
        }

        UserModel user = customerService.getSpecificUserInfo(user_ID);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher(RedirectionUtil.updateUrl).forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int user_ID;
        try {
            user_ID = Integer.parseInt(request.getParameter("user_ID"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID.");
            return;
        }

        switch (action) {
            case "updateForm":
                handleUpdateForm(request, response, user_ID);
                break;
            case "update":
                handleUpdate(request, response, user_ID);
                break;
            case "delete":
                handleDelete(request, response, user_ID);
                break;
            default:
                request.setAttribute("error", "Unsupported action: " + action);
                request.getRequestDispatcher(RedirectionUtil.updateUrl).forward(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, int user_ID)
            throws ServletException, IOException {
        String validationMessage = validateUpdateForm(request);
        if (validationMessage != null) {
            request.setAttribute("error", validationMessage);
            doGet(request, response); // reload form with error
            return;
        }

        String user_name = request.getParameter("user_name");
        String user_email = request.getParameter("user_email");
        String user_contact_number = request.getParameter("user_contact_number");

        UserModel user = new UserModel(user_ID, user_name, user_email, user_contact_number);
        boolean success = customerService.updateUser(user);

        if (success) {
            request.setAttribute("success", "User information updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update user information.");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher(RedirectionUtil.updateUrl).forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, int user_ID)
            throws ServletException, IOException {
        boolean success = customerService.deleteUser(user_ID);
        if (success) {
            System.out.println("Deletion successful");
        } else {
            System.out.println("Deletion failed");
        }
        response.sendRedirect(request.getContextPath() + "/CustomerController");
    }

    private void handleUpdateForm(HttpServletRequest request, HttpServletResponse response, int user_ID)
            throws IOException {
        UserModel user = customerService.getSpecificUserInfo(user_ID);
        if (user != null) {
            response.sendRedirect(request.getContextPath() + "/Update?user_ID=" + user_ID);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found with ID: " + user_ID);
        }
    }

    private String validateUpdateForm(HttpServletRequest request) {
        String user_name = request.getParameter("user_name");
        String user_email = request.getParameter("user_email");
        String user_contact_number = request.getParameter("user_contact_number");

        if (ValidationUtil.isNulOrEmpty(user_name))
            return "User name is required.";
        if (ValidationUtil.isNulOrEmpty(user_email))
            return "Email is required.";
        if (ValidationUtil.isNulOrEmpty(user_contact_number))
            return "Contact number is required.";

        if (!ValidationUtil.isAlphanuericStartingWithLetter(user_name))
            return "Name must start with a letter and contain only letters and numbers.";
        if (!ValidationUtil.isValiEmail(user_email))
            return "Invalid email format.";
        if (!ValidationUtil.isValiPhoneNumber(user_contact_number))
            return "Phone number must be 10 digits and start with 98.";

        return null;
    }
}
