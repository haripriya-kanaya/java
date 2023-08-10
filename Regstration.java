package com.infinite.java;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;
import javax.faces.event.ComponentSystemEvent;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
@ManagedBean(name = "Regstration")
@SessionScoped
@Entity




@Table(name="reg")
public class Regstration {
	@Id
	
	@Column(name="uid")
	private String uid;
	@Column(name="name")
	private String name;
	@Column(name="Email")
	private String Email;
	@Column(name=" Phonenumber")
	private String  Phonenumber;
	@Column(name="dob")
	private Date dob;
	@Column(name="category")
	private String category;
	@Column(name="securityquestions")
	private String securityquestions;
	@Column(name="Password")
	private String Password;
	@Column(name="Confirmpassword")
	private String Confirmpassword;
	@Column(name="username",unique = true)
	private String username;
	@Column(name="Securityanswer1")
	private String Securityanswer1;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPhnum() {
		return Phonenumber;
	}
	public void setPhnum(String phnum) {
		Phonenumber = phnum;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSecurityquestions() {
		return securityquestions;
	}
	public void setSecurityquestions(String securityquestions) {
		this.securityquestions = securityquestions;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getConfirmpassword() {
		return Confirmpassword;
	}
	public void setConfirmpassword(String confirmpassword) {
		Confirmpassword = confirmpassword;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	
	public String getSecurityanswer1() {
		return Securityanswer1;
	}
	public void setSecurityanswer1(String securityanswer1) {
		Securityanswer1 = securityanswer1;
	}
	@Override
	public boolean equals(Object obj) {
	    if (this == obj) {
	        return true;
	    }
	    if (obj == null || getClass() != obj.getClass()) {
	        return false;
	    }
	    Regstration other = (Regstration) obj;
	    return Objects.equals(Password, other.Password);
	}
	public void reset() {
	    this.name = null;
	    this.Phonenumber = null;
	    this.dob = null;
	    this.category = null;
	    this.securityquestions = null;
	    this.Securityanswer1 = null;
	    this.username = null;
	    this.Password = null;
	    this.Confirmpassword = null;
	    this.Email = null;
	  
	}
	@Column(name="Securityquestion2")
	private String Securityquestion2;
	@Column(name="Securityanswer2")
	private String Securityanswer2;

	public String getSecurityquestion2() {
		return Securityquestion2;
	}
	public void setSecurityquestion2(String securityquestion2) {
		Securityquestion2 = securityquestion2;
	}
	public String getSecurityanswer2() {
		return Securityanswer2;
	}
	public void setSecurityanswer2(String securityanswer2) {
		Securityanswer2 = securityanswer2;
	}
	@Override
	public String toString() {
		return "Regstration [uid=" + uid + ", name=" + name + ", Email=" + Email + ", Phonenumber=" + Phonenumber
				+ ", dob=" + dob + ", category=" + category + ", securityquestions=" + securityquestions + ", Password="
				+ Password + ", Confirmpassword=" + Confirmpassword + ", username=" + username + ", Securityanswer1="
				+ Securityanswer1 + ", Securityquestion2=" + Securityquestion2 + ", Securityanswer2=" + Securityanswer2
				+ "]";
	}
	
	public boolean isSecurityQuestionSelected(String question) {
	    return question.equals(securityquestions);
	}

	@Column(name="Lastpassword")
	private String Lastpassword;
	@Column(name="Password2")
	private String Password2;

	public String getLastpassword() {
		return Lastpassword;
	}
	public void setLastpassword(String lastpassword) {
		Lastpassword = lastpassword;
	}
	public String getPassword2() {
		return Password2;
	}
	public void setPassword2(String password2) {
		Password2 = password2;
	}
	
	
	
	public void checkDuplicateQuestions() {
        if (securityquestions != null && securityquestions.equals(getSecurityquestion2())) {
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error: Duplicate questions selected. Please select different questions.", null));
        }
    }

	





	}
	


	

	 

