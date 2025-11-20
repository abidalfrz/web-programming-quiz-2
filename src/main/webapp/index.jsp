<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Expense Tracker</title>
    <%@ include file="Component/links.jsp"%>
</head>
<body>
    <%@include file="Component/navbar.jsp"%>

    <c:if test="${not empty msg}">
        <div class="container mt-3">
            <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
                ${msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <c:remove var="msg" />
            </div>
        </div>
    </c:if>

    <header class="container my-5 animate__animated animate__fadeIn">
        <div class="row align-items-center flex-column-reverse flex-lg-row">
            <div class="col-lg-6 mt-4 mt-lg-0">
                <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill mb-3">#1 Finance Tool</span>
                <h1 class="display-4 fw-bold mb-3">Master Your Money, <br><span class="text-primary">Effortlessly.</span></h1>
                <p class="lead text-muted mb-4">
                    Store your daily expenses, visualize your spending habits, and gain financial freedom.
                </p>
                <div class="d-flex gap-3">
                    <a href="viewExpense.jsp" class="btn btn-gradient px-4 shadow-lg">Get Started</a>
                    <button type="button" class="btn btn-light px-4 border shadow-sm" data-bs-toggle="modal" data-bs-target="#learnMoreModal">
                        Learn More
                    </button>
                </div>
            </div>
            <div class="col-lg-6 text-center">
                <img src="Images/Banner/ex1.jpg" class="img-fluid rounded-4 shadow-lg animate__animated animate__fadeInRight" alt="Hero Image">
            </div>
        </div>
    </header>

    <section id="features" class="container mb-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card-modern p-4 h-100 text-center">
                    <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-3">
                        <i class="fa-solid fa-bolt fs-4"></i>
                    </div>
                    <h5 class="fw-bold">Fast Recording</h5>
                    <p class="text-muted small">Input expenses in seconds.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-modern p-4 h-100 text-center">
                    <div class="bg-success bg-opacity-10 text-success rounded-circle d-inline-flex p-3 mb-3">
                        <i class="fa-solid fa-chart-pie fs-4"></i>
                    </div>
                    <h5 class="fw-bold">Visual Insights</h5>
                    <p class="text-muted small">Interactive charts analysis.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-modern p-4 h-100 text-center">
                    <div class="bg-warning bg-opacity-10 text-warning rounded-circle d-inline-flex p-3 mb-3">
                        <i class="fa-solid fa-shield-halved fs-4"></i>
                    </div>
                    <h5 class="fw-bold">Secure Data</h5>
                    <p class="text-muted small">Encrypted and stored safely.</p>
                </div>
            </div>
        </div>
    </section>

    <div class="modal fade" id="learnMoreModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content card-modern border-0">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold text-primary"><i class="fa-solid fa-code me-2"></i>Source Code</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center py-4">
                    <p class="text-muted mb-4">
                        This project is open source. You can view the full source code, documentation, and contribute on our GitHub repository.
                    </p>
                    <a href="https://github.com/abidalfrz/web-programming-quiz-2" target="_blank" class="btn btn-dark btn-lg w-100 d-flex align-items-center justify-content-center gap-2">
                        <i class="fa-brands fa-github"></i>
                        <span>Visit GitHub Repository</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@include file="Component/footer.jsp"%>
</body>
</html>