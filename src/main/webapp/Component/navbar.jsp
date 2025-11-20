<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<nav class="navbar navbar-expand-lg navbar-glass sticky-top mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="index.jsp">
            <div class="bg-primary text-white rounded p-1 d-flex justify-content-center align-items-center shadow-sm" style="width:35px; height:35px;">
                <i class="fa-solid fa-wallet"></i>
            </div>
            <span class="text-gradient fs-5">ExpenseTracker</span>
        </a>
        
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <c:if test="${not empty loginUser}">
                    <li class="nav-item"><a class="nav-link" href="viewExpense.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="addExpense.jsp">Add New</a></li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0">
                <button class="btn btn-light rounded-circle shadow-sm" onclick="toggleTheme()" title="Toggle Theme">
                    <i class="fa-solid fa-moon" id="themeIcon"></i>
                </button>

                <c:if test="${not empty loginUser}">
                    <div class="dropdown">
                        <button class="btn btn-light rounded-circle shadow-sm position-relative" data-bs-toggle="dropdown" id="notifBtn">
                            <i class="fa-regular fa-bell"></i>
                            <span id="notifBadge" class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle d-none"></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 p-0 overflow-hidden" style="width: 320px;" id="notifList">
                            <li class="d-flex justify-content-between align-items-center p-3 bg-light border-bottom">
                                <h6 class="m-0 fw-bold small text-uppercase text-muted">Notifications</h6>
                                <button class="btn btn-link btn-sm text-decoration-none p-0 small" onclick="clearNotifs()">Clear All</button>
                            </li>
                            <div id="notifContent" style="max-height: 300px; overflow-y: auto;">
                                <li id="noNotif" class="text-center py-4 text-muted small">No notifications yet</li>
                            </div>
                        </ul>
                    </div>

                    <div class="dropdown">
                        <button class="btn btn-gradient btn-sm dropdown-toggle" data-bs-toggle="dropdown">
                            ${loginUser.fullName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0">
                            <li><a class="dropdown-item text-danger" href="logout"><i class="fa-solid fa-power-off me-2"></i> Logout</a></li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty loginUser}">
                    <a href="login.jsp" class="btn btn-primary rounded-pill px-4 btn-sm">Login</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<script>
    // 1. Dark Mode Logic
    function toggleTheme() {
        const body = document.body;
        const icon = document.getElementById('themeIcon');
        if (body.getAttribute('data-theme') === 'dark') {
            body.removeAttribute('data-theme');
            localStorage.setItem('theme', 'light');
            if(icon) icon.classList.replace('fa-sun', 'fa-moon');
        } else {
            body.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark');
            if(icon) icon.classList.replace('fa-moon', 'fa-sun');
        }
    }
    // Init Theme
    if (localStorage.getItem('theme') === 'dark') {
        document.body.setAttribute('data-theme', 'dark');
        const icon = document.getElementById('themeIcon');
        if(icon) icon.classList.replace('fa-moon', 'fa-sun');
    }

    // 2. Notification Logic
    document.addEventListener("DOMContentLoaded", function() {
        renderNotifications();
    });

    function renderNotifications() {
        const content = document.getElementById('notifContent');
        const badge = document.getElementById('notifBadge');
        const noNotif = document.getElementById('noNotif');
        
        let notifications = JSON.parse(localStorage.getItem('expenseNotifs')) || [];
        notifications.reverse(); // Terbaru diatas

        if(notifications.length > 0) {
            if(noNotif) noNotif.style.display = 'none';
            if(badge) badge.classList.remove('d-none');
            
            content.innerHTML = ''; // Clear list

            notifications.forEach(n => {
                // Set Icon & Color based on Type
                let icon = 'fa-info-circle';
                let color = 'text-primary';
                let bg = 'bg-primary';
                
                if(n.type === 'add') { icon = 'fa-circle-check'; color = 'text-success'; bg = 'bg-success'; }
                if(n.type === 'edit') { icon = 'fa-pen-to-square'; color = 'text-warning'; bg = 'bg-warning'; }
                if(n.type === 'delete') { icon = 'fa-trash-can'; color = 'text-danger'; bg = 'bg-danger'; }

                const item = document.createElement('a');
                item.className = 'dropdown-item p-3 border-bottom d-flex gap-3 align-items-start';
                item.href = '#';
                item.innerHTML = `
                    <div class="\${bg} bg-opacity-10 rounded-circle p-2 d-flex align-items-center justify-content-center" style="width:35px; height:35px; flex-shrink:0;">
                        <i class="fa-solid \${icon} \${color}"></i>
                    </div>
                    <div class="w-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <span class="fw-bold text-dark small">\${n.title}</span>
                        </div>
                        <p class="text-muted small mb-0" style="font-size: 11px;">\${n.date}</p>
                    </div>
                `;
                content.appendChild(item);
            });
        } else {
            content.innerHTML = '';
            if(noNotif) {
                content.appendChild(noNotif);
                noNotif.style.display = 'block';
            }
            if(badge) badge.classList.add('d-none');
        }
    }

    function clearNotifs() {
        localStorage.removeItem('expenseNotifs');
        renderNotifications();
    }
</script>