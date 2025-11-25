package com.pwebq2.expensetracker.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pwebq2.expensetracker.model.User;
import com.pwebq2.expensetracker.util.HibernateUtil;
import com.pwebq2.expensetracker.dao.UserDao;

@WebServlet("/userRegister")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        try {
            // 1. Ambil data dari Form HTML
            String fullname = req.getParameter("full_name");
            String email = req.getParameter("email");
            String phoneStr = req.getParameter("phone_no"); // Masih berupa String
            String password = req.getParameter("password");
            String cpassword = req.getParameter("cpassword");

            // 2. Validasi: Pastikan tidak ada yang kosong
            if (fullname == null || fullname.isEmpty() || 
                email == null || email.isEmpty() || 
                phoneStr == null || phoneStr.isEmpty() || 
                password == null || password.isEmpty()) {
                
                session.setAttribute("msg", "Please fill all fields!");
                resp.sendRedirect("register.jsp");
                return;
            }

            // 3. Validasi: Cek Password Match
            if (!password.equals(cpassword)) {
                session.setAttribute("msg", "Passwords do not match!");
                resp.sendRedirect("register.jsp");
                return;
            }

            // 4. Validasi & Konversi Nomor HP (PENTING: Di sini perbaikan error "For input string: a")
            Long mobile_no = null;
            try {
                mobile_no = Long.parseLong(phoneStr);
            } catch (NumberFormatException e) {
                // Jika user mengetik huruf, kode akan masuk sini & tidak crash (Error 500)
                session.setAttribute("msg", "Invalid Phone Number! Please enter digits only.");
                resp.sendRedirect("register.jsp");
                return; // Berhenti, jangan lanjut ke database
            }

            // 5. Simpan ke Database
            User user = new User(fullname, email, mobile_no, password);
            UserDao userDao = new UserDao(HibernateUtil.getSessionFactory());
            boolean check = userDao.saveUser(user);

            if (check) {
                session.setAttribute("msg", "Register Successfully!");
                resp.sendRedirect("register.jsp"); 
            } else {
                session.setAttribute("msg", "Something Went Wrong On Server! (Check Console Logs)");
                resp.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "System Error: " + e.getMessage());
            resp.sendRedirect("register.jsp");
        }
    }
}