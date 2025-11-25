<%@page import="com.pwebq2.expensetracker.model.Expense"%>
<%@page import="com.pwebq2.expensetracker.util.HibernateUtil"%>
<%@page import="com.pwebq2.expensetracker.dao.ExpenseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Expense</title>
    <%@ include file="Component/links.jsp"%>
</head>
<body>
    <c:if test="${empty loginUser}">
        <c:redirect url="login.jsp" />
    </c:if>

    <%@include file="Component/navbar.jsp"%>

    <div class="container animate__animated animate__fadeInUp">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card-modern p-4 p-md-5">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold">Edit Transaction</h3>
                    </div>

                    <form action="updateExpense" method="post">
                        <%
                            int id = Integer.parseInt(request.getParameter("id"));
                            ExpenseDao expenseDao = new ExpenseDao(HibernateUtil.getSessionFactory());
                            Expense e = expenseDao.getExpenseById(id);
                            // Default logic jika kolom category tidak ada di DB, fallback ke 'Food'
                            String cat = "Food"; 
                        %>

                        <div class="form-floating mb-3">
                            <input type="text" name="title" class="form-control" value="<%=e.getTitle()%>" placeholder="Title">
                            <label>Title</label>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <div class="form-floating">
                                    <input type="date" name="date" class="form-control" value="<%=e.getDate()%>">
                                    <label>Date</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <input type="time" name="time" class="form-control" value="<%=e.getTime()%>">
                                    <label>Time</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <select name="category" class="form-select">
                                <option value="Food">Food & Dining</option>
                                <option value="Transport">Transportation</option>
                                <option value="Shopping">Shopping</option>
                                <option value="Entertainment">Entertainment</option>
                                <option value="Utilities">Utilities</option>
                                <option value="Others">Others</option>
                            </select>
                            <label>Category</label>
                        </div>

                        <div class="form-floating mb-3">
                            <textarea name="description" class="form-control" style="height: 100px"><%=e.getDescription()%></textarea>
                            <label>Description</label>
                        </div>

                        <div class="input-group mb-4">
                            <span class="input-group-text bg-light">Rp</span>
                            <input type="text" name="price" class="form-control fw-bold text-primary" value="<%=e.getPrice()%>">
                        </div>

                        <input type="hidden" name="id" value="<%=e.getId()%>">
                        <button type="submit" name="edit" class="btn btn-gradient w-100">Update Changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>