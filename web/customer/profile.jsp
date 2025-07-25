<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Thông Tin Cá Nhân</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .profile-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group textarea {
            height: 100px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .profile-action-buttons {
            margin-top: 20px;
            text-align: right;
        }
        
        .profile-action-buttons button {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .profile-action-buttons button.secondary {
            background-color: #ccc;
            margin-right: 10px;
        }

        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <% 
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    String dateOfBirth = user.getDateOfBirth() != null ? dateFormat.format(user.getDateOfBirth()) : "";
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
                    <a href="${pageContext.request.contextPath}/customer/dashboard.jsp">Trang cá nhân</a>
                    <a href="${pageContext.request.contextPath}/customer/profile.jsp">Thông tin cá nhân</a>
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
                <li><a href="${pageContext.request.contextPath}/customer/dashboard.jsp">QUẢN LÝ TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/orders.jsp">ĐƠN HÀNG CỦA TÔI</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">ĐỊA CHỈ GIAO HÀNG</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/customer/profile.jsp">THÔNG TIN TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/favorites.jsp">DANH SÁCH SẢN PHẨM ĐÃ MUA</a></li>
            </ul>
        </div>
        
        <main class="main-content">
            <section class="account-header">
                <h2>THÔNG TIN CÁ NHÂN</h2>
                <p class="welcome-message">Xin chào, <%= user.getFullName() %>. Cập nhật thông tin cá nhân của bạn tại đây.</p>
            </section>
            
            <section class="profile-container">
                <% if (request.getAttribute("success") != null) { %>
                    <div class="message success-message">
                        <%= request.getAttribute("success") %>
                    </div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="message error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/ProfileUpdateServlet" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Họ và Tên</label>
                            <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required readonly>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Số Điện Thoại</label>
                            <input type="tel" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" pattern="[0-9]{10,11}" placeholder="VD: 0987654321">
                        </div>
                        
                        <div class="form-group">
                            <label for="dateOfBirth">Ngày Sinh</label>
                            <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= dateOfBirth %>">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Địa Chỉ Giao Hàng</label>
                        <textarea id="address" name="address" placeholder="Nhập địa chỉ chi tiết"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="paymentMethod">Phương Thức Thanh Toán</label>
                        <select id="paymentMethod" name="paymentMethod">
                            <option value="" <%= user.getPaymentMethod() == null ? "selected" : "" %>>Chọn phương thức</option>
                            <option value="Cash" <%= "Cash".equals(user.getPaymentMethod()) ? "selected" : "" %>>Tiền mặt</option>
                            <option value="Credit Card" <%= "Credit Card".equals(user.getPaymentMethod()) ? "selected" : "" %>>Thẻ tín dụng</option>
                            <option value="Mobile Payment" <%= "Mobile Payment".equals(user.getPaymentMethod()) ? "selected" : "" %>>Thanh toán qua ứng dụng</option>
                        </select>
                    </div>
                    
                    <div class="profile-action-buttons">
                        <button type="button" class="secondary" onclick="location.href='${pageContext.request.contextPath}/customer/dashboard.jsp'">Hủy</button>
                        <button type="submit">Lưu thay đổi</button>
                    </div>
                </form>
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
            <p>© 2025 Bánh Mì Pew Pew. Tất cả quyền được bảo lưu.</p>
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