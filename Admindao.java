package com.infinite.java;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;


import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

@ManagedBean(name = "Admindao")
@SessionScoped
public class Admindao {
	SessionFactory sessionFactory;
//	   private SessionFactory sessionFactory;
//	   
	   
	   public Admindao() {
		   sessionFactory = SessionHelper.getConnection();
	         Session session = sessionFactory.openSession();
	         
	    }
	   
	   
	   
	   public String addUser(Admin admin) {
		    if (admin == null) {
		        return "error"; // or any appropriate error message
		    }
		    
		    try {
		        sessionFactory = SessionHelper.getConnection();
		        Session session = sessionFactory.openSession();
		        
		        String id = Generateid();
		        System.out.println("Generated Id is " + id);
		        
		        admin.setAdminid(id);
		       
		        Transaction transaction = null;
		        try {
		            transaction = session.beginTransaction();
		            
		            // Check if the vehicle number already exists
		            String vehicleNumberExists = isVehicleNumberExist(admin.getVehiclenumber());
		            if (vehicleNumberExists != null) {
		                // The vehicle number already exists, handle accordingly (e.g., show an error message)
		                return "error";
		            }
		            
		         // Perform additional validations here
		            if (admin.getVehiclenumber() == null || admin.getVehiclenumber().isEmpty()) {
		                return "Vehicle number cannot be empty";
		            }
		            
		           
		            // Set the current date and time
		            admin.setIntime(new Date());
		            
		            
		           
		            session.save(admin);
		            transaction.commit();
		            System.out.println("Saved");
		            
		            return "success"; // or any appropriate success message
		        } catch (Exception e) {
		            if (transaction != null) {
		                transaction.rollback();
		            }
		            e.printStackTrace();
		            return "error"; // or any appropriate error message
		        } finally {
		            session.close();
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        return "error"; // or any appropriate error message
		    }
		}

	   
	   public String isVehicleNumberExist(String vehiclenumber) {
		    Session session = null;
		    try {
		        session = sessionFactory.openSession();

		        Criteria criteria = session.createCriteria(Admin.class);
		        criteria.add(Restrictions.eq("vehiclenumber", vehiclenumber));
		        criteria.setProjection(Projections.rowCount());
		        Long count = (Long) criteria.uniqueResult();

		        if (count > 0) {
		            // Vehicle number exists
		            return "Vehicle number already exists.";
		        } else {
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

	   
	private String Generateid() {
        sessionFactory = SessionHelper.getConnection();
        Session session = sessionFactory.openSession();
        Criteria cr = session.createCriteria(Admin.class);
        List<Admin> regstrationList = cr.list();
        session.close();
        if (regstrationList.size() == 0) {
            System.out.println("List Checked");
            return "A001";
        } else {
            String uid = regstrationList.get(regstrationList.size() - 1).getAdminid();
            int uidNumber = Integer.parseInt(uid.substring(1));
            uidNumber++;
            String newUid = String.format("A%03d", uidNumber);

            return newUid;
        }
    }
	
	 public List<Admin> getAllBookedSlots() {
	        Session session = sessionFactory.openSession();
	        try {
	            Criteria criteria = session.createCriteria(Admin.class);
	            return criteria.list();
	        } finally {
	            session.close();
	        }
	    }
	 
	 
	 public List<Staff>  getStaffByCategory(String category) {
		    SessionFactory sessionFactory = SessionHelper.getConnection();
		    Session session = sessionFactory.openSession();
		    List<Staff> staffList = null;

		    try {
		        // Use HQL syntax for the query
		        Query query = session.createQuery("FROM Staff WHERE category = :category");
		        query.setParameter("category", category);

		        
		        // Retrieve all staff members with the specified category
		        staffList = query.list();
		    } finally {
		        session.close();
		    }

		    return staffList;
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
	  
	 
	 public Admin updateOutTime(String vehicleNumber, Date systemTime) {
		    try {
		        Session session = sessionFactory.openSession();
		        Transaction transaction = session.beginTransaction();

		        // Fetch the Admin object by vehicleNumber
		        Admin admin = (Admin) session.createQuery("FROM Admin WHERE vehiclenumber = :vehicleNumber")
		                .setParameter("vehicleNumber", vehicleNumber)
		                .uniqueResult();

		        if (admin != null) {
		            Date existingOutTime = admin.getOuttime();
		            if (existingOutTime == null) {
		                // Create a new Date object by combining the existing date with the system time
		                Date updatedOutTime = new Date(systemTime.getTime());
		                admin.setOuttime(updatedOutTime);

		                // Use merge() to update the entity object in the session
		                session.merge(admin);

		                transaction.commit();
		            } else {
		                // Vehicle has already been exited, return null to indicate failure
		                admin = null;
		            }
		        }

		        session.close();
		        return admin;
		    } catch (Exception e) {
		        e.printStackTrace();
		        return null;
		    }
		}

	
	 public List<Admin>  getAdminByCategory(String category) {
		    SessionFactory sessionFactory = SessionHelper.getConnection();
		    Session session = sessionFactory.openSession();
		    List<Admin> staffList = null;

		    try {
		        // Use HQL syntax for the query
		        Query query = session.createQuery("FROM Admin WHERE category = :category");
		        query.setParameter("category", category);

		        
		        // Retrieve all staff members with the specified category
		        staffList = query.list();
		    } finally {
		        session.close();
		    }

		    return staffList;
		}
	 
	 public Admin getAdminByVehicleNumber(String vehicleNumber) {
	        Session session = null;
	        try {
	            session = HibernateUtil.getSessionFactory().openSession();
	            Criteria criteria = session.createCriteria(Admin.class);
	            criteria.add(Restrictions.eq("vehiclenumber", vehicleNumber));
	            return (Admin) criteria.uniqueResult();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (session != null) {
	                session.close();
	            }
	        }
	        return null;
	    }

	 
	 public Date getOutTimeByVehicleNumber(String vehicleNumber) {
		    // Get the Hibernate Session
		    Session session = HibernateUtil.getSessionFactory().openSession();

		    try {
		        // Create a Criteria instance for the Admin class
		        Criteria criteria = session.createCriteria(Admin.class);

		        // Add a restriction to filter by vehicle number
		        criteria.add(Restrictions.eq("vehiclenumber", vehicleNumber)); // Use "vehiclenumber" here

		        // Set the projection to fetch only the "outtime" property (also in lowercase)
		        criteria.setProjection(Projections.property("outtime"));

		        // Execute the query and get the result
		        Date outtime = (Date) criteria.uniqueResult();

		        return outtime;
		    } catch (Exception e) {
		        // Handle any exceptions or log errors
		        e.printStackTrace();
		    } finally {
		        // Close the session
		        session.close();
		    }

		    return null; // Return null if the outTime is not found for the given vehicle number
		}
}




	   
	  
	  
	
	 
	



	 
	

	
	 
	
	 
	
	
	 
	 
	 
	 
	 
	
	 








