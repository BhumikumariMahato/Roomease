<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.roomease.model.UserModel"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to RoomEase - Find Your Perfect Rental</title>
<link rel="stylesheet" type="text/css"
    href="${pageContext.request.contextPath}/css/login.css" />
</head>

<body>
    <div class="welcome-container">
    <!-- Left Column - Image/Content -->
    <div class="welcome-hero">
        <div class="welcome-content">
            <h1>Find Your Perfect Room</h1>
            <p class="tagline">Browse thousands of rooms for rent across the city</p>
            
            <div class="features">
                <div class="feature-item">
                    <span class="icon">✓</span> Verified listings
                </div>
                <div class="feature-item">
                    <span class="icon">✓</span> Safe and secure
                </div>
                <div class="feature-item">
                    <span class="icon">✓</span> Affordable options
                </div>
            </div>
        </div>
    </div>

        <div class="login-box">
            <%
            String errorMessage = (String) request.getAttribute("error");
            String successMessage = (String) request.getAttribute("success");

            if (errorMessage != null && !errorMessage.isEmpty()) {
                out.println("<p class=\"error-message\">" + errorMessage + "</p>");
            }

            if (successMessage != null && !successMessage.isEmpty()) {
            %>
            <p class="success-message"><%=successMessage%></p>
            <%
            }
            %>

            <h2>Access Your Account</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="row">
                    <div class="col">
                        <label for="user_name">Name:</label>
                        <input type="text" id="user_name" name="user_name" placeholder="Enter your name" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <label for="user_password">Password:</label>
                        <input type="password" id="user_password" name="user_password" placeholder="Enter your password" required>
                    </div>
                </div>
                <div class="row">
                    <button type="submit" class="login-button">Sign In</button>
                </div>
            </form>

            <div class="divider">New to RoomEase?</div>

            <div class="row">
                <a href="${pageContext.request.contextPath}/register"
                    class="register-button">Create Account</a>
            </div>
        </div>
    </div>
</body>
</html>