package com.pwebq2.expensetracker.util;

import java.util.Properties;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import com.pwebq2.expensetracker.model.Expense;
import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.model.Notification; // 1. TAMBAHKAN IMPORT INI

public class HibernateUtil {

    static SessionFactory sessionFactory;
    static Session session;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();

                // Hibernate settings equivalent to hibernate.cfg.xml's properties
                Properties settings = new Properties();

                settings.put(Environment.DRIVER, "com.mysql.cj.jdbc.Driver");
                settings.put(Environment.URL, "jdbc:mysql://localhost:3306/expense_tracker_db");
                settings.put(Environment.USER, "root");
                settings.put(Environment.PASS, "");
                settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL8Dialect");
                settings.put(Environment.HBM2DDL_AUTO, "update");
                settings.put(Environment.SHOW_SQL, true);
                
                configuration.setProperties(settings);

                // Mendaftarkan Entity Class ke Hibernate
                configuration.addAnnotatedClass(User.class);
                configuration.addAnnotatedClass(Expense.class);
                
                // 2. TAMBAHKAN BARIS INI AGAR NOTIFIKASI DIKENALI
                configuration.addAnnotatedClass(Notification.class); 
                
                ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                        .applySettings(configuration.getProperties()).build();

                sessionFactory = configuration.buildSessionFactory(serviceRegistry);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return sessionFactory;
    }

    public static Session closeSession() {
        if (session != null) {
            session.close();
        }
        return session;
    }

    public static void closeSessionFactory() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}