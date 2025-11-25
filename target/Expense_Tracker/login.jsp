<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <%@include file="Component/links.jsp"%>
    <style>
        .bg-login { background: url('Images/Banner/ex2.jpg') center/cover; }
    </style>
</head>
<body>
    <button class="btn-theme-float animate__animated animate__fadeInRight" onclick="toggleTheme()">
        <i class="fa-solid fa-moon" id="themeIconFloat"></i>
    </button>

    <div class="container-fluid">
        <div class="row vh-100">
            <div class="col-lg-7 d-none d-lg-block bg-login position-relative animate__animated animate__fadeIn">
                <div class="position-absolute w-100 h-100 bg-dark opacity-50 top-0 start-0"></div>
                <div class="position-relative h-100 d-flex flex-column justify-content-center px-5">
                    <h1 class="display-4 fw-bold text-overlay animate__animated animate__fadeInUp delay-1">Welcome Back</h1>
                    <p class="fs-5 text-overlay animate__animated animate__fadeInUp delay-2">Keep track of your expenses and save for the future.</p>
                </div>
            </div>
            
            <div class="col-lg-5 d-flex align-items-center justify-content-center bg-white animate__animated animate__slideInRight">
                <div class="w-75">
                    <div class="mb-4">
                        <a href="index.jsp" class="text-decoration-none text-muted small"><i class="fa-solid fa-arrow-left"></i> Back Home</a>
                        <h2 class="fw-bold mt-3">Sign In</h2>
                        <p class="text-muted">Enter your credentials to access your account.</p>
                    </div>

                    <c:if test="${not empty msg}">
                        <div class="alert alert-danger shadow-sm animate__animated animate__shakeX">${msg}</div>
                        <c:remove var="msg" />
                    </c:if>

                    <form action="login" method="post">
                        <div class="form-floating mb-3">
                            <input type="email" name="email" class="form-control" id="floatingEmail" placeholder="name@example.com" required>
                            <label for="floatingEmail">Email Address</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                            <label for="floatingPassword">Password</label>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember">
                                <label class="form-check-label text-muted" for="remember">Remember me</label>
                            </div>
                            <a href="emailrecovery.jsp" class="text-primary text-decoration-none small">Forgot Password?</a>
                        </div>

                        <button type="submit" name="login" class="btn btn-gradient w-100 mb-3 shadow-sm">Login</button>
                        
                        <p class="text-center text-muted">
                            Don't have an account? <a href="register.jsp" class="fw-bold text-primary text-decoration-none">Register</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Script Dark Mode Floating
        function toggleTheme() {
            const body = document.body;
            const icon = document.getElementById('themeIconFloat');
            if (body.getAttribute('data-theme') === 'dark') {
                body.removeAttribute('data-theme');
                localStorage.setItem('theme', 'light');
                icon.classList.replace('fa-sun', 'fa-moon');
            } else {
                body.setAttribute('data-theme', 'dark');
                localStorage.setItem('theme', 'dark');
                icon.classList.replace('fa-moon', 'fa-sun');
            }
        }
        if (localStorage.getItem('theme') === 'dark') {
            document.body.setAttribute('data-theme', 'dark');
            document.getElementById('themeIconFloat').classList.replace('fa-moon', 'fa-sun');
        }
    </script>
</body>
</html>