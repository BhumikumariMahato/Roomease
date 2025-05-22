<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>About Us</title>

  <style>
   * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

body {
  background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), 
              url('${pageContext.request.contextPath}/images/background.png') no-repeat center center fixed;
  background-size: cover;
  min-height: 100vh;
  width: 100%;
  margin: 0;
  padding: 0;
}

/* Headings */
.heading {
  text-align: center;
  padding-top: 40px;
  color: #fff;
}

.heading h1 {
  font-size: 3rem;
  font-weight: 700;
  color: #f97316;
  text-shadow: 2px 2px rgba(0, 0, 0, 0.2);
}

/* Intro Section */
.intro {
  position: relative;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(8px);
  padding: 60px 20px;
  margin: 30px 20px;
  border-radius: 20px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
  text-align: center;
  overflow: hidden;
}

.intro::before {
  content: "";
  position: absolute;
  inset: 0;
  background: url('${pageContext.request.contextPath}/images/aboutus.jpg') no-repeat center center;
  background-size: cover;
  opacity: 0.3;
  z-index: -1;
}

.intro h2 {
  font-size: 2rem;
  font-weight: 700;
  color: #fff;
  margin-bottom: 10px;
}

.intro p {
  font-size: 1rem;
  color: #e5e5e5;
  max-width: 600px;
  margin: 0 auto;
}

/* Team Members */
.team-members {
  padding: 40px 20px;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(4px);
  border-radius: 20px;
  margin: 40px 20px;
}

.team-members h3 {
  color: #f97316;
  font-size: 2rem;
  text-align: center;
  margin-bottom: 30px;
}

.row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 20px;
}

/* Member Card */
.card {
  background: linear-gradient(rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0.85));
  border-radius: 20px;
  padding: 20px;
  width: 300px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  border: 2px solid transparent;
  background: linear-gradient(rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.9)) padding-box,
              linear-gradient(45deg, #7c3aed, #f97316) border-box;
  transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
  transform: scale(1.03);
  box-shadow: 0 12px 35px rgba(0, 0, 0, 0.2);
}

.card-img img {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 16px;
  margin-bottom: 15px;
  border: 2px solid rgba(124, 58, 237, 0.3);
}

.card p {
  font-size: 0.95rem;
  color: #1f2937;
}

details summary {
  margin-top: 12px;
  font-weight: 600;
  color: #7c3aed;
  cursor: pointer;
  transition: color 0.3s;
}

details[open] summary {
  color: #f97316;
}

.card-content p {
  margin-top: 10px;
  font-size: 0.9rem;
  color: #4b5563;
}

/* Responsive */
@media (max-width: 768px) {
  .row {
    flex-direction: column;
    align-items: center;
  }

  .card {
    width: 90%;
  }

  .intro {
    padding: 40px 15px;
  }

  .heading h1 {
    font-size: 2.5rem;
  }
}

     </style>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
</head>
<body>
<jsp:include page="header.jsp" />
<div class="heading" align="center">
  <h1>About Us</h1>
  <div class="intro">
    <h2>Introducing Our Best Online Room Finder</h2>
  </div>
</div>

<div class="team-members">
  <h3 align="center">Teams</h3>

  <div class="row">
    <div class="card">
      <div class="box"></div>
      <div class="card-img">
        <img src="${pageContext.request.contextPath}/images/bhumi.jpg" alt="Bhumi">
      </div>
      <p>Bhumi Kumari Mahato,Group leader responsible for this group</p> 
      <details>
        <summary>Explore More</summary>
        <div class="card-content">
          <p>I am from Gaighat.I completed SEE from Peace Zone Academy and +2 from Trinity Secondary School in science (biology), Kathmandu.</p>
        </div>
      </details>
    </div>

    <div class="card">
      <div class="box"></div>
      <div class="card-img">
        <img src="${pageContext.request.contextPath}/images/revant.jpg" alt="Revant Raj">
      </div>
      <p>Hello Everyone its me Revant Raj IT student.</p>
      <details>
        <summary>Explore More</summary>
        <div class="card-content">
          <p>passionate about gaming and biking. I enjoy diving into the digital world and virtual adventures.</p>
        </div>
      </details>
    </div>

    <div class="card">
      <div class="box"></div>
      <div class="card-img">
        <img src="${pageContext.request.contextPath}/images/pooja.jpg" alt="Pooja Kumari Yadav">
      </div>
      <p>Hello I am Pooja Kumari Yadav BSCIT student.</p>
      <details>
        <summary>Explore More</summary>
        <div class="card-content">
          <p>I'm from Rajbiraj. I Completed SEE in Rajbiraj and +2 from KMC, Balkumari. Passionate about coding, exploring tech, and encouraging women in IT.</p>
        </div>
      </details>
    </div>
  </div>

  <div class="row">
    <div class="card">
      <div class="box"></div>
      <div class="card-img">
        <img src="${pageContext.request.contextPath}/images/sushmita.jpg" alt="Sushmita Adhikari">
      </div>
      <p>It's me Sushmita Adhikari student of BSc Computing.</p>
      <details>
        <summary>Explore More</summary>
        <div class="card-content">
          <p>Completed high school from Kathmandu Bernhardt College.</p>
        </div>
      </details>
    </div>

    <div class="card">
      <div class="box"></div>
      <div class="card-img">
        <img src="${pageContext.request.contextPath}/images/kalpa.jpg" alt="Kalpa Jung Kunwar">
      </div>
      <p>I am Kalpa Jung Kunwar, eager to learn Java programming.</p>
      <details>
        <summary>Explore More</summary>
        <div class="card-content">
          <p>"I am committed to understanding the core concepts and developing my skills to become a proficient Java coder."</p>
        </div>
      </details>
    </div>

    <div class="card">
      <div class="box"></div>
      <div class="card-img">
        <img src="${pageContext.request.contextPath}/images/rajnish.jpg" alt="Rajnish Chaudhary">
      </div>
      <p>Hi! it's me Rajnish, a student learning and growing.</p>
      <details>
        <summary>Explore More</summary>
        <div class="card-content">
          <p>I am a committed computing student with a strong interest in Java-based development. </p>
        </div>
      </details>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>