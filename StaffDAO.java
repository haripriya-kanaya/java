package com.infinite.java;

import com.infinite.java.Staff;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.ArrayList;
import java.util.Calendar;


import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@ManagedBean(name = "StaffDAO")
@SessionScoped
public class StaffDAO {
    private SessionFactory sessionFactory;
    
 // Constructor
    public StaffDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
 // Getter and Setter for SessionFactory
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    
    

    public StaffDAO() {
        // Create the Hibernate SessionFactory
        Configuration configuration = new Configuration().configure();
        sessionFactory = configuration.buildSessionFactory();
    }
    
    
    
    
    
   

    public List<Staff> getAllBookedSlots() {
        Session session = sessionFactory.openSession();
        try {
            Criteria criteria = session.createCriteria(Staff.class);
            List<Staff> bookedSlots = criteria.list();

            // Log a message to indicate the successful execution of the method.
            logger.info("getAllBookedSlots() method executed successfully.");

            return bookedSlots;
        } finally {
            session.close();
        }
    }




    
    
    
    
   
    private static final Logger logger = LogManager.getLogger(StaffDAO.class);

    public void bookSlot(String vehicleNumber, Date startDate, Date endDate, String category, String slotNumber,String username) {
    	 Session session = sessionFactory.openSession();
        Transaction transaction = null;
        
        logger.info("Inside bookSlot() method"); // Log message for debugging

       

        logger.debug("Vehicle Number: {}", vehicleNumber);
        logger.debug("Start Date: {}", startDate);
        logger.debug("End Date: {}", endDate);

       


        try {
            transaction = session.beginTransaction();

            // Check if the number of booked slots in the month exceeds the limit
            int bookedSlotsCount = getBookedSlotsCountForMonth(startDate, category);
            int maxSlots = 40; // Set the maximum number of slots available

            if (bookedSlotsCount >= maxSlots) {
                System.out.println("All slots for this month are already booked.");
                // The maximum number of slots has been reached for the current month, handle accordingly (e.g., show an error message)
                return;
            }

            // Check if the slot is available for the given date range
            List<String> bookedSlotNumbers = getBookedSlotNumbers(startDate, endDate);
            if (bookedSlotNumbers.contains(slotNumber)) {
                System.out.println("Slot is already booked for the given date range.");
                // The slot is already booked for the given date range, handle accordingly (e.g., show an error message)
                return;
            }

            // Check if the vehicle number already exists
            String vehicleNumberExists = isVehicleNumberExist(vehicleNumber);
            if (vehicleNumberExists != null) {
                // The vehicle number already exists, handle accordingly (e.g., show an error message)
                return;
            }

            // Check if the slot number already exists
            String slotNumberExists = isSlotNumberExist(slotNumber);
            if (slotNumberExists != null) {
                // The slot number already exists, handle accordingly (e.g., show an error message)
                return;
            }
 
            // Check if the user has already booked a slot
            if (isUsernameAlreadyBooked(username)) {
                System.out.println("You have already booked a slot. You cannot book another one.");
                // Handle the case where the user has already booked a slot (e.g., show an error message)
                return;
            }
            
            // Calculate the total number of days for the booking period
            long totalDays = calculateTotalDays(startDate, endDate);

            // Calculate charges per day based on the category of the vehicle
            double chargesPerDay;
            if (category.equalsIgnoreCase("two wheeler")) {
                chargesPerDay = 10.0;
            } else if (category.equalsIgnoreCase("four wheeler")) {
                chargesPerDay = 20.0;
            } else {
                chargesPerDay = 5.0; // Default value if category is not recognized
            }

            // Calculate the total amount for the entire booking period based on the category
            double totalAmount = totalDays * chargesPerDay;

            if (category.equalsIgnoreCase("two wheeler")) {
                totalAmount *= 1.0; // No additional factor for two-wheelers
            } else if (category.equalsIgnoreCase("four wheeler")) {
                totalAmount *= 1.5; // Additional factor of 1.5 for four-wheelers
            } else {
                totalAmount *= 2.0; // Additional factor of 2.0 for other categories (if category is not recognized)
            }

            logger.debug("Vehicle Number: {}", vehicleNumber);
            logger.debug("Start Date: {}", startDate);
            logger.debug("End Date: {}", endDate);

            // Retrieve the customer ID by username
            String uid = getCustIdByUserName();

            // Create a new Staff object
            Staff staff = new Staff();
            staff.setStaffid(Generateid());
            staff.setBookid(Generateid1());
            staff.setVechilenumber(vehicleNumber);
            staff.setStartdate(startDate);
            staff.setEnddate(endDate);
            staff.setUsername(username);
            staff.setCategory(category);
            staff.setSlotnumber(slotNumber);
            staff.setCalculateamount(totalAmount);
            
            
        
            session.save(staff);
            transaction.commit();
            
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            logger.error("Error occurred during transaction ", e);
            e.printStackTrace();
        } finally {
            session.close();
        }
    }


    
    public long calculateTotalDays(Date startDate, Date endDate) {
        long differenceMillis = endDate.getTime() - startDate.getTime();
        long differenceDays = differenceMillis / (24 * 60 * 60 * 1000);
        return differenceDays + 1; // Add 1 to include both the start and end dates in the count.
    }
    
    
    
    
    public int getBookedSlotsCountForMonth(Date startDate, String category) {
        Session session = sessionFactory.openSession();
        try {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.set(Calendar.DAY_OF_MONTH, 1); // Set the day of the month to 1
            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH) + 1;

            org.hibernate.Query query = session.createQuery(
                    "SELECT COUNT(*) FROM Staff WHERE category = :category AND YEAR(startdate) = :year AND MONTH(startdate) = :month"
            );
            query.setParameter("category", category);
            query.setParameter("year", year);
            query.setParameter("month", month);
            Long result = (Long) query.uniqueResult();

            int bookedSlotsCount = result != null ? result.intValue() : 0;
            int maxSlots = 0;

            // Set the maximum number of slots based on the category
            if (category.equals("two wheeler")) {
                maxSlots = 20;
            } else if (category.equals("four wheeler")) {
                maxSlots = 20;
            } else if (category.equals("Ambulance")) {
                maxSlots = 1;
            }

            if (bookedSlotsCount > maxSlots) {
                // Adjust the number of booked slots to the maximum limit
                bookedSlotsCount = maxSlots;

                // Alternatively, you can throw an exception or handle it in your application logic
                // throw new RuntimeException("Exceeded the maximum number of slots for the month.");
            }
            
            logger.debug("Max Slots: {}", maxSlots);

            

            return bookedSlotsCount;
        } finally {
            session.close();
        }
    }


    

    private String Generateid() {
        sessionFactory = SessionHelper.getConnection();
        Session session = sessionFactory.openSession();
        Criteria cr = session.createCriteria(Staff.class);
        List<Staff> staffList = cr.list();
        session.close();
        
        if (staffList.size() == 0) {
            System.out.println("List Checked");
            return "S001";
        } else {
            String staffid = staffList.get(staffList.size() - 1).getStaffid();
            int staffNumber = Integer.parseInt(staffid.substring(1));
            staffNumber++;
            String newStaffid = String.format("S%03d", staffNumber);

            return newStaffid;
        }
    }

    private String Generateid1() {
        sessionFactory = SessionHelper.getConnection();
        Session session = sessionFactory.openSession();
        Criteria cr = session.createCriteria(Staff.class);
        List<Staff> staffList = cr.list();
        session.close();
        
        if (staffList.size() == 0) {
            System.out.println("List Checked");
            return "B001";
        } else {
            String staffid = staffList.get(staffList.size() - 1).getStaffid();
            int staffNumber = Integer.parseInt(staffid.substring(1));
            staffNumber++;
            String newStaffid = String.format("B%03d", staffNumber);

            return newStaffid;
        }
    }
    
    
    public String isVehicleNumberExist(String vechilenumber) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            Criteria criteria = session.createCriteria(Staff.class);
            criteria.add(Restrictions.eq("vechilenumber", vechilenumber));
            criteria.setProjection(Projections.rowCount());
            Long count = (Long) criteria.uniqueResult();

            if (count > 0) {
                // Vehicle number exists
                return "Vehicle number already exists.";
            }
            else {
                // Vehicle number does not exist
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return null;
    }
    
    

    public String isSlotNumberExist(String slotnumber) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            Criteria criteria = session.createCriteria(Staff.class);
            criteria.add(Restrictions.eq("slotnumber", slotnumber));
            criteria.setProjection(Projections.rowCount());
            Long count = (Long) criteria.uniqueResult();

            if (count > 0) {
                // Slot number already exists
                return "The selected slot number is already booked. Please choose another slot.";
            } else {
                // Slot number does not exist
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return null;
    }

    

   

   
    public List<String> getAvailableSlotNumbers(Date startDate, Date endDate) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            // Retrieve the list of all slot numbers
            Criteria criteria = session.createCriteria(Staff.class);
            criteria.setProjection(Projections.property("slotnumber"));
            List<String> allSlotNumbers = criteria.list();

            // Retrieve the list of booked slot numbers that do not overlap with the specified range
            Criteria bookedCriteria = session.createCriteria(Staff.class);
            bookedCriteria.add(
                Restrictions.or(
                    Restrictions.gt("enddate", endDate),
                    Restrictions.lt("startdate", startDate)
                )
            );
            bookedCriteria.setProjection(Projections.property("slotnumber"));
            List<String> bookedSlotNumbers = bookedCriteria.list();

            // Create a new list for available slot numbers
            List<String> availableSlotNumbers = new ArrayList<String>(allSlotNumbers);

            // Exclude the booked slot numbers from the available slot numbers
            availableSlotNumbers.removeAll(bookedSlotNumbers);

            return availableSlotNumbers;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return new ArrayList<String>(); // Return an empty list if an error occurs
    }

    public List<String> getBookedSlotNumbers(Date startdate, Date enddate) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            // Retrieve the list of booked slot numbers for the given date range
            Criteria criteria = session.createCriteria(Staff.class);
            criteria.add(Restrictions.between("startdate", startdate, enddate));
            criteria.setProjection(Projections.property("slotnumber"));
            List<String> bookedSlotNumbers = criteria.list();

            return bookedSlotNumbers;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return new ArrayList<String>(); // Return an empty list if an error occurs
    }
  
   

    
    public Staff getStaffByStaffId(String staffId) {
        Session session = sessionFactory.openSession();
        try {
            Criteria criteria = session.createCriteria(Staff.class);
            criteria.add(Restrictions.eq("staffid", staffId));
            return (Staff) criteria.uniqueResult();
        } finally {
            session.close();
        }
    }
    
    
    public void updateStaffByStaffId(String staffId, Date startDate, Date endDate, double calculatedamount) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();

            // Retrieve the staff record based on staffId
            Staff staff = getStaffByStaffId(staffId);

            // Update the startDate and endDate fields with the new values
            if (staff != null) {
                staff.setStartdate(startDate);
                staff.setEnddate(endDate);
                staff.setCalculateamount(calculatedamount);
                
              
                // Save the updated staff record
                session.update(staff);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    
    private static Date createDate(int year, int month, int day) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month - 1, day);
        return calendar.getTime();
    }
    
   

    public String getCustIdByUserName() {
        try {
            FacesContext context = FacesContext.getCurrentInstance();
            ExternalContext externalContext = context.getExternalContext();

            Map<String, Object> sessionMap = externalContext.getSessionMap();
            String userNameString = (String) sessionMap.get("userName");

            sessionFactory = SessionHelper.getConnection();
            Session session = sessionFactory.openSession();

            String query = "SELECT uid FROM Regstration WHERE username = :username";
            String uid = (String) session.createQuery(query)
                                       .setParameter("username", userNameString)
                                       .uniqueResult();

            session.close();
            return uid;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    
    public double calculateRefundAmount(Date initialStartDate, Date initialEndDate, Date updatedEndDate, String category) {
	    // Calculate the initial duration in days
	    long initialDurationInMillis = initialEndDate.getTime() - initialStartDate.getTime();
	    int initialDays = (int) (initialDurationInMillis / (24 * 60 * 60 * 1000)) + 1;

	    // Calculate the updated duration in days
	    long updatedDurationInMillis = updatedEndDate.getTime() - initialStartDate.getTime();
	    int updatedDays = (int) (updatedDurationInMillis / (24 * 60 * 60 * 1000)) + 1;

	    // Calculate the refund amount based on the category
	    double refundAmount = 0.0;

	    if (category.equals("two-wheeler")) {
	        refundAmount = (initialDays - updatedDays) * 10;
	    } else if (category.equals("four-wheeler")) {
	        refundAmount = (initialDays - updatedDays) * 20;
	    }

	    return refundAmount;
	}
	
	
	
	    public double calculatePenaltyAmount(Date initialEndDate, Date updatedEndDate, String category) {
	        // Calculate the delay in days
	        long delayInMillis = updatedEndDate.getTime() - initialEndDate.getTime();
	        int delayDays = (int) (delayInMillis / (24 * 60 * 60 * 1000));

	        // Calculate the penalty amount based on the category
	        double penaltyAmount = 0.0;

	        if (category.equals("two-wheeler")) {
	            penaltyAmount = delayDays * 5;
	        } else if (category.equals("four-wheeler")) {
	            penaltyAmount = delayDays * 7;
	        }

	        return penaltyAmount;
	    }
	    
	    
	    public void removeStaffByStaffId(String staffId) {
	    	  Session session = sessionFactory.openSession();
	    	  Transaction transaction = null;

	    	  try {
	    	    transaction = session.beginTransaction();

	    	    String hql = "DELETE FROM Staff WHERE staffId = :id";
	    	    Query query = session.createQuery(hql);
	    	    query.setParameter("id", staffId);

	    	    int rowsAffected = query.executeUpdate();
	    	    if (rowsAffected > 0) {
	    	      System.out.println("Staff record with ID " + staffId + " has been removed.");
	    	    } else {
	    	      System.out.println("No staff record found with ID " + staffId + ".");
	    	    }

	    	    transaction.commit();
	    	  } catch (Exception e) {
	    	    if (transaction != null) {
	    	      transaction.rollback();
	    	    }
	    	    e.printStackTrace();
	    	  } finally {
	    	    session.close();
	    	  }
	    	}


	    
	    public Staff getStaffByUsername(String username) {
	        Session session = sessionFactory.openSession();
	        try {
	            Criteria criteria = session.createCriteria(Staff.class);
	            criteria.createAlias("user", "u");
	            criteria.add(Restrictions.eq("u.username", username));
	            return (Staff) criteria.uniqueResult();
	        } finally {
	            session.close();
	        }
	    }
	    
	    
	    public List<String> getBookedSlotNumbersForDateRange(Date startdate, Date enddate) {
	        List<String> bookedSlotNumbers = new ArrayList<>();
	        Session session = null;
	        try {
	            session = sessionFactory.openSession();

	            // Retrieve all records within the specified date range
	            Criteria criteria = session.createCriteria(Staff.class);
	            criteria.add(Restrictions.le("startdate", enddate)); // Check if the start date is less than or equal to the end date
	            criteria.add(Restrictions.ge("enddate", startdate)); // Check if the end date is greater than or equal to the start date

	            // Execute the query to get the booked slot numbers
	            List<Staff> staffList = criteria.list();

	            for (Staff staff : staffList) {
	                bookedSlotNumbers.add(staff.getSlotnumber());
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (session != null) {
	                session.close();
	            }
	        }

	        return bookedSlotNumbers;
	    }

	    
	 // Assuming you have a list of all slots (e.g., SLOT1, SLOT2, ..., SLOT20)
	    private static final List<String> allSlots = new ArrayList<>();

	    static {
	        for (int i = 1; i <= 20; i++) {
	            allSlots.add("SLOT" + i);
	        }
	    }

	    // Mocked booked slots for testing purposes
	    private List<String> bookedSlotNumbers = new ArrayList<>();

	    // ... (other methods in the StaffDAO class)

	    public List<String> getAvailableSlotsForDateRange(Date startDate, Date endDate) {
	        List<String> bookedSlots = getBookedSlotNumbersForDateRange(startDate, endDate);

	        // Create a copy of allSlots to work with
	        List<String> availableSlots = new ArrayList<>(allSlots);

	        // Remove booked slots from the list of available slots
	        availableSlots.removeAll(bookedSlots);

	        return availableSlots;
	    }
	    
	    
	    public List<Admin> getAllBookedSlots1() {
	        Session session = sessionFactory.openSession();
	        try {
	            Criteria criteria = session.createCriteria(Admin.class);
	            return criteria.list();
	        } finally {
	            session.close();
	        }
	    }

	    public boolean isUsernameAlreadyBooked(String username) {
	        Session session = sessionFactory.openSession();
	        try {
	            Query query = session.createQuery("SELECT COUNT(*) FROM Staff WHERE username = :username");
	            query.setParameter("username", username);
	            Long count = (Long) query.uniqueResult();
	            return count != null && count > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        } finally {
	            session.close();
	        }
	    }
	    
	    
	  
	        // Method to calculate the difference between StartDate and EndDate
	        public long getDaysDifference(String staffId) {
	            Staff staff = getStaffByStaffId(staffId);
	            if (staff == null) {
	                return -1; // Return -1 if staff not found or other error
	            }

	            Date startDate = staff.getStartdate();
	            Date endDate = staff.getEnddate();

	            // Calculate the time difference in milliseconds
	            long timeDifference = endDate.getTime() - startDate.getTime();
	            // Convert the difference to days
	            return timeDifference / (24 * 60 * 60 * 1000);
	        }
	    }

	    
	    


