<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - Bánh Mì Pew Pew</title>
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
                <li class="active"><a href="${pageContext.request.contextPath}/ProductManagementServlet"><i class="fas fa-box"></i> QUẢN LÝ SẢN PHẨM</a></li>
                <li><a href="${pageContext.request.contextPath}/OrdersServlet"><i class="fas fa-shopping-cart"></i> ĐƠN HÀNG</a></li>
                <li><a href="${pageContext.request.contextPath}/UserManagementServlet"><i class="fas fa-users"></i> NGƯỜI DÙNG</a></li>
                <li><a href="${pageContext.request.contextPath}/PromotionServlet"><i class="fas fa-tags"></i> KHUYẾN MÃI</a></li>
                <li><a href="#"><i class="fas fa-exclamation-circle"></i> BÁO CÁO</a></li>
                <li><a href="#"><i class="fas fa-cog"></i> CÀI ĐẶT</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="account-header">
                <h2>QUẢN LÝ SẢN PHẨM</h2>
                <p class="welcome-message">Quản lý thông tin sản phẩm trong hệ thống Bánh Mì Pew Pew.</p>
            </div>

            <!-- Thông báo lỗi hoặc thành công -->
            <c:if test="${not empty error}">
                <p style="color: var(--danger);">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p style="color: var(--success);">${message}</p>
            </c:if>

            <!-- Form thêm/sửa sản phẩm -->
            <div class="admin-section">
                <div class="section-header">
                    <h3>${empty product ? 'Thêm sản phẩm mới' : 'Cập nhật sản phẩm'}</h3>
                </div>
                <div class="section-content">
                    <form action="${pageContext.request.contextPath}/ProductManagementServlet" method="post">
                        <input type="hidden" name="action" value="${empty product ? 'add' : 'update'}">
                        <input type="hidden" name="productID" value="${product != null ? product.productID : ''}">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                            <div>
                                <label>Tên sản phẩm:</label><br>
                                <input type="text" name="productName" value="${product != null ? product.productName : ''}" required>
                            </div>
                            <div>
                                <label>Hình ảnh:</label><br>
                                <input type="text" name="image" value="${product != null ? product.image : ''}">
                            </div>
                            <div>
                                <label>Giá (VNĐ):</label><br>
                                <input type="number" name="price" value="${product != null ? product.price : ''}" required>
                            </div>
                            <div>
                                <label>Số lượng:</label><br>
                                <input type="number" name="quantity" value="${product != null ? product.quantity : ''}" required>
                            </div>
                            <div>
                                <label>Danh mục:</label><br>
                                <select name="categoryID" required>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryID}" 
                                                ${product != null && product.categoryID == category.categoryID ? 'selected' : ''}>
                                            ${category.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label>Ngày nhập hàng:</label><br>
                                <input type="date" name="importDate" value="${product != null ? product.importDate : ''}" required>
                            </div>
                            <div>
                                <label>Ngày sử dụng:</label><br>
                                <input type="date" name="usingDate" value="${product != null ? product.usingDate : ''}" required>
                            </div>
                            <div>
                                <label>Ngày hết hạn:</label><br>
                                <input type="date" name="expirationDate" value="${product != null ? product.expirationDate : ''}">
                            </div>
                            <div>
                                <label>Trạng thái:</label><br>
                                <select name="status">
                                    <option value="1" ${product != null && product.status == 1 ? 'selected' : ''}>Kích hoạt</option>
                                    <option value="0" ${product != null && product.status == 0 ? 'selected' : ''}>Khóa</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="action-btn">${empty product ? 'Thêm' : 'Cập nhật'}</button>
                    </form>
                </div>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="admin-section">
                <div class="section-header">
                    <h3>Danh sách sản phẩm</h3>
                </div>
                <div class="section-content">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá (VNĐ)</th>
                                <th>Số lượng</th>
                                <th>Danh mục</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>${product.productID}</td>
                                    <td>${product.productName}</td>
                                    <td>${product.price}</td>
                                    <td>${product.quantity}</td>
                                    <td>
                                        <c:forEach var="category" items="${categories}">
                                            <c:if test="${category.categoryID == product.categoryID}">
                                                ${category.categoryName}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <span class="status ${product.status == 1 ? 'completed' : 'pending'}">
                                            ${product.status == 1 ? 'Kích hoạt' : 'Khóa'}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/ProductManagementServlet?action=edit&productID=${product.productID}" class="action-btn">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/ProductManagementServlet?action=delete&productID=${product.productID}" 
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')" 
                                           style="background-color: var(--danger); margin-left: 5px;" class="action-btn">Xóa</a>
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
        <p class="copyright">© 2025 Bánh Mì Pew Pew. All rights reserved.</p>
    </footer>
</body>
</html>