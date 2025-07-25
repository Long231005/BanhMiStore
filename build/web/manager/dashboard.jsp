<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
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
            <h1>Trang Quản Lý (Manager)</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/jsp/manager/dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/manager/products.jsp">Quản lý sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/manager/orders.jsp">Quản lý đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/manager/promotions.jsp">Quản lý khuyến mãi</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/manager/reports.jsp">Báo cáo</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <section class="dashboard">
                <h2>Xin chào, <%= user.getFullName() %></h2>
                <p>Vai trò: Manager</p>
                
                <div class="dashboard-stats">
                    <div class="stat-box">
                        <h3>Tổng số sản phẩm</h3>
                        <p class="stat-number"><!-- Số liệu từ cơ sở dữ liệu --></p>
                    </div>
                    <div class="stat-box">
                        <h3>Đơn hàng mới</h3>
                        <p class="stat-number"><!-- Số liệu từ cơ sở dữ liệu --></p>
                    </div>
                    <div class="stat-box">
                        <h3>Doanh thu</h3>
                        <p class="stat-number"><!-- Số liệu từ cơ sở dữ liệu --></p>
                    </div>
                </div>
                
                <div class="dashboard-actions">
                    <h3>Thao tác nhanh</h3>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/jsp/manager/products.jsp" class="btn">Quản lý sản phẩm</a>
                        <a href="${pageContext.request.contextPath}/jsp/manager/orders.jsp" class="btn">Quản lý đơn hàng</a>
                        <a href="${pageContext.request.contextPath}/jsp/manager/promotions.jsp" class="btn">Quản lý khuyến mãi</a>
                        <a href="${pageContext.request.contextPath}/jsp/manager/reports.jsp" class="btn">Xem báo cáo</a>
                    </div>
                </div>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 BanhMiPewPew - Trang Quản Lý</p>
        </footer>
    </div>
</body>
</html>