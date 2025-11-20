<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <%@ include file="Component/links.jsp" %>
</head>
<body>
    <%@ include file="Component/navbar.jsp" %>

    <main class="container animate__animated animate__fadeIn">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card-modern p-5">
                    <div class="text-center mb-5">
                        <div class="position-relative d-inline-block mb-3">
                            <img src="https://ui-avatars.com/api/?name=User&background=6366f1&color=fff&size=128" class="rounded-circle shadow-lg p-1 bg-white">
                            <button class="btn btn-sm btn-dark position-absolute bottom-0 end-0 rounded-circle shadow-sm" style="width:35px; height:35px;">
                                <i class="fa-solid fa-camera"></i>
                            </button>
                        </div>
                        <h3 class="fw-bold">Account Settings</h3>
                        <p class="text-muted">Manage your personal information</p>
                    </div>

                    <form>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Full Name</label>
                                <input type="text" class="form-control" value="Admin User" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Email Address</label>
                                <input type="email" class="form-control" value="admin@example.com" readonly>
                            </div>
                        </div>

                        <hr class="my-4 border-muted">
                        
                        <h5 class="fw-bold mb-3"><i class="fa-solid fa-shield-halved me-2 text-primary"></i>Security</h5>
                        <div class="mb-4">
                            <label class="form-label">Change Password</label>
                            <input type="password" class="form-control" placeholder="Enter new password">
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-5">
                            <button type="button" class="btn btn-outline-danger border-0 bg-danger bg-opacity-10 text-danger">
                                Delete Account
                            </button>
                            <button type="submit" class="btn btn-gradient px-5">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="Component/footer.jsp" %>
</body>
</html>