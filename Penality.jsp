<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
  <title>Penalty Calculation</title>
  <!-- Your CSS styling -->
</head>
<body>
<%
  // Retrieve the form submission parameters
  String initialEndDateStr = request.getParameter("endDate");

  // Check if the "endDate" parameter is present and not empty
  if (initialEndDateStr == null || initialEndDateStr.isEmpty()) {
    %>
    <style>
      .validation-message {
        display: block;
      }
    </style>
    <h3>Missing or Invalid End Date</h3>
    <%
  } else {
    // Proceed with penalty calculation if "endDate" is valid
    try {
      // Calculate the difference in days between initial end date and current date
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
      Date initialEndDate = dateFormat.parse(initialEndDateStr);
      Date currentDate = new Date();
      long timeDifference = initialEndDate.getTime() - currentDate.getTime();
      int differenceInDays = (int) (timeDifference / (1000 * 3600 * 24));

      // Add your penalty calculation logic here
      // For demonstration purposes, let's assume a penalty amount of 2 per day for all categories
      int penaltyAmountPerDay = 2;
      int penaltyAmount = differenceInDays * penaltyAmountPerDay;

      // Ensure the penalty amount is not negative
      penaltyAmount = Math.max(0, penaltyAmount);
    } catch (Exception e) {
      // Handle any parsing or calculation errors
      %>
      <style>
        .validation-message {
          display: block;
        }
      </style>
      <h3>Error Occurred: <%= e.getMessage() %></h3>
      <%
    }
  }
%>

<div class="container">
  <h2>Penalty Calculation</h2>
  <div class="field">
    <label for="initialEndDate">Initial End Date:</label>
    <%= initialEndDateStr %>
  </div>
  <div class="field">
    <label for="penaltyAmount">Penalty Amount:</label>
   
  </div>
</div>

</body>
</html>
