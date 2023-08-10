package com.infinite.java;



import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;
import javax.faces.validator.ValidatorException;
import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.primefaces.context.RequestContext;




@ManagedBean(name = "Hospitaldao")
@SessionScoped
public class Hospitaldao {
	
	    private SessionFactory sessionFactory;
	    
	    public void addUser(Regstration regstration) {
	        if (regstration == null) {
	            // Handle the error case or display an error message
	            return;
	        }

	        // First, call the checkDuplicateQuestions() method to check for duplicate questions
	        regstration.checkDuplicateQuestions();

	        // Next, check if there are any validation errors due to duplicate questions or any other validation issues
	        if (!FacesContext.getCurrentInstance().isValidationFailed()) {
	            try {
	                sessionFactory = SessionHelper.getConnection();
	                Session session = sessionFactory.openSession();

	                boolean usernameExists = isUserExist("username", regstration.getUsername());
	                boolean emailExists = isUserExist("email", regstration.getEmail());
	                boolean phoneNumberExists = isUserExist("phoneNumber", regstration.getPhnum());

	                // Combined validation message for all three fields
	                if (usernameExists && emailExists && phoneNumberExists) {
	                    FacesMessage combinedMessage = new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                            "Duplicate data entered: Username, email, and phone number already exist!", null);
	                    FacesContext.getCurrentInstance().addMessage(null, combinedMessage);

	                    // Return without adding the user when all three fields have duplicates
	                    return;
	                }

	                // Individual validation messages for duplicate fields
	                if (usernameExists) {
	                    FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Username already exists", "Username already exists");
	                    FacesContext.getCurrentInstance().addMessage(null, message);
	                    return; // Return without adding the user when the username already exists
	                }

	                if (emailExists) {
	                    FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Email already exists", "Email already exists");
	                    FacesContext.getCurrentInstance().addMessage(null, message);
	                    return; // Return without adding the user when the email already exists
	                }

	                if (phoneNumberExists) {
	                    FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Phone number already exists", "Phone number already exists");
	                    FacesContext.getCurrentInstance().addMessage(null, message);
	                    return; // Return without adding the user when the phone number already exists
	                }

	                // Hash the password using MD5
	                String hashedPassword = md5Hash(regstration.getPassword());
	                regstration.setPassword(hashedPassword);

	                // Hash the confirm password using MD5
	                String hashedConfirmPassword = md5Hash(regstration.getConfirmpassword());
	                regstration.setConfirmpassword(hashedConfirmPassword);

	                String id = Generateid();
	                System.out.println("Generated Id is " + id);
	                regstration.setUid(id);
	                regstration.setLastpassword(regstration.getPassword());
	                regstration.setPassword2(regstration.getPassword());

	                Transaction transaction = session.beginTransaction();
	                session.save(regstration);
	                transaction.commit();
	                System.out.println("Saved");

	                // Clear form fields after successful registration
	                regstration.setName(null);
	                regstration.setPhnum(null);
	                regstration.setDob(null);
	                regstration.setCategory(null);
	                regstration.setSecurityquestions(null);
	                regstration.setSecurityanswer1(null);
	                regstration.setUsername(null);
	                regstration.setPassword(null);
	                regstration.setConfirmpassword(null);
	                regstration.setEmail(null);

	                // Clear the view map to clear the form data
	                FacesContext.getCurrentInstance().getViewRoot().getViewMap().clear();

	                // Display success message
	                FacesContext context = FacesContext.getCurrentInstance();
	                context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Registration Successfully Completed", "You have successfully registered."));

	                session.close();
	                return;

	            } catch (Exception e) {
	                e.printStackTrace();
	                // Handle the error case or display an error message
	                return;
	            }
	        }
	        // If there are validation errors, the form will stay on the current page without submitting
	    }

	    
	    
		private String Generateid() {
	        sessionFactory = SessionHelper.getConnection();
	        Session session = sessionFactory.openSession();
	        Criteria cr = session.createCriteria(Regstration.class);
	        List<Regstration> regstrationList = cr.list();
	        session.close();
	        if (regstrationList.size() == 0) {
	            System.out.println("List Checked");
	            return "U001";
	        } else {
	            String uid = regstrationList.get(regstrationList.size() - 1).getUid();
	            int uidNumber = Integer.parseInt(uid.substring(1));
	            uidNumber++;
	            String newUid = String.format("U%03d", uidNumber);

	            return newUid;
	        }
	    }

public void validateEmail(FacesContext context, UIComponent comp, Object value) {
	String email = (String) value;
	Pattern pattern = Pattern.compile("^[a-zA-Z0-9][a-zA-Z0-9_]{0,}@(?:yahoo|gmail|coundent|casient|outlook|marketing|infinite)\\.[a-zA-Z]{2,}$");

	Matcher matcher = pattern.matcher(email);
	if (!matcher.matches()) {
		((UIInput) comp).setValid(false);
		FacesMessage message = new FacesMessage("The Email should consists uppercase letters and lowercase letters  which should be followed by @ .");
		context.addMessage(comp.getClientId(context), message);
	}
}

public static boolean isUserExist(String field, String value) {
    SessionFactory sessionFactory = SessionHelper.getConnection();
    Session session = sessionFactory.openSession();
    
    String query = "SELECT COUNT(*) FROM Regstration WHERE " + field + " = :value";
    Long count = (Long) session.createQuery(query)
            .setParameter("value", value)
            .uniqueResult();
    
    session.close();
    return count != null && count > 0;
}
//Hospitaldao.java

private Regstration regstration = new Regstration();



public Regstration getRegstration() {
	return regstration;
}



public void setRegstration(Regstration regstration) {
	this.regstration = regstration;
}



public String checkUsers(Regstration regstration) throws NoSuchAlgorithmException {
    try {
    	
        sessionFactory = SessionHelper.getConnection();
        Session session = sessionFactory.openSession();
        Criteria cr = session.createCriteria(Regstration.class);
        cr.add(Restrictions.eq("username", regstration.getUsername()));

        List<Regstration> coml = cr.list();
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        Map<String, Object> sessionMap = externalContext.getSessionMap();
       
        // Get the category selected during registration
        String selectedCategory = regstration.getCategory();

        for (Regstration storedCustomer : coml) {
            if (storedCustomer.getPassword().equals(regstration.getPassword()) || storedCustomer.getPassword().equals(md5Hash(regstration.getPassword()))) {
                // Check if the selected category matches the stored category
                if (!storedCustomer.getCategory().equalsIgnoreCase(selectedCategory)) {
                    FacesMessage message = new FacesMessage("Invalid category for login");
                    context.addMessage("cfrm:login", message);
                    return null;
                }
    // Successful login logic
                sessionMap.put("UserName", regstration.getUsername());
                sessionMap.put("Ids", storedCustomer.getUid());
            
                // Clear form fields
                
                regstration.setUsername(null);
                regstration.setPassword(null);
                
                // Set the username attribute in the session
              
                HttpSession session1 = (HttpSession) externalContext.getSession(false);
                session1.setAttribute("username", regstration.getUsername());
                
               

                // Determine the redirect URL based on category
                if ("Staff".equalsIgnoreCase(storedCustomer.getCategory())) {
                    return "Newjsp.jsp?faces-redirect=true";
                } else if ("Admin".equalsIgnoreCase(storedCustomer.getCategory())) {
                    return "Navbar.jsp?faces-redirect=true";
                } else {
                    // Handle other categories or default behavior
                    return "default.xhtml?faces-redirect=true";
                }
                
               

        
            }
        }

        // Invalid credentials logic
        FacesMessage message = new FacesMessage("Invalid credentials");
        context.addMessage("cfrm:login", message);
        return null;
    } catch (HibernateException e) {
        // Exception handling logic
        FacesContext context = FacesContext.getCurrentInstance();
        FacesMessage message = new FacesMessage("Error occurred during login");
        context.addMessage(null, message);
        e.printStackTrace();
       
        return null;
    }
}

private boolean isValidUser(String username) {
    try {
        sessionFactory = SessionHelper.getConnection();
        Session session = sessionFactory.openSession();
        Criteria cr = session.createCriteria(Regstration.class);
        cr.add(Restrictions.eq("username", username));
        List<Regstration> listcustomer = cr.list();
        session.close();
        if (listcustomer.size() == 1) {
            return true;
        }
        // TODO Auto-generated method stub
        return false;
    } catch (Exception e) {
        // Handle the exception
        e.printStackTrace();
        // Optionally, you can throw a new exception or return an error message
        return false;
    }
}
public Regstration searchBySignupUserName(String username, String password) {
    try {
        SessionFactory sf = SessionHelper.getConnection();
        Session session = sf.openSession();
        Criteria cr = session.createCriteria(Regstration.class);
        cr.add(Restrictions.eq("username", username));
        cr.add(Restrictions.eq("password", password));
        System.out.println("In Search Method");
        Regstration cus = (Regstration) cr.uniqueResult();
        session.close();
        return cus;
    } catch (Exception e) {
        // Handle the exception
        e.printStackTrace();
        // Optionally, you can throw a new exception or return an error value
        return null;
    }
}


private String md5Hash(String input) {
    try {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(input.getBytes());
        byte[] digest = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    } catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
        return null;
    }
}

public String getCategoryByUsername(String username) {
    try {
        SessionFactory sf = SessionHelper.getConnection();
        Session session = sf.openSession();
        Criteria cr = session.createCriteria(Regstration.class);
        cr.add(Restrictions.eq("username", username));

        List<Regstration> coml = cr.list();

        session.close(); // Don't forget to close the session after use

        if (!coml.isEmpty()) {
            // Assuming the username is unique, so only one record should be found
            Regstration user = coml.get(0);
            return user.getCategory();
        } else {
            // If no user found with the given username, return null or an appropriate value
            return null;
        }
    } catch (Exception e) {
        // Exception handling logic
        e.printStackTrace();
        return null;
    }
}






}










