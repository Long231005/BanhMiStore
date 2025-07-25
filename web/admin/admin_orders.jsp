<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bánh Mì Pew Pew - Đơn Hàng Tháng Này (Admin)</title>
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
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
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
                <h2>ĐƠN HÀNG THÁNG NÀY</h2>
                <p>Xem và quản lý các đơn hàng tháng này.</p>
            </section>
            
            <section class="admin-sections">
                <div class="section-row">
                    <div class="admin-section orders">
                        <div class="section-header">
                            <h3>ĐƠN HÀNG THÁNG NÀY</h3>
                        </div>
                        <div class="section-content">
                            <% if (orders == null || orders.isEmpty()) { %>
                                <p class="empty-info">Không có đơn hàng nào gần đây.</p>
                            <% } else { %>
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
                                        <% for (Order order : orders) { %>
                                            <tr>
                                                <td>#<%= order.getOrderID() %></td>
                                                <td><%= order.getUserID() %></td> <!-- Giả sử userID là tên khách hàng, cần thay bằng tên thật từ UserDAO -->
                                                <td><%= order.getOrderDate() %></td>
                                                <td><%= String.format("%,.0fđ", order.getTotal()) %></td>
                                                <td><span class="status pending">Đang xử lý</span></td> <!-- Cần logic để xác định trạng thái thực tế -->
                                                <td><a href="${pageContext.request.contextPath}/admin/order-details?orderID=<%= order.getOrderID() %>" class="action-btn">Chi tiết</a></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <% if (totalRevenue != null) { %>
                                    <p class="total-revenue" style="font-size: 18px; font-weight: bold; margin-top: 20px;">
                                        Tổng doanh thu: <%= String.format("%,.0fđ", totalRevenue) %>
                                    </p>
                                <% } %>
                            <% } %>
                        </div>
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