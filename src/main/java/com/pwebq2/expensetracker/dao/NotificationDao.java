package com.pwebq2.expensetracker.dao;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import com.pwebq2.expensetracker.model.Notification;
import com.pwebq2.expensetracker.model.User;

public class NotificationDao {
    private SessionFactory factory;

    public NotificationDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveNotification(Notification notif) {
        boolean f = false;
        try {
            Session session = factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(notif);
            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }

    public List<Notification> getNotificationsByUser(User user) {
        List<Notification> list = new ArrayList<Notification>();
        try {
            Session session = factory.openSession();
            Query q = session.createQuery("from Notification where user=:u order by id desc");
            q.setParameter("u", user);
            list = q.list();
            session.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public boolean clearAllNotifications(int userId) {
        boolean f = false;
        try {
            Session session = factory.openSession();
            Transaction tx = session.beginTransaction();
            Query q = session.createQuery("delete from Notification where user.id=:uid");
            q.setParameter("uid", userId);
            q.executeUpdate();
            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }
}