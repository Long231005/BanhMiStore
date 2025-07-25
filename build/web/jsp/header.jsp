<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Header -->
<header class="main-header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Bánh Mì Pew Pew Logo" class="logo">
        <h1>Bánh Mì Pew Pew</h1>
    </div>
    <nav class="main-nav">
        <ul>
            <li><a href="${pageContext.request.contextPath}/jsp/index.jsp">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/ProductServlet">Thực đơn</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/promotions.jsp">Khuyến mãi</a></li>
            <li><a href="${pageContext.request.contextPath}/CartServlet">Giỏ hàng</a></li>
        </ul>
    </nav>
    <div class="user-controls">
        <div class="hotline">
            <span>Hotline: 0948056269</span>
        </div>
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <div class="account-dropdown">
                    <button class="dropdown-btn">Tài khoản <i class="fas fa-chevron-down"></i></button>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/jsp/login.jsp">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/jsp/register.jsp">Đăng ký</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="account-dropdown">
                    <button class="dropdown-btn">Tài khoản <i class="fas fa-chevron-down"></i></button>
                    <div class="dropdown-content">
                        <c:choose>
                            <c:when test="${sessionScope.roleID == 1}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Trang Admin</a>
                            </c:when>
                            <c:when test="${sessionScope.roleID == 3}">
                                <a href="${pageContext.request.contextPath}/manager/dashboard.jsp">Trang Manager</a>
                            </c:when>
                            <c:when test="${sessionScope.roleID == 4}">
                                <a href="${pageContext.request.contextPath}/staff/dashboard.jsp">Trang Staff</a>
                            </c:when>
                            <c:when test="${sessionScope.roleID == 2}">
                                <a href="${pageContext.request.contextPath}/customer/dashboard.jsp">Trang Customer</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const dropdownBtn = document.querySelector('.dropdown-btn');
        const dropdownContent = document.querySelector('.dropdown-content');

        dropdownBtn.addEventListener('click', function() {
            dropdownContent.classList.toggle('show');
        });

        window.addEventListener('click', function(event) {
            if (!event.target.matches('.dropdown-btn') && !event.target.matches('.dropdown-btn *')) {
                if (dropdownContent.classList.contains('show')) {
                    dropdownContent.classList.remove('show');
                }
            }
        });
    });
</script>