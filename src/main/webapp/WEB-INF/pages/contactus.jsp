<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Contact Us</title>
<style>
 body {
  background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), url('${pageContext.request.contextPath}/images/background.png') no-repeat center center fixed;
   background-size: cover;
    min-height: 100vh;
    width: 100%;
  margin: 0;
  padding: 0;
  border-radius: 0
}

  .Container {
    display: flex;
    max-width: 1000px;
    margin: 50px auto;
    background-color: white;
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
    border-radius: 12px;
    overflow: hidden;
  }

  .left-side {
    width: 42%;
    background-color: white;
    padding: 20px;
    text-align: center;
  }

  .left-side img {
    width: 100%;
    height: auto;
    object-fit: cover;
    border-radius: 12px;
  }

  .information {
    text-align: left;
    margin-top: 20px;
    font-size: 15px;
  }

  .response {
    font-style: italic;
  }

  .right-side {
    width: 60%;
    padding: 45px;
    background-color: white;
  }

  .right-side form {
    display: flex;
    flex-direction: column;
  }

  .right-side input,
  .right-side textarea {
    margin-bottom: 15px;
    padding: 10px;
    font-size: 15px;
    border: 1px solid;
    border-radius: 4%;
  }

  .right-side button {
    background-color: white;
    padding: 10px;
    font-size: 18px;
    cursor: pointer;
    border-radius: 6px;
    transition: background-color 0.3s ease;
  }

  .right-side button:hover {
    background-color: blue;
  }
  
  
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />

</head>
<body>
<jsp:include page="header.jsp" />
<div class ="Container">
    <div class ="left-side">
    <img src="${pageContext.request.contextPath}/images/contactus.jpg" />
    <div class ="information">
        <p><strong>Address:Kamalpokhari,Kathmandu</strong></p>
        <p><strong>Email:</strong>Roomease20@gmail.com</p>
        <p><strong>Phone No:</strong>+9779856321048</p>
        <p>Please feel free to contact us if any issue arises.</p>
        <p class="response">Responses will be answered within 24 hours.</p>
    </div>
    </div>
       <div class="right-side">
			<form method="post" action="${pageContext.request.contextPath}/contact">
				<input type="text" name="first_name" placeholder="Full Name" required> 
				<input type ="text" name="last_name" placeholder="Last Name" required>
				<input type="email" name="form_email" placeholder="Email" required>
				<textarea name="form_message" placeholder="Comment or message" required></textarea>
				<button type="submit">Submit</button>
			</form>
		</div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>