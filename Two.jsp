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
         .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #808080;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            float: right; /* Move the element to the right */
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
           
            <th>User name</th>
            <th>Vehicle Number</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Category</th>
            <th>Slot Number</th>
          
        </tr>
        <% for (Staff staff : staffList) { %>
            <tr>
            
                <td><%= staff.getUsername() %></td>
                <td><%= staff.getVechilenumber() %></td>
                <td><%= staff.getStartdate() %></td>
                <td><%= staff.getEnddate() %></td>
                <td><%= staff.getCategory() %></td>
                <td><%= staff.getSlotnumber() %></td>
                
               
            </tr>
        <% } %>
    </table>
    
    
    
    
<% } else if (category != null) { %>
    <p>No staff found for the specified category: <%= category %></p>
<% } %>

<%@ include file="Admin2.jsp" %>
 <a href="Navbar.jsp" class="back-link">Back</a>
