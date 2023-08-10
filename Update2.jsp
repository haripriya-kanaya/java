<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.infinite.java.StaffDAO" %>

<!DOCTYPE html>
<html>
<head>
  <title>Update Staff</title>
</head>
<body>
  <%
    // Retrieve the data from URL parameters
    String staffId = request.getParameter("staffId");
    String endDateStr = request.getParameter("endDate");
    String chargesPerDayStr = request.getParameter("chargesperday");

    // Convert the charges per day String to a double
    double chargesPerDay = 0.0;
    if (chargesPerDayStr != null && !chargesPerDayStr.isEmpty()) {
      try {
        chargesPerDay = Double.parseDouble(chargesPerDayStr);
      } catch (NumberFormatException e) {
        // Handle the case when the chargesPerDayStr is not a valid double value
        // For example, you can set a default value or show an error message to the user
        e.printStackTrace();
      }
    }

    // Check if endDateStr is not null and not empty before proceeding
    if (endDateStr != null && !endDateStr.isEmpty()) {
      // Parse the end date from the URL parameter
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
      Date endDate = dateFormat.parse(endDateStr);

      // Calculate the start date as the next day of the end date
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(endDate);
      calendar.add(Calendar.DAY_OF_MONTH, 1);
      Date startDate = calendar.getTime();

      // Calculate the new end date as 15 days from the start date
      calendar.setTime(startDate);
      calendar.add(Calendar.DAY_OF_MONTH, 14);
      Date newEndDate = calendar.getTime();

      // Call the updateStaffByStaffId method to update the staff record
      StaffDAO staffDAO = new StaffDAO();
      staffDAO.updateStaffByStaffId(staffId, startDate, newEndDate, chargesPerDay);
  %>
      <h1>Update Successful</h1>
  <%
    } else {
  %>
      <h1>Invalid Parameters</h1>
  <% } %>
</body>
</html>
