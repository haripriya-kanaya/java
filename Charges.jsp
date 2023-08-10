<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.infinite.java.Admindao"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Parking Charges and Booking Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
        
            text-align: right; /* Align the entire container to the right */
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }

        .charges-container {
            border: 1px solid #000000;
            padding: 20px;
            text-align: right; /* Align the details to the right */
            position: absolute;
            top: 0;
            right: 0;
        }

      

      

        .details-box {
            border: 1px solid  #000000;
            padding: 20px;
            text-align: center;
            margin-top: 100px; /* Add margin to create space below the charges container */
        }

        body {
  background-image: url("https://img.freepik.com/free-vector/wallpaper-with-bokeh-design_23-2148491954.jpg");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  
}

     

        .center-words {
            text-align: center;
            padding: 20px;
            font-weight: bold;
        }

        .calculate-form {
            margin-top: 20px;
            text-align: center;
        }

        .calculate-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
         .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #808080;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            float: right; /* Move the element to the right */
        }
        

      
        
    </style>
  <script>
  
  function calculateCharges() {
      const inTimeStr = document.getElementById("inTime").value;
      const outTimeStr = document.getElementById("outTime").value;
      const category = document.getElementById("category").value;
      const penalty = document.getElementById("penalty").value; // Get the selected penalty

      // Parse the time strings to timestamps
      const inTime = Date.parse(inTimeStr);
      const outTime = Date.parse(outTimeStr);

      // Calculate the time difference in milliseconds
      const timeDifferenceMs = outTime - inTime;

      // Calculate the time difference in hours (rounded up to 1 hour if less than 1 hour)
      const timeDifferenceHours = Math.ceil(timeDifferenceMs / (1000 * 60 * 60));

      // Determine the hourly charges based on the vehicle category
      let hourlyCharges = 0;
      switch (category) {
          case "twowheeler":
              hourlyCharges = 10;
              break;
          case "fourwheeler":
              hourlyCharges = 20;
              break;
          case "Ambulance":
              hourlyCharges = 20;
              break;
          // Add other cases for different categories if needed
          default:
              alert("Invalid vehicle category.");
              return;
      }

      // Calculate the total charges in Rupees (considering at least one hour)
      const totalCharges = hourlyCharges * Math.max(1, timeDifferenceHours);

      // Additional penalty charges
      let penaltyCharges = 0;
      switch (penalty) {
          case "wrongParking":
              penaltyCharges = 50;
              break;
          case "breakingVehicle":
              penaltyCharges = 50; // You can set the penalty charges as per your requirement
              break;
          default:
              penaltyCharges = 0;
      }

      // Add the penalty charges to the total charges
      const totalChargesWithPenalty = totalCharges + penaltyCharges;

      // Display the result on the web page
      document.getElementById("amount").textContent = totalChargesWithPenalty.toFixed(2);
  }
</script>





    
</head>
<body>
    <div class="container">
        <div class="charges-container">
            <h2>Charges for Parking:</h2>
            <p> 2 Wheeler (per Hr): 10 Rupees</p>
            <p> 4 Wheeler (per Hr): 20 Rupees</p>
            <p> Ambulance (per Hr): 20 Rupees</p>
            <p> Penality  (per Hr): 50 Ruppes</p>
            
        </div>
 
           <div class="details-box">
            <%-- Retrieve the parameters from the URL --%>
            <% 
            String vehicleNumber = request.getParameter("vehicleNumber");
            String outTime = request.getParameter("outTime");
            String inTime = request.getParameter("inTime");
            String category = request.getParameter("category");
            String adminId = request.getParameter("adminId");
            
            // Split the outTime into date and time
            String outDate = outTime.substring(0, 10);
            String outTime1 = outTime.substring(11, 19);
          
            String updatedVehicleNumber = request.getParameter("vehicleNumber");
            String outTimeUpdated = request.getParameter("outTimeUpdated");
      

            if (outTime != null) {
                outTime = URLDecoder.decode(outTime, "UTF-8");
            }
            // Check if the outTime is not null and format it as needed
             %>
          
 

 
 
 

<!-- Now you can use the 'vehicleNumber' variable and 'updatedOutTimes' variable (List) in your Charges.jsp page as needed -->


            <h2>Booking Details</h2>
            <div>
                <%-- Check if the parameters are not null before displaying them --%>
                <% if (vehicleNumber != null && inTime != null && outTime != null && category != null && adminId != null) { %>
                <p>   Vehicle Number: <%= updatedVehicleNumber %></p>
    
                    <p> In Time: <%= inTime %></p>
                    <p>Out Time: <%= outTime %></p>
                    <p>Category: <%= category %></p>
                    <p>Staff ID: <%= adminId %></p>
                     <label for="penalty">Penalty:</label>
        <select id="penalty" name="penalty">
            <option value="Penality">Penality</option>
            <option value="wrongParking">Wrong Parking</option>
            <option value="breakingVehicle">Broken the Other Vehicle</option>
        </select>
                    
                <% } else { %>
                    <p>Invalid parameters received.</p>
                <% } %>
            </div>

            <!-- Calculate Charges form -->
            <form class="calculate-form">
               <input type="hidden" id="inTime" value="<%= inTime %>">
<input type="hidden" id="outTime" value="<%= outTime %>">
<input type="hidden" id="category" value="<%= category %>">


                <input type="button" class="calculate-button" value="Calculate Charges" onclick="calculateCharges()">
                <p>Calculated Amount: <span id="amount">0.00</span> Rupees</p>
            </form>

            <!-- Display the calculated charges -->
            <div class="result" id="chargesResult"></div>
        </div>
    </div>
<a href="Navbar.jsp" class="back-link">Back</a>
</body>
</html>
