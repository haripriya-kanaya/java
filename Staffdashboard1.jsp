<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ page import="com.infinite.java.StaffDAO" %>
<%@ page import="com.infinite.java.Staff" %>
<!DOCTYPE html>
<html>
<head>
  <title>Staff Dashboard</title>
  <style>
    /* CSS styles here */
    .header {
      text-align: center;
    }
    .container {
      text-align: right;
      overflow: hidden;
    }
    .staff-details {
      float: left;
      margin-right: 20px;
      text-align: center;
      margin-top: -30px;
    }
    .button {
      display: inline-block;
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      margin-left: 10px;
    }
    .button-container {
      margin-top: 30px;
    }
    
     body {
        background-image: url("https://img.freepik.com/free-vector/blue-curve-frame-template_53876-114605.jpg");
        background-position: center center;
        background-size: cover;
        height: 100vh;
        width: 100%;
        background-repeat: no-repeat;
    }
    .search-bar {
      margin-top: 20px;
      text-align: center;
      display: none;
    }
    .search-input {
      padding: 5px;
      border: 1px solid #ccc;
      border-radius: 3px;
      margin-right: 10px;
    }
    
    .welcome-message {
  
    max-width: 100%; /* Set the maximum width of the container to ensure the entire username is displayed */
}
    
    .search-button {
      padding: 6px 12px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    .staff-details-container {
      margin-top: 30px;
    }
  </style>
  <script>
    function toggleSearchBar() {
      var searchBar = document.getElementById("searchBar");
      searchBar.style.display = (searchBar.style.display === "none") ? "block" : "none";
    }

    function searchStaff() {
      var staffId = document.getElementById("staffIdInput").value;

      // Make an AJAX request to retrieve the staff details
      var xhr = new XMLHttpRequest();
      xhr.open("GET", "Search.jsp?staffId=" + staffId, true);
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText;

          // Update the staff details container with the response
          document.getElementById("staffDetailsContainer").innerHTML = response;
        }
      };
      xhr.send();
    }
  </script>
</head>
<body>
  <div class="header">
    <h1>Staff Dashboard</h1>
  </div>
  <div class="container">
    <div class="staff-details">
    
      
    <h2 class="welcome-message">Welcome</h2>
<a href="#" class="button" onclick="toggleSearchBar()">Staff Details</a>
      <div class="search-bar" id="searchBar">
        <input type="text" class="search-input" id="staffIdInput" placeholder="Enter Staff ID">
        <input type="button" class="search-button" value="Search" onclick="searchStaff()">
      </div>
    </div>
    <div class="button-container">
      <a href="Slot.jsp" class="button">Booking Slot</a>
      <a href="Login.xhtml" class="button">Logout</a>
    </div>
  </div>
  <div class="staff-details-container" id="staffDetailsContainer">
    <!-- Staff details will be dynamically updated here -->
  </div>
</body>
</html>
