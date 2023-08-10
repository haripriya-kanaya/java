<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.infinite.java.Staff" %>
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
    </style>


<%
    String category = request.getParameter("category");
    List<Staff> staffList = null;

    if (category != null && !category.isEmpty()) {
        Admindao admindao = new Admindao();
        staffList = admindao.getStaffByCategory(category);
    }
%>

<% if (staffList != null && !staffList.isEmpty()) { %>
    <table>
        <tr>
            <th>Staff ID</th>
            <th>User name</th>
            <th>Vehicle Number</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Category</th>
            <th>Slot Number</th>
            <th>Charges Per Day</th>
        </tr>
        <% for (Staff staff : staffList) { %>
            <tr>
                <td><%= staff.getStaffid() %></td>
                <td><%= staff.getUsername() %></td>
                <td><%= staff.getVechilenumber() %></td>
                <td><%= staff.getStartdate() %></td>
                <td><%= staff.getEnddate() %></td>
                <td><%= staff.getCategory() %></td>
                <td><%= staff.getChargesperday() %></td>
                <td><%= staff.getSlotnumber() %></td>
            </tr>
        <% } %>
    </table>
<% } else if (category != null) { %>
    <p>No staff found for the specified category: <%= category %></p>
<% } %>