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

@WebServlet("/updateExpense")
public class UpdateExpense extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String title = req.getParameter("title");
            String time = req.getParameter("time");
            String date = req.getParameter("date");
            String description = req.getParameter("description");
            String price = req.getParameter("price");

            // --- 1. AMBIL KATEGORI DARI FORM EDIT ---
            String category = req.getParameter("category");
            // ----------------------------------------

            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("loginUser");
            
            Expense expense = new Expense(title, date, time, description, price, user);
            expense.setId(id);
            
            // --- 2. SET KATEGORI BARU ---
            expense.setCategory(category);
            // ----------------------------

            ExpenseDao expenseDao = new ExpenseDao(HibernateUtil.getSessionFactory());
            boolean check = expenseDao.updateExpense(expense);

            if (check) {
                session.setAttribute("msg", "Expense Updated Successfully!");
                resp.sendRedirect("viewExpense.jsp");
            } else {
                session.setAttribute("msg", "Failed to Update Expense");
                resp.sendRedirect("editExpense.jsp?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("viewExpense.jsp");
        }
    }
}