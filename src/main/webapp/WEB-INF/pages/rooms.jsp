<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.roomease.model.RoomModel"%>

<%
List<com.roomease.model.LocationModel> locations = (List<com.roomease.model.LocationModel>) request
		.getAttribute("locations");
List<com.roomease.model.PriceModel> prices = (List<com.roomease.model.PriceModel>) request.getAttribute("prices");

String selectedLocation = request.getParameter("location_ID");
String selectedPrice = request.getParameter("price_ID");
String selectedStatus = request.getParameter("room_status");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Room-ease</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)),
		url('${pageContext.request.contextPath}/images/background.png')
		no-repeat center center fixed;
	background-size: cover;
	min-height: 100vh;
	width: 100%;
}

.container {
	width: 100%;
	background: rgba(255, 255, 255, 0.85);
	backdrop-filter: blur(8px);
	padding: 30px;
	margin: 20px auto 0;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	border: 1px solid rgba(255, 255, 255, 0.3);
}

.container form {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	align-items: flex-end;
	gap: 20px;
}

.container form>div {
	flex: 1;
	min-width: 220px;
	display: flex;
	flex-direction: column;
}

.container label {
	font-weight: 700;
	margin-bottom: 10px;
	color: #1f2937;
	font-size: 1rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.container select {
	height: 50px;
	border-radius: 12px;
	border: none;
	padding: 0 20px;
	font-size: 0.95rem;
	background: rgba(255, 255, 255, 0.9);
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	transition: box-shadow 0.3s, transform 0.3s;
}

.container select:focus {
	outline: none;
	box-shadow: 0 0 12px rgba(124, 58, 237, 0.5);
	transform: translateY(-2px);
}

.container button {
	background: linear-gradient(90deg, #7c3aed, #f97316);
	color: #fff;
	border: none;
	border-radius: 12px;
	padding: 14px 30px;
	cursor: pointer;
	font-weight: 600;
	font-size: 1rem;
	transition: transform 0.3s, box-shadow 0.3s;
	animation: pulse 2s infinite;
}

.container button:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 20px rgba(124, 58, 237, 0.5);
}

@
keyframes pulse { 0% {
	transform: scale(1);
}

50
%
{
transform
:
scale(
1.02
);
}
100
%
{
transform
:
scale(
1
);
}
}
.room-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	margin: 40px auto;
	padding: 0 20px;
	justify-content: center;
}

.room-card {
	position: relative;
	background: rgba(255, 255, 255, 0.9);
	backdrop-filter: blur(8px);
	border-radius: 20px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
	overflow: hidden;
	padding: 20px;
	min-height: 550px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	transition: transform 0.4s ease, box-shadow 0.4s ease;
	border: 2px solid transparent;
	background: linear-gradient(rgba(255, 255, 255, 0.9),
		rgba(255, 255, 255, 0.9)) padding-box,
		linear-gradient(45deg, #7c3aed, #f97316) border-box;
}

.room-card:hover {
	transform: translateY(-10px) scale(1.02);
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
}

.room-card img {
	width: 100%;
	height: 220px;
	object-fit: cover;
	border-radius: 16px;
	margin-bottom: 15px;
	border: 2px solid rgba(124, 58, 237, 0.3);
	transition: transform 0.5s ease;
	flex-shrink: 0;
}

.room-card:hover img {
	transform: scale(1.1);
}

.room-card .status {
	position: absolute;
	top: 15px;
	right: 15px;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.8rem;
	font-weight: 600;
	color: #fff;
}

.room-card .status.available {
	background: #22c55e;
}

.room-card .status.occupied {
	background: #dc2626;
}

.room-card h3 {
	color: #1f2937;
	font-size: 1.8rem;
	font-weight: 700;
	margin-bottom: 12px;
	letter-spacing: 0.5px;
}

.room-card p {
	color: #4b5563;
	margin: 8px 0;
	font-size: 0.95rem;
	line-height: 1.5;
}

.room-card .button {
	display: block;
	width: 100%;
	padding: 14px;
	background: linear-gradient(90deg, #7c3aed, #f97316);
	color: #fff;
	text-align: center;
	border-radius: 12px;
	border: none;
	font-weight: 600;
	font-size: 1rem;
	cursor: pointer;
	transition: transform 0.3s, box-shadow 0.3s;
}

.room-card .button:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 20px rgba(124, 58, 237, 0.5);
}

@media ( max-width : 1024px) {
	.container form {
		flex-direction: column;
		align-items: stretch;
	}
	.container button {
		width: 100%;
		margin-top: 10px;
	}
}

@media ( max-width : 768px) {
	.room-container {
		grid-template-columns: 1fr;
		padding: 20px;
	}
	.room-card {
		max-width: 100%;
	}
}

@media ( max-width : 480px) {
	body {
		padding: 15px;
	}
	.container {
		padding: 15px;
	}
	.room-card img {
		height: 200px;
	}
	.room-card h3 {
		font-size: 1.6rem;
	}
	.room-card p {
		font-size: 0.9rem;
	}
	.room-card .button {
		padding: 12px;
	}
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container">
		<form method="get" action="${pageContext.request.contextPath}/home">
			<div>
				<label for="location">Choose your Location:</label> <select
					name="location_ID" id="location">
					<option value="">All Locations</option>
					<%
					for (com.roomease.model.LocationModel loc : locations) {
					%>
					<option value="<%=loc.getLocation_ID()%>"
						<%=(String.valueOf(loc.getLocation_ID()).equals(selectedLocation)) ? "selected" : ""%>>
						<%=loc.getLocation_area()%> (<%=loc.getLocation_city()%>)
					</option>
					<%
					}
					%>
				</select>
			</div>

			<div>
				<label for="budget">Select Budget:</label> <select name="price_ID"
					id="budget">
					<option value="">All Budgets</option>
					<%
					for (com.roomease.model.PriceModel price : prices) {
					%>
					<option value="<%=price.getPrice_ID()%>"
						<%=(String.valueOf(price.getPrice_ID()).equals(selectedPrice)) ? "selected" : ""%>>
						Rs
						<%=price.getPrice_monthly()%>
					</option>
					<%
					}
					%>
				</select>
			</div>



			<div>
				<label for="room_status">Select Room Status:</label> <select
					name="room_status" id="room_status">
					<option value="">All Statuses</option>
					<option value="Available"
						<%="Available".equalsIgnoreCase(selectedStatus) ? "selected" : ""%>>Available</option>
					<option value="Occupied"
						<%="Occupied".equalsIgnoreCase(selectedStatus) ? "selected" : ""%>>Occupied</option>
				</select>
			</div>

			<button type="submit">Search</button>
		</form>
	</div>

	<div class="room-container">
		<%
		List<RoomModel> rooms = (List<RoomModel>) request.getAttribute("rooms");
		for (RoomModel room : rooms) {
		%>
		<div class="room-card">
			<img
				src="<%=request.getContextPath() + "/" + room.getImage_path()%>" />


			<h3><%=room.getRoom_type()%></h3>
			<p>
				Location:
				<%=room.getLocation_ID().getLocation_area()%></p>
			<p>
				City:
				<%=room.getLocation_ID().getLocation_city()%></p>
			<p>
				Price: Rs
				<%=room.getPrice_ID().getPrice_monthly()%>/month
			</p>
			<p>
				Status:
				<%=room.getRoom_status()%></p>
			<p>
				Size:
				<%=room.getRoom_size()%>
				sq ft
			</p>
			<p>
				Furnished:
				<%=room.getRoom_furnishing()%></p>
			<p>
				Facilities:
				<%=room.getRoom_facilities()%></p>
			<a
				href="<%=request.getContextPath()%>/RoomDetails?id=<%=room.getRoom_ID()%>"
				class="button">View Details</a>
		</div>
		<%
		}
		%>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>
