<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.infinite.java.Admin" %>
<%@ page import="java.util.List" %>
<%@ page import="com.infinite.java.Admindao" %>
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
        
</style>

<%
    String adminCategory = "twowheeler"; // Category for admin
    Admindao admindao = new Admindao();

    // Get Admin details for "twowheeler" category
    List<Admin> adminList = admindao.getAdminByCategory(adminCategory);

    // Pagination
    int rowsPerPage = 5; // Number of rows to display per page
    int totalRecords = adminList.size(); // Total number of records
    int totalPages = (int) Math.ceil((double) totalRecords / rowsPerPage); // Total number of pages

    // Get the current page number from the request parameter
    int currentPage = 1; // Default current page is 1

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

    List<Admin> currentPageAdmins = adminList.subList(startIndex, endIndex);
%>

<%-- Display Admin details --%>
<% if (adminList != null && !adminList.isEmpty()) { %>
    <h2>Admin Details (Two Wheeler)</h2>
    <table>
        <tr>
            <th>Admin ID</th>
            <th>Category</th>
            <th>Vehicle Number</th>
            <th>In Time</th>
            <th>Out Time</th>
        </tr>
        <% for (Admin admin : adminList) { %>
            <tr>
                <td><%= admin.getAdminid() %></td>
                <td><%= admin.getCategory() %></td>
                <td><%= admin.getVehiclenumber() %></td>
                <td><%= admin.getIntime() %></td>
                <td><%= admin.getOuttime() %></td>
            </tr>
        <% } %>
    </table>
     <div class="pagination">
        <a href="?currentPage=1">&laquo; </a>
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="?currentPage=<%= i %>" <%= currentPage == i ? "class=\"active\"" : "" %>><%= i %></a>
        <% } %>
        <a href="?currentPage=<%= totalPages %>"> &raquo;</a>
    </div>
<% } else { %>
    
<% } %>
