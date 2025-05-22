<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.roomease.model.BookingModel"%>
<%@ page import="com.roomease.model.RoomModel"%>
<html>
<head>
<title>Booked Rooms</title>
<style>
body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
		url('${pageContext.request.contextPath}/images/background.png')
		no-repeat center center fixed;
	background-size: cover;
	color: #fff;
	min-height: 100vh;
}

.overlay {
	display: flex;
	width: 100%;
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

.main-content {
	flex: 1;
	padding: 40px;
}

.card {
	background-color: rgba(0, 0, 0, 0.4);
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
	backdrop-filter: blur(8px);
}

h2 {
	text-align: center;
	margin-bottom: 30px;
	color: #ffcc00;
	text-transform: uppercase;
	letter-spacing: 1px;
}

table {
	width: 100%;
	border-collapse: collapse;
	background-color: rgba(255, 255, 255, 0.1);
}

th, td {
	padding: 12px 15px;
	border: 1px solid #555;
	text-align: center;
	color: #fff;
}

th {
	background-color: rgba(255, 204, 0, 0.8);
	color: #000;
}

tr:nth-child(even) {
	background-color: rgba(255, 255, 255, 0.05);
}

.action-btn, button {
	padding: 8px 16px;
	background-color: #ffcc00;
	color: #000;
	border: none;
	border-radius: 6px;
	font-weight: 600;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.action-btn:hover, button:hover {
	background-color: #e6b800;
	transform: translateY(-1px);
}
</style>
</head>
<body>
	<div class="overlay">
		<aside class="sidebar">
			<ul class="nav">
				<li><a href="${pageContext.request.contextPath}/dashboard"><span
						class="icon">🏠</span> Dashboard</a></li>
				<li><a href="${pageContext.request.contextPath}/logout"><span
						class="icon">🔒</span> Logout</a></li>
			</ul>
		</aside>

		<div class="main-content">
			<div class="card">
				<h2>Booked Room Details</h2>
				<table>
					<thead>
						<tr>
							<th>Booking ID</th>
							<th>Full Name</th>
							<th>Email</th>
							<th>Check-in Date</th>
							<th>Booking Date</th>
							<th>Room ID</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<BookingModel> bookings = (List<BookingModel>) request.getAttribute("bookings");
						if (bookings != null && !bookings.isEmpty()) {
							for (BookingModel booking : bookings) {
						%>
						<tr>
							<td><%=booking.getBooking_ID()%></td>
							<td><%=booking.getFull_name()%></td>
							<td><%=booking.getEmail()%></td>
							<td><%=booking.getCheckin_date()%></td>
							<td><%=booking.getBooking_date()%></td>
							<td><%=booking.getRoom_ID().getRoom_ID()%></td>
							<td>
								<form action="<%=request.getContextPath()%>/book-room"
									method="post" style="display: inline;">
									<input type="hidden" name="booking_ID"
										value="<%=booking.getBooking_ID()%>"> <input
										type="hidden" name="action" value="delete">
									<button class="action-btn" type="submit">Delete</button>
								</form>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="7" style="text-align: center;">No bookings
								found.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
