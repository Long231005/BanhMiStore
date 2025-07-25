<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chào mừng - Bánh Mì Pew Pew</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        .welcome { color: #333; }
        .nav-links { margin-top: 20px; }
        .nav-links a { margin-right: 15px; color: #0066cc; text-decoration: none; }
        .nav-links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1 class="welcome">Chào mừng, ${sessionScope.user.fullName}</h1>
    <p>Vai trò: ${sessionScope.user.roleID == 1 ? 'Admin' : 'Customer'}</p>

    <div class="nav-links">
        <c:if test="${sessionScope.user.roleID == 1}">
            <a href="${pageContext.request.contextPath}/UserManagementServlet">Quản lý tài khoản</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/ProductServlet">Xem sản phẩm</a>
        <a href="${pageContext.request.contextPath}/CartServlet">Giỏ hàng</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
        <a href="${pageContext.request.contextPath}/jsp/index.jsp">Quay lại trang chủ</a>
    </div>
</body>
</html>