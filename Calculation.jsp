<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.infinite.java.StaffDAO" %>
<!DOCTYPE html>
<html>
<head>
  <title>Refund Amount</title>
   <style>
    /* Your existing CSS styling goes here */

   body {
    font-family: Arial, sans-serif;
    background-image: url("https://img.freepik.com/premium-vector/line-background-abstract-background-beautiful-background-bg-pattern-background-design-slide-bg_634868-9.jpg");
    background-position: center center;
    background-size: cover;
    height: 100vh;
    width: 100%;
   
}
    .container {
      max-width: 400px;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .field {
      margin-bottom: 15px;
      font-size: 16px;
    }

    .label {
      display: inline-block;
      width: 120px;
      font-weight: bold;
    }

    input[type="date"],
    .button {
      padding: 5px 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
     font-size: 16px;
    }

    .button {
      background-color: #4CAF50;
      color: #fff;
      cursor: pointer;
    }

    .button:hover {
      background-color: #45a049;
    }

    .validation-message {
      color: red;
      display: block;
    }

    #refundAmount {
      font-weight: bold;
    }
  </style>
</head>
<body>

<%
  // Retrieve the form submission parameters
  String category = request.getParameter("category");
  String initialEndDateStr = request.getParameter("endDate");

  // Check if the Category field is empty
  if (category == null || category.isEmpty()) {
    %>
    <style>
      .validation-message {
        display: block;
      }
    </style>
    <%
  }
%>

  <div class="container">
    <h2>Refund Amount</h2>
    <div class="field" id="staffIdField">
      <span class="label">Staff ID:</span>
      <%= request.getParameter("staffId") %>
    </div>

    <div class="field">
      <span class="label">Vehicle Number:</span>
      <%= request.getParameter("vechilenumber") %>
    </div>
  <form id="refundForm" action="Calculation.jsp" method="post" onsubmit="return calculateRefund(event, '<%= category %>')">
      <div class="field">
        <label for="initialStartDate"> Start Date:</label>
        <input type="date" id="initialStartDate" name="initialStartDate" value="<%= request.getParameter("startDate") %>" required readonly>
      </div>
      <div class="field">
        <label for="initialEndDate">Initial End Date:</label>
        <input type="date" id="initialEndDate" name="initialEndDate" value="<%= initialEndDateStr %>" required readonly>
      </div>
      <div class="field">
        <label for="category">Category:</label>
        <%= category %>
       <input type="hidden" id="category" value="<%= category %>">

      </div>

      <div class="field">
      <button type="submit" class="button" name="action" value="calculateRefund">Calculate Refund</button>

         <a href="Newjsp.jsp" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">Back</a>
      </div>

      <div class="field">
        <label for="refundAmount">Refund Amount:</label>
        <span id="refundAmount" style="display: none;"></span>
      </div>
    </form>
  </div>

  <script>
    function calculateRefund(event) {
      event.preventDefault();

      // Get the initial end date from the form
      var initialEndDateStr = document.getElementById("initialEndDate").value;
      console.log("Initial End Date:", initialEndDateStr);

      var initialEndDateParts = initialEndDateStr.split('-');
      var initialEndDate = new Date(
        parseInt(initialEndDateParts[0]),
        parseInt(initialEndDateParts[1]) , // Subtract 1 from the month value
        parseInt(initialEndDateParts[2])
      );

      // Get the current date
      var currentDate = new Date();
      console.log("Current Date:", currentDate);

      // Calculate the difference in days between initial end date and current date
      var timeDifference = initialEndDate.getTime() - currentDate.getTime();
      var differenceInDays = Math.ceil(timeDifference / (1000 * 3600 * 24));
      console.log("Difference in Days:", differenceInDays);

      // Get the category value from the hidden input field
      var category = document.getElementById("category").value;

      
      // Get the refund amount per day based on the category
      var refundAmountPerDay = 0;
      if (category === "twowheeler") {
        refundAmountPerDay = 5;
      } else if (category === "fourwheeler" || category === "ambulance") {
        refundAmountPerDay = 10;
      }
      console.log("Refund Amount Per Day:", refundAmountPerDay);

      // Calculate the refund amount directly based on the number of days
      var refundAmount = differenceInDays * refundAmountPerDay;
      console.log("Refund Amount:", refundAmount);

      // Show the refund amount
      document.getElementById("refundAmount").textContent = "Refund Amount: $" + refundAmount.toFixed(2);
      document.getElementById("refundAmount").style.display = "block";

      return false;
    }
  </script>
</body>
</html>
