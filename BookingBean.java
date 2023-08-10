package com.infinite.java;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.SessionScoped;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@ManagedBean
@SessionScoped
public class BookingBean implements Serializable {

    @ManagedProperty("#{bookingDAO}")
    private BookingDAO bookingDAO;

    private Staff bookingDetails;

    public BookingBean() {
        // Create a database connection
        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/priya", "root", "india@123");
            bookingDAO = new BookingDAO(connection);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void fetchBookingDetails(String username) {
        bookingDetails = bookingDAO.getBookingByUsername(username);
    }

    public Staff getBookingDetails() {
        return bookingDetails;
    }

    public BookingDAO getBookingDAO() {
        return bookingDAO;
    }

    public void setBookingDAO(BookingDAO bookingDAO) {
        this.bookingDAO = bookingDAO;
    }
}
