package com.pwebq2.expensetracker.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pwebq2.expensetracker.dao.ExpenseDao;
import com.pwebq2.expensetracker.model.Expense;
import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.util.HibernateUtil;

@WebServlet("/addExpense")
public class AddExpense extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String title = req.getParameter("title");
        String time = req.getParameter("time");
        String date = req.getParameter("date");
        String description = req.getParameter("description");
        String price = req.getParameter("price");
        
        // --- 1. AMBIL KATEGORI DARI JSP ---
        String category = req.getParameter("category");
        // ----------------------------------
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loginUser");
        
        // Membuat object expense
        Expense expense = new Expense(title, date, time, description, price, user);
        
        // --- 2. SET KATEGORI KE OBJECT ---
        expense.setCategory(category);
        // ---------------------------------
        
        ExpenseDao expenseDao = new ExpenseDao(HibernateUtil.getSessionFactory());
        boolean check = expenseDao.saveExpense(expense);
        
        if (check) {
            session.setAttribute("msg", "Expense Added Successfully!");
            resp.sendRedirect("addExpense.jsp");
        } else {
            session.setAttribute("msg", "Failed to Add Expense");
            resp.sendRedirect("addExpense.jsp");
        }
    }
}