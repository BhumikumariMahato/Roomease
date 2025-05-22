<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.roomease.model.RoomModel"%>
<%@ page import="com.roomease.model.UserModel"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Room Details - Room-ease</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/room.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
</head>

<style>
body {
	background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)),
	url('${pageContext.request.contextPath}/images/background.png') no-repeat center center fixed;
	background-size: cover;
	color: #333;
}

</style>

<body>

<%
	UserModel customer = (UserModel) session.getAttribute("customer");
	boolean isUserLoggedIn = customer != null;
	String fullName = isUserLoggedIn ? customer.getUser_name() : "";
	String email = isUserLoggedIn && customer.getUser_email() != null ? customer.getUser_email() : "";
%>


	<jsp:include page="header.jsp" />

<%
RoomModel room = (RoomModel) request.getAttribute("room");
if (room != null) {
%>

<section class="hero">
	<div class="hero-overlay">
		<h1><%=room.getRoom_type()%> in <%=room.getLocation_ID().getLocation_area()%></h1>
		<p>Comfortable and Convenient Living in <%=room.getLocation_ID().getLocation_city()%></p>
	</div>
</section>

<section class="gallery">
	<div class="container">
		<h2>Explore the Room</h2>
		<div class="gallery-grid">
			<img class="gallery-image" src="<%= request.getContextPath() + "/" + room.getImage_path() %>" />

		</div>
	</div>
</section>

<section class="room-details">
	<div class="container">
		<!-- Left Column -->
		<div class="details-left">
			<div class="section">
				<h2>About This Room</h2>
				<p><%=room.getRoom_description()%></p>
			</div>
			<div class="section">
				<h2>Amenities</h2>
				<ul class="amenities-list">
					<li><%=room.getRoom_facilities() != null ? room.getRoom_facilities() : "Not specified"%></li>
				</ul>
			</div>
			<div class="section">
				<h2>Location</h2>
				<p><%=room.getLocation_ID().getLocation_area()%>, <%=room.getLocation_ID().getLocation_city()%></p>
			</div>
		</div>

		<!-- Right Column -->
		<div class="details-right">
			<div class="pricing-card">
				<h2>Pricing</h2>
				<p class="price">Rs <%=room.getPrice_ID().getPrice_monthly()%> / month</p>
				<p class="status <%=room.getRoom_status().equalsIgnoreCase("Available") ? "available" : "unavailable"%>">
					<%=room.getRoom_status()%>
				</p>
				<p><strong>Size:</strong> <%=room.getRoom_size()%> sq ft</p>
				<p><strong>Furnished:</strong> <%=room.getRoom_furnishing()%></p>
				<p><strong>Deposit:</strong> Rs <%=room.getPrice_ID().getPrice_deposit_amount()%></p>
			</div>

			<c:if test="${room.room_status eq 'Available'}">
				<div class="booking-form">
					<h2>Request to Book</h2>

					<c:choose>
						<c:when test="${sessionScope.customer != null}">
							<form action="${pageContext.request.contextPath}/book-room" method="post">
								<input type="hidden" name="room_ID" value="<%=room.getRoom_ID()%>" />
								<input type="hidden" name="action" value="book" />

								<label for="name">Full Name</label>
								<input type="text" id="name" name="name" value="<%=fullName%>" required />

								<label for="email">Email</label>
								<input type="email" id="email" name="email" value="<%=email%>" required />

								<label for="checkin">Check-in Date</label>
								<input type="date" id="checkin" name="checkin" required />

								<button type="submit" class="submit-button">Submit Request</button>

								<c:if test="${param.success == 'bookingSubmitted'}">
									<div class="alert alert-success">Booking request submitted successfully!</div>
								</c:if>
								<c:if test="${param.error == 'bookingFailed'}">
									<div class="alert alert-danger">Booking failed. Please try again.</div>
								</c:if>
								<c:if test="${param.error == 'alreadyBooked'}">
									<div class="alert alert-warning">You have already requested a booking for this room.</div>
								</c:if>
							</form>
						</c:when>
						<c:otherwise>
							<p>Please <a href="${pageContext.request.contextPath}/login">log in</a> to request a booking.</p>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
	</div>
</section>

<% } else { %>
<section class="room-details">
	<div class="container">
		<h2>Room details not available.</h2>
		<a href="<%=request.getContextPath()%>/rooms">← Back to rooms</a>
	</div>
</section>
<% } %>


	<jsp:include page="footer.jsp" />


</body>
</html>
