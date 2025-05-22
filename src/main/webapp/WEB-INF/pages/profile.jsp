<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${requestScope.user}" />
<c:set var="customer" value="${requestScope.customer}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Update Profile</title>
<link rel="stylesheet" type="text/css"
	href="${contextPath}/css/footer.css" />
<style>
body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)),
		url('${contextPath}/images/background.png') no-repeat center center
		fixed;
	background-size: cover;
	color: #fff;
}

.page-wrapper {
	display: flex;
	min-height: 100vh;
}

.sidebar {
	width: 220px;
	background-color: rgba(0, 0, 0, 0.7);
	backdrop-filter: blur(6px);
	padding: 30px 20px;
	border-radius: 12px;
	margin-right: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
	height: 100vh;
	position: sticky;
	top: 0;
}

.sidebar .nav {
	list-style: none;
}

.sidebar .nav li {
	margin: 20px 0;
}

.sidebar .nav li a {
	text-decoration: none;
	color: #ffcc00;
	font-weight: bold;
	display: flex;
	align-items: center;
	font-size: 16px;
	transition: color 0.3s ease;
}

.sidebar .nav li a:hover {
	color: #fff;
}

.sidebar .nav li a .icon {
	margin-right: 10px;
	font-size: 18px;
}

.container {
	flex-grow: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 30px 20px;
	min-height: calc(100vh - 100px);
}

.content {
	backdrop-filter: blur(10px);
	background-color: rgba(0, 0, 0, 0.4);
	padding: 40px 35px;
	border-radius: 15px;
	width: 100%;
	max-width: 650px;
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

input[type="text"], input[type="email"], input[type="password"] {
	width: 100%;
	padding: 11px 12px;
	margin-bottom: 10px;
	border: none;
	border-radius: 8px;
	background-color: #ffffff;
	color: #333;
	font-size: 14px;
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
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
</style>

</head>
<body>

	<c:choose>
		<c:when test="${customer != null && customer.user_role == 'admin'}">
			<div class="page-wrapper">
				<aside class="sidebar">
					<ul class="nav">
						<li><a href="${contextPath}/dashboard"><span class="icon">🏠</span>
								Dashboard</a></li>
						<li><a href="${contextPath}/logout"><span class="icon">🔒</span>
								Logout</a></li>
					</ul>
				</aside>
				<div class="container">
					<main class="content">
						<h2>Update Your Profile</h2>

						<c:if test="${not empty error}">
							<div class="message error-message">${error}</div>
						</c:if>

						<c:if test="${not empty success}">
							<div class="message success-message">${success}</div>
						</c:if>

						<c:if test="${user != null}">
							<form action="${contextPath}/Profile" method="post"
								class="update-form">
								<label for="user_name">Name:</label> <input type="text"
									id="user_name" name="user_name" value="${user.user_name}"
									required /> <label for="user_email">Email:</label> <input
									type="email" id="user_email" name="user_email"
									value="${user.user_email}" required /> <label
									for="user_password">Password:</label>
								<div style="position: relative;">
									<input type="password" id="user_password" name="user_password"
										value="${user.user_password}" required /> <span
										class="toggle-icon"
										onclick="togglePassword('user_password', this)">🔒</span>
								</div>

								<label for="confirm_password">Confirm Password:</label>
								<div style="position: relative;">
									<input type="password" id="confirm_password"
										name="confirm_password" required /> <span class="toggle-icon"
										onclick="togglePassword('confirm_password', this)">🔒</span>
								</div>

								<label for="user_contact_number">Contact Number:</label> <input
									type="text" id="user_contact_number" name="user_contact_number"
									value="${user.user_contact_number}" required />

								<div class="form-buttons">
									<button type="submit">Update Details</button>
								</div>
							</form>
						</c:if>

						<c:if test="${user == null}">
							<div class="message error-message">User data not available.
								Please log in again.</div>
						</c:if>
					</main>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<jsp:include page="header.jsp" />
			<div class="container">
				<main class="content">
					<h2>Update Your Profile</h2>

					<c:if test="${not empty error}">
						<div class="message error-message">${error}</div>
					</c:if>

					<c:if test="${not empty success}">
						<div class="message success-message">${success}</div>
					</c:if>

					<c:if test="${user != null}">
						<form action="${contextPath}/Profile" method="post"
							class="update-form">
							<label for="user_name">Name:</label> <input type="text"
								id="user_name" name="user_name" value="${user.user_name}"
								required /> <label for="user_email">Email:</label> <input
								type="email" id="user_email" name="user_email"
								value="${user.user_email}" required /> <label
								for="user_password">Password:</label>
							<div style="position: relative;">
								<input type="password" id="user_password" name="user_password"
									value="${user.user_password}" required /> <span
									class="toggle-icon"
									onclick="togglePassword('user_password', this)">🔒</span>
							</div>

							<label for="confirm_password">Confirm Password:</label>
							<div style="position: relative;">
								<input type="password" id="confirm_password"
									name="confirm_password" required /> <span class="toggle-icon"
									onclick="togglePassword('confirm_password', this)">🔒</span>
							</div>

							<label for="user_contact_number">Contact Number:</label> <input
								type="text" id="user_contact_number" name="user_contact_number"
								value="${user.user_contact_number}" required />

							<div class="form-buttons">
								<button type="submit">Update Details</button>
							</div>
						</form>
					</c:if>

					<c:if test="${user == null}">
						<div class="message error-message">User data not available.
							Please log in again.</div>
					</c:if>
				</main>
			</div>
			<jsp:include page="footer.jsp" />
		</c:otherwise>
	</c:choose>

	<script>
		function togglePassword(id, el) {
			const input = document.getElementById(id);
			if (input.type === "password") {
				input.type = "text";
				el.textContent = "🔓";
			} else {
				input.type = "password";
				el.textContent = "🔒";
			}
		}
	</script>

</body>
</html>
