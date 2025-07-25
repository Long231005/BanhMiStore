<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <% 
    // Kiểm tra đăng nhập
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    %>

    <div class="container">
        <header>
            <h1>Trang Nhân Viên (Staff)</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/jsp/staff/dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/staff/orders.jsp">Xử lý đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/staff/products.jsp">Xem sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/staff/customers.jsp">Quản lý khách hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <section class="dashboard">
                <h2>Xin chào, <%= user.getFullName() %></h2>
                <p>Vai trò: Staff</p>
                
                <div class="dashboard-stats">
                    <div class="stat-box">
                        <h3>Đơn hàng đang xử lý</h3>
                        <p class="stat-number"><!-- Số liệu từ cơ sở dữ liệu --></p>
                    </div>
                    <div class="stat-box">
                        <h3>Khách hàng mới</h3>
                        <p class="stat-number"><!-- Số liệu từ cơ sở dữ liệu --></p>
                    </div>
                </div>
                
                <div class="dashboard-actions">
                    <h3>Thao tác nhanh</h3>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/jsp/staff/orders.jsp" class="btn">Xử lý đơn hàng</a>
                        <a href="${pageContext.request.contextPath}/jsp/staff/customers.jsp" class="btn">Quản lý khách hàng</a>
                    </div>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 BanhMiPewPew - Trang Nhân Viên</p>
        </footer>
    </div>
</body>
</html>