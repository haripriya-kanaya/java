<%@ page import="com.infinite.java.ForgotPassword1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.infinite.java.Regstration" %>

<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
     <style>
         body {
  background-image: url("https://img.freepik.com/premium-photo/green-bokeh-textured-background-illustration_53876-150075.jpg?w=360");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  background-size: 3000px 2000px;
}

        h1 {
            text-align: center;
        }

        form {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px #ccc;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .password-fields {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .password-fields label {
            flex-basis: 48%;
        }

        .password-strength {
            color: #777;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .button-container a {
            text-decoration: none;
            color: #000;
            padding: 10px 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .button-container a:hover {
            background-color: #f5f5f5;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }

        .success-message {
            color: green;
            margin-top: 10px;
        }
    </style>
    <script>
       
        	function validateForm() {
        	    var password = document.getElementById("password").value;
        	    var confirmpassword = document.getElementsByName("confirmpassword")[0].value;
        	    var passwordMatchMessage = document.getElementById("passwordMatchMessage");
        	    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&amp;+=]).{8,}$/;

        	    if (!regex.test(password)) {
        	        passwordMatchMessage.innerHTML = "New Password should be exactly 8 characters long, including one uppercase letter, one lowercase letter, one digit, and one special character.";
        	        return false;
        	    }

        	    if (password !== confirmpassword) {
        	        passwordMatchMessage.innerHTML = "New Password does not match with Confirm Password.";
        	        return false;
        	    }

        	    return true;
        	}
        	           
        
    </script>
</head>
<body>
    <h1>Forgot Password</h1>
  <%
    if (request.getMethod().equals("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");

        if (password != null && password.equals(confirmpassword)) {
            String securityQuestion1 = request.getParameter("securityQuestion1");
            String securityAnswer1 = request.getParameter("securityAnswer1");
            String securityQuestion2 = request.getParameter("securityQuestion2");
            String securityAnswer2 = request.getParameter("securityAnswer2");

            if (ForgotPassword1.isUserExist(username)) {
                boolean isValidUser = ForgotPassword1.checkSecurityQuestion(username, securityQuestion1, securityAnswer1, securityQuestion2, securityAnswer2);

                if (isValidUser) {
                    // If user exists and security questions/answers are correct, proceed with password reset
                    Regstration registration = new Regstration();
                    registration.setUsername(username);
                    registration.setPassword(password);

                    // Create an instance of ForgotPassword1
                    ForgotPassword1 forgotPassword1 = new ForgotPassword1();

                    // Call the forgotpassword method and get the password update status
                    boolean isPasswordUpdated = forgotPassword1.forgotpassword(registration);

                    if (isPasswordUpdated) {
                        // Password updated successfully
                        out.println("Password changed successfully. Redirecting to login page...");
                        // Redirect to the login page after successful password reset
                        response.sendRedirect("Login.xhtml");
                        return;
                    } else {
                        // Handle the case if the password update was not successful
                        // For example, display an error message
                        request.setAttribute("error", "New Password does not match the last three passwords.");
                    }
                } else {
                    // Set the error message as an attribute to be accessed below the form
                    request.setAttribute("error", "Security Questions And Answers Are Incorrect.");
                }
            } else {
                request.setAttribute("error", "User does not exist.");
            }
        } else {
            request.setAttribute("error", "Passwords do not match.");
        }
    }
%>
    <form action="Reset.jsp" method="post" onsubmit="return validateForm();">
        <label for="username">Username:</label>
        <input type="text" name="username" required><br>

        <label for="securityQuestion1">Security Question 1:</label>
        <select id="securityQuestion1" name="securityQuestion1" required onchange="removeSelectedOption();">
            <option value="What was your childhood nickname?">What was your childhood nickname?</option>
            <option value="What is the name of your first pet?">What is the name of your first pet?</option>
            <option value="In which city were you born?">In which city were you born?</option>
        </select><br>

        <label for="securityAnswer1">Security Answer 1:</label>
        <input type="text" name="securityAnswer1" required><br>

        <label for="securityQuestion2">Security Question 2:</label>
        <select name="securityQuestion2" required>
            <option value="What was your childhood nickname?">What was your childhood nickname?</option>
            <option value="What is the name of your first pet?">What is the name of your first pet?</option>
            <option value="In which city were you born?">In which city were you born?</option>
        </select><br>

        <label for="securityAnswer2">Security Answer 2:</label>
        <input type="text" name="securityAnswer2" required><br>
        
        <div class="password-fields">
            <label for="password">New Password:</label>
            <input type="password" name="password" id="password"  required>
            </div>
            
             <div class="password-fields">
            <label for="confirmpassword">Confirm Password:</label>
            <input type="password" name="confirmpassword" required><br><br>
            <span id="passwordMatch"></span><br>
            <span id="passwordMatchMessage" style="color:red;"></span><br> <!-- Added span element for the message -->
            <br>
        </div>
        
        <% 
            if (request.getParameter("confirmpassword") != null) {
                String password = request.getParameter("password");
                String confirmpassword = request.getParameter("confirmpassword");
                if (!password.equals(confirmpassword)) {
        %>
                    <script>
                        document.getElementById('passwordMatchMessage').innerHTML = 'New Password does not match with Confirm Password.';
                    </script>
        <%
                }
            }
        %>


      <c:if test="${not empty message}">
        <div style="color: green;">${message}</div>
    </c:if>

    <!-- Display the error message below the form if it exists -->
    <c:if test="${not empty error}">
        <div style="color: red;">${error}</div>
    </c:if>
       
   

        <div class="button-container">
            <input type="submit" class="btn btn-dark" value="Submit" />
            <a href="Login.xhtml" class="btn btn-dark">Back</a>
            

        </div>
    </form>

</body>
</html>
