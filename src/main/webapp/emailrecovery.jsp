<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Recovery Password</title>
    <%@include file="Component/links.jsp"%>
</head>
<body>
    <button class="btn-theme-float" onclick="toggleTheme()">
        <i class="fa-solid fa-moon" id="themeIconFloat"></i>
    </button>

    <div class="container d-flex align-items-center justify-content-center vh-100">
        <div class="col-md-5">
            <div class="card-modern p-5 text-center animate__animated animate__fadeInUp">
                <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-4">
                    <i class="fa-solid fa-lock-open fs-2"></i>
                </div>
                <h3 class="fw-bold mb-2">Forgot Password?</h3>
                <p class="text-muted mb-4">Enter your email address and we'll send you a link to reset your password.</p>

                <form id="recoveryForm" onsubmit="handleRecovery(event)">
                    <div class="form-floating mb-4">
                        <input type="email" class="form-control" id="email" placeholder="name@example.com" required>
                        <label for="email">Email Address</label>
                    </div>
                    <button type="submit" class="btn btn-gradient w-100 py-3 shadow-sm">Send Reset Link</button>
                </form>
                
                <div class="mt-4">
                    <a href="login.jsp" class="text-decoration-none text-muted small">
                        <i class="fa-solid fa-arrow-left me-1"></i> Back to Login
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Simulasi Pengiriman Email (Mockup)
        function handleRecovery(e) {
            e.preventDefault();
            const btn = e.target.querySelector('button');
            const originalText = btn.innerText;
            
            btn.disabled = true;
            btn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Sending...';

            setTimeout(() => {
                Swal.fire({
                    icon: 'success',
                    title: 'Email Sent!',
                    text: 'Please check your inbox for reset instructions.',
                    confirmButtonColor: '#6366f1'
                }).then(() => {
                    window.location.href = "login.jsp";
                });
            }, 2000);
        }

        // Dark Mode Script (Copy dari login)
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