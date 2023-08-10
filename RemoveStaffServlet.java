package com.infinite.java;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RemoveStaffServlet extends HttpServlet {

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    // Get the staffId from the request parameters
    String staffId = request.getParameter("staffId");

    // Call the method to remove the staff record based on the staffId
    StaffDAO staffDAO = new StaffDAO();
    staffDAO.removeStaffByStaffId(staffId);

    // Send a success response (you may customize the response based on your needs)
    response.getWriter().write("Staff record with ID " + staffId + " has been removed.");
  }
}
