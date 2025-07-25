<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="dal.UserDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bánh Mì Pew Pew - Trang Quản Lý Khách Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% 
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    // Lấy dữ liệu người dùng mới nhất từ cơ sở dữ liệu
    UserDAO userDAO = new UserDAO();
    try {
        user = userDAO.getUserById(user.getUserID());
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }
        session.setAttribute("user", user); // Cập nhật session với dữ liệu mới nhất
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    // Ghi log để kiểm tra người dùng và email
    System.out.println("Người dùng đăng nhập: " + user.getUserID() + ", Email: " + user.getEmail());
    %>
    
    <!-- Gồm phần đầu trang -->
    <jsp:include page="../jsp/header.jsp" />

    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>TÀI KHOẢN CỦA TÔI</h2>
            </div>
            <ul class="sidebar-menu">
                <li class="active"><a href="${pageContext.request.contextPath}/customer/dashboard.jsp">QUẢN LÝ TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/orders.jsp">ĐƠN HÀNG CỦA TÔI</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">ĐỊA CHỈ GIAO HÀNG</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">THÔNG TIN TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/favorites.jsp">DANH SÁCH SẢN PHẨM ĐÃ MUA</a></li>
            </ul>
        </div>

        <main class="main-content">
            <section class="account-header">
                <h2>QUẢN LÝ TÀI KHOẢN</h2>
                <p class="welcome-message">Xin chào, <%= user.getFullName() %>. Với trang này, bạn sẽ quản lý được tất cả thông tin tài khoản của mình.</p>
            </section>
            
            <section class="account-info">
                <div class="account-section">
                    <h3>THÔNG TIN TÀI KHOẢN</h3>
                    <div class="account-details">
                        <div class="contact-info">
                            <h4>THÔNG TIN LIÊN HỆ</h4>
                            <p><%= user.getFullName() %></p>
                            <p><%= user.getEmail() %></p>
                            <div class="action-links">
                                <a href="${pageContext.request.contextPath}/customer/profile.jsp">Chỉnh sửa</a> | 
                                <a href="${pageContext.request.contextPath}/ChangePasswordServlet">Thay đổi mật khẩu</a>
                            </div>
                        </div>
                        
                        <div class="subscription-info">
                            <h4>ĐĂNG KÝ NHẬN TIN</h4>
                            <p>Bạn đã đăng ký nhận "Bản Tin Chung".</p>
                            <div class="action-links">
                                <a href="${pageContext.request.contextPath}/customer/subscription.jsp">Chỉnh sửa</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="account-section">
                    <h3>ĐỊA CHỈ GIAO HÀNG</h3>
                    <div class="address-info">
                        <div class="default-address">
                            <h4>ĐỊA CHỈ GIAO HÀNG MẶC ĐỊNH</h4>
                            <% 
                            // Ghi log để kiểm tra địa chỉ
                            System.out.println("Địa chỉ của người dùng trong dashboard: " + user.getAddress()); 
                            if (user.getAddress() != null && !user.getAddress().trim().isEmpty()) { %>
                                <p><%= user.getAddress() %></p>
                            <% } else { %>
                                <p class="empty-info">Bạn chưa thiết lập địa chỉ giao hàng mặc định.</p>
                            <% } %>
                            <div class="action-links">
                                <a href="${pageContext.request.contextPath}/customer/profile.jsp">Chỉnh sửa</a>
                            </div>
                        </div>

                        <div class="address-management">
                            <h4>QUẢN LÝ ĐỊA CHỈ</h4>
                            <a href="${pageContext.request.contextPath}/customer/profile.jsp" class="manage-btn">Quản lý địa chỉ</a>
                        </div>
                    </div>
                </div>
            </section>

            <section class="quick-actions">
                <h3>THAO TÁC NHANH</h3>
                <div class="action-cards">
                    <div class="action-card">
                        <i class="fas fa-shopping-cart"></i>
                        <h4>Đơn hàng đang giao</h4>
                        <p>Theo dõi trạng thái đơn hàng của bạn</p>
                        <a href="${pageContext.request.contextPath}/customer/orders.jsp" class="action-btn">Xem đơn hàng</a>
                    </div>
                    
                    <div class="action-card">
                        <i class="fas fa-shopping-bag"></i>
                        <h4>Sản phẩm đã mua</h4>
                        <p>Xem lại những sản phẩm bạn đã mua</p>
                        <a href="${pageContext.request.contextPath}/customer/favorites.jsp" class="action-btn">Xem danh sách</a>
                    </div>
                    
                    <div class="action-card">
                        <i class="fas fa-tag"></i>
                        <h4>Khuyến mãi hiện có</h4>
                        <p>Xem các ưu đãi độc quyền dành cho bạn</p>
                        <a href="${pageContext.request.contextPath}/jsp/promotions.jsp" class="action-btn">Xem ưu đãi</a>
                    </div>
                </div>
            </section>

            <section class="recommended-products">
                <h3>SẢN PHẨM ĐỀ XUẤT CHO BẠN</h3>
                <div class="product-carousel">
                    <div class="product-item">
                        <img src="${pageContext.request.contextPath}/img/banhmi_chamuc.jpg" alt="Bánh Mì Pew Pew Thịt Xiên">
                        <h4>Bánh Mì Pew Pew Thịt Xiên</h4>
                        <p class="price">15.000đ</p>
                        <a href="${pageContext.request.contextPath}/CartServlet?action=add&productID=7&quantity=1" class="buy-btn">Mua Ngay</a>
                    </div>
                    
                    <div class="product-item">
                        <img src="${pageContext.request.contextPath}/img/suachua_vietquat.jpg" alt="Sữa Chua Việt Quất Pew Pew">
                        <h4>Sữa Chua Việt Quất Pew Pew</h4>
                        <p class="price">20.000đ</p>
                        <a href="${pageContext.request.contextPath}/CartServlet?action=add&productID=20&quantity=1" class="buy-btn">Mua Ngay</a>
                    </div>
                    
                    <div class="product-item">
                        <img src="${pageContext.request.contextPath}/img/photron_bo.jpg" alt="Phở Trộn Bò Pew Pew">
                        <h4>Phở Trộn Bò Pew Pew<span class="hot-label">HOT</span></h4>
                        <p class="price">45.000đ</p>
                        <a href="${pageContext.request.contextPath}/CartServlet?action=add&productID=10&quantity=1" class="buy-btn">Mua Ngay</a>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <!-- Gồm phần chân trang -->
    <jsp:include page="../jsp/footer.jsp" />
</body>
</html>