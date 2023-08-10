<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.infinite.java.StaffDAO" %>
<%@ page import="com.infinite.java.Staff" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
  <title>Staff Records</title>
  <style>
    /* Your existing CSS styling */
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      margin: 0;
      padding: 0;
    }

    h1 {
      text-align: center;
    }

    table {
      border-collapse: collapse;
      width: 80%;
      margin: 20px auto;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: center;
    }

    th {
      background-color: #f2f2f2;
    }

    .action-buttons {
      display: flex;
      justify-content: center;
    }

    form {
      margin: 5px;
    }

    .button {
      padding: 10px 15px;
      font-size: 14px;
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
      border-radius: 3px;
    }

    .button[disabled] {
      background-color: #bcbcbc;
      cursor: not-allowed;
    }

    .button[enabled]:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <% 
  String staffId = request.getParameter("id");

  // Create an instance of the StaffDAO
  StaffDAO staffDAO = new StaffDAO();

  // Call the method to retrieve the staff details based on the staff ID
  Staff staff = staffDAO.getStaffByStaffId(staffId);

  if (staff == null) {
  %>
  <h1>Staff Records</h1>
  <p>No staff found with Staff ID: <%= staffId %></p>
  <%
  } else {
    // Staff found, display the details
    // Create a SimpleDateFormat instance to format the dates
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date startDate = staff.getStartdate();
    Date endDate = staff.getEnddate();
    long timeDifferenceInMillis = endDate.getTime() - startDate.getTime();
    boolean isRenewalEnabled = (timeDifferenceInMillis <= (24 * 60 * 60 * 1000)); // Check if time difference is less than or equal to 24 hours (1 day)
  %>
  <h1>Staff Records</h1>
  <table>
    <tr>
      <th>Staff ID</th>
      <th>Vehicle Number</th>
      <th>Start Date</th>
      <th>End Date</th>
      <th>Category</th>
      <th>Action</th>
    </tr>
    <tr>
      <td><%= staff.getStaffid() %></td>
      <td><%= staff.getVechilenumber() %></td>
      <td><%= dateFormat.format(staff.getStartdate()) %></td>
      <td><%= dateFormat.format(staff.getEnddate()) %></td>
      <td><%= staff.getCategory() %></td>
      <td class="action-buttons">
        <form action="Countinue.jsp" method="GET">
          <input type="hidden" name="staffId" value="<%= staff.getStaffid() %>">
          <input type="hidden" name="vechilenumber" value="<%= staff.getVechilenumber() %>">
          <input type="hidden" name="category" value="<%= staff.getCategory() %>">
          <input type="hidden" name="startDate" value="<%= dateFormat.format(staff.getStartdate()) %>">
          <input type="hidden" name="endDate" value="<%= dateFormat.format(staff.getEnddate()) %>">
          <button type="submit" class="button" <% if (isRenewalEnabled) { %>enabled<% } else { %>disabled<% } %>>Renewal</button>
        </form>
        
        <form action="Calculation.jsp" method="POST">
          <input type="hidden" name="staffId" value="<%= staff.getStaffid() %>">
          <input type="hidden" name="vechilenumber" value="<%= staff.getVechilenumber() %>">
          <input type="hidden" name="startDate" value="<%= dateFormat.format(staff.getStartdate()) %>">
          <input type="hidden" name="endDate" value="<%= dateFormat.format(staff.getEnddate()) %>">
          <input type="hidden" name="category" value="<%= staff.getCategory() %>">
          <button type="submit" class="button">Discontinue</button>
        </form>
      </td>
    </tr>
  </table>
  <%
  }
  %>
</body>
</html>
