package com.infinite.java;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class test {
    public static void main(String[] args) {
        Calcualtiondao dao = new Calcualtiondao();

        // Test case 1: Two-wheeler, initialEndDate = 2023-08-16, systemDate = 2023-08-02
        double refund1 = dao.calculateRefundAmount(parseDate("2023-08-16"), parseDate("2023-08-02"), "two-wheeler");
        System.out.println("Refund for two-wheeler: " + refund1);

        // Test case 2: Four-wheeler, initialEndDate = 2023-08-16, systemDate = 2023-08-02
        double refund2 = dao.calculateRefundAmount(parseDate("2023-08-16"), parseDate("2023-08-02"), "four-wheeler");
        System.out.println("Refund for four-wheeler: " + refund2);
    }

    // Helper method to parse date strings
    private static Date parseDate(String dateStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
}


