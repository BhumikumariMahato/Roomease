<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.roomease.model.ContactModel" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    String contextPath = request.getContextPath();
    List<ContactModel> contactMessages = (List<ContactModel>) request.getAttribute("contactMessages");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Messages</title>
    </head>
    <style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)),
                url('${contextPath}/images/background.png') no-repeat center center fixed;
    background-size: cover;
    color: #fff;
}

.container {
    display: flex;
    min-height: 100vh;
    padding: 20px;
}

.sidebar {
    width: 220px;
    background-color: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(6px);
    padding: 30px 20px;
    border-radius: 12px;
    margin-right: 20px;
    box-shadow: 0 0 10px rgba(0,0,0,0.4);
}

.nav {
    list-style: none;
}

.nav li {
    margin: 20px 0;
}

.nav a {
    text-decoration: none;
    color: #ffcc00;
    font-weight: bold;
    display: flex;
    align-items: center;
    font-size: 16px;
    transition: color 0.3s ease;
}

.nav a:hover {
    color: #fff;
}

.nav .icon {
    margin-right: 10px;
    font-size: 18px;
}

.content {
    flex: 1;
    backdrop-filter: blur(10px);
    background-color: rgba(0, 0, 0, 0.4);
    padding: 40px 35px;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #ffcc00;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.success-message,
.error-message {
    text-align: center;
    margin-bottom: 20px;
    font-size: 14px;
    font-weight: bold;
}

.success-message {
    color: #4CAF50;
}

.error-message {
    color: #ff4d4d;
}

.table-container {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    overflow: hidden;
}

table th,
table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    color: #fff;
}

table th {
    background-color: rgba(0, 0, 0, 0.5);
    color: #ffcc00;
    text-transform: uppercase;
    font-size: 14px;
}

table tr:hover {
    background-color: rgba(255, 255, 255, 0.05);
}

.action-btn {
    background-color: #ff4d4d;
    color: #fff;
    padding: 6px 12px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
    transition: background-color 0.3s ease;
}

.action-btn:hover {
    background-color: #cc0000;
}
    
    </style>
<body>
<div class="container">
<aside class="sidebar">
			<ul class="nav">
				<li><a href="${contextPath}/dashboard"><span class="icon">🏠</span>
						Dashboard</a></li>
				<li><a href="${contextPath}/CustomerController"><span
						class="icon">💳</span> User List</a></li>
				<li><a href="${pageContext.request.contextPath}/logout"><span
						class="icon">🔒</span>Logout</a></li>
			</ul>
		</aside>
   
    <div class="content">
        <h2>All Messages</h2>

        <% if (successMessage != null) { %>
            <div class="success-message"><%= successMessage %></div>
        <% } %>
        <% if (errorMessage != null) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Message</th>
                    <th>User ID</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% if (contactMessages != null && !contactMessages.isEmpty()) {
                    for (ContactModel contact : contactMessages) { %>
                        <tr>
                            <td><%= contact.getContact_form_id() %></td>
                            <td><%= contact.getFirst_name() %></td>
                            <td><%= contact.getLast_name() %></td>
                            <td><%= contact.getForm_email() %></td>
                            <td><%= contact.getForm_message() %></td>
                            <td><%= contact.getUser_ID() != null ? contact.getUser_ID().getUser_ID() : "N/A" %></td>
                            <td>
                                <a class="action-btn"
                                   href="<%= contextPath %>/contact?action=delete&id=<%= contact.getContact_form_id() %>"
                                   onclick="return confirm('Are you sure you want to delete this message?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                <%  }
                   } else { %>
                    <tr>
                        <td colspan="7">No contact messages found.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
