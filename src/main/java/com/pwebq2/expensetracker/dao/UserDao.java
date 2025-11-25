package com.pwebq2.expensetracker.dao;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.util.HibernateUtil;

public class UserDao {

    // Removed instance variables (transaction, session, flag) to ensure thread safety

    public UserDao(SessionFactory sessionFactory) {
        // It is better to use the passed factory, but we will stick to your util for now
    }

    public boolean saveUser(User user) {
        Transaction transaction = null;
        Session session = null;
        boolean isSuccess = false;

        try {
            // 1. Open Session
            session = HibernateUtil.getSessionFactory().openSession();
            
            // 2. Start Transaction
            transaction = session.beginTransaction();

            // 3. Save
            session.save(user);

            // 4. Commit
            transaction.commit();
            isSuccess = true;

        } catch (Exception e) {
            // 5. Safe Rollback
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            // 6. Always close the session
            if (session != null) {
                session.close();
            }
        }
        return isSuccess;
    }
    
    public User login(String email, String password) {
        Transaction transaction = null;
        Session session = null;
        User user = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();

            Query query = session.createQuery("from User where email=:em and password=:pw");
            query.setParameter("em", email);
            query.setParameter("pw", password);
            
            user = (User) query.uniqueResult();
            
            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return user;
    }
}