<%@page import="java.io.IOException"%>
<%@page import="com.infinite.java.ForgotPasswordDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #F8F8F8;
        }
            h1 {
        text-align: center;
        margin-top: 50px;
        margin-bottom: 30px;
    }

    form {
        width: 30%;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 60px;
        box-shadow: 0px 0px 10px #ccc;
    }

    label {
        font-weight: bold;
        font-size: 16px;
    }
      #passwordMatchMessage {
        display: block;
        margin-top: -30px; /* Adjusted the negative margin value to move the message upward */
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: none;
        border-radius: 5px;
        box-shadow: 0px 0px 5px #ccc;
    }

    input[type="submit"] {
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
    }
    .custom-btn {
  background-color: #007bff;
  color: #fff;
}
body {
  background-image: url("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2mGEapf5shKOXUDGaoDR5tPa-tHwadH7uqw&usqp=CAU");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  background-size: 3000px 2000px;
}

    .error {
        color: red;
        margin-bottom: 10px;
    }

    .success {
        color: green;
        margin-bottom: 10px;
    }
    .button-container {
  display: flex;
  justify-content: flex;
  gap: 10px;
}

.btn {
  flex: 1;
  max-width: 150px;
}
 form {
        width: 40%; /* Decreased the width to 40% */
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 60px;
        box-shadow: 0px 0px 10px #ccc;
    }
     input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px; /* Decreased the margin-bottom to 10px */
        border: none;
        border-radius: 5px;
        box-shadow: 0px 0px 5px #ccc;
    }
 .password-fields {
        display: flex;
        flex-direction: column;
        gap: 2px; /* Decreased the gap between fields to 5px */
    }
    .button-container {
        display: flex;
        justify-content: flex;
        gap: 10px;
        margin-top: -40px; /* Adjust the negative margin value to move the buttons upward */
    }
      
}
 form {
        width: 40%;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 60px;
        box-shadow: 0px 0px 10px #ccc;
        margin-left: 5%; /* Adjusted the left margin to move the form slightly to the left */
    }
     h1 {
        text-align: left; /* Set the text alignment to left */
        margin-top: 50px;
        margin-bottom: 30px;
        margin-left: 9%; /* Adjust the left margin to move the heading to the left */
    }
    .password-fields input[type="password"] {
    margin-bottom: -10px; /* Adjust the value as desired to decrease the space */
}
   
    
   .btn-dark.custom-btn {
  background-color: #007bff;
  color: #fff;
}
.password-fields {
    display: flex;
    flex-direction: column;
    gap: 0px; /* Adjust the value as desired to decrease the space */
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

    <div class="container">
   
   <h1 style="text-align: left; margin-top: 30px; margin-bottom: 10px; font-size: 26px; margin-left: 40%; ">Reset Password</h1>
 


	<c:if test="${not empty error}">
		<div style="color: red;">${error}</div>
	</c:if>

	<form method="post" action="ForgetPassword.jsp" onsubmit="return validateForm() && validateSecurityQuestion();" style="width: 42%;">

		<label for="username"style="font-size: 14px;">User Name:</label>
		<input type="text" name="username" required pattern="^[A-Z][a-z]{2,14}$"><span id="usernameError" style="color: red;"></span><br><br>
		
		
      
<label for="oldpassword" style="font-size: 14px;">Old Password:</label>
<input type="password" name="oldpassword" id="oldpassword" required>
<span id="oldpasswordError" style="color: red;"></span>

<script>
  var oldpasswordInput = document.getElementById("oldpassword");
  var oldpasswordError = document.getElementById("oldpasswordError");

  oldpasswordInput.addEventListener("blur", function() {
    var oldpasswordValue = oldpasswordInput.value;
    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$/;

    if (!regex.test(oldpasswordValue)) {
      oldpasswordError.textContent = "The Password consist the characers,numbers and special symbols.";
    } else {
      oldpasswordError.textContent = "";
    }
  });
</script>
         <div class="password-fields">
		<label for="password" style="font-size: 14px;">New Password:</label>
		<input type="password" name="password" id="password" onkeyup="checkPasswordStrength()" required>
       <p id="password-strength-text"></p><br><br>
      
         <label for="confirmpassword" style="font-size: 16px;">Confirm Password:</label>
		<input type="password" name="confirmpassword" style="margin-top: -5px;"required><br><br>
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


  <div class="button-container">
  <input type="submit" class="btn btn-dark" value="Reset Password" />
 <a href="Login.xhtml" class="btn btn-dark custom-btn">Back</a>

</div>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String confirmpassword = request.getParameter("confirmpassword");
String validationMessage = null;
if (username != null) {
    boolean userExists = ForgotPasswordDAO.isUserExist(username);

    if (!userExists) {
%>
        <p style="color: red;">User does not exist.</p>
<%
    }
}
 if (password != null && password.equals(confirmpassword)) {
    if (ForgotPasswordDAO.isUserExist(username)) {
        String oldpassword = ForgotPasswordDAO.getOldPassword(username); // Retrieve the old password from the database
        String newpassword = password; // Assign the value of 'password' to 'newpassword'

        if (oldpassword != null && !oldpassword.equals(newpassword)) { // Compare the new password with the old password
            ForgotPasswordDAO.resetPassword(username, newpassword);
            request.setAttribute("message", "Password changed successfully");
            response.sendRedirect("Login.xhtml");
            return;
        } else {
            request.setAttribute("error", "New password cannot be the same as the old password");
        }
    } else {
        request.setAttribute("error", validationMessage);
    }
} else {
    request.setAttribute("error", "Passwords do not match");
}
 
%>

</form>

	
     <div id="error" style="color: red;"></div>
	<c:if test="${not empty message}">
		<div style="color: green;">${message}</div>
	</c:if>
		</div>


<script>
function validateForm() {
    var oldPassword = document.getElementById("oldpassword").value;
    var newPassword = document.getElementById("password").value;
    var confirmPassword = document.getElementsByName("confirmpassword")[0].value;
    var passwordMatchMessage = document.getElementById("passwordMatchMessage");
    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$/;
    if (!regex.test(newPassword)) {
        passwordMatchMessage.innerHTML = "New Password should have atleast 8 charcters including numbers and specialsymbols";
        return false;
    }
    

    if (oldPassword === newPassword) {
        passwordMatchMessage.innerHTML = "New Password should be different from the Old Password.";
        return false;
    }
    

    if (newPassword !== confirmPassword) {
        passwordMatchMessage.innerHTML = "New Password does not match with Confirm Password.";
        return false;
    }

    return true;
}

</script>

<script>
    var usernameInput = document.getElementById("username");
    var usernameError = document.getElementById("usernameError");

    usernameInput.addEventListener("blur", function() {
        var username = usernameInput.value;
        var regex = /^[A-Z][a-z]{2,14}$/;

        if (!regex.test(username)) {
            usernameError.textContent = "Username must start with an uppercase letter and have 2 to 14 lowercase letters.";
        } else {
            usernameError.textContent = "";
        }
    });
</script>

</body>
</html>

