<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String category = request.getParameter("category");

    if ("Staff".equals(category)) {
        // Display staff details
        request.getRequestDispatcher("Show.jsp").include(request, response);
    } else if ("Admin".equals(category)) {
        // Display ambulance details
        request.getRequestDispatcher("Admintable.jsp").include(request, response);
    
    } else if ("Ambulance".equals(category)) {
        // Display ambulance details
        request.getRequestDispatcher("Ambulance.jsp").include(request, response);
    } else if ("Two Wheeler".equals(category)) {
        // Display two-wheeler details
        request.getRequestDispatcher("Two.jsp").include(request, response);
    } else if ("Four Wheeler".equals(category)) {
        // Display four-wheeler details
        request.getRequestDispatcher("Four.jsp").include(request, response);
    } else {
        out.println("No category selected.");
    }
%>
