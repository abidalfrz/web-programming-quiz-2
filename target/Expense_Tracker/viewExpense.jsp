<%@page import="com.pwebq2.expensetracker.model.Expense"%>
<%@page import="java.util.List"%>
<%@page import="com.pwebq2.expensetracker.util.HibernateUtil"%>
<%@page import="com.pwebq2.expensetracker.dao.ExpenseDao"%>
<%@page import="com.pwebq2.expensetracker.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <%@ include file="Component/links.jsp"%>
    <style>
        .desc-truncate {
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            display: inline-block;
            vertical-align: middle;
        }
        /* Badge Colors */
        .badge-Food { background-color: #dbeafe; color: #1e40af; }
        .badge-Transport { background-color: #fce7f3; color: #9d174d; }
        .badge-Shopping { background-color: #fae8ff; color: #86198f; }
        .badge-Entertainment { background-color: #ffedd5; color: #9a3412; }
        .badge-Utilities { background-color: #e0f2fe; color: #075985; }
        .badge-Others { background-color: #f1f5f9; color: #475569; }
    </style>
</head>
<body>
    <c:if test="${empty loginUser}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <%@include file="Component/navbar.jsp"%>

    <div class="container pb-5 animate__animated animate__fadeIn">
        
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 gap-3">
            <div>
                <h2 class="fw-bold mb-0">My Expenses</h2>
                <p class="text-muted mb-0">Manage your financial activity.</p>
            </div>
            <div class="d-flex gap-2 no-print">
                <button class="btn btn-light border shadow-sm" onclick="window.print()">
                    <i class="fa-solid fa-file-arrow-down me-2"></i> Export PDF
                </button>
                
                <a href="addExpense.jsp" class="btn btn-gradient shadow-sm">
                    <i class="fa-solid fa-plus me-2"></i> Add New
                </a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-4 mb-3 mb-md-0">
                <div class="card-modern p-4 h-100 text-white" style="background: var(--gradient-primary); border:none;">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="bg-white bg-opacity-25 p-2 rounded"><i class="fa-solid fa-wallet fs-4"></i></div>
                        <span class="badge bg-white bg-opacity-25">Total Spent</span>
                    </div>
                    <h1 class="fw-bold mb-0" id="totalAmountDisplay">Rp 0</h1>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card-modern p-4 h-100">
                    <h6 class="fw-bold mb-3">Daily Spending Trend</h6>
                    <div style="height: 200px;"><canvas id="expenseChart"></canvas></div>
                </div>
            </div>
        </div>

        <div class="row g-2 mb-3 no-print">
            <div class="col-md-5">
                <div class="input-group shadow-sm h-100">
                    <span class="input-group-text bg-white border-end-0 ps-3"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                    <input type="text" id="searchInput" class="form-control border-start-0 ps-0" placeholder="Search by title..." onkeyup="applyFilters()">
                </div>
            </div>
            <div class="col-md-3">
                <select id="categoryFilter" class="form-select shadow-sm h-100" onchange="applyFilters()">
                    <option value="all">All Categories</option>
                    <option value="Food">Food</option>
                    <option value="Transport">Transport</option>
                    <option value="Shopping">Shopping</option>
                    <option value="Entertainment">Entertainment</option>
                    <option value="Utilities">Utilities</option>
                    <option value="Others">Others</option>
                </select>
            </div>
            <div class="col-md-4">
                <select id="sortFilter" class="form-select shadow-sm h-100" onchange="sortExpenses()">
                    <option value="newest">Sort: Date (Newest)</option>
                    <option value="oldest">Sort: Date (Oldest)</option>
                    <option value="high">Sort: Price (Highest)</option>
                    <option value="low">Sort: Price (Lowest)</option>
                </select>
            </div>
        </div>

        <div class="card-modern overflow-hidden">
            <div class="table-responsive">
                <table class="table table-custom table-hover mb-0" id="expenseTable">
                    <thead>
                        <tr>
                            <th class="ps-4">Transaction</th>
                            <th>Date</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Amount</th>
                            <th class="text-end pe-4 no-print">Action</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <%
                            User user = (User) session.getAttribute("loginUser");
                            ExpenseDao expenseDao = new ExpenseDao(HibernateUtil.getSessionFactory());
                            List<Expense> list = expenseDao.getAllExpenseByUser(user);
                            
                            // Notifikasi Trigger
                            String msg = (String) session.getAttribute("msg");
                            String notifType = "none"; String notifMsg = "";
                            if(msg != null) {
                                if(msg.toLowerCase().contains("add")) { notifType = "add"; notifMsg = "Transaction added"; }
                                else if(msg.toLowerCase().contains("updat")) { notifType = "edit"; notifMsg = "Transaction updated"; }
                                else if(msg.toLowerCase().contains("delet")) { notifType = "delete"; notifMsg = "Transaction removed"; }
                                session.removeAttribute("msg");
                            }

                            for (Expense e : list) {
                                String cat = (e.getCategory() == null || e.getCategory().isEmpty()) ? "Others" : e.getCategory();
                        %>
                        <tr class="align-middle expense-row" 
                            data-title="<%= e.getTitle().toLowerCase() %>"
                            data-date="<%= e.getDate() %>" 
                            data-price="<%= e.getPrice() %>"
                            data-category="<%= cat %>">
                            
                            <td class="ps-4">
                                <div class="fw-bold"><%= e.getTitle() %></div>
                            </td>
                            <td>
                                <div class="small text-muted"><i class="fa-regular fa-calendar me-1"></i> <%= e.getDate() %></div>
                            </td>
                            <td>
                                <span class="badge badge-<%= cat %> border"><%= cat %></span>
                            </td>
                            <td>
                                <span class="desc-truncate text-muted"><%= e.getDescription() %></span>
                                <a href="#" class="text-primary small fw-bold ms-1 text-decoration-none"
                                   onclick="showDescModal('<%=e.getTitle()%>', '<%=e.getDescription()%>', '<%=e.getDate()%>', '<%=e.getPrice()%>')">
                                   View
                                </a>
                            </td>
                            <td class="fw-bold text-danger">
                                Rp <%= e.getPrice() %>
                            </td>
                            <td class="text-end pe-4 no-print">
                                <a href="editExpense.jsp?id=<%=e.getId()%>" class="btn btn-light btn-sm text-primary rounded-circle shadow-sm me-1"><i class="fa-solid fa-pen"></i></a>
                                <a href="javascript:void(0)" onclick="confirmDelete('<%=e.getId()%>')" class="btn btn-light btn-sm text-danger rounded-circle shadow-sm"><i class="fa-solid fa-trash"></i></a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% if(list.isEmpty()) { %>
                    <div class="text-center py-5"><p class="text-muted">No data available.</p></div>
                <% } %>
            </div>
        </div>
    </div>

    <div class="modal fade" id="descModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content card-modern border-0">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold">Transaction Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="fw-bold text-primary mb-0" id="modalTitle"></h4>
                        <span class="badge bg-light text-dark border" id="modalDate"></span>
                    </div>
                    <div class="bg-light p-3 rounded border mb-3">
                        <h2 class="text-danger fw-bold mb-0" id="modalPrice"></h2>
                    </div>
                    <label class="text-muted small fw-bold text-uppercase mb-1">Description</label>
                    <p id="modalDesc" class="text-body p-2 bg-secondary bg-opacity-10 rounded"></p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-gradient w-100" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <%@include file="Component/footer.jsp"%>
    
    <input type="hidden" id="notifTriggerType" value="<%= notifType %>">
    <input type="hidden" id="notifTriggerMsg" value="<%= notifMsg %>">

    <script>
        // 1. INIT & CHART
        document.addEventListener("DOMContentLoaded", function() {
            let total = 0;
            const rows = document.querySelectorAll('.expense-row');
            const dataMap = {};

            rows.forEach(row => {
                const price = parseFloat(row.getAttribute('data-price'));
                const dateStr = row.getAttribute('data-date');
                if(!isNaN(price)) {
                    total += price;
                    if(dataMap[dateStr]) dataMap[dateStr] += price;
                    else dataMap[dateStr] = price;
                }
            });
            document.getElementById('totalAmountDisplay').innerText = "Rp " + total.toLocaleString('id-ID');

            const sortedDates = Object.keys(dataMap).sort((a, b) => new Date(a) - new Date(b));
            const sortedPrices = sortedDates.map(date => dataMap[date]);

            new Chart(document.getElementById('expenseChart').getContext('2d'), {
                type: 'line',
                data: {
                    labels: sortedDates,
                    datasets: [{
                        label: 'Daily Total',
                        data: sortedPrices,
                        borderColor: '#6366f1',
                        backgroundColor: 'rgba(99, 102, 241, 0.1)',
                        tension: 0.3, fill: true, pointRadius: 5
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { x: { grid: { display: false } }, y: { display: false } } }
            });
        });

        // 2. FILTER LOGIC
        function applyFilters() {
            const searchVal = document.getElementById('searchInput').value.toLowerCase();
            const catVal = document.getElementById('categoryFilter').value;
            
            document.querySelectorAll('.expense-row').forEach(row => {
                const title = row.getAttribute('data-title');
                const category = row.getAttribute('data-category');
                const matchSearch = title.includes(searchVal);
                const matchCat = (catVal === 'all') || (category === catVal);
                row.style.display = (matchSearch && matchCat) ? '' : 'none';
            });
        }

        // 3. SORTING LOGIC
        function sortExpenses() {
            const table = document.getElementById("tableBody");
            const rows = Array.from(document.querySelectorAll(".expense-row"));
            const sortType = document.getElementById("sortFilter").value;

            rows.sort((a, b) => {
                const dateA = new Date(a.getAttribute("data-date"));
                const dateB = new Date(b.getAttribute("data-date"));
                const priceA = parseFloat(a.getAttribute("data-price"));
                const priceB = parseFloat(b.getAttribute("data-price"));

                if (sortType === "newest") return dateB - dateA;
                if (sortType === "oldest") return dateA - dateB;
                if (sortType === "high") return priceB - priceA;
                if (sortType === "low") return priceA - priceB;
                return 0;
            });
            rows.forEach(row => table.appendChild(row));
        }

        // 4. Notifications
        const type = document.getElementById('notifTriggerType').value;
        const msg = document.getElementById('notifTriggerMsg').value;
        if(type !== 'none' && msg !== '') {
            let notifications = JSON.parse(localStorage.getItem('expenseNotifs')) || [];
            const newNotif = { title: msg, type: type, date: new Date().toLocaleString('id-ID', { hour12: false }) };
            notifications.push(newNotif);
            localStorage.setItem('expenseNotifs', JSON.stringify(notifications));
        }

        // 5. Helpers
        function showDescModal(title, desc, date, price) {
            document.getElementById('modalTitle').innerText = title;
            document.getElementById('modalDesc').innerText = desc;
            document.getElementById('modalDate').innerText = date;
            document.getElementById('modalPrice').innerText = "Rp " + price;
            new bootstrap.Modal(document.getElementById('descModal')).show();
        }
        function confirmDelete(id) {
            Swal.fire({
                title: 'Delete?', text: "Cannot be undone!", icon: 'warning',
                showCancelButton: true, confirmButtonColor: '#ef4444', confirmButtonText: 'Yes'
            }).then((res) => { if (res.isConfirmed) window.location.href = "deleteExpense?id=" + id; })
        }
    </script>
</body>
</html>