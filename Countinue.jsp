<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.infinite.java.StaffDAO" %>
<%@ page import="com.infinite.java.Staff" %>
<!DOCTYPE html>
<html>
<head>
  <title>Renewal</title>
  <!-- Add any necessary styles or scripts here -->
</head>
<body>
  <% 
  // Retrieve the data from URL parameters
  String staffId = request.getParameter("staffId");
  String vehicleNumber = request.getParameter("vechilenumber");
  String category = request.getParameter("category");
  String endDateStr = request.getParameter("endDate");
//Convert the calculatedAmountStr to a double value
 double calculatedamount = 0.0;
 String calculatedAmountStr = request.getParameter("calculatedAmount");
 if (calculatedAmountStr != null && !calculatedAmountStr.isEmpty()) {
   try {
	   calculatedamount  = Double.parseDouble(calculatedAmountStr);
   } catch (NumberFormatException e) {
     e.printStackTrace();
   }
 }


  // Initialize the start date variable
  String startDateStr = null;
  String newEndDateStr = null;
  
 
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

      // Format the dates as strings
      startDateStr = dateFormat.format(startDate);
      newEndDateStr = dateFormat.format(newEndDate);
  }
%>

<h1>Renewal</h1>
<form name="renewalForm" action="Countinue.jsp" method="POST" onsubmit="return calculateAmount()">
  <label for="staffId">Staff ID:</label>
  <input type="text" name="staffId" value="<%= staffId %>" readonly>
  <br>
  <label for="vehicleNumber">Vehicle Number:</label>
  <input type="text" name="vehicleNumber" value="<%= vehicleNumber %>" readonly>
  <!-- Add hidden fields to retain the initial values -->
  <input type="hidden" name="vechilenumber" value="<%= vehicleNumber %>">
  <input type="hidden" name="endDate" value="<%= endDateStr %>">

  <!-- Add hidden fields for the updated values -->
  <input type="hidden" name="newEndDate" value="<%= newEndDateStr %>">
 <!-- Add hidden field to store the calculated amount -->
<!-- Add hidden field to store the calculated amount -->
<input type="hidden" name="calculatedAmount" id="calculatedAmount" value="0.00">

  <br>
  <label for="category">Category:</label>
  <input type="text" name="category" value="<%= category %>" readonly>
  <br>
  <%-- Check if startDateStr is defined before displaying the Start Date --%>
  <% if (startDateStr != null && !startDateStr.isEmpty()) { %>
    <label for="startDate">Start Date:</label>
    <input type="text" name="startDate" value="<%= startDateStr %>" readonly>
  <% } %>
  <br>
  <%-- Display the new end date --%>
  <% if (newEndDateStr != null && !newEndDateStr.isEmpty()) { %>
    <label for="newEndDate">New End Date:</label>
    <span><%= newEndDateStr %></span>
  <% } %>
  <br>
    
  <%-- Display the calculated amount --%>
  <label for="amount">Amount:</label>
  <input type="text" name="amount" id="amount" value="0.00" readonly>
  <br>

  <!-- Add hidden field for charges per day based on the selected category -->
 <!-- Add hidden field to store the calculated amount -->
<!-- Add hidden field to store the calculated amount -->
<input type="hidden" name="calculatedAmount" id="calculatedAmount" value="0.00">


  <!-- Add other input fields as needed -->
  <button type="submit" class="button">Submit Renewal</button>
</form>

<script>
  function calculateAmount() {
    var category = document.getElementsByName("category")[0].value;
    

    // Define the daily rates for each category
    var twowheeler = 10.00;
    var fourwheeler = 20.00;
    var ambulance = 20.00;

    // Calculate the amount based on the selected category and the date range (fixed 15 days)
    var amount = 0.0;
    var daysDifference = 15;
    if (category === "two wheeler") {
      amount = twowheeler * daysDifference;
    } else if (category === "four wheeler") {
      amount = fourwheeler * daysDifference;
    } else if (category === "Ambulance") {
      amount = ambulance * daysDifference;
    }

    // Set the calculated amount value in the input field
    document.getElementById("amount").value = amount.toFixed(2);

    document.getElementById("calculatedAmount").value = amount.toFixed(2);

    // Prevent the form from submitting
    return false;
  }
</script>
<%
  // Now, update the endDateStr to newEndDateStr before continuing
  endDateStr = newEndDateStr;

  //Convert the necessary String values to their respective types (e.g., Date and double)
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  Date endDate = dateFormat.parse(endDateStr);
  Date startDate = dateFormat.parse(startDateStr);

  
 
  // Create an instance of the StaffDAO class
  StaffDAO staffDAO = new StaffDAO();

  // Update the staff record with the new values
  staffDAO.updateStaffByStaffId(staffId, startDate, endDate, calculatedamount);
%>

  <a href="Newjsp.jsp" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">Back</a>
 
</body>
</html>
