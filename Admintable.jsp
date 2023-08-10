<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.infinite.java.Admin"%>
<%@ page import="java.util.List"%>
<%@ page import="com.infinite.java.Admindao" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Booked Slots</title>
    <style>
        /* Define your CSS styles here */
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
            cursor: pointer;
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
        /* Sorting arrows */
        .sort-arrow {
            display: inline-block;
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
        }
        .sort-arrow-up {
            border-bottom: 4px solid #000;
        }
        .sort-arrow-down {
            border-top: 4px solid #000;
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
</head>
<body>
    <h1>Admin Booked Slots</h1>

    <%-- Pagination for Admin table --%>
    <% 
        Admindao admindao = new Admindao();
        List<Admin> adminDetails = admindao.getAllBookedSlots();
        int rowsPerPageAdmin = 5; // Number of rows to display per page for Admin table
        int totalRecordsAdmin = adminDetails.size(); // Total number of records in the Admin table
        int totalPagesAdmin = (int) Math.ceil((double) totalRecordsAdmin / rowsPerPageAdmin); // Total number of pages for Admin table

        int currentPageAdmin = 1; // Default is 1
        if (request.getParameter("currentPageAdmin") != null) {
            currentPageAdmin = Integer.parseInt(request.getParameter("currentPageAdmin"));
            if (currentPageAdmin < 1) {
                currentPageAdmin = 1;
            } else if (currentPageAdmin > totalPagesAdmin) {
                currentPageAdmin = totalPagesAdmin;
            }
        }

        int startIndexAdmin = (currentPageAdmin - 1) * rowsPerPageAdmin;
        int endIndexAdmin = Math.min(startIndexAdmin + rowsPerPageAdmin, totalRecordsAdmin);

        List<Admin> currentPageAdminSlots = adminDetails.subList(startIndexAdmin, endIndexAdmin);
    %>

    <%-- Display the Admin table with the current page slots --%>
    <table id="adminTable">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Vehicle Number</th>
            <th scope="col">Category</th>
            <th scope="col">In Time</th>
        </tr>
        <% for (Admin admin : currentPageAdminSlots) { %>
            <tr>
                <td><%= admin.getAdminid() %></td>
                <td><%= admin.getVehiclenumber() %></td>
                <td><%= admin.getCategory() %></td>
                <td><%= admin.getIntime() %></td>
            </tr>
        <% } %>
    </table>

    <%-- Display the pagination links for Admin table --%>
    <div class="pagination">
        <a href="?currentPageAdmin=1">&laquo;</a>
        <% for (int i = 1; i <= totalPagesAdmin; i++) { %>
            <a href="?currentPageAdmin=<%= i %>" <%= currentPageAdmin == i ? "class=\"active\"" : "" %>><%= i %></a>
        <% } %>
        <a href="?currentPageAdmin=<%= totalPagesAdmin %>">&raquo;</a>
    </div>

    <a href="Navbar.jsp" class="back-link">Back</a>
</body>
</html>
