<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% 
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    %>
    
    <header class="main-header">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Bánh Mì Pew Pew Logo" class="logo">
            <h1>Bánh Mì Pew Pew - Admin</h1>
        </div>
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductManagementServlet">Sản phẩm</a></li>
                <!-- Liên kết đến AdminOrdersServlet, forward đến admin_orders.jsp -->
                <li><a href="${pageContext.request.contextPath}/admin/orders">Đơn hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/UserManagementServlet">Người dùng</a></li>
            </ul>
        </nav>
        <div class="user-controls">
            <div class="hotline">Admin Portal</div>
            <div class="account-dropdown">
                <button class="dropdown-btn">Tài khoản <i class="fas fa-chevron-down"></i></button>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                </div>
            </div>
        </div>
    </header>
    
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>QUẢN TRỊ HỆ THỐNG</h2>
            </div>
            <ul class="sidebar-menu">
                <li class="active"><a href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> DASHBOARD</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductManagementServlet"><i class="fas fa-hamburger"></i> QUẢN LÝ SẢN PHẨM</a></li>
                <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo CategoriesServlet -->
                <li><a href="${pageContext.request.contextPath}/admin/categories.jsp"><i class="fas fa-list"></i> DANH MỤC</a></li>
                <!-- Liên kết đến AdminOrdersServlet, forward đến admin_orders.jsp -->
                <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> ĐƠN HÀNG</a></li>
                <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo UsersServlet -->
                <li><a href="${pageContext.request.contextPath}/admin/users.jsp"><i class="fas fa-users"></i> NGƯỜI DÙNG</a></li>
                <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo PromotionsServlet -->
                <li><a href="${pageContext.request.contextPath}/admin/promotions.jsp"><i class="fas fa-percent"></i> KHUYẾN MÃI</a></li>
                <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo ReportsServlet -->
                <li><a href="${pageContext.request.contextPath}/admin/reports.jsp"><i class="fas fa-chart-line"></i> BÁO CÁO</a></li>
                <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo SettingsServlet -->
                <li><a href="${pageContext.request.contextPath}/admin/settings.jsp"><i class="fas fa-cog"></i> CÀI ĐẶT</a></li>
            </ul>
        </div>
        
        <main class="main-content">
            <section class="account-header">
                <h2>DASHBOARD</h2>
                <p class="welcome-message">Xin chào, <%= user.getFullName() %>. Chào mừng bạn đến với Trang Quản Trị Bánh Mì Pew Pew.</p>
            </section>
            
            <section class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Người dùng</h3>
                        <p class="stat-number">1,245</p>
                        <p class="stat-growth positive">+8.5% <i class="fas fa-arrow-up"></i></p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Sản phẩm</h3>
                        <p class="stat-number">68</p>
                        <p class="stat-growth positive">+12% <i class="fas fa-arrow-up"></i></p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Đơn hàng mới</h3>
                        <p class="stat-number">38</p>
                        <p class="stat-growth positive">+5.2% <i class="fas fa-arrow-up"></i></p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="stat-details">
                        <h3>Doanh thu</h3>
                        <p class="stat-number">32.5M VND</p>
                        <p class="stat-growth positive">+15% <i class="fas fa-arrow-up"></i></p>
                    </div>
                </div>
            </section>
            
            <section class="admin-sections">
                <div class="section-row">
                    <div class="admin-section orders">
                        <div class="section-header">
                            <h3>ĐƠN HÀNG GẦN ĐÂY</h3>
                            <!-- Liên kết đến AdminOrdersServlet, forward đến admin_orders.jsp -->
                            <a href="${pageContext.request.contextPath}/admin/orders" class="view-all">Xem tất cả</a>
                        </div>
                        <div class="section-content">
                            <table class="orders-table">
                                <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>#ORD-2025042</td>
                                        <td>Nguyễn Văn A</td>
                                        <td>26/04/2025</td>
                                        <td>185,000đ</td>
                                        <td><span class="status pending">Đang xử lý</span></td>
                                        <td><a href="#" class="action-btn">Chi tiết</a></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-2025041</td>
                                        <td>Trần Thị B</td>
                                        <td>26/04/2025</td>
                                        <td>290,000đ</td>
                                        <td><span class="status shipping">Đang giao</span></td>
                                        <td><a href="#" class="action-btn">Chi tiết</a></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-2025040</td>
                                        <td>Lê Văn C</td>
                                        <td>25/04/2025</td>
                                        <td>145,000đ</td>
                                        <td><span class="status completed">Hoàn thành</span></td>
                                        <td><a href="#" class="action-btn">Chi tiết</a></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-2025039</td>
                                        <td>Phạm Thị D</td>
                                        <td>25/04/2025</td>
                                        <td>320,000đ</td>
                                        <td><span class="status completed">Hoàn thành</span></td>
                                        <td><a href="#" class="action-btn">Chi tiết</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="section-row">
                    <div class="admin-section inventory">
                        <div class="section-header">
                            <h3>SẢN PHẨM SẮP HẾT HÀNG</h3>
                            <a href="${pageContext.request.contextPath}/ProductManagementServlet" class="view-all">Xem tất cả</a>
                        </div>
                        <div class="section-content">
                            <table class="products-table">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Danh mục</th>
                                        <th>Tồn kho</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Bánh Mì Thịt Nướng</td>
                                        <td>Bánh Mì</td>
                                        <td>8</td>
                                        <td><span class="stock low">Sắp hết</span></td>
                                        <td><a href="#" class="action-btn">Cập nhật</a></td>
                                    </tr>
                                    <tr>
                                        <td>Cà Phê Sữa Đá</td>
                                        <td>Đồ uống</td>
                                        <td>5</td>
                                        <td><span class="stock low">Sắp hết</span></td>
                                        <td><a href="#" class="action-btn">Cập nhật</a></td>
                                    </tr>
                                    <tr>
                                        <td>Bánh Mì Chay</td>
                                        <td>Bánh Mì</td>
                                        <td>3</td>
                                        <td><span class="stock critical">Cần nhập</span></td>
                                        <td><a href="#" class="action-btn">Cập nhật</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
            
            <section class="quick-actions">
                <h3>THAO TÁC NHANH</h3>
                <div class="action-cards">
                    <div class="action-card">
                        <i class="fas fa-plus-circle"></i>
                        <h4>Thêm sản phẩm mới</h4>
                        <p>Tạo sản phẩm mới trong hệ thống</p>
                        <a href="${pageContext.request.contextPath}/ProductManagementServlet" class="action-btn">Thêm ngay</a>
                    </div>
                    
                    <div class="action-card">
                        <i class="fas fa-percent"></i>
                        <h4>Tạo khuyến mãi</h4>
                        <p>Thiết lập chương trình khuyến mãi mới</p>
                        <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo PromotionsServlet -->
                        <a href="${pageContext.request.contextPath}/admin/add-promotion.jsp" class="action-btn">Tạo mới</a>
                    </div>
                    
                    <div class="action-card">
                        <i class="fas fa-chart-bar"></i>
                        <h4>Xem báo cáo</h4>
                        <p>Phân tích doanh thu và số liệu</p>
                        <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo ReportsServlet -->
                        <a href="${pageContext.request.contextPath}/admin/orders" class="action-btn">Xem báo cáo</a>
                    </div>
                    
                    <div class="action-card">
                        <i class="fas fa-cog"></i>
                        <h4>Cài đặt hệ thống</h4>
                        <p>Điều chỉnh cấu hình ứng dụng</p>
                        <!-- Trỏ trực tiếp đến JSP, nếu cần xử lý logic thì nên tạo SettingsServlet -->
                        <a href="${pageContext.request.contextPath}/admin/settings.jsp" class="action-btn">Cài đặt</a>
                    </div>
                </div>
            </section>
        </main>
    </div>
    
    <footer class="main-footer">
        <div class="copyright">
            <p>© 2025 Bánh Mì Pew Pew - Trang Quản Trị. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownBtn = document.querySelector('.dropdown-btn');
            const dropdownContent = document.querySelector('.dropdown-content');
            
            dropdownBtn.addEventListener('click', function() {
                dropdownContent.classList.toggle('show');
            });
            
            window.addEventListener('click', function(event) {
                if (!event.target.matches('.dropdown-btn') && !event.target.matches('.fa-chevron-down')) {
                    if (dropdownContent.classList.contains('show')) {
                        dropdownContent.classList.remove('show');
                    }
                }
            });
        });
    </script>
</body>
</html>