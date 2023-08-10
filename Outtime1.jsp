<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.infinite.java.Admin"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.infinite.java.Admindao"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Booked Slots</title>
    <style>
        /* Define your CSS styles here */
        table {
            border-collapse: collapse;
            width: 100%;
        }
        
         body {
  background-image: url("https://image.slidesdocs.com/responsive-images/background/simple-geometric-pink-small-fresh-powerpoint-background_d2bc22a905__960_540.jpg");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  
}
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .update-form {
            display: inline;
        }
        .update-form input[type="button"] {
            margin-left: 5px; /* Add some space between buttons */
        }
        .success-message {
            color: red;
            font-weight: bold;
            display: none;
        }
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 10px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            text-decoration: none;
            color: #333;
            font-size: 16px;
        }
        .pagination a.active {
            background-color: #ccc;
            color: #fff;
        }
        .pagination a.previous:before {
            content: '<';
        }
        .pagination a.next:after {
            content: '>';
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

        /* Style for the content below the Back link */
        .content {
            margin-top: 20px;
        }
    </style>
    <!-- Add Font Awesome CSS for sorting icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <h1>Booked Slots</h1>

    <%-- Retrieve the booked slots from the DAO --%>
    <% 
    Admindao staffDAO = new Admindao();
    List<Admin> bookedSlots = staffDAO.getAllBookedSlots();
    String outTimeUpdated = request.getParameter("outTimeUpdated");
    int rowsPerPage = 5; // Number of rows to display per page
    int currentPage = 1; // Current page number (default is 1)

    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int startIndex = (currentPage - 1) * rowsPerPage;
    int endIndex = Math.min(startIndex + rowsPerPage, bookedSlots.size());

    List<Admin> currentPageSlots = bookedSlots.subList(startIndex, endIndex);
    int totalPages = (int) Math.ceil((double) bookedSlots.size() / rowsPerPage);
    %>
<!-- Rest of your code -->

<script>
function updateOutTime(vehicleNumber) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Success response, show the success message
            showSuccessMessage(vehicleNumber);
            // Hide the Exit button after showing the success message
            const exitButton = document.getElementById("exitButton_" + vehicleNumber);
            exitButton.style.display = "none";
            // Show the Update button after showing the success message
            const updateForm = document.getElementById("updateForm_" + vehicleNumber);
            updateForm.style.display = "inline-block";
        }
    };

    // Get the current date and time
    const currentDate = new Date();
    const currentDateTimeString = currentDate.toISOString().slice(0, 19).replace('T', ' ');

    xhr.send("action=updateOutTime&vehicleNumber=" + encodeURIComponent(vehicleNumber) + "&outTime=" + encodeURIComponent(currentDateTimeString));
}


    // Function to show the success message
    function showSuccessMessage(vehicleNumber) {
        const successMessage = document.getElementById("successMessage");
        const updatedVehicleNumber = document.getElementById("updatedVehicleNumber");
        updatedVehicleNumber.innerText = vehicleNumber;
        successMessage.style.display = "block";
    }
</script>

<table class="table table-striped">
    <thead class="thead-dark">
        <tr>
            <th scope="col" data-type="number" data-order="asc">Admin ID <i class="sort-arrow fas fa-sort"></i></th>
            <th scope="col" data-type="text" data-order="asc">Vehicle Number <i class="sort-arrow fas fa-sort"></i></th>
            <th scope="col" data-type="text" data-order="asc">Start Date & Time <i class="sort-arrow fas fa-sort"></i></th>
            <th scope="col" data-type="text" data-order="asc">Category <i class="sort-arrow fas fa-sort"></i></th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <% for (Admin slot : currentPageSlots) { %>
        <tr>
            <td><%= slot.getAdminid() %></td>
            <td><%= slot.getVehiclenumber() %></td>
            <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(slot.getIntime()) %></td>
            <td><%= slot.getCategory() %></td>
            <td>
                <div>
                  <div><%-- Check if the outTime is null (not updated) for the current slot --%>
<% if (slot.getOuttime() == null) { %>
<!-- Show the Exit button only if the outTime is null -->
<button id="exitButton_<%= slot.getVehiclenumber() %>" onclick="updateOutTime('<%= slot.getVehiclenumber() %>')">Exit</button>
<% } else { %>
<!-- Show the Exit button as disabled if the outTime is not null -->
<button id="exitButton_<%= slot.getVehiclenumber() %>" disabled>Exit</button>
<% } %>
   <form action="Charges.jsp" method="post" id="updateForm_<%= slot.getVehiclenumber() %>" style="display: none;">
                        <input type="hidden" name="vehicleNumber" value="<%= slot.getVehiclenumber() %>">
                        <input type="hidden" name="inTime" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(slot.getIntime()) %>">
                  <%-- Add a hidden input field to store the outTime value --%>
    <input type="hidden" name="outTime" value="<%= slot.getOuttime() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(slot.getOuttime()) : "" %>">
          <input type="hidden" name="category" value="<%= slot.getCategory() %>">
                        <input type="hidden" name="adminId" value="<%= slot.getAdminid() %>">
                        <input type="button" value="Update" onclick="submitForm('<%= slot.getVehiclenumber() %>')">
                    </form>
                </div>   
            </td>
        </tr>
        <% } %>
    </tbody>
</table>

<!-- Rest of your code -->

   <%-- Display the pagination links --%>
    <div class="pagination">
        <a href="?currentPage=1">&laquo; </a>
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="?currentPage=<%= i %>" <%= currentPage == i ? "class=\"active\"" : "" %>><%= i %></a>
        <% } %>
        <a href="?currentPage=<%= totalPages %>"> &raquo;</a>
    </div>

    <!-- Display the success message -->
    <div class="success-message" id="successMessage" style="display: none;">
        Out Time Updated for existing Vehicle Number: <span id="updatedVehicleNumber"></span>
    </div>

  



   <%
    if ("updateOutTime".equals(request.getParameter("action"))) {
        String vehicleNumber = request.getParameter("vehicleNumber");
        Admindao adminDAO = new Admindao();

        // Get the current system time
        Date systemTime = new Date(); // Or use Calendar.getInstance().getTime()

        // Call the updated updateOutTime method with the new outtime value
        Admin admin = adminDAO.updateOutTime(vehicleNumber, systemTime);

        if (admin != null) {
            out.println("Out Time Updated for existing Vehicle Number: " + vehicleNumber);
        } else {
            out.println("Admin not found with Vehicle Number: " + vehicleNumber);
        }
    }
%>
    <script>  
        function submitForm(vehicleNumber) {
            const formId = "updateForm_" + vehicleNumber;
            document.getElementById(formId).submit();
        }
    </script>
    <script>
        // Sorting functionality
        const sortableColumns = document.querySelectorAll("th[data-type]");

        sortableColumns.forEach(column => {
            column.addEventListener("click", () => {
                const dataType = column.getAttribute("data-type");
                const order = column.getAttribute("data-order");
                const rows = Array.from(document.querySelectorAll("tbody tr"));

                rows.sort((a, b) => {
                    let aData = a.querySelector(`td:nth-child(${column.cellIndex + 1})`).textContent;
                    let bData = b.querySelector(`td:nth-child(${column.cellIndex + 1})`).textContent;

                    if (dataType === "number") {
                        aData = parseFloat(aData);
                        bData = parseFloat(bData);
                    }

                    if (order === "asc") {
                        return aData > bData ? 1 : -1;
                    } else {
                        return aData < bData ? 1 : -1;
                    }
                });

                const tbody = document.querySelector("tbody");
                while (tbody.firstChild) {
                    tbody.removeChild(tbody.firstChild);
                }

                rows.forEach(row => {
                    tbody.appendChild(row);
                });

                if (order === "asc") {
                    column.setAttribute("data-order", "desc");
                    column.querySelector(".sort-arrow").classList.remove("fa-sort");
                    column.querySelector(".sort-arrow").classList.add("fa-sort-up");
                } else {
                    column.setAttribute("data-order", "asc");
                    column.querySelector(".sort-arrow").classList.remove("fa-sort-up");
                    column.querySelector(".sort-arrow").classList.add("fa-sort");
                }
            });
        });
    </script>
    
     <!-- Back link -->
    <a href="Navbar.jsp" class="back-link">Back</a>
<script>
function submitForm(vehicleNumber) {
    // Get the current date and time
    const currentDate = new Date();
    const currentDateString = currentDate.toISOString().slice(0, 10); // Get only the date part (yyyy-MM-dd)
    const currentTimeString = currentDate.toTimeString().slice(0, 8); // Get only the time part (HH:mm:ss)

    // Set the "outTime" value in the form to the current date and time
    const formId = "updateForm_" + vehicleNumber;
    document.getElementById(formId).elements["outTime"].value = currentDateString + " " + currentTimeString;

    // Submit the form
    document.getElementById(formId).submit();
}
</script>

   
</body>
</html>
