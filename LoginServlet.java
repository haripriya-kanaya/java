package com.infinite.java;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // You should perform authentication against your database or any other method
        // For simplicity, we'll simulate successful login with a hardcoded username and password
        if ("user123".equals(username) && "pass456".equals(password)) {
            // Create a session and store the username in it
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            // Redirect to the dashboard or any other protected page
            response.sendRedirect("Newjsp.jsp");
        } else {
            // Invalid credentials, redirect back to the login page with an error message
            response.sendRedirect("login.xhtml?error=1");
        }
    }
}

