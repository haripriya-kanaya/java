<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.infinite.java.StaffDAO" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html>
<head>
  <title>Remove Staff Action</title>
</head>
<body>
<%
  String staffId = request.getParameter("staffId");

  // Create an instance of the StaffDAO
  StaffDAO staffDAO = new StaffDAO();

  // Call the method to remove the staff record based on the staff ID
  staffDAO.removeStaffByStaffId(staffId);

  // Return a response to the AJAX call (optional)
  response.getWriter().print("Staff record with ID " + staffId + " has been removed.");
%>
</body>
</html>
