package com.infinite.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean(name = "BookingDAO")
@SessionScoped
public class BookingDAO {
    
    private Connection connection;

    // Initialize the BookingDAO with a database connection
    public BookingDAO(Connection connection) {
        this.connection = connection;
    }

    public Staff getBookingByUsername(String username) {
        Staff staff = null;
       
        String staffQuery = "SELECT * FROM staff WHERE username = ?";

        try (PreparedStatement staffStatement = connection.prepareStatement(staffQuery)) {
            staffStatement.setString(1, username);
            ResultSet staffResultSet = staffStatement.executeQuery();

            if (staffResultSet.next()) {
                // Retrieve staff details
                String bookingUsername = staffResultSet.getString("username");
                
                // Check if the booking username matches the logged-in username
                if (username.equals(bookingUsername)) {
                    // Retrieve other staff details
                    String staffId = staffResultSet.getString("staffid");
                    String vehicleNumber = staffResultSet.getString("vechilenumber");
                    Date startDate = staffResultSet.getDate("startdate");
                    Date endDate = staffResultSet.getDate("enddate");
                    String category = staffResultSet.getString("category");

                 // Now you can use the `category` variable, for example:
                 System.out.println("Staff category: " + category);

                    // Create a new Staff object
                    staff = new Staff();
                    staff.setUsername(username);
                    staff.setStaffid(staffId);
                    staff.setVechilenumber(vehicleNumber);
                    staff.setStartdate(startDate);
                    staff.setEnddate(endDate);
                    staff.setCategory(category);

                    // Retrieve more staff details and set them in the Staff object as needed
                }
            }

            staffResultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return staff;
    }
    
    

}
