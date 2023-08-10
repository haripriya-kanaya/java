<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.infinite.java.Admindao" %>
<%@ page import="com.infinite.java.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            text-align: center;
        }
        .form-box {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-box label {
            display: block;
            margin-top: 10px;
        }
        .form-box input[type="text"],
        .form-box select {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ccc;
             margin-bottom: 10px; /* Add spacing between fields */
        }
        /* Add space between "Category" and "In Time" fields */
    #category {
        margin-bottom: 20px;
    }
    #intime {
        margin-bottom: 20px;
    }
        .form-box button[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
             margin-right: 20px; 
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            font-size: 16px;
            text-align: center;
            display: none; /* Hide the success message by default */
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
        .success-message {
            margin-top: 20px;
            padding: 10px;
            font-size: 16px;
            text-align: center;
            background-color: #d4edda;
            color: #155724;
            display: none; /* Hide the success message by default */
        }
        .success {
        /* Remove any background, border, and padding to hide the box */
        background: none;
        border: none;
        padding: 0;
        /* Keep the color to make the text visible */
        color: #155724;
    }
    
    .form-box {
        width: 380px; /* Decrease the box width to 300px */
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    #intime {
        width: 60%;
        
    }
     #vehicleNumber {
     
        width: 89%; /* Decrease the width of the vehicle number field */
        padding: 8px;
        font-size: 16px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }
     body {
        background-image: url("https://thumbs.dreamstime.com/z/admin-login-sign-table-made-wood-68499314.jpg");
        background-position: center center;
        background-size: cover;
        height: 100vh;
        width: 100%;
        background-repeat: no-repeat;
    }
    .message.error {
        /* Remove any background, border, and padding to hide the box */
        background: none;
        border: none;
        padding: 0;
        /* Keep the color to make the text visible */
        
         color: #f00;
         
         
         
    </style>
</head>
<body>
    <h1>Add Admin</h1>
    
 
   
    <div class="form-box">
        <form action="Addadminjsp.jsp" method="post">
            <label for="vehicleNumber">Vehicle Number:</label>
            <input type="text" id="vehicleNumber" name="vehicleNumber" pattern="[A-Z]{2}\d{4}"
                title="Please enter two capital letters followed by four numbers" required>
            
            <label for="intime">In Time:</label>
            <input type="date" id="intime" name="intime" required>
             
           
            <script>
              var today = new Date().toISOString().split('T')[0];
              document.getElementById("intime").setAttribute('min', today);
              document.getElementById("outtime").setAttribute('min', today); 
            </script>

            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="" disabled selected>Select category</option>
                <option value="twowheeler">Two Wheeler</option>
                <option value="fourwheeler">Four Wheeler</option>
            </select>
                  <% // Server-side validation and message display %>
            <%-- Move this code inside the if condition --%>
            <%
                String vehicleNumber = request.getParameter("vehicleNumber");
                String inTimeStr = request.getParameter("intime");
                String category = request.getParameter("category");
               
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date inTime = null;
                Date outTime = null; // Initialize the "Out Time" variable

                try {
                    if (inTimeStr != null && !inTimeStr.isEmpty()) {
                        inTime = sdf.parse(inTimeStr);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                // Create an instance of Admin and set the form data
                Admin admin = new Admin();
                admin.setVehicleNumber(vehicleNumber);
                admin.setIntime(inTime);
                admin.setCategory(category);
                admin.setOuttime(outTime); // Set the "Out Time" value

                // Create an instance of Admindao and call the addUser method
                Admindao admindao = new Admindao();
                String vehicleNumberExists = admindao.isVehicleNumberExist(vehicleNumber);
                if (vehicleNumberExists != null) {
            %>
                <div class="message error">
                    Vehicle number already exists.
                </div>
                <script>
                    // Show the error message after a duplicate vehicle number is entered
                    var errorMessage = document.querySelector('.message.error');
                    if (errorMessage) {
                        errorMessage.style.display = 'block';
                    }
                </script>
            <%
                } else {
                    String result = admindao.addUser(admin);
                    if (result.equals("success")) {
            %>
                <div class="message success">
                    Admin added successfully.
                </div>
            <%
                    } else {
            %>
                <div class="message error">
                    Failed to add admin. Please try again.
                </div>
            <%
                    }
                }
            %>
            <button type="submit">Submit</button>
            
            
            
             <input type="button" value="Reset"
                style="background-color: #808080; color: white; padding: 10px 20px; border: none; cursor: pointer; margin-right: 25px;"
                onclick="cancelBooking(event)">

            <a href="Navbar.jsp" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">Back</a>
        </form>
    </div>
     

    <script>
        // Show the success message after a successful submission
        window.onload = function() {
            var successMessage = document.querySelector('.message.success');
            if (successMessage) {
                successMessage.style.display = 'block';
            }
        };

    
    </script>
     <script>
        function cancelBooking(event) {
            event.preventDefault(); // Prevent the default form submission behavior
            // Redirect to the cancellation page
            window.location.href = "Addadminjsp.jsp";
        }
 </script>
 
      <div id="updateResultMessage" style="margin-top: 20px; text-align: center;"></div>
 
</body>
</html>
