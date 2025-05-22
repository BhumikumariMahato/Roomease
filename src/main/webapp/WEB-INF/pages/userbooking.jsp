<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.roomease.model.BookingModel"%>
<%@ page import="com.roomease.model.RoomModel"%>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/home.css" />
<title>My Bookings</title>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background:
		url('${pageContext.request.contextPath}/images/background.png')
		no-repeat center center fixed;
	background-size: cover;
}

.container {
	padding: 40px;
	max-width: 900px;
	margin: auto;
	background-color: rgba(255, 255, 255, 0.95);
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	margin-top: 50px;
}

h2 {
	text-align: center;
	margin-bottom: 30px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 12px 15px;
	border: 1px solid #ccc;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

button {
	padding: 6px 12px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>

	<jsp:include page="header.jsp" />
	<div class="container">
		<h2>My Booked Rooms</h2>
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
						<form action="<%=request.getContextPath()%>/RoomDetails"
							method="get" style="display: inline;">
							<input type="hidden" name="id"
								value="<%=booking.getRoom_ID().getRoom_ID()%>" />
							<button type="submit">View Room</button>
						</form>
						<form action="<%=request.getContextPath()%>/book-room"
							method="post" style="display: inline;">
							<input type="hidden" name="booking_ID"
								value="<%=booking.getBooking_ID()%>"> <input
								type="hidden" name="action" value="delete">
							<button type="submit">Delete</button>
						</form>
					</td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="7" style="text-align: center;">No bookings found.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>
