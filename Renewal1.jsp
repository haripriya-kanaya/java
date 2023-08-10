<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.infinite.java.StaffDAO" %>
<%@ page import="com.infinite.java.Staff" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.infinite.java.Calcualtiondao" %>
<!DOCTYPE html>
<html>
<head>
  <title>Staff Records</title>
  <style>
   body {
  background-image: url("https://c4.wallpaperflare.com/wallpaper/415/195/652/spots-reflections-soft-light-wallpaper-thumb.jpg");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  background-size: 3000px 2000px;
}
    .container {
      border: 1px solid #ddd;
      padding: 20px;
      width: 400px;
      margin: 0 auto;
    }
    .heading {
      text-align: center;
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .field {
      margin-bottom: 10px;
    }
    .label {
      font-weight: bold;
    }
    .input-field {
      padding: 5px;
      border: 1px solid #ccc;
      border-radius: 3px;
    }
    .button-container {
      text-align: left;
    }
    .button-container.center {
  text-align: center;
}
    .button {
      display: inline-block;
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }
    .button:hover {
      background-color: #45a049;
    }
   .back-button {
      display: inline-block;
      padding: 10px 20px;
      background-color: #ccc;
      color: black;
      border: none;
      border-radius: 3px;
      cursor: pointer;
      margin-right: 10px;
    }
    
  
  .button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    margin-right: 10px;
    font-size: 14px;
    font-weight: bold;
  }

  .button.back-button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    margin-right: 10px;
    font-size: 14px;
    font-weight: bold;
  }

  .button.back-button:hover {
    background-color: #45a049;
  }
</style>

 <script>
  function calculateAmount() {
    var startDate = new Date(document.getElementById("newStartDate").value);
    var endDate = new Date(document.getElementById("newEndDate").value);
    var category = document.getElementById("vehicleCategory").value;
    var amount = 0;

    // Validation: Check if all three fields are selected
    if (!startDate || !endDate || !category) {
      document.getElementById("amount").textContent = "";
      document.getElementById("selectedCategoryField").style.display = "none";
      document.getElementById("dateValidationMessage").style.display = "block";
      return false;
    } else {
      document.getElementById("dateValidationMessage").style.display = "none";
    }

    var start = new Date(startDate);
    var end = new Date(endDate);

    if (start > end) {
      document.getElementById("amount").textContent = "";
      document.getElementById("selectedCategoryField").style.display = "none";
      return false;
    }

    var days = Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;

    if (isNaN(days) || days < 0) {
      document.getElementById("amount").textContent = "";
      document.getElementById("selectedCategoryField").style.display = "none";
      return false;
    }

    if (days < 15) {
      document.getElementById("amount").textContent = "";
      document.getElementById("selectedCategoryField").style.display = "none";
      document.getElementById("validationMessage").textContent =
        "Renewal should be for at least 15 days.";
      return false;
    }

    // Get the existing start and end dates from the hidden fields
    var existingStartDate = new Date(document.getElementById("existingStartDate").value);
    var existingEndDate = new Date(document.getElementById("existingEndDate").value);

    // Check if the selected start date is the initial end date (ignoring time)
    if (
      startDate.getFullYear() !== existingEndDate.getFullYear() ||
      startDate.getMonth() !== existingEndDate.getMonth() ||
      startDate.getDate() !== existingEndDate.getDate()
    ) {
      document.getElementById("amount").textContent = "";
      document.getElementById("selectedCategoryField").style.display = "none";
      document.getElementById("validationMessage").textContent =
        "Selected start date should be the initial end date.";
      return false;
    }

    // Check if the selected end date for renewal is the same as the start date for renewal
    if (
      endDate.getFullYear() !== startDate.getFullYear() ||
      endDate.getMonth() !== startDate.getMonth() ||
      endDate.getDate() !== startDate.getDate()
    ) {
      document.getElementById("amount").textContent = "";
      document.getElementById("selectedCategoryField").style.display = "none";
      document.getElementById("validationMessage").textContent =
        "Selected end date for renewal should be the same as the start date for renewal.";
      return false;
    }

    if (category === "two-wheeler") {
      amount = days * 10;
    } else if (category === "four-wheeler") {
      amount = days * 20;
    }

    document.getElementById("amount").textContent = amount;
    document.getElementById("validationMessage").textContent = "";

    // Check if the renewal button was clicked
    if (document.getElementById("renewalButtonClicked").value === "true") {
      // Perform the renewal process here
      // ...
      // Reset the renewal button clicked value
      document.getElementById("renewalButtonClicked").value = "false";

      // Calculate the difference between the original amount and the adjusted amount
      var originalAmount = parseFloat(document.getElementById("originalAmount").value);
      var difference = originalAmount - amount;

      // Display the difference on the page
      document.getElementById("difference").textContent = difference.toFixed(2); // You can format the difference as needed
    }

    return true;
  }

  function showRefundMessage() {
    document.getElementById("refundMessage").style.display = "block";
  }
</script>


</head>
<body>
  <% 
    String staffId = request.getParameter("staffId");

    // Create an instance of the StaffDAO
    StaffDAO staffDAO = new StaffDAO();
    
    // Call the method to retrieve the staff details based on the staff ID
    Staff staff = staffDAO.getStaffByStaffId(staffId);
   
    if (staff == null) {
  %>
  <div class="container">
    <p>No staffdetails found with Staff ID: <%= staffId %></p>
  </div>
  <%
 
    } else {
    	
      // Staff found, display the details
      // Create a SimpleDateFormat instance to format the dates
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
      
      // Retrieve the existing dates from the staff object
      Date existingStartDate = staff.getStartdate();
      Date existingEndDate = staff.getEnddate();
      
      // Get the selected start and end dates from the request parameters or use the existing dates as default values
      String newStartDateStr = request.getParameter("newStartDate");
      String newEndDateStr = request.getParameter("newEndDate");
      Date newStartDate = (newStartDateStr != null) ? dateFormat.parse(newStartDateStr) : existingStartDate;
      Date newEndDate = (newEndDateStr != null) ? dateFormat.parse(newEndDateStr) : existingEndDate;
  
      // Calculate the total charges based on the selected dates
      long durationInMillis = newEndDate.getTime() - newStartDate.getTime();
      int days = (int) (durationInMillis / (24 * 60 * 60 * 1000)) + 1;
      
      // Calculate the amount and penalty based on the vehicle category and duration
      String vehicleCategory = request.getParameter("vehicleCategory");
      double amount = 0.0;
      double penalty = 0.0;
      double refundAmount = 0.0;

      if (vehicleCategory != null) {
        if (vehicleCategory.equals("two-wheeler")) {
          amount = days * 10;
          penalty = Math.max(days - 1, 0) * 5;
        } else if (vehicleCategory.equals("four-wheeler")) {
          amount = days * 20;
          penalty = Math.max(days - 1, 0) * 7;
        }
      }
      
      // Update the staff record if the form is submitted
      if (newStartDateStr != null && newEndDateStr != null) {
        staffDAO.updateStaffByStaffId(staffId, newStartDate, newEndDate);
        staff = staffDAO.getStaffByStaffId(staffId);
      }
  %>
  <div class="container">
    <h2 class="heading">Staff Details</h2>
    <div class="field">
      <span class="label">Staff ID:</span>
      <%= staff.getStaffid() %>
    </div>
    <div class="field">
      <span class="label">Vehicle Number:</span>
      <%= staff.getVechilenumber() %>
    </div>
    <form action="" method="POST" onsubmit="return calculateAmount();">
      <input type="hidden" name="staffId" value="<%= staff.getStaffid() %>">
  <div class="field">
  <span class="label">New Start Date:</span>
  <input type="date" class="input-field" name="newStartDate" id="newStartDate" onchange="calculateAmount();" required>
  <input type="hidden" name="selectedStartDate" value="<%= dateFormat.format(existingStartDate) %>">
</div>



<div class="validation-message" id="dateValidationMessage" style="display: none; color: red;">Please select both start date and end date.</div>

<div class="field">
  <span class="label">New End Date:</span>
  <input type="date" class="input-field" name="newEndDate" id="newEndDate" value="<%= dateFormat.format(existingEndDate) %>" min="2023-07-01" max="2023-12-25" required onchange="calculateAmount();">
  <input type="hidden" name="selectedEndDate" value="<%= dateFormat.format(existingEndDate) %>">
</div>


      <div class="field">
        <span class="label">Category:</span>
        <input type="text" class="input-field" value="<%= staff.getCategory() %>" readonly>
      </div>
     
      <div class="field">
        <span class="label">Vehicle Category:</span>
        <select class="input-field" name="vehicleCategory" id="vehicleCategory" required onchange="calculateAmount();">
          <option value="">Please select category</option>
          <option value="two-wheeler" <% if (vehicleCategory != null && vehicleCategory.equals("two-wheeler")) { %>selected<% } %>>Two Wheeler</option>
          <option value="four-wheeler" <% if (vehicleCategory != null && vehicleCategory.equals("four-wheeler")) { %>selected<% } %>>Four Wheeler</option>
        </select>
      </div>
       
      <div class="field">
      <span class="label">Amount:</span>
      <span id="amount"><%= amount > 0 ? amount : "" %></span>
    </div>
    
      <div class="field">
        <span id="validationMessage" style="color: red;"></span>
      </div>
      <div class="button-container">
        <button type="submit" class="button">Renewal</button>
       <a href="Newjsp.jsp" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">Back</a>

      </div>
      <div class="field" id="selectedCategoryField" style="display: none;">
        <span class="label">Selected Vehicle Category:</span>
        <span id="selectedVehicleCategory"></span>
      </div>
      <% if (amount > 0) { %>
        <div class="field">
          <p>Total Charges: <%= amount %></p>
        </div>
       <div class="button-container center">
          <button type="button" class="button" onclick="showRefundMessage();">Submit</button>
        </div>
           
        <div class="field" id="refundMessage" style="display: none;">
          <p>Successfully Renewead</p>
        </div>
      <% } %>
    </form>
  </div>
  <% } %>
  <script>// JavaScript
  document.getElementById("newStartDate").addEventListener("input", function () {
	  var existingStartDate = new Date(document.getElementById("existingStartDate").value);
	  var selectedDate = new Date(this.value);

	  if (selectedDate < existingStartDate) {
	    this.value = formatDate(existingStartDate);
	  }
	});

	function formatDate(date) {
	  var year = date.getFullYear();
	  var month = String(date.getMonth() + 1).padStart(2, "0");
	  var day = String(date.getDate()).padStart(2, "0");
	  return year + "-" + month + "-" + day;
	}

	 function onFormSubmit() {
	 }
	 
	  </script>
  
</body>
</html>
