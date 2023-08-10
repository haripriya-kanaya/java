package com.infinite.java;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.infinite.java.Resetdao;

public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String enteredAnswer = request.getParameter("securityAnswer");

        Resetdao resetdao = new Resetdao();
        List<String[]> securityInfoList = resetdao.getSecurityInfoByUsername(username);

        if (securityInfoList != null && !securityInfoList.isEmpty()) {
            String storedAnswer = securityInfoList.get(0)[1];
            if (storedAnswer.equals(enteredAnswer)) {
                // Here you can implement the password reset logic and set the new password for the user in the database
                // For simplicity, let's assume the password is reset to a fixed value "newPassword123" for demonstration purposes
                String newPassword = "newPassword123";
                // Implement your password update logic here, and you can display a message or redirect to a success page.
                request.setAttribute("newPassword", newPassword);
                request.getRequestDispatcher("Reset.jsp").forward(request, response);
            } else {
                // Incorrect security answer
                request.setAttribute("error", "Invalid security question or answer");
                request.getRequestDispatcher("Reset.jsp").forward(request, response);
            }
        } else {
            // User not found in the database
            request.setAttribute("error", "User not found");
            request.getRequestDispatcher("Reset.jsp").forward(request, response);
        }
    }
}
