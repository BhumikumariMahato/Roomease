<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="java.util.Map"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Dashboard - Roomease</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<style>
<
style>* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)),
		url('${pageContext.request.contextPath}/images/background.png')
		no-repeat center center fixed;
	background-size: cover;
	color: #fff;
}

.dashboard-container {
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

.sidebar h2 {
	color: #ffcc00;
	margin-bottom: 30px;
	text-align: center;
	font-size: 22px;
	text-transform: uppercase;
}

.sidebar ul {
	list-style: none;
}

.sidebar ul li {
	margin: 20px 0;
}

.sidebar ul li a {
	text-decoration: none;
	color: #ffcc00;
	font-weight: bold;
	font-size: 16px;
	display: block;
	transition: color 0.3s ease;
}

.sidebar ul li a:hover, .sidebar ul li a.active {
	color: #ffffff;
}

.main-content {
	flex: 1;
	backdrop-filter: blur(10px);
	background-color: rgba(0, 0, 0, 0.4);
	padding: 40px 35px;
	border-radius: 15px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

.header h1 {
	font-size: 28px;
	color: #ffcc00;
	margin-bottom: 10px;
}

.header p {
	font-size: 16px;
	color: #f5f5f5;
	margin-bottom: 30px;
}

h2 {
	color: #ffcc00;
	text-transform: uppercase;
	margin-top: 30px;
}

.stats-cards {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-bottom: 30px;
}

.stat-card {
	flex: 1 1 200px;
	background-color: #ffffff;
	color: #333;
	padding: 20px;
	border-radius: 12px;
	text-align: center;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.stat-card h3 {
	font-size: 18px;
	margin-bottom: 10px;
	color: #000;
}

.stat-card p {
	font-size: 20px;
	font-weight: bold;
	color: #000;
}

.charts {
	display: flex;
	justify-content: center; /* Center chart horizontally */
	align-items: center;
	width: 100%;
	margin-top: 20px;
}

.chart-box {
	background-color: #ffffff;
	border-radius: 12px;
	text-align: center;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
	padding: 20px;
	width: 350px; /* Optional: sets a consistent width */
	margin: 0 auto; /* Ensures it's centered within parent */
}

.chart-box h3 {
	margin-bottom: 15px;
	color: #000;
	font-size: 16px;
}

.chart-box img {
	max-width: 100%;
	height: auto;
}
</style>


<body>

	<div class="dashboard-container">
		<div class="sidebar">
			<h2>Room Rentals</h2>
			<ul>
				<li><a href="${pageContext.request.contextPath}/dashboard"
					class="active">Dashboard</a></li>
				<li><a
					href="${pageContext.request.contextPath}/CustomerController">User
						List</a></li>
				<li><a href="${pageContext.request.contextPath}/contact">Messages</a></li>
				<li><a href="${pageContext.request.contextPath}/book-room">Bookings</a></li>
				<li><a href="${pageContext.request.contextPath}/manage-rooms">Manage
						Rooms</a></li>

				<li><a href="${pageContext.request.contextPath}/Profile">Profile</a></li>
				<li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
			</ul>
		</div>

		<div class="main-content">
			<div class="header">
				<h1>
					<strong>Welcome to the Dashboard</strong>
				</h1>
				<p>
					<strong>Overview of your room rentals</strong>
				</p>
			</div>

			<!-- Room Statistics Section -->
			<h2 style="margin-bottom: 15px; font-size: 1.4rem;">Room
				Statistics</h2>
			<div class="stats-cards">
				<div class="stat-card">
					<h3>Total Rooms</h3>
					<p>${totalRooms}</p>
				</div>
				<div class="stat-card">
					<h3>Occupied</h3>
					<p>${occupiedRooms}</p>
				</div>
				<div class="stat-card">
					<h3>Available</h3>
					<p>${availableRooms}</p>
				</div>
			</div>

			<h2 style="margin: 40px 0 15px; font-size: 1.4rem;">Platform
				Metrics</h2>
			<div class="stats-cards">
				<div class="stat-card">
					<h3>Total Revenue</h3>
					<p>$${totalRevenue}</p>
				</div>
				<div class="stat-card">
					<h3>Total Users</h3>
					<p>${totalUsers}</p>
				</div>
				<div class="stat-card">
					<h3>Bookings</h3>
					<p>${totalBookings}</p>
				</div>
				<div class="stat-card">
					<h3>Pending Requests</h3>
					<p>${pendingRequests}</p>
				</div>
			</div>

			<div class="charts">
				<div class="chart-box">
					<h3>Room Types Distribution</h3>
					<canvas id="roomTypePieChart" width="300" height="300"></canvas>
					<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
					<script>
    const roomTypeLabels = [
        <%Map<String, Integer> roomTypeMap = (Map<String, Integer>) request.getAttribute("roomTypeMap");
for (String key : roomTypeMap.keySet()) {%>"<%=key%>",<%}%>
    ];
    
    const roomTypeData = [
        <%for (Integer value : roomTypeMap.values()) {%><%=value%>,<%}%>
    ];

    const ctx = document.getElementById('roomTypePieChart').getContext('2d');
    const roomTypeChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: roomTypeLabels,
            datasets: [{
                label: 'Room Type Distribution',
                data: roomTypeData,
                backgroundColor: [
                    '#FF6384', '#36A2EB', '#FFCE56', '#8BC34A', '#FF9800', '#9C27B0'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { color: '#000' }
                }
            }
        }
    });
</script>

				</div>

			</div>
		</div>
	</div>

</body>
</html>
