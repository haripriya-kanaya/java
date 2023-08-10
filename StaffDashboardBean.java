package com.infinite.java;

import java.io.Serializable;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.faces.event.ComponentSystemEvent;

@ManagedBean(name = "staffDashboardBean")
@SessionScoped
public class StaffDashboardBean implements Serializable {
    private String loggedInUsername;
    private Staff loggedInStaff;

    @ManagedProperty(value = "#{bookingDAO}")
    private BookingDAO bookingDAO;

    // Getter and Setter methods for loggedInUsername and loggedInStaff

    public void setBookingDAO(BookingDAO bookingDAO) {
        this.bookingDAO = bookingDAO;
    }

    public void init(ComponentSystemEvent event) {
        // Retrieve the logged-in username from the session or authentication mechanism
        // Set the loggedInUsername property

        // Retrieve the staff details for the logged-in username
        loggedInStaff = bookingDAO.getBookingByUsername(loggedInUsername);

        if (loggedInStaff == null) {
            // The logged-in user does not exist in the staff table
            // You can handle this case by redirecting to an error page or displaying a message
            // For example:
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "User not found", "The logged-in user does not exist in the staff table."));
        }
    }
}
