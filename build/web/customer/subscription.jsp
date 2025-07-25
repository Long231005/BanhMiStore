<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Đăng Ký Nhận Tin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .subscription-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .subscription-icon {
            font-size: 60px;
            color: #ff6600;
            margin-bottom: 20px;
        }
        
        .subscription-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }
        
        .subscription-desc {
            margin-bottom: 30px;
            color: #666;
            line-height: 1.6;
        }
        
        .subscription-form {
            max-width: 500px;
            margin: 0 auto;
        }
        
        .email-input {
            width: 70%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            font-size: 16px;
        }
        
        .subscribe-btn {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            font-size: 16px;
        }
        
        .benefits-list {
            margin-top: 30px;
            text-align: left;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .benefits-list li {
            margin-bottom: 10px;
            position: relative;
            padding-left: 30px;
        }
        
        .benefits-list li i {
            position: absolute;
            left: 0;
            top: 3px;
            color: #ff6600;
        }
    </style>
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
    
    <header class="main-header">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Bánh Mì Pew Pew Logo" class="logo">
            <h1>Bánh Mì Pew Pew</h1>
        </div>
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/index.jsp">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductServlet">Thực đơn</a></li>
                <li><a href="${pageContext.request.contextPath}/PromotionServlet">Khuyến mãi</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/cart.jsp">Giỏ hàng</a></li>
            </ul>
        </nav>
        <div class="user-controls">
            <div class="hotline">Hotline: 1900-1533</div>
            <div class="account-dropdown">
                <button class="dropdown-btn">Tài khoản <i class="fas fa-chevron-down"></i></button>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/jsp/customer/dashboard.jsp">Trang cá nhân</a>
                    <a href="${pageContext.request.contextPath}/jsp/customer/profile.jsp">Thông tin cá nhân</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                </div>
            </div>
        </div>
    </header>
    
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>TÀI KHOẢN CỦA TÔI</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/jsp/customer/dashboard.jsp">QUẢN LÝ TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/customer/orders.jsp">ĐƠN HÀNG CỦA TÔI</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/customer/profile.jsp">ĐỊA CHỈ GIAO HÀNG</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/customer/profile.jsp">THÔNG TIN TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/customer/favorites.jsp">DANH SÁCH SẢN PHẨM ĐÃ MUA</a></li>
            </ul>
        </div>
        
        <main class="main-content">
            <section class="account-header">
                <h2>ĐĂNG KÝ NHẬN TIN</h2>
                <p class="welcome-message">Xin chào, <%= user.getFullName() %>. Đăng ký để nhận các thông tin khuyến mãi hấp dẫn.</p>
            </section>
            
            <section class="subscription-container">
                <div class="subscription-icon">
                    <i class="fas fa-envelope-open-text"></i>
                </div>
                <h3 class="subscription-title">ĐĂNG KÝ NHẬN BẢN TIN</h3>
                <p class="subscription-desc">
                    Đăng ký nhận bản tin để không bỏ lỡ những ưu đãi độc quyền, 
                    sản phẩm mới và các chương trình khuyến mãi hấp dẫn từ Bánh Mì Pew Pew.
                </p>
                
                <form class="subscription-form" onsubmit="redirectToFacebook(event)">
                    <div style="display: flex;">
                        <input type="email" name="email" class="email-input" placeholder="Nhập địa chỉ email của bạn" value="<%= user.getEmail() %>" required>
                        <button type="submit" class="subscribe-btn">
                            <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </form>
                
                <div class="benefits-list">
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Ưu đãi độc quyền dành riêng cho người đăng ký</li>
                        <li><i class="fas fa-check-circle"></i> Thông báo về các sản phẩm mới nhất</li>
                        <li><i class="fas fa-check-circle"></i> Cập nhật về khuyến mãi theo mùa và sự kiện đặc biệt</li>
                        <li><i class="fas fa-check-circle"></i> Mã giảm giá dành riêng cho thành viên</li>
                    </ul>
                </div>
            </section>
        </main>
    </div>
    
    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-section">
                <h4>Về Bánh Mì Pew Pew</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/jsp/about.jsp">Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/news.jsp">Tin tức</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/careers.jsp">Tuyển dụng</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4>Hỗ trợ khách hàng</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/jsp/ordering-guide.jsp">Hướng dẫn đặt hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/payment-methods.jsp">Phương thức thanh toán</a></li>
                    <li><a href="${pageContext.request.contextPath}/jsp/delivery-policy.jsp">Chính sách giao hàng</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4>Liên hệ</h4>
                <p>Hotline: 1900-1533</p>
                <p>Email: info@banhmipewpew.com</p>
                <div class="social-icons">
                    <a href="https://www.facebook.com/mid.best.568/" target="_blank"><i class="fab fa-facebook"></i></a>
                    <a href="https://www.facebook.com/mid.best.568/" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://www.facebook.com/mid.best.568/" target="_blank"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
        </div>
        
        <div class="copyright">
            <p>&copy; 2025 Bánh Mì Pew Pew. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>
    
    <script>
        // JavaScript cho dropdown menu
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownBtn = document.querySelector('.dropdown-btn');
            const dropdownContent = document.querySelector('.dropdown-content');
            
            dropdownBtn.addEventListener('click', function() {
                dropdownContent.classList.toggle('show');
            });
            
            // Đóng dropdown khi click bên ngoài
            window.addEventListener('click', function(event) {
                if (!event.target.matches('.dropdown-btn') && !event.target.matches('.fa-chevron-down')) {
                    if (dropdownContent.classList.contains('show')) {
                        dropdownContent.classList.remove('show');
                    }
                }
            });
        });
        
        // Function to redirect to Facebook when form is submitted
        function redirectToFacebook(event) {
            event.preventDefault();
            // Save email to database logic would go here
            
            // Redirect to Facebook page
            window.location.href = "https://www.facebook.com/mid.best.568/";
        }
    </script>
</body>
</html>