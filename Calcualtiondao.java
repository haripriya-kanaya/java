package com.infinite.java;

import java.util.Calendar;
import java.util.Date;

public class Calcualtiondao {
	public double calculateRefundAmount(Date initialEndDate, Date systemDate, String category) {
	    // Calculate the duration in days between initialEndDate and systemDate
	    long durationInMillis = initialEndDate.getTime() - systemDate.getTime();
	    int days = (int) (durationInMillis / (24 * 60 * 60 * 1000)) + 1;

	    // Calculate the refund amount based on the category and number of days
	    double refundAmount = 0.0;

	    if (category.equals("two-wheeler")) {
	        refundAmount = days * 5;
	    } else if (category.equals("four-wheeler")) {
	        refundAmount = days * 10;
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
	    
	    
	   

	    }

	    
	    
	
	
	



