<%@ page import="com.infinite.java.ForgotPasswordDAO" %>
<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%
    String username = request.getParameter("username");
    String enteredSecurityQuestion = request.getParameter("securityQuestion");
    String enteredSecurityAnswer = request.getParameter("securityAnswer");

    // Perform input validation for the username, security question, and security answer
    if (username != null && !username.isEmpty() &&
            enteredSecurityQuestion != null && !enteredSecurityQuestion.isEmpty() &&
            enteredSecurityAnswer != null && !enteredSecurityAnswer.isEmpty()) {
    	
    	  // Create an instance of the ForgotPasswordDAO class
        ForgotPasswordDAO dao = new ForgotPasswordDAO();

        // Call the non-static method on the object instance
        String[] securityInfo = dao.getSecurityInfoByUsername(username);
       
        if (securityInfo != null) {
            String storedSecurityQuestion = securityInfo[0];
            String storedSecurityAnswer = securityInfo[1];

            // Check if the entered security question and answer match the stored values
            boolean isValid = storedSecurityQuestion.equals(enteredSecurityQuestion) &&
                              storedSecurityAnswer.equals(enteredSecurityAnswer);

            // Construct the JSON response with the validation result
            out.println("{\"isValid\": " + isValid + "}");
        } else {
            // If no user found with the given username, return an error message in JSON
            out.println("{\"message\": \"User not found or invalid username.\"}");
        }
    } else {
        // If any of the required parameters are missing, return an error message in JSON
        out.println("{\"message\": \"Please enter a valid username, security question, and security answer.\"}");
    }
%>
