package com.pwebq2.expensetracker.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.pwebq2.expensetracker.dao.NotificationDao;
import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.util.HibernateUtil;

@WebServlet("/clearNotification")
public class ClearNotification extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");

        if (user != null) {
            NotificationDao dao = new NotificationDao(HibernateUtil.getSessionFactory());
            dao.clearAllNotifications(user.getId());
        }
        
        // Kembali ke halaman sebelumnya
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "viewExpense.jsp");
    }
}