<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css"/>

<footer id="footer">
  <div class="footer-container">
    <!-- About Section -->
    <div class="footer-about">
      <h3><i class="fas fa-home" style="color: #f9c410; margin-right: 8px;"></i>RoomEase</h3>
      <p>At RoomEase, we make finding your next home effortless. Discover cozy, affordable rooms that match your lifestyle — simple, fast, and stress-free.</p>
      <div class="social-icons">
        <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
        <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
        <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
        <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
      </div>
    </div>

    <!-- Quick Links -->
    <div class="footer-links">
      <h4>Quick Links</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        
      </ul>
    </div>

    <!-- Contact Section -->
    <div class="footer-contact">
      <h4>Contact Us</h4>
      <p><i class="fas fa-envelope" style="color: #f9c410; margin-right: 8px;"></i> support@roomease.com</p>
      <p><i class="fas fa-phone-alt" style="color: #f9c410; margin-right: 8px;"></i> +977-9856321048</p>
      <p><i class="fas fa-map-marker-alt" style="color: #f9c410; margin-right: 8px;"></i> Mandikhatar, Kathmandu, Nepal</p>
    </div>
  </div>

  <div class="footer-bottom">
    <p>&copy; 2025 RoomEase. All rights reserved.</p>
    <div class="footer-legal">
      <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
      <span> | </span>
      <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
    </div>
  </div>
</footer>