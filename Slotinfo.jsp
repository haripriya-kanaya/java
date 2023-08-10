<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.infinite.java.Staff" %>
<%@ page import="java.util.List" %>
<%@ page import="com.infinite.java.Admindao" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Slots Information</title>
    
</head>
<body>
   

    <%-- Get the selected start date and end date from the URL query parameters --%>
    <% String startDateParam = request.getParameter("startDate");
       String endDateParam = request.getParameter("endDate");
    %>

    <%-- Check if the start date and end date parameters are not empty --%>
    <% if (startDateParam != null && endDateParam != null && !startDateParam.isEmpty() && !endDateParam.isEmpty()) { %>

        <%-- Parse the start date and end date parameters --%>
        <% java.time.LocalDate startDate = java.time.LocalDate.parse(startDateParam);
           java.time.LocalDate endDate = java.time.LocalDate.parse(endDateParam);
        %>

        <%-- Retrieve the booked slots for the selected date range --%>
        <% Admindao admindao = new Admindao();
           List<String> bookedSlotNumbers = admindao.getBookedSlotNumbers(java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate));
        %>

        <%-- Calculate the number of total slots --%>
        <% int totalSlots = 40; // Assuming there are 20 slots available in a month
        %>

        <%-- Calculate the number of booked slots --%>
        <% int bookedSlots = bookedSlotNumbers.size(); %>

        <%-- Calculate the number of empty slots --%>
        <% int emptySlots = totalSlots - bookedSlots; %>

        <%-- Display the booked and empty slot numbers for the selected date range --%>
        <h2>Booked Slots:</h2>
        <ul>
            <% for (String slotNumber : bookedSlotNumbers) { %>
                <li><%= slotNumber %></li>
            <% } %>
        </ul>

        <h2>Empty Slots:</h2>
        <p>Total Slots: <%= totalSlots %></p>
        <p>Booked Slots: <%= bookedSlots %></p>
        <p>Empty Slots: <%= emptySlots %></p>

    <% } else { %>
        <p>No start date and end date specified.</p>
    <% } %>
</body>
</html>
