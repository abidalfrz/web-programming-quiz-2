package com.pwebq2.expensetracker.util;

import java.util.Properties;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import com.pwebq2.expensetracker.model.Expense;
import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.model.Notification;

public class HibernateUtil {

    static SessionFactory sessionFactory;
    static Session session;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();
                Properties settings = new Properties();

                // JDBC Driver
                settings.put(Environment.DRIVER, "com.mysql.cj.jdbc.Driver");

                // -----------------------------
                // RAILWAY DATABASE CONFIG
                // -----------------------------
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db   = System.getenv("MYSQLDATABASE");
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                // Build JDBC URL for Railway
                String jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + db 
                                + "?useSSL=false&serverTimezone=UTC";

                settings.put(Environment.URL, jdbcUrl);
                settings.put(Environment.USER, user);
                settings.put(Environment.PASS, pass);

                // Hibernate options
                settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL8Dialect");
                settings.put(Environment.HBM2DDL_AUTO, "update");
                settings.put(Environment.SHOW_SQL, true);

                configuration.setProperties(settings);

                // Register entity classes
                configuration.addAnnotatedClass(User.class);
                configuration.addAnnotatedClass(Expense.class);
                configuration.addAnnotatedClass(Notification.class);

                // Build session factory
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
