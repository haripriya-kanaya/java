package com.infinite.java;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SecurityAnswerServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/priya";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "india@123";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        String expectedSecurityAnswer = getExpectedSecurityAnswer(username);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print(expectedSecurityAnswer);
        out.flush();
    }

    private String getExpectedSecurityAnswer(String username) {
        String expectedSecurityAnswer = null;

        try {
            Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            String sql = "SELECT Securityanswer FROM reg WHERE username = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                expectedSecurityAnswer = resultSet.getString("Securityanswer");
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return expectedSecurityAnswer;
    }
}
