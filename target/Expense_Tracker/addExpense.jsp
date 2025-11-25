<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Expense</title>
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
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-3">
                            <i class="fa-solid fa-plus fs-4"></i>
                        </div>
                        <h3 class="fw-bold">New Transaction</h3>
                    </div>

                    <c:if test="${not empty msg}">
                        <div class="alert alert-success shadow-sm">${msg}</div>
                        <c:remove var="msg" />
                    </c:if>

                    <form action="addExpense" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" name="title" class="form-control" id="title" placeholder="Title" required>
                            <label for="title">Expense Title</label>
                        </div>
                        
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <div class="form-floating">
                                    <input type="date" name="date" class="form-control" id="date" required>
                                    <label for="date">Date</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <input type="time" name="time" class="form-control" id="time" required>
                                    <label for="time">Time</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <select name="category" class="form-select" id="category">
                                <option value="Food">Food & Dining</option>
                                <option value="Transport">Transportation</option>
                                <option value="Shopping">Shopping</option>
                                <option value="Entertainment">Entertainment</option>
                                <option value="Utilities">Utilities</option>
                                <option value="Others">Others</option>
                            </select>
                            <label for="category">Category</label>
                        </div>

                        <div class="form-floating mb-3">
                            <textarea name="description" class="form-control" id="desc" placeholder="Notes" style="height: 100px"></textarea>
                            <label for="desc">Description (Optional)</label>
                        </div>

                        <div class="input-group mb-4">
                            <span class="input-group-text bg-light">Rp</span>
                            <input type="text" name="price" class="form-control form-control-lg fw-bold text-primary" placeholder="0" required>
                        </div>

                        <button type="submit" name="Add" class="btn btn-gradient w-100 shadow-sm">
                            <i class="fa-solid fa-check me-2"></i> Save Expense
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@include file="Component/footer.jsp"%>
</body>
</html>