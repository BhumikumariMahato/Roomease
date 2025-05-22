<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <style>
        /* Page background */
        body {
            margin: 0;
            background-color:   #87CEEB;;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Header wrapper */
        #header {
            background-color: transparent;
            padding: 1px ;
        }

        .header {
            background-color: #e6f7ff; /* Lightest blue */
            border-radius: 12px;
            padding: 20px 40px;
            margin: 0 auto;
            max-width: 100%; /* Wider but not full width */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Logo */
        .logo img {
            height: 60px;
            transition: transform 0.3s ease;
        }

        .logo img:hover {
            transform: scale(1.05);
        }

        /* Navigation */
        .main-nav {
            list-style: none;
            display: flex;
            gap: 30px;
            margin: 0;
            padding: 0;
        }

        .main-nav li a {
            text-decoration: none;
            color: #1e1e2f; /* Dark text for light background */
            font-weight: 600;
            font-size: 17px;
            transition: color 0.3s, border-bottom 0.3s;
            padding: 5px 0;
            border-bottom: 2px solid transparent;
        }

        .main-nav li a:hover {
            color: #0078a8;
            border-bottom: 2px solid #0078a8;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                padding: 20px;
            }

            .main-nav {
                flex-direction: column;
                width: 100%;
                gap: 15px;
            }

            .main-nav li {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <div id="header">
        <header class="header">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" />
                </a>
            </div>
            <ul class="main-nav" role="navigation">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/Profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/book-room">My Bookings</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </header>
    </div>
</body>
</html>
