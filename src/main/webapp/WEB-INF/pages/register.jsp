<%@ page import="com.roomease.model.UserModel"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Register - Room-ease</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f8f9fa;
	color: #333;
	min-height: 100vh;
}

.welcome-container {
	display: flex;
	min-height: 100vh;
	width: 100%;
}

.welcome-hero {
	flex: 1;
	background: linear-gradient(135deg, #2b5876, #4e4376);
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding: 40px;
	color: white;
	position: relative;
	overflow: hidden;
}

/* Responsive */
@media ( max-width : 900px) {
	.welcome-container {
		flex-direction: column;
	}
	.welcome-hero {
		padding: 30px 20px;
	}
}

.register-section {
	color: #333;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 80px);
	padding: 40px 20px;
	width: 100%;
}

.container {
	background: rgba(255, 255, 255, 0.9);
	backdrop-filter: blur(8px);
	border-radius: 20px;
	padding: 40px;
	max-width: 550px;
	width: 100%;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
	border: 1px solid rgba(255, 255, 255, 0.3);
	text-align: center;
}

.container h1 {
	font-size: 2rem;
	font-weight: 700;
	color: #8b5cf6;
	margin-bottom: 10px;
}

.container p {
	font-size: 1rem;
	color: #4b5563;
	margin-bottom: 20px;
}

.register-form {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.form-group {
	display: flex;
	flex-direction: column;
	text-align: left;
}

.form-group label {
	font-size: 0.95rem;
	font-weight: 600;
	color: #1f2937;
	margin-bottom: 8px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.form-group input {
	padding: 12px;
	border-radius: 8px;
	border: none;
	background: rgba(255, 255, 255, 0.8);
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	font-size: 0.95rem;
	transition: box-shadow 0.3s, transform 0.3s;
}

.form-group input:focus {
	outline: none;
	box-shadow: 0 0 12px rgba(139, 92, 246, 0.5);
	transform: translateY(-2px);
}

.submit-button {
	background: linear-gradient(90deg, #8b5cf6, #f97316);
	color: #fff;
	border: none;
	border-radius: 12px;
	padding: 14px;
	font-size: 1rem;
	font-weight: 600;
	cursor: pointer;
	transition: transform 0.3s, box-shadow 0.3s;
}

.submit-button:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 20px rgba(139, 92, 246, 0.5);
}

.error-message {
	color: #dc2626;
	background: rgba(255, 245, 245, 0.9);
	padding: 12px;
	border-radius: 8px;
	border-left: 4px solid #dc2626;
	margin-bottom: 20px;
	font-size: 0.9rem;
	text-align: left;
}

.success-message {
	color: #22c55e;
	background: rgba(240, 255, 244, 0.9);
	padding: 12px;
	border-radius: 8px;
	border-left: 4px solid #22c55e;
	margin-bottom: 20px;
	font-size: 0.9rem;
	text-align: left;
}

.login-link {
	font-size: 0.9rem;
	color: #4b5563;
	margin-top: 20px;
}

.login-link a {
	color: #8b5cf6;
	text-decoration: none;
	font-weight: 600;
	transition: color 0.3s;
}

.login-link a:hover {
	color: #f97316;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.register-section {
		padding: 20px;
	}
	.container {
		padding: 30px;
	}
	.container h1 {
		font-size: 1.8rem;
	}
	.container p {
		font-size: 0.95rem;
	}
}

@media ( max-width : 480px) {
	.container {
		padding: 20px;
	}
	.container h1 {
		font-size: 1.6rem;
	}
	.form-group label {
		font-size: 0.9rem;
	}
	.form-group input {
		padding: 10px;
	}
	.submit-button {
		padding: 12px;
	}
}
</style>
</head>
<body>
	<div class="welcome-container">
		<div class="welcome-hero">
			<section class="register-section">
				<div class="container">
					<h1>Register for Room-ease</h1>
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
					<p>Create an account to find your perfect rental!</p>
					<form action="${pageContext.request.contextPath}/register"
						method="post" enctype="multipart/form-data" class="register-form">
						<div class="form-group">
							<label for="user_name">Full Name</label> <input type="text"
								id="user_name" name="user_name"
								placeholder="Enter your full name" required>
						</div>
						<div class="form-group">
							<label for="user_email">Email Address</label> <input type="email"
								id="user_email" name="user_email" placeholder="Enter your email"
								required>
						</div>
						<div class="form-group">
							<label for="user_contact_number">Contact Number</label> <input
								type="text" id="user_contact_number" name="user_contact_number"
								placeholder="Enter your phone number" pattern="\d{10,}"
								title="Please enter a valid phone number with at least 10 digits."
								required>
						</div>
						<div class="form-group">
							<label for="user_password">Password</label> <input
								type="password" id="user_password" name="user_password"
								placeholder="Create a password"
								pattern="(?=.*[A-Z])(?=.*[\W_]).{8,}"
								title="Password must be at least 8 characters long, include one uppercase letter, and one special character."
								required>
						</div>
						<div class="form-group">
							<label for="retypePassword">Retype Password</label> <input
								type="password" id="retypePassword" name="retypePassword"
								placeholder="Confirm your password" required>
						</div>
						<button type="submit" class="submit-button">Create
							Account</button>
						<p class="login-link">
							Already have an account? <a href="login.jsp">Log in</a>
						</p>
					</form>
				</div>
			</section>
		</div>
	</div>
</body>
</html>
