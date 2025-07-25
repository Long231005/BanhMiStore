<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý tài khoản - Bánh Mì Pew Pew</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard-style.css">
</head>
<body>
    <!-- Header -->
    <header class="main-header">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="logo">
            <h1>Bánh Mì Pew Pew - Admin</h1>
        </div>
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductManagementServlet">Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/OrdersServlet">Đơn hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/UserManagementServlet">Người dùng</a></li>
            </ul>
        </nav>
        <div class="user-controls">
            <span class="hotline">Hotline: 0948056269</span>
            <div class="account-dropdown">
                <button class="dropdown-btn">Tài khoản <i class="fas fa-caret-down"></i></button>
                <div class="dropdown-content">
                    <a href="#">Hồ sơ</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>QUẢN TRỊ HỆ THỐNG</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> DASHBOARD</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductManagementServlet"><i class="fas fa-box"></i> QUẢN LÝ SẢN PHẨM</a></li>
                <li><a href="${pageContext.request.contextPath}/OrdersServlet"><i class="fas fa-shopping-cart"></i> ĐƠN HÀNG</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/UserManagementServlet"><i class="fas fa-users"></i> NGƯỜI DÙNG</a></li>
                <li><a href="${pageContext.request.contextPath}/PromotionServlet"><i class="fas fa-tags"></i> KHUYẾN MÃI</a></li>
                <li><a href="#"><i class="fas fa-exclamation-circle"></i> BÁO CÁO</a></li>
                <li><a href="#"><i class="fas fa-cog"></i> CÀI ĐẶT</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="account-header">
                <h2>QUẢN LÝ TÀI KHOẢN</h2>
                <p class="welcome-message">Quản lý thông tin người dùng trong hệ thống Bánh Mì Pew Pew.</p>
            </div>

            <!-- Thông báo lỗi hoặc thành công -->
            <c:if test="${not empty error}">
                <p style="color: var(--danger);">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p style="color: var(--success);">${message}</p>
            </c:if>

            <!-- Form thêm tài khoản -->
            <div class="admin-section">
                <div class="section-header">
                    <h3>Thêm tài khoản mới</h3>
                </div>
                <div class="section-content">
                    <form action="${pageContext.request.contextPath}/UserManagementServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                            <div>
                                <label>Họ tên:</label><br>
                                <input type="text" name="fullName" required>
                            </div>
                            <div>
                                <label>Mật khẩu:</label><br>
                                <input type="text" name="password" required>
                            </div>
                            <div>
                                <label>Vai trò (roleID):</label><br>
                                <select name="roleID">
                                    <option value="1">Admin</option>
                                    <option value="2">Customer</option>
                                    <option value="3">Manager</option>
                                    <option value="4">Staff</option>
                                    <option value="5">Guest</option>
                                </select>
                            </div>
                            <div>
                                <label>Địa chỉ:</label><br>
                                <input type="text" name="address">
                            </div>
                            <div>
                                <label>Số điện thoại:</label><br>
                                <input type="text" name="phone">
                            </div>
                            <div>
                                <label>Email:</label><br>
                                <input type="email" name="email" required>
                            </div>
                            <div>
                                <label>Trạng thái:</label><br>
                                <select name="activate">
                                    <option value="true">Kích hoạt</option>
                                    <option value="false">Khóa</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="action-btn">Thêm</button>
                    </form>
                </div>
            </div>

            <!-- Danh sách tài khoản -->
            <div class="admin-section">
                <div class="section-header">
                    <h3>Danh sách tài khoản</h3>
                </div>
                <div class="section-content">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.userID}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.roleID == 1}">Admin</c:when>
                                            <c:when test="${user.roleID == 2}">Customer</c:when>
                                            <c:when test="${user.roleID == 3}">Manager</c:when>
                                            <c:when test="${user.roleID == 4}">Staff</c:when>
                                            <c:when test="${user.roleID == 5}">Guest</c:when>
                                            <c:otherwise>Không xác định</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="status ${user.activate ? 'completed' : 'pending'}">
                                            ${user.activate ? 'Kích hoạt' : 'Khóa'}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/UserManagementServlet?action=edit&userID=${user.userID}" class="action-btn">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/UserManagementServlet?action=delete&userID=${user.userID}" 
                                           onclick="return confirm('Bạn có chắc muốn khóa tài khoản này?')" style="background-color: var(--warning); margin-left: 5px;" class="action-btn">Khóa</a>
                                        <a href="${pageContext.request.contextPath}/UserManagementServlet?action=remove&userID=${user.userID}" 
                                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?')" style="background-color: var(--danger); margin-left: 5px;" class="action-btn">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="main-footer">
        <p class="copyright">&copy; 2025 Bánh Mì Pew Pew. All rights reserved.</p>
    </footer>
</body>
</html>