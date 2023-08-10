package com.infinite.java;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ExitServlet")
public class ExitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleNumber = request.getParameter("vehicleNumber");
        Date systemTime = new Date(); // Get the current system time
        
        // Assuming you have a method named updateOutTime in your Admindao class
        Admindao adminDAO = new Admindao();
        Admin updatedAdmin = adminDAO.updateOutTime(vehicleNumber, systemTime);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (updatedAdmin != null) {
            Date updatedOutTime = updatedAdmin.getOuttime();
            String formattedOutTime = updatedOutTime != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(updatedOutTime) : "N/A";
            out.println("success");
            out.println("Updated Out Time: " + formattedOutTime);
        } else {
            out.println("error");
        }
    }
}
