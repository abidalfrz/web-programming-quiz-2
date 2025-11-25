<!DOCTYPE html>
<html>
<head>
    <title>Budgeting</title>
    <%@ include file="Component/links.jsp" %>
</head>
<body>
    <%@ include file="Component/navbar.jsp" %>

    <main class="container animate__animated animate__fadeIn">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Monthly Budget</h2>
            <button class="btn btn-outline-primary rounded-pill btn-sm"><i class="fa-solid fa-gear me-2"></i>Settings</button>
        </div>

        <div class="row g-4">
            <div class="col-12">
                <div class="card-modern p-5 text-white text-center position-relative overflow-hidden" style="background: var(--gradient-primary); border:none;">
                    <div class="position-absolute top-0 end-0 bg-white opacity-10 rounded-circle" style="width:200px; height:200px; transform: translate(50%, -50%);"></div>
                    
                    <p class="text-uppercase fw-bold ls-1 opacity-75 mb-2">Remaining Budget</p>
                    <h1 class="display-3 fw-bold mb-3">Rp 2.400.000</h1>
                    <div class="progress bg-black bg-opacity-25 mx-auto" style="height: 10px; max-width: 600px;">
                        <div class="progress-bar bg-white" style="width: 52%"></div>
                    </div>
                    <p class="mt-3 opacity-75 small">52% Used from Rp 5.000.000 Limit</p>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card-modern p-4 h-100">
                    <h5 class="fw-bold mb-4">Category Limits</h5>
                    
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold text-primary"><i class="fa-solid fa-utensils me-2"></i>Food</span>
                            <span class="fw-bold text-danger">85%</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar bg-danger" style="width: 85%"></div>
                        </div>
                        <div class="d-flex justify-content-between small text-muted mt-1">
                            <span>Spent: Rp 850k</span>
                            <span>Limit: Rp 1.000k</span>
                        </div>
                    </div>

                    <div class="mb-2">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-bold text-info"><i class="fa-solid fa-bus me-2"></i>Transport</span>
                            <span class="fw-bold text-success">30%</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar bg-success" style="width: 30%"></div>
                        </div>
                        <div class="d-flex justify-content-between small text-muted mt-1">
                            <span>Spent: Rp 150k</span>
                            <span>Limit: Rp 500k</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card-modern p-4 h-100 bg-warning bg-opacity-10 border-warning border-opacity-25">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="bg-warning text-white rounded-circle p-3 shadow-sm">
                            <i class="fa-solid fa-lightbulb fs-4"></i>
                        </div>
                        <h5 class="fw-bold text-dark m-0">Smart Insight</h5>
                    </div>
                    <p class="text-dark">
                        You spend <strong>20% more on Food</strong> compared to last week. 
                        Consider cooking at home this weekend to save around <span class="fw-bold">Rp 150.000</span>.
                    </p>
                    <button class="btn btn-warning text-white btn-sm px-3 rounded-pill fw-bold">See Details</button>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="Component/footer.jsp" %>
</body>
</html>