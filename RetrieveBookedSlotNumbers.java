package com.infinite.java;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;

public class RetrieveBookedSlotNumbers {
    public static void main(String[] args) {
        // Create a Hibernate session factory
        SessionFactory sessionFactory = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(Staff.class)
                .buildSessionFactory();

        // Create a Hibernate session
        Session session = sessionFactory.getCurrentSession();

        try {
            // Begin a transaction
            session.beginTransaction();

            // Create a criteria object
            Criteria criteria = session.createCriteria(Staff.class);

            // Add a restriction for booked slots
            criteria.add(Restrictions.eq("booked", true));

            // Retrieve the booked slot numbers
            List<Staff> bookedSlots = criteria.list();
            for (Staff slot : bookedSlots) {
                String slotNumber = slot.getSlotnumber();
                System.out.println(slotNumber);
            }

            // Commit the transaction
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the session and session factory
            session.close();
            sessionFactory.close();
        }
    }
}
