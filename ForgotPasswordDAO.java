package com.infinite.java;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.Registration;

import org.apache.catalina.User;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;



public class ForgotPasswordDAO {
	public static boolean isUserExist(String username) {
	    try {
	        SessionFactory sessionFactory = SessionHelper.getConnection();
	        Session session = sessionFactory.openSession();
	        Long count = (Long) session.createQuery("SELECT COUNT(*) FROM Regstration WHERE UserName = :username")
	                                   .setParameter("username", username).uniqueResult();
	        session.close();

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
	        throw new RuntimeException("Error validating user existence");
	    }
	}


	public static String resetPassword(String username, String newPassword) {
	    try {
	        Session session = SessionHelper.getConnection().openSession();
	        Transaction transaction = session.beginTransaction();

	        Regstration user = (Regstration) session.createQuery("FROM Regstration WHERE UserName = :username")
	                                              .setParameter("username", username).uniqueResult();
	        if (user != null) {
	            String oldPassword = user.getPassword(); // Get the old password from the user object
	            String hashedNewPassword = getMD5Hash(newPassword);

	            if (!hashedNewPassword.equals(oldPassword)) { // Compare the hashed new password with the old password
	                user.setPassword(hashedNewPassword);
	                session.update(user);
	                transaction.commit();
	                session.close();
	                return "Password changed successfully";
	            } else {
	                return "New password cannot be the same as the old password";
	            }
	        } else {
	            // Handle case when user is not found
	        	 throw new RuntimeException("User not found");
	        }
	    } catch (Exception e) {
	        // Handle the exception appropriately
	        e.printStackTrace(); // You can print the stack trace for debugging purposes

	        // Return a default value or throw a custom exception depending on your requirements
	        return "Error resetting password";
	    }
	}

	 private static String getMD5Hash(String password) {
	        try {
	            MessageDigest md = MessageDigest.getInstance("MD5");
	            byte[] messageDigest = md.digest(password.getBytes());
	            StringBuilder hexString = new StringBuilder();

	            for (byte b : messageDigest) {
	                String hex = Integer.toHexString(0xFF & b);
	                if (hex.length() == 1) {
	                    hexString.append('0');
	                }
	                hexString.append(hex);
	            }

	            return hexString.toString();
	        } catch (NoSuchAlgorithmException e) {
	            // Handle exception
	            e.printStackTrace();
	            return null;
	        }
	    }



	 
	 
		    // Other methods and fields
		    
		    public static String getOldPassword(String username) {
		        try {
		            Session session = SessionHelper.getConnection().openSession();
		            Transaction transaction = session.beginTransaction();

		            Regstration user = (Regstration) session.createQuery("FROM Regstration WHERE UserName = :username")
		                                                  .setParameter("username", username).uniqueResult();
		            if (user != null) {
		                String oldPassword = user.getPassword();
		                session.close();
		                return oldPassword;
		            } else {
		                // Handle case when user is not found
		                session.close();
		                return null;
		            }
		        } catch (Exception e) {
		            // Handle the exception appropriately
		            e.printStackTrace(); // You can print the stack trace for debugging purposes

		            // Return a default value or throw a custom exception depending on your requirements
		            return null;
		        }
		    }
		    public boolean checkUserExists(String username) {
		        Session session = SessionHelper.getConnection().openSession();
		        Transaction transaction = null;
		        boolean userExists = false;

		        try {
		            transaction = session.beginTransaction();

		            Regstration user = (Regstration) session.createQuery("FROM Regstration WHERE UserName = :username")
		                                                  .setParameter("username", username)
		                                                  .uniqueResult();
		            if (user != null) {
		                userExists = true;
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

		        return userExists;
		    }
		 
		  

		
		  

}
		    

		       
		    

		   
		    
		   
		

	
	    
	 

		


	





