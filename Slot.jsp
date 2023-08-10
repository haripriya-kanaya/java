<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.infinite.java.StaffDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import ="java.time.LocalDate"%>
<%@ page import ="java.time.ZoneId"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="javax.faces.context.ExternalContext" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.infinite.java.Staff" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Slot</title>
<script>
function calculateAmount() {
    var startDateInput = document.getElementById("startDate").value;
    var endDateInput = document.getElementById("endDate").value;
    var startDate = new Date(startDateInput);
    var endDate = new Date(endDateInput);
    var category = document.getElementById("category").value;
    var days = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;
    var amount = 0;

    if (isNaN(days) || days < 0) {
        document.getElementById("amount").textContent = "0";
        return;
    }

    var chargesperday; // Define the chargesperday variable

    if (category === "two wheeler") {
        chargesperday = 10; // Set the chargesperday for the two-wheeler category
    } else if (category === "four wheeler") {
        chargesperday = 20; // Set the chargesperday for the four-wheeler category
    } else if (category === "Ambulance") {
        chargesperday = 20; // Set the chargesperday for the ambulance category
    } else {
        chargesperday = 0; // Set the default value if no valid category is selected
    }

    if (days === 1) {
        amount = chargesperday; // If the start and end dates are the same day, set the amount as chargesperday for a single day
    } else {
        amount = days * chargesperday; // Calculate the total amount for the selected category
    }

    document.getElementById("amount").textContent = amount; // Update the amount on the page
}

function selectSlot(slot) {
    var slotBox = document.querySelector("[data-slot='" + slot + "']");
    slotBox.classList.toggle("selected-slot");

    // Get the selected slot number and store it in the hidden input field
    var selectedSlotNumber = slotBox.textContent;
    document.getElementById("selectedSlot").value = selectedSlotNumber;
}

document.getElementById("startDate").addEventListener("change", calculateAmount);
document.getElementById("endDate").addEventListener("change", calculateAmount);
document.getElementById("category").addEventListener("change", calculateAmount);

calculateAmount();
</script>




<style>
 /* CSS for slot boxes */
  #slotBoxContainer {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* Creates 4 equal columns */
    gap: 10px; /* Adds gap between slot boxes */
    margin-top: 10px; /* Optional margin at the top */
  }

  .slot-box {
    /* Add your desired styling for slot boxes here */
    padding: 10px;
    border: 1px solid #ccc;
    text-align: center;
    cursor: pointer;
    display: none; /* Initially hide all slot boxes */
  }

  /* Optional styling for ambulance slots */
  .ambulance-slot {
    background-color: #ff9999;
  }

  /* Optional styling for two-wheeler slots */
  .two-wheeler-slot {
    background-color: #99ff99;
  }

  /* Optional styling for four-wheeler slots */
  .four-wheeler-slot {
    background-color: #9999ff;
  }
    body {
        font-family: Arial, sans-serif;
    }

    h1 {
        text-align: center;
        margin-top: 50px;
        color: 	#FF0000;
      
  font-size: 40px;

    }

  body {
    font-family: Arial, sans-serif;
    background-image: url("https://www.plasmacomp.com/wp-content/uploads/2016/06/Smart-Parking-Solution-1.jpg");
    background-position: center center;
    background-size: cover;
    height: 100vh;
    width: 100%;
   
}
.container {
    /* ... your existing styles ... */
    min-height: 100vh; /* Set the minimum height to 100% of the viewport height */
}

    input[type="date"],
    input[type="text"],
    select {
        font-size: 15px;
    }

    .container {
        max-width: 450px;
        margin: 50px auto;
        border: 1px solid #000000;
        padding: 20px;
        border-radius: 5px;
    }
    .form-container {
        position: relative;
        top: -110px; /* Adjust the value as needed to move the form upwards */
    }

    form {
        max-width: 400px;
        margin: 0 auto;
    }

    label {
        display: block;
        margin-bottom: 5px;
    }

    input[type="text"],
    input[type="date"],
    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 3px;
        margin-bottom: 10px;
    }

    input[type="submit"] {
        background-color: #4caf50;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
    }

    span#amount {
        font-weight: bold;
    }

    .error-message {
        color: red;
        margin-top: 5px;
    }

    label {
        display: block;
        
        margin-bottom: 5px;
    }
    slot-boxes {
            display: none;
        }

    .remaining-slots {
        color: red;
    }

    #slotNumber {
        position: relative;
    }

    #slotNumber option {
        position: absolute;
        z-index: 1;
    }

    input[type="submit"] {
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
    }
    
    

    /* CSS styles */
    .charges-container {
        position: absolute;
        top: 20px;
        right: 20px;
        text-align: right;
    }

    .booked-slot {
      
        color: red;
    }
  .slot-boxes {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* Four slots per row */
    gap: 20px; /* Adjust the gap between slots as needed */
    background-color: lightblue;
    height: 110%; /* Set the height to 100% */
}


    .slot-box {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: center;
    }
    
    #error-container {
    /* Style the error message container */
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    padding: 5px;
    background-color: rgba(255, 0, 0, 0.7);
    text-align: center;
}
    
  .selected-slot {
    background-color: #00FF00; /* Change this to your desired color for selected slots */
}
       #slotBoxContainer {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* Creates 4 equal columns */
            gap: 10px; /* Adds gap between slot boxes */
            margin-top: 10px; /* Optional margin at the top */
        }

        .slot-box {
            /* Add your desired styling for slot boxes here */
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
            cursor: pointer;
            display: none; /* Initially hide all slot boxes */
        }

        /* Optional styling for ambulance slots */
        .ambulance-slot {
            background-color: #ff9999;
        }

        /* Optional styling for two-wheeler slots */
        .two-wheeler-slot {
            background-color: #99ff99;
        }

        /* Optional styling for four-wheeler slots */
        .four-wheeler-slot {
            background-color: #9999ff;
        }																		
     #validationMessage {
            display: none;
            color: red;
        }
        .red-label {
    color: red;
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div style="position: relative;">
    <div class="charges-container">
        <h2>Charges for Parking:</h2>
        <p>For 2 Wheeler (per day): 10 Rupees</p>
        <p>For 4 Wheeler (per day): 20 Rupees</p>
         <p>For Ambulance (per day): 20 Rupees</p>
    </div>
</div>
<div class="container form-container" > 
    <h1>Slot Booking</h1>
    <%-- JSP code to handle the form submission --%>
    <%@ page import="java.text.ParseException" %>
    <%@ page import="java.text.SimpleDateFormat" %>

    <%-- JSP code for the booking form --%>
  <form id="bookingForm" method="POST" onsubmit="return validateForm(event) && bookSlot();">

     <%
// Retrieve the current session
HttpSession session1 = request.getSession();

// Retrieve the login username from the session
String loggedInUsername = (String) session.getAttribute("UserName");
%>
<label for="username" class="red-label">Username:</label>
<input type="text" id="username" name="username" value="<%= loggedInUsername %>" readonly>

        <label for="vehicleNumber">Vehicle Number:</label>
        <input type="text" id="vehicleNumber" name="vehicleNumber" pattern="[A-Z]{2}\d{4}"
            title="Please enter two capital letters followed by four numbers" required>

       <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required onchange="calculateAmount(); calculateEndDate();">
    <br>

    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" readonly onchange="calculateAmount();">
    <br>
        
      
        <script>
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("startDate").setAttribute('min', today);
            document.getElementById("endDate").setAttribute('min', today);
        </script>

        <label for="category">Category:</label>
<select id="category" name="category" required onchange="calculateAmount()">
    <option value="Category">Please Select Category</option>
    <option value="Ambulance">Ambulance</option>
    <option value="twowheeler">Two Wheeler</option>
    <option value="fourwheeler">Four Wheeler</option>
</select>
<p id="categoryError" class="error-message" style="display: none;">Please select a category.</p>
<br>

<label for="amount">Amount:</label>
<span id="amount"></span><br>


 <div class="slot-boxes" id="slotBoxContainer">
    <!-- Slots for Ambulance category -->
    <label class="slot-box ambulance-slot" data-slot="Ambulance1">
        <input type="radio" name="selectedSlot" value="Ambulance1">Ambulance1
    </label>

    <!-- Slots for Two Wheeler category -->
    <% for (int i = 1; i <= 20; i++) { %>
        <label class="slot-box two-wheeler-slot" data-slot="TwoWheeler<%= i %>">
            <input type="radio" name="selectedSlot" value="TwoWheeler<%= i %>">Two<%= i %>
        </label>
    <% } %>

    <!-- Slots for Four Wheeler category -->
    <% for (int i = 1; i <= 20; i++) { %>
        <label class="slot-box four-wheeler-slot" data-slot="FourWheeler<%= i %>">
            <input type="radio" name="selectedSlot" value="FourWheeler<%= i %>">Four<%= i %>
        </label>
    <% } %>
</div>


<input type="hidden" id="selectedSlot" name="slotNumber">
    <p id="validationMessage"></p>

      <%
    if (request.getAttribute("validationError") != null) {
        %>
        <p class="error-message"><%= request.getAttribute("validationError") %></p>
        
        
        <%
    }

    if (request.getMethod().equals("POST")) {
        // Get form data
        String uid = request.getParameter("uid");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String category = request.getParameter("category");
        String slotNumber = request.getParameter("slotNumber");
        String username = request.getParameter("username");
      
        // Parse the dates
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = sdf.parse(startDateStr);
            endDate = sdf.parse(endDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        StaffDAO staffDAO = new StaffDAO();
        
     // Check if the slot number already exists
        String slotNumberExistsMessage = staffDAO.isSlotNumberExist(slotNumber);


        // Check if the vehicle number already exists
        String vehicleNumberExists = staffDAO.isVehicleNumberExist(vehicleNumber);
        
        boolean isUsernameBooked = staffDAO.isUsernameAlreadyBooked(username);
    

        List<String> bookedSlotNumbers1 = staffDAO.getBookedSlotNumbersForDateRange(startDate, endDate);
        
      


        if (slotNumberExistsMessage != null || vehicleNumberExists != null || bookedSlotNumbers1.contains(slotNumber) || isUsernameBooked) {
 	  
            // Handle the existing vehicle number case (e.g., show an error message)
        	%>
            <p class="error-message">
        <% if (slotNumberExistsMessage != null) { %>
            <%= slotNumberExistsMessage %>
        <% } else if (vehicleNumberExists != null) { %>
            <%= "The vehicle number already exists." %>
        <% } else if (bookedSlotNumbers1.contains(slotNumber)) { %>
            <%= "The selected slot is already booked." %>
        <% } else if (isUsernameBooked) { %>
            <%= "This  user is already booked." %>
        <% } %>
    </p> <%
        
        } else {
            // Check if the number of booked slots in the month exceeds the limit
           int bookedSlotsCount = staffDAO.getBookedSlotsCountForMonth(startDate, "two wheeler");
            

// Display the result

            int maxSlots = 39; // Set the maximum number of slots available

            int remainingSlots = maxSlots - bookedSlotsCount;

            if (remainingSlots < 0) {
                remainingSlots = 0; // Ensure the remaining slots count is not negative
            }

            boolean showValidationMessage = false; // Flag to track validation message display

            if (bookedSlotsCount >= maxSlots) {
                // The maximum number of slots has been reached for the current month
                showValidationMessage = true;
            }

            // Retrieve the booked slot numbers from the database
            List<String> bookedSlotNumbers = staffDAO.getBookedSlotNumbers(startDate, endDate);
            // Check if the selected slot is already booked
            if (bookedSlotNumbers.contains(slotNumber)) {
                // The selected slot number is already booked, handle accordingly (e.g., show an error message)
                %>
  <div id="validationMessage" class="error-message" style="color: red;"></div>
 <%
                return; // Prevent further processing
            }

            // Set the bookedSlotNumbers attribute in the request
            request.setAttribute("bookedSlotNumbers", bookedSlotNumbers);
        %>
        <p class="remaining-slots">Remaining slots for this month: <%= remainingSlots %></p>

        <% if (showValidationMessage) { %>
        <p class="error-message">Sorry, all slots for this month are already booked.</p>
        <% } else {
            staffDAO.bookSlot(vehicleNumber, startDate, endDate, category, slotNumber, username);
            // Display a success message
        %>
        <p class="success-message" id="success-message" style="color: green;">Slot booked successfully!</p>
        <% } %>
    <% } } %>
    
 <%
    // Assuming you have initialized sessionFactory somewhere before this point
    StaffDAO staffDAO = new StaffDAO();

//Assuming you have retrieved the `username` from the session
String loggedInUsername1 = (String) session.getAttribute("UserName");

    // Define the list of slot numbers to check
    List<String> slotNumbersList = new ArrayList<>();
   
    // Add more slot numbers to the list as needed

    // Loop through the slot numbers and check their existence
    for (String slotNumber : slotNumbersList) {
        // Call the method to check if the slot number exists
        String slotNumberExistsMessage = staffDAO.isSlotNumberExist(slotNumber);

        // Check the result and display appropriate messages for each slot number
        if (slotNumberExistsMessage != null) {
            // Slot number already exists
            %>
            <div style="position: absolute; top: 0; left: 0; width: 100%; height: 50px;">
                <p class="error-message"><%= slotNumberExistsMessage %></p>
            </div>
            <%
        } else {
            // Slot number does not exist
            %>
            <p class="success-message">Slot number <%= slotNumber %> is available.</p>
            <%
        }
    }
    
    
%>


    
   <div id="error-container">
        <p class="error-message" id="error-message"></p>
    </div>

           <%-- Your existing code --%>
            
           
        <div style="display: flex; justify-content: flex-start; align-items: center;">
            <p class="error-message" id="error-message"></p>
          <input type="submit" value="Book" style="margin-right: 25px;" onclick="bookSlot();">
<div id="messageSlot" style="color: red;"></div>

            <input type="button" value="Reset"
                style="background-color: #808080; color: white; padding: 10px 20px; border: none; cursor: pointer; margin-right: 25px;"
                onclick="cancelBooking(event)">

            <a href="Newjsp.jsp" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">Back</a>
        </div>
        <div id="messageSlot"></div>
    </form>
    </div>
    
<script>
   

    var messageTimeout; // Variable to store the timeout reference

    function bookSlot() {
        var selectedSlot = document.querySelector('input[name="selectedSlot"]:checked');
        var messageSlot = document.getElementById("messageSlot");

        if (!selectedSlot) {
            messageSlot.textContent = "Please select a slot. Slot number is required.";
            if (messageTimeout) {
                clearTimeout(messageTimeout); // Clear the previous timeout if it exists
            }
            messageTimeout = setTimeout(function () {
                messageSlot.textContent = ""; // Clear the message after 3 minutes
            }, 180000); // 180000 milliseconds = 3 minutes
            return false; // Prevent form submission if slot is not selected
        } else {
            var slotValue = selectedSlot.value;
            var isSlotBooked = slotAvailability[slotValue];

            if (isSlotBooked) {
                messageSlot.textContent = "The selected slot number is already booked. Please choose another slot.";
                return false; // Prevent form submission if slot is already booked
            } else {
                // If the slot is available, update its availability in the slotAvailability object
                slotAvailability[slotValue] = true;
                // Proceed with the booking logic here if needed
                // Optionally, you can remove the following line if you want the form to submit after slot selection.
                return true; // Allow form submission if slot is available
            }
        }
    }

    // Add an event listener to the form submission event
    document.getElementById("bookingForm").addEventListener("submit", function (event) {
        if (!bookSlot()) {
            event.preventDefault(); // Prevent default form submission if validation fails
        }
    });
</script>


    <script>
        function cancelBooking(event) {
            event.preventDefault(); // Prevent the default form submission behavior
            // Redirect to the cancellation page
            window.location.href = "Slot.jsp";
        }
    </script>
    <script>
        // Hide the success message after 1 seconds (5000 milliseconds)
        setTimeout(function () {
            document.getElementById("success-message").style.display = "none";
        }, 10000);
    </script>
    <script>
        function validateForm(event) {
            var category = document.getElementById("category").value;

            if (category === "Category") {
                document.getElementById("categoryError").style.display = "block";
                event.preventDefault(); // Prevent form submission only if validation fails
            } else {
                document.getElementById("categoryError").style.display = "none";
            }
        }
    </script>
 

    <script>
        $(document).ready(function() {
            // Function to generate slots for Two Wheeler and Four Wheeler categories
            function generateSlots(category, count) {
                for (let i = 1; i <= count; i++) {
                    const slotNumber = category + i;
                    const slotBox = $('<div class="slot-box ' + category + '-slot" data-slot="' + slotNumber + '">' + slotNumber + '</div>');
                    $("#slotBoxContainer").append(slotBox);
                }
            }

            // Initially hide all slot boxes
            $(".slot-box").hide();

            // When the category dropdown changes
            $("#category").change(function() {
                // Hide all slot boxes
                $(".slot-box").hide();

                // Get the selected category
                const selectedCategory = $(this).val();

                // Show the slot boxes for the selected category
                if (selectedCategory === "Ambulance") {
                    $(".ambulance-slot").show();
                } else if (selectedCategory === "two wheeler") {
                    $(".two-wheeler-slot").show();
                } else if (selectedCategory === "four wheeler") {
                    $(".four-wheeler-slot").show();
                }
            });

            // Generate slots for Two Wheeler and Four Wheeler categories
            generateSlots("Two", 20); // Generate slots for Two Wheeler category (20 slots)
            generateSlots("Four", 20); // Generate slots for Four Wheeler category (20 slots)

            // Event listener for slot box click
            $(document).on("click", ".slot-box", function() {
                const slotNumber = $(this).data("slot");
                selectSlot(slotNumber);
            });
        });
      
    </script>
    
  <script>
function calculateEndDate() {
    var startDateInput = document.getElementById("startDate");
    var endDateInput = document.getElementById("endDate");

    // Get the selected start date
    var startDateValue = new Date(startDateInput.value);

    // Add 15 days to the start date to calculate the end date
    var endDateValue = new Date(startDateValue);
    endDateValue.setDate(startDateValue.getDate() + 14);

    // Format the end date as YYYY-MM-DD (required format for input type="date")
    var endDateFormatted = endDateValue.toISOString().slice(0, 10);

    // Set the calculated end date in the endDate input field
    endDateInput.value = endDateFormatted;
}
</script>

    
</body>
</html>


