package com.pwebq2.expensetracker.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.util.HibernateUtil;

public class UserDao {

    private SessionFactory sessionFactory;

    public UserDao() {
        this.sessionFactory = HibernateUtil.getSessionFactory();
    }

    // SAVE USER
    public boolean saveUser(User user) {

        Transaction transaction = null;
        boolean saved = false;

        try (Session session = sessionFactory.openSession()) {

            transaction = session.beginTransaction();

            session.save(user);
            saved = true;

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }

        return saved;
    }

    // LOGIN
    public User login(String email, String password) {

        Transaction transaction = null;
        User user = null;

        try (Session session = sessionFactory.openSession()) {

            transaction = session.beginTransaction();

            Query<User> q = session.createQuery(
                "FROM User WHERE email = :em AND password = :pw",
                User.class
            );
            q.setParameter("em", email);
            q.setParameter("pw", password);

            user = q.uniqueResult();

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }

        return user;
    }
}
