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
</style>

<%
    String adminCategory = "fourwheeler"; // Category for admin
    Admindao admindao = new Admindao();

    // Get Admin details for "four wheeler" category
    List<Admin> adminList = admindao.getAdminByCategory(adminCategory);
%>

<%-- Display Admin details --%>
<% if (adminList != null && !adminList.isEmpty()) { %>
    <h2>Admin Details (Four Wheeler)</h2>
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
<% } else { %>
   
<% } %>
