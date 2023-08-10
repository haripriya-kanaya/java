<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.infinite.java.Staff"%>
<%@ page import="java.util.List"%>
<%@ page import="com.infinite.java.StaffDAO"%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Booked Slots</title>
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
    <h1>Staff Booked Slots</h1>

    <%-- Pagination for Staff table --%>
    <% 
        StaffDAO staffDAO = new StaffDAO();
        List<Staff> bookedSlots = staffDAO.getAllBookedSlots();

        int rowsPerPage = 5; // Number of rows to display per page
        int totalRecords = bookedSlots.size(); // Total number of records
        int totalPages = (int) Math.ceil((double) totalRecords / rowsPerPage); // Total number of pages

        int currentPage = 1; // Default value is 1
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }
        }

        int startIndex = (currentPage - 1) * rowsPerPage;
        int endIndex = Math.min(startIndex + rowsPerPage, totalRecords);

        List<Staff> currentPageSlots = bookedSlots.subList(startIndex, endIndex);
    %>

    <%-- Display the Staff table with the current page slots --%>
    <table id="staffTable">
        <tr>
            <th scope="col"> ID </th>
            <th scope="col">Vehicle number</th>
            <th scope="col">Start date</th>
            <th scope="col">End date</th>
            <th scope="col">Category</th>
            <th scope="col">Slot number</th>
        </tr>
        <% for (Staff staff : currentPageSlots) { %>
            <tr>
                <td><%= staff.getStaffid() %></td>
                <td><%= staff.getVechilenumber() %></td>
                <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(staff.getStartdate()) %></td>
                <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(staff.getEnddate()) %></td>
                <td><%= staff.getCategory() %></td>
                <td><%= staff.getSlotnumber() %></td>
            </tr>
        <% } %>
    </table>

    <%-- Display the pagination links for Staff table --%>
    <div class="pagination">
        <a href="?currentPage=1">&laquo; </a>
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="?currentPage=<%= i %>" <%= currentPage == i ? "class=\"active\"" : "" %>><%= i %></a>
        <% } %>
        <a href="?currentPage=<%= totalPages %>"> &raquo;</a>
    </div>

    <a href="Navbar.jsp" class="back-link">Back</a>
</body>
</html>
