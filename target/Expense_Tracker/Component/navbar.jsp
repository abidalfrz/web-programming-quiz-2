<%@page import="com.pwebq2.expensetracker.dao.NotificationDao"%>
<%@page import="com.pwebq2.expensetracker.model.Notification"%>
<%@page import="com.pwebq2.expensetracker.model.User"%>
<%@page import="com.pwebq2.expensetracker.util.HibernateUtil"%>
<%@page import="java.util.List"%>
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
                        <button class="btn btn-light rounded-circle shadow-sm position-relative" data-bs-toggle="dropdown">
                            <i class="fa-regular fa-bell"></i>
                            <%
                                User notifUser = (User) session.getAttribute("loginUser");
                                NotificationDao notifDao = new NotificationDao(HibernateUtil.getSessionFactory());
                                List<Notification> notifList = notifDao.getNotificationsByUser(notifUser);
                                if(notifList != null && !notifList.isEmpty()) {
                            %>
                                <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                            <% } %>
                        </button>
                        
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 p-0 overflow-hidden" style="width: 320px;">
                            <li class="d-flex justify-content-between align-items-center p-3 bg-light border-bottom">
                                <h6 class="m-0 fw-bold small text-uppercase text-muted">Notifications</h6>
                                <a href="clearNotification" class="btn btn-link btn-sm text-decoration-none p-0 small">Clear All</a>
                            </li>
                            
                            <div style="max-height: 300px; overflow-y: auto;">
                                <% if(notifList == null || notifList.isEmpty()) { %>
                                    <li class="text-center py-4 text-muted small">No new notifications</li>
                                <% } else {
                                    for(Notification n : notifList) {
                                        String iC = "fa-info-circle"; String tC = "text-primary"; String bC = "bg-primary";
                                        if("add".equals(n.getType())) { iC="fa-circle-check"; tC="text-success"; bC="bg-success"; }
                                        if("edit".equals(n.getType())) { iC="fa-pen-to-square"; tC="text-warning"; bC="bg-warning"; }
                                        if("delete".equals(n.getType())) { iC="fa-trash-can"; tC="text-danger"; bC="bg-danger"; }
                                %>
                                    <a class="dropdown-item p-3 border-bottom d-flex gap-3 align-items-start" href="#">
                                        <div class="<%=bC%> bg-opacity-10 rounded-circle p-2 d-flex align-items-center justify-content-center" style="width:35px; height:35px; flex-shrink:0;">
                                            <i class="fa-solid <%=iC%> <%=tC%>"></i>
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <span class="fw-bold text-dark small"><%= n.getTitle() %></span>
                                            </div>
                                            <span class="d-block small text-muted text-truncate" style="max-width: 200px;"><%= n.getMessage() %></span>
                                            <p class="text-muted small mb-0" style="font-size: 10px;"><%= n.getCreatedAt() %></p>
                                        </div>
                                    </a>
                                <%  } } %>
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
    // Dark Mode Logic
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
    if (localStorage.getItem('theme') === 'dark') {
        document.body.setAttribute('data-theme', 'dark');
        const icon = document.getElementById('themeIcon');
        if(icon) icon.classList.replace('fa-moon', 'fa-sun');
    }
</script>