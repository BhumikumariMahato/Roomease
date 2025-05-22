<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${requestScope.user}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Update User</title>
</head>
<style>


* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

 body {
        margin: 0;
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

    .content {
        backdrop-filter: blur(10px);
        background-color: rgba(0, 0, 0, 0.4);
        padding: 40px 35px;
        border-radius: 15px;
        width: 100%; /* Increased width */
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
    }

    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #ffcc00;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    label {
        display: block;
        margin: 15px 0 6px;
        font-weight: 600;
        font-size: 14px;
        color: #f5f5f5;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 11px 12px;
        margin-bottom: 10px;
        border: none;
        border-radius: 8px;
        background-color: #ffffff;
        color: #333;
        font-size: 14px;
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
    }

    .toggle-icon {
        position: absolute;
        top: 50%;
        right: 12px;
        transform: translateY(-50%);
        cursor: pointer;
        font-size: 16px;
        color: #333;
    }

    .form-buttons {
        text-align: center;
        margin-top: 25px;
    }

    button[type="submit"] {
        background-color: #ffcc00;
        color: #000;
        padding: 12px 28px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    button[type="submit"]:hover {
        background-color: #e6b800;
        transform: translateY(-1px);
    }

    .message {
        text-align: center;
        margin-bottom: 20px;
        font-size: 14px;
    }

    .error-message {
        color: #ff4d4d;
    }

    .success-message {
        color: #4CAF50;
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

		<main class="content">
			<h2>Update User Information</h2>

			<!-- Error message -->
			<c:if test="${not empty error}">
				<div class="error-message" style="color: red; margin-bottom: 1rem;">
					${error}</div>
			</c:if>

			<!-- Success message -->
			<c:if test="${not empty success}">
				<div class="success-message"
					style="color: green; margin-bottom: 1rem;">${success}</div>
			</c:if>

			<form action="${contextPath}/Update" method="post"
				class="update-form">
				<input type="hidden" name="action" value="update" /> <input
					type="hidden" name="user_ID" value="${user.user_ID}" />

				<div class="row">
					<div class="col">
						<label for="user_name">Name:</label> <input type="text"
							id="user_name" name="user_name" value="${user.user_name}"
							required />
					</div>

					<div class="col">
						<label for="user_email">Email:</label> <input type="email"
							id="user_email" name="user_email" value="${user.user_email}"
							required />
					</div>
				</div>

				<div class="row">
					<div class="col">
						<label for="user_contact_number">Contact Number:</label> <input
							type="text" id="user_contact_number" name="user_contact_number"
							value="${user.user_contact_number}" required />
					</div>
				</div>

				<div class="form-buttons">
					<button type="submit">Update User Details</button>
				</div>
			</form>
		</main>
	</div>

</body>
</html>
