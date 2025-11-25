<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <%@include file="Component/links.jsp"%>
    <style>.bg-reg { background: url('Images/Banner/ex3.jpg') center/cover; }</style>
</head>
<body>
    <button class="btn-theme-float animate__animated animate__fadeInLeft" onclick="toggleTheme()">
        <i class="fa-solid fa-moon" id="themeIconFloat"></i>
    </button>

    <div class="container-fluid">
        <div class="row vh-100">
            <div class="col-lg-5 d-flex align-items-center justify-content-center bg-white order-2 order-lg-1 animate__animated animate__slideInLeft">
                <div class="w-75 py-5">
                    <div class="mb-4">
                        <a href="index.jsp" class="text-decoration-none text-muted small"><i class="fa-solid fa-arrow-left"></i> Back Home</a>
                        <h2 class="fw-bold mt-3">Create Account</h2>
                        <p class="text-muted">Join us to manage your finances better.</p>
                    </div>

                    <c:if test="${not empty msg}">
                        <div class="alert alert-info shadow-sm">${msg}</div>
                        <c:remove var="msg" />
                    </c:if>

                    <form action="userRegister" method="post">
                        <div class="form-floating mb-2">
                            <input type="text" name="full_name" class="form-control" id="fname" placeholder="Full Name" required>
                            <label for="fname">Full Name</label>
                        </div>
                        <div class="form-floating mb-2">
                            <input type="text" name="email" class="form-control" id="email" placeholder="Email" required>
                            <label for="email">Email Address</label>
                        </div>
                        <div class="form-floating mb-2">
                            <input type="text" name="phone_no" class="form-control" id="phone" placeholder="Phone">
                            <label for="phone">Phone Number</label>
                        </div>
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <div class="form-floating">
                                    <input type="password" name="password" class="form-control" id="pass" placeholder="Pass" required>
                                    <label for="pass">Password</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <input type="password" name="cpassword" class="form-control" id="cpass" placeholder="Confirm" required>
                                    <label for="cpass">Confirm</label>
                                </div>
                            </div>
                        </div>

                        <button type="submit" name="register" class="btn btn-gradient w-100 mb-3 shadow-sm">Register Now</button>
                        <p class="text-center text-muted">
                            Already have an account? <a href="login.jsp" class="fw-bold text-primary text-decoration-none">Login</a>
                        </p>
                    </form>
                </div>
            </div>
            
            <div class="col-lg-7 d-none d-lg-block bg-reg position-relative order-1 order-lg-2 animate__animated animate__fadeIn">
                <div class="position-absolute w-100 h-100 bg-primary opacity-25 top-0 start-0"></div>
                <div class="position-relative h-100 d-flex flex-column justify-content-center px-5 text-white text-end">
                    <h1 class="display-4 fw-bold text-overlay animate__animated animate__fadeInUp delay-1">Start Your Journey</h1>
                    <p class="fs-5 text-overlay animate__animated animate__fadeInUp delay-2">Smart financial planning starts here.</p>
                </div>
            </div>
        </div>
    </div>
    <script>
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