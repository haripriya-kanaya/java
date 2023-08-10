package com.infinite.java;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New password and confirm password do not match");
            request.setAttribute("username", username);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Check if the user is registered
        boolean isUserExist = ForgotPasswordDAO.isUserExist(username);
        if (!isUserExist) {
            request.setAttribute("errorMessage", "User not registered");
            request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
            return;
        }

        // Perform password reset logic
        String resetMessage = ForgotPasswordDAO.resetPassword(username, newPassword);

        request.setAttribute("errorMessage", resetMessage);
        request.setAttribute("username", username);
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }
}
