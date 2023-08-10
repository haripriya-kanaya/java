<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.infinite.java.Staff" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty staffList}">
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Role</th>
            <!-- Add more table headers for other attributes if needed -->
        </tr>
        <c:forEach items="${staffList}" var="staff">
            <tr>
                <td>${staff.id}</td>
                <td>${staff.name}</td>
                <td>${staff.role}</td>
                <!-- Add more columns for other attributes if needed -->
            </tr>
        </c:forEach>
    </table>
</c:if>
