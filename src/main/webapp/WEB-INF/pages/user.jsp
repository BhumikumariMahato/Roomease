<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Management</title>
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
		url('${contextPath}/images/background.png') no-repeat center center
		fixed;
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
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
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
	backdrop-filter: blur(10px);
	background-color: rgba(0, 0, 0, 0.4);
	padding: 40px 35px;
	border-radius: 15px;
	width: 100%;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

h2, h3 {
	text-align: center;
	margin-bottom: 30px;
	color: #ffcc00;
	text-transform: uppercase;
	letter-spacing: 1px;
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

.table-container {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	background-color: rgba(255, 255, 255, 0.95);
	color: #333;
	border-radius: 10px;
	overflow: hidden;
}

th, td {
	padding: 14px 16px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #ffcc00;
	color: #000;
	text-transform: uppercase;
	font-size: 14px;
}

tr:hover {
	background-color: #f2f2f2;
}

.action-btn {
	background-color: #ffcc00;
	color: #000;
	padding: 6px 14px;
	margin: 2px;
	border: none;
	border-radius: 6px;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.action-btn:hover {
	background-color: #e6b800;
	transform: translateY(-1px);
}
</style>
</head>
<body>

	<div class="container">
		<div class="sidebar">
			<ul class="nav">
				<li><a href="${contextPath}/dashboard"><span class="icon">🏠</span>
						Dashboard</a></li>
				<li><a href="${contextPath}/logout"><span class="icon">🔒</span>Logout</a></li>
			</ul>
		</div>

		<div class="content">
			<h3>User List</h3>

			<c:if test="${not empty error}">
				<p class="error-message">${error}</p>
			</c:if>

			<c:if test="${not empty success}">
				<p class="success-message">${success}</p>
			</c:if>

			<div class="table-container">
				<table>
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Number</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${userList}">
							<tr>
								<td>${user.user_ID}</td>
								<td>${user.user_name}</td>
								<td>${user.user_email}</td>
								<td>${user.user_contact_number}</td>
								<td>
									<form action="${contextPath}/Update" method="post"
										style="display: inline;">
										<input type="hidden" name="user_ID" value="${user.user_ID}">
										<input type="hidden" name="action" value="updateForm">
										<button class="action-btn" type="submit">Edit</button>
									</form>
									<form action="${contextPath}/Update" method="post"
										style="display: inline;">
										<input type="hidden" name="user_ID" value="${user.user_ID}">
										<input type="hidden" name="action" value="delete">
										<button class="action-btn" type="submit">Delete</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

</body>
</html>
