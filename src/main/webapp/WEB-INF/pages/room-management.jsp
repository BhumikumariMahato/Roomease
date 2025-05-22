<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Room Management</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)),
                url('${pageContext.request.contextPath}/images/background.png') no-repeat center center fixed;
    background-size: cover;
    color: #fff;
    min-height: 100vh;
}

.overlay {
    display: flex;
    width: 100%;
}

.sidebar {
    width: 220px;
    background-color: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(6px);
    padding: 30px 20px;
    border-radius: 12px;
    margin-right: 20px;
    box-shadow: 0 0 10px rgba(0,0,0,0.4);
    height: 100vh;
    position: fixed;
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

.sidebar .icon {
    margin-right: 10px;
    font-size: 18px;
}

.main-content {
    margin-left: 240px;
    padding: 40px 35px;
    width: calc(100% - 240px);
    backdrop-filter: blur(10px);
    background-color: rgba(0, 0, 0, 0.4);
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

.card {
    background-color: rgba(255, 255, 255, 0.05);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 0 15px rgba(0,0,0,0.3);
    margin-bottom: 40px;
}

.room-entry {
    background-color: rgba(0, 0, 0, 0.5);
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 30px;
    box-shadow: 0 0 10px rgba(0,0,0,0.3);
}

h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #ffcc00;
    text-transform: uppercase;
    letter-spacing: 1px;
}

form {
    margin-bottom: 15px;
}

input[type="text"],
input[type="number"],
select,
input[type="file"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 12px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 6px;
    background-color: rgba(255, 255, 255, 0.1);
    color: #fff;
}

input::file-selector-button {
    background-color: #ffcc00;
    border: none;
    padding: 6px 10px;
    color: #000;
    border-radius: 6px;
    cursor: pointer;
}

input::file-selector-button:hover {
    background-color: #e6b800;
}

input.readonly {
    background-color: rgba(255, 255, 255, 0.2);
    font-weight: bold;
}

button {
    padding: 10px 20px;
    background-color: #ff4d4d;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 5px;
}

button:hover {
    background-color: #cc0000;
}

hr {
    margin: 20px 0;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

select {
    background-color: rgba(255, 255, 255, 0.2); /* Slightly more opaque */
    color: #fff;
    border: 1px solid rgba(255, 255, 255, 0.3);
    padding: 10px;
    border-radius: 6px;
    appearance: none; /* Optional: for custom styling */
}

select option {
    background-color: #333; /* Ensures dropdown options are readable */
    color: #fff;
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
				<h2>Create New Room</h2>
				<form action="${pageContext.request.contextPath}/manage-rooms" method="post" enctype="multipart/form-data">
					<input type="hidden" name="action" value="create" /> <label
						for="image_path">Room Image:</label> <input type="file"
						id="image_path" name="image_path" accept="image/*" /> <input
						type="text" name="room_type" placeholder="Room Type" required />
					<input type="text" name="room_description"
						placeholder="Description" required /> <input type="text"
						name="room_status" placeholder="Status" required /> <input
						type="number" name="room_capacity" placeholder="Capacity" required />
					<input type="text" name="room_furnishing" placeholder="Furnishing"
						required /> <input type="text" name="room_facilities"
						placeholder="Facilities" required /> <input type="number"
						name="room_size" placeholder="Size (sq ft)" required />

					<!-- Location Select -->
					<select name="location_ID" required>
						<c:forEach var="loc" items="${locations}">
							<option value="${loc.location_ID}">${loc.location_city},
								${loc.location_area}</option>
						</c:forEach>
					</select>

					<!-- Price Select -->
					<select name="price_ID" required>
						<c:forEach var="price" items="${prices}">
							<option value="${price.price_ID}">Rs
								${price.price_monthly} / Rs ${price.price_deposit_amount}</option>
						</c:forEach>
					</select>

					<div style="text-align: center;">
						<button type="submit">Add Room</button>
					</div>
				</form>
			</div>

			<div class="card">
				<h2>Manage Existing Rooms</h2>
				<c:forEach var="room" items="${rooms}">
					<div class="room-entry">
						<form action="${pageContext.request.contextPath}/manage-rooms" method="post" enctype="multipart/form-data">
							<input type="hidden" name="room_ID" value="${room.room_ID}" /> <input
								type="hidden" name="action" value="update" /> <label>Room
								ID</label> <input type="text" class="readonly" value="${room.room_ID}"
								readonly /><input type="hidden" name="action" value="create" /> <label
						for="image_path">Room Image:</label> <input type="file"
						id="image_path" name="image_path" accept="image/*" /> <input type="text" name="room_type"
								value="${room.room_type}" required /> <input type="text"
								name="room_description" value="${room.room_description}"
								required /> <input type="text" name="room_status"
								value="${room.room_status}" required /> <input type="number"
								name="room_capacity" value="${room.room_capacity}" required />
							<input type="text" name="room_furnishing"
								value="${room.room_furnishing}" required /> <input type="text"
								name="room_facilities" value="${room.room_facilities}" required />
							<input type="number" name="room_size" value="${room.room_size}"
								required />

							<!-- Location Select -->
							<select name="location_ID" required>
								<c:forEach var="loc" items="${locations}">
									<option value="${loc.location_ID}"
										<c:if test="${loc.location_ID == room.location_ID.location_ID}">selected</c:if>>
										${loc.location_city}, ${loc.location_area}</option>
								</c:forEach>
							</select>

							<!-- Price Select -->
							<select name="price_ID" required>
								<c:forEach var="price" items="${prices}">
									<option value="${price.price_ID}"
										<c:if test="${price.price_ID == room.price_ID.price_ID}">selected</c:if>>
										Rs ${price.price_monthly} / Rs ${price.price_deposit_amount}</option>
								</c:forEach>
							</select>

							<button type="submit">Update</button>
						</form>

						<form action="${pageContext.request.contextPath}/manage-rooms"
							method="post"
							onsubmit="return confirm('Are you sure you want to delete this room?');">
							<input type="hidden" name="room_ID" value="${room.room_ID}" /> <input
								type="hidden" name="action" value="delete" />
							<button type="submit">Delete</button>
						</form>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>
