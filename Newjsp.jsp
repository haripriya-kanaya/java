<%@ page import="com.infinite.java.BookingDAO" %>
<%@ page import="com.infinite.java.Staff" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>


<%
    // Create a database connection
    Connection connection = null;
    try {
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/priya", "root", "india@123");

        // Create an instance of the BookingDAO class with the database connection
        BookingDAO bookingDAO = new BookingDAO(connection);

        // Retrieve the currently logged-in username from the session
        HttpSession session1 = request.getSession();
        String loggedInUsername = (String) session.getAttribute("UserName");

        // Retrieve the booking details for the logged-in username
        Staff bookingDetails = bookingDAO.getBookingByUsername(loggedInUsername);

        // Close the database connection (move the connection closing after fetching the data)
        connection.close();

        // Set the booking details as a request attribute
        request.setAttribute("bookingDetails", bookingDetails);
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle the exception appropriately, such as displaying an error message or redirecting to an error page
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <style>
        /* CSS styles here */
        .header {
            text-align: center;
        }
        .container {
            text-align: right;
            overflow: hidden;
        }
        .staff-details {
            float: left;
            margin-right: 20px;
            text-align: center;
            margin-top: -30px;
        }
      .button-container {
        position: absolute;
        top: 40px;
        right: 20px;
        text-align: right;
        padding-right: 20px;
    }
    .button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        margin-left: 10px;
    }
    
        body {
            background-image: url("https://images.pexels.com/photos/255379/pexels-photo-255379.jpeg?cs=srgb&dl=pexels-miguel-%C3%A1-padri%C3%B1%C3%A1n-255379.jpg&fm=jpg");
            background-position: center center;
            background-size: cover;
            height: 100vh;
            width: 100%;
            background-repeat: no-repeat;
        }
        .search-bar {
            margin-top: 20px;
            text-align: center;
            display: none;
        }
        .search-input {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            margin-right: 10px;
        }
    
        .welcome-message {
  
            max-width: 100%; /* Set the maximum width of the container to ensure the entire username is displayed */
        }
    
        .search-button {
            padding: 6px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .staff-details-container {
            margin-top: 30px;
        }
    
        .table-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 45vh; /* Set the container height to match the viewport */
    }

    table {
        border-collapse: collapse;
        width: 70%;
    }
    
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
    
        th {
            background-color: #f2f2f2;
        }
        .action-buttons {
        text-align: center;
    }

    .action-buttons button {
        padding: 8px 16px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px;
    }

    .action-buttons button:last-child {
        margin-right: 0;
    }
    </style>
    <%
    Staff bookingDetails = (Staff) request.getAttribute("bookingDetails");
    String staffId = bookingDetails != null ? bookingDetails.getStaffid() : "";
%>
    <script>
    function searchStaff() {
        var staffId = "<%= staffId %>";

        // Make an AJAX request to retrieve the staff details
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "Search.jsp?id=" + staffId, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = xhr.responseText;

                // Update the staff details container with the response
                document.getElementById("staffDetailsContainer").innerHTML = response;
            }
        };
        xhr.send();
    }
    </script>
</head>
<body>
    <h1>Booking Details:</h1>
    
  
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>User Name</th>
                    <th>Staff ID</th>
                    <th>Vehicle Number</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
               <% if (request.getAttribute("bookingDetails") != null) { %>
                    <tr>
                        <td><%= bookingDetails.getUsername() %></td>
                        <td><%= bookingDetails.getStaffid() %></td>
                        <td><%= bookingDetails.getVechilenumber() %></td>
                        <td><%= bookingDetails.getStartdate() %></td>
                        <td><%= bookingDetails.getEnddate() %></td>
                        <td><%= bookingDetails.getCategory() %></td>
                       
                        <td class="action-buttons">
                            <a href="Search.jsp?id=<%= bookingDetails.getStaffid() %>" class="button">Update</a>
                        </td>
                    </tr>
                <% } else { %>
                    <tr>
                        <td colspan="6" class="no-booking-message">No booking details found for the currently logged-in user.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <div class="button-container">
        <a href="Slot.jsp" class="button">Booking Slot</a>
        <a href="Login.xhtml" class="button">Logout</a>
    </div>
    <div class="staff-details-container" id="staffDetailsContainer">
        <!-- Staff details will be dynamically updated here -->
    </div>
</body>
</html>
