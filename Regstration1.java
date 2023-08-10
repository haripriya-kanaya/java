package com.infinite.java;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean(name = "Regstration1")
	@SessionScoped
	public class Regstration1 implements Serializable {
	    private String securityquestions;
	    private String securityquestionsSection2;
	   

	    // Constructor and other properties/methods if needed

	    @Override
		public String toString() {
			return "Regstration1 [securityquestions=" + securityquestions + ", securityquestionsSection2="
					+ securityquestionsSection2 + "]";
		}

		public String getSecurityquestions() {
			return securityquestions;
		}

		public void setSecurityquestions(String securityquestions) {
			this.securityquestions = securityquestions;
		}

		public String getSecurityquestionsSection2() {
			return securityquestionsSection2;
		}

		public void setSecurityquestionsSection2(String securityquestionsSection2) {
			this.securityquestionsSection2 = securityquestionsSection2;
		}

		public List<String> getSecurityQuestionsSection1() {
	        // List of security questions for Section 1
	        List<String> questions = new ArrayList<>();
	        questions.add("What is your pet's name?");
	        questions.add("What is your City?");
	        questions.add("What is your School name?");
	        // Add more questions here if needed
	        return questions;
	    }

	    public List<String> getSecurityQuestionsSection2() {
	        // List of security questions for Section 2
	        List<String> questions = new ArrayList<>();
	        questions.add("What is your pet's name?");
	        questions.add("What is your City?");
	        questions.add("What is your School name?");
	        // Add more questions here if needed
	        return questions;
	    }

	    // Getters and setters for other properties
	}
