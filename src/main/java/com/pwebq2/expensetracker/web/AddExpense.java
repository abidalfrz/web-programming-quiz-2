package com.pwebq2.expensetracker.web;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pwebq2.expensetracker.dao.ExpenseDao;
import com.pwebq2.expensetracker.dao.NotificationDao;
import com.pwebq2.expensetracker.model.Expense;
import com.pwebq2.expensetracker.model.Notification;
import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.util.HibernateUtil;

@WebServlet("/addExpense")
public class AddExpense extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        String category = req.getParameter("category"); // Tangkap Kategori
        String description = req.getParameter("description");
        String price = req.getParameter("price");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loginUser");

        if(user != null) {
            Expense expense = new Expense(title, date, time, description, price, user);
            expense.setCategory(category); // Set Kategori

            ExpenseDao expenseDao = new ExpenseDao(HibernateUtil.getSessionFactory());
            boolean check = expenseDao.saveExpense(expense);

            if (check) {
                // --- BUAT NOTIFIKASI ---
                NotificationDao notifDao = new NotificationDao(HibernateUtil.getSessionFactory());
                Notification notif = new Notification(
                    "Expense Added", "You added '" + title + "' (" + category + ")", 
                    "add", new Date().toString(), user
                );
                notifDao.saveNotification(notif);
                // -----------------------

                session.setAttribute("msg", "Expense Added Successfully!");
                resp.sendRedirect("addExpense.jsp");
            } else {
                session.setAttribute("msg", "Failed to Add Expense");
                resp.sendRedirect("addExpense.jsp");
            }
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}