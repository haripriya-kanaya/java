package com.infinite.java;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;


public class ForgotPassword1 {
	
	public static boolean isUserExist(String username) {
	    try {
	        SessionFactory sessionFactory = SessionHelper.getConnection();
	        Session session = sessionFactory.openSession();
	        Long count = (Long) session.createQuery("SELECT COUNT(*) FROM Regstration WHERE UserName = :username")
	                                   .setParameter("username", username).uniqueResult();
	        session.close();

	        System.out.println("Count for username " + username + ": " + count); // Debug print

	        if (count != null && count == 1) {
	            return true;
	        } else {
	            System.out.println("User does not exist."); // Display validation message
	            return false;
	        }

	    } catch (Exception e) {
	        // Handle the exception appropriately
	        e.printStackTrace(); // You can print the stack trace for debugging purposes

	        // Return a default value or throw a custom exception depending on your requirements
	       
	    }
	    return false;
	}

	
	public boolean forgotpassword(Regstration regstration) {
	    if (regstration == null) {
	        System.out.println("Registration object is null");
	        return false;
	    }

	    try {
	        // Check if the user exists using the isUserExist method
	        if (isUserExist(regstration.getUsername())) {
	            // User exists, proceed with the password reset logic

	            Session session = SessionHelper.getConnection().openSession();
	            Transaction transaction = session.beginTransaction();

	            Regstration cust = search(regstration.getUsername());
	            System.out.println(cust.getUsername());

	            String newPassword = regstration.getPassword();
	            String oldPassword1 = cust.getPassword();
	            String oldPassword2 = cust.getLastpassword();
	            String oldPassword3 = cust.getPassword2();

	            System.out.println(newPassword);
	            System.out.println(oldPassword1);
	            System.out.println(oldPassword2);
	            System.out.println(oldPassword3);

	            // Check if the new password matches any of the customer's previous three passwords
	            if (!newPassword.equals(oldPassword1)
	                    && !newPassword.equals(oldPassword2)
	                    && !newPassword.equals(oldPassword3)) {

	                // Check if the new password is not the same as the last three passwords
	                if (!newPassword.equals(oldPassword1)
	                        && !newPassword.equals(oldPassword2)
	                        && !newPassword.equals(oldPassword3)) {

	                    // Update the previous passwords
	                    cust.setPassword2(oldPassword2); // Move oldPassword2 to Password2
	                    cust.setLastpassword(oldPassword1); // Move oldPassword1 to Lastpassword
	                    cust.setPassword(newPassword); // Set the new password in the Password field

	                    // Now you can save the updated entity without explicitly setting the ID
	                    session.update(cust); // Use session.update() to update the existing entity
	                    transaction.commit();
	                    System.out.println("Password updated successfully");
	                    session.close();
	                    return true;
	                } else {
	                    // The new password is the same as one of the previous three passwords
	                    // You can use a request attribute to store the error message for display on the JSP page
	                    System.out.println("New password cannot be the same as the last 3 passwords");
	                    session.close();
	                    return false;
	                }
	            } else {
	                // The new password matches one of the previous three passwords
	                // You can use a request attribute to store the error message for display on the JSP page
	                System.out.println("New password must not match previous 3 passwords");
	                session.close();
	                return false;
	            }
	        } else {
	            // Handle case when user is not found
	            System.out.println("User not found");
	            return false;
	        }

	    } catch (Exception e) {
	        // Handle the exception appropriately
	        e.printStackTrace(); // You can print the stack trace for debugging purposes
	        return false;
	    }
	}


	public Regstration search(String username) {
		  SessionFactory sessionFactory = SessionHelper.getConnection();
	        Session session = sessionFactory.openSession();
	   	Criteria criteria = session.createCriteria(Regstration.class);
		criteria.add(Restrictions.eq("username", username));
		List<Regstration> customerList = criteria.list();
		// int count = customerList.size();
		return customerList.get(0);

	}



	


//	public int searchusername(String username) {
//	    SessionFactory sessionFactory = SessionHelper.getConnection();
//	    Session session = sessionFactory.openSession();
//	  
//	    Criteria cr = session.createCriteria(Regstration.class);
//	    cr.add(Restrictions.eq("username", username));
//	    List<Regstration> listcustomer = cr.list();
//	    int count = listcustomer.size();
//	    System.out.println(count);
//	    return count;
//	}
//




	public String getMD5Hash(String input) {
	    if (input == null) {
	        return null;
	    }

	    try {
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        byte[] messageDigest = md.digest(input.getBytes(StandardCharsets.UTF_8));
	        BigInteger no = new BigInteger(1, messageDigest);
	        String hashText = no.toString(16);
	        while (hashText.length() < 32) {
	            hashText = "0" + hashText;
	        }
	        return hashText;
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	    }
	    return null; // Return null in case of any error
	}



	    public static boolean checkSecurityQuestion(String username, String securityQuestion1, String securityAnswer1, String securityQuestion2, String securityAnswer2) {
	        SessionFactory sessionFactory = null;
	        Session session = null;

	        try {
	            sessionFactory = SessionHelper.getConnection();
	            session = sessionFactory.openSession();

	            Criteria criteria = session.createCriteria(Regstration.class);
	            criteria.add(Restrictions.eq("username", username));
	            criteria.add(Restrictions.eq("securityquestions", securityQuestion1));
	            criteria.add(Restrictions.eq("Securityanswer1", securityAnswer1));
	            criteria.add(Restrictions.eq("Securityquestion2", securityQuestion2));
	            criteria.add(Restrictions.eq("Securityanswer2", securityAnswer2));

	            Regstration user = (Regstration) criteria.uniqueResult();

	            if (user != null) {
	                return true;
	            } else {
	                System.out.println("User does not exist or security question/answer is incorrect."); // Display validation message
	                return false;
	            }
	        } catch (Exception e) {
	            // Handle the exception appropriately
	            e.printStackTrace(); // You can print the stack trace for debugging purposes

	            // Return a default value or throw a custom exception depending on your requirements
	            throw new RuntimeException("Error validating security question and answer");
	        } finally {
	            if (session != null) {
	                session.close();
	            }
	            if (sessionFactory != null) {
	                sessionFactory.close();
	            }
	        }
	    }

}
	   
	 



