<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDetail" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bánh Mì Pew Pew - Chi Tiết Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% 
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRoleID() != 1) { // 1 là roleID của Admin
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    Order order = (Order) request.getAttribute("order");
    User customer = (User) request.getAttribute("customer");
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
                <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> DASHBOARD</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductManagementServlet"><i class="fas fa-hamburger"></i> QUẢN LÝ SẢN PHẨM</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/categories.jsp"><i class="fas fa-list"></i> DANH MỤC</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> ĐƠN HÀNG</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users.jsp"><i class="fas fa-users"></i> NGƯỜI DÙNG</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/promotions.jsp"><i class="fas fa-percent"></i> KHUYẾN MÃI</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reports.jsp"><i class="fas fa-chart-line"></i> BÁO CÁO</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/settings.jsp"><i class="fas fa-cog"></i> CÀI ĐẶT</a></li>
            </ul>
        </div>
        
        <main class="main-content">
            <section class="account-header">
                <h2>CHI TIẾT ĐƠN HÀNG</h2>
                <p>Thông tin chi tiết của đơn hàng #<%= order.getOrderID() %>.</p>
            </section>
            
            <section class="admin-sections">
                <div class="section-row">
                    <div class="admin-section">
                        <div class="section-header">
                            <h3>THÔNG TIN KHÁCH HÀNG</h3>
                        </div>
                        <div class="section-content">
                            <p><strong>Họ tên:</strong> <%= customer.getFullName() %></p>
                            <p><strong>Email:</strong> <%= customer.getEmail() %></p>
                            <p><strong>Số điện thoại:</strong> <%= customer.getPhone() != null ? customer.getPhone() : "Không có" %></p>
                            <p><strong>Địa chỉ:</strong> <%= customer.getAddress() != null ? customer.getAddress() : "Không có" %></p>
                            <p><strong>Ngày sinh:</strong> <%= customer.getDateOfBirth() != null ? customer.getDateOfBirth() : "Không có" %></p>
                            <p><strong>Phương thức thanh toán:</strong> <%= customer.getPaymentMethod() != null ? customer.getPaymentMethod() : "Không có" %></p>
                        </div>
                    </div>
                </div>
                
                <div class="section-row">
                    <div class="admin-section orders">
                        <div class="section-header">
                            <h3>CHI TIẾT SẢN PHẨM</h3>
                        </div>
                        <div class="section-content">
                            <table class="orders-table">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng</th>
                                        <th>Giá</th>
                                        <th>Tổng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (OrderDetail detail : order.getOrderDetails()) { %>
                                        <tr>
                                            <td><%= detail.getProductName() %></td>
                                            <td><%= detail.getQuantity() %></td>
                                            <td><%= String.format("%,.0fđ", detail.getPrice()) %></td>
                                            <td><%= String.format("%,.0fđ", detail.getPrice() * detail.getQuantity()) %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <p class="total-revenue" style="font-size: 18px; font-weight: bold; margin-top: 20px;">
                                Tổng tiền: <%= String.format("%,.0fđ", order.getTotal()) %>
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            
            <section class="quick-actions">
                <h3>THAO TÁC NHANH</h3>
                <div class="action-cards">
                    <div class="action-card">
                        <i class="fas fa-arrow-left"></i>
                        <h4>Quay lại</h4>
                        <p>Quay lại danh sách đơn hàng</p>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="action-btn">Quay lại</a>
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