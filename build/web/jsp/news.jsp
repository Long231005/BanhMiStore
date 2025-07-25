<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Tin Tức</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .news-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .news-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .news-header h1 {
            color: #e94822;
            font-size: 32px;
        }
        
        .news-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        
        .news-item {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .news-item:hover {
            transform: translateY(-5px);
        }
        
        .news-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .news-content {
            padding: 20px;
        }
        
        .news-date {
            color: #888;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .news-title {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
        }
        
        .news-excerpt {
            color: #666;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .read-more {
            display: inline-block;
            color: #e94822;
            font-weight: bold;
            text-decoration: none;
        }
        
        .read-more:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header class="main-header">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Bánh Mì Pew Pew Logo" class="logo">
            <h1>Bánh Mì Pew Pew</h1>
        </div>
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/ProductServlet">Thực đơn</a></li>
                <li><a href="${pageContext.request.contextPath}/PromotionServlet">Khuyến mãi</a></li>
                <li><a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a></li>
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
    
    <div class="news-container">
        <div class="news-header">
            <h1>TIN TỨC & SỰ KIỆN</h1>
            <p>Cập nhật những tin tức mới nhất từ Bánh Mì Pew Pew</p>
        </div>
        
        <div class="news-grid">
            <div class="news-item">
                <img src="${pageContext.request.contextPath}/img/news1.jpg" alt="Khai trương cơ sở mới" class="news-image">
                <div class="news-content">
                    <div class="news-date">20/04/2025</div>
                    <h3 class="news-title">Khai trương cơ sở mới tại quận 7</h3>
                    <p class="news-excerpt">Bánh Mì Pew Pew vừa khai trương cơ sở mới tại Phú Mỹ Hưng, quận 7, TP.HCM. Đây là cơ sở thứ 10 của chuỗi nhà hàng đang phát triển mạnh mẽ.</p>
                    <a href="#" class="read-more">Đọc tiếp...</a>
                </div>
            </div>
            
            <div class="news-item">
                <img src="${pageContext.request.contextPath}/img/news2.jpg" alt="Món mới" class="news-image">
                <div class="news-content">
                    <div class="news-date">15/04/2025</div>
                    <h3 class="news-title">Ra mắt dòng sản phẩm bánh mì chay đầu tiên</h3>
                    <p class="news-excerpt">Đáp ứng xu hướng ăn chay ngày càng phổ biến, Bánh Mì Pew Pew đã cho ra mắt dòng sản phẩm bánh mì chay đầu tiên với nhiều lựa chọn hấp dẫn.</p>
                    <a href="#" class="read-more">Đọc tiếp...</a>
                </div>
            </div>
            
            <div class="news-item">
                <img src="${pageContext.request.contextPath}/img/news3.jpg" alt="Khuyến mãi" class="news-image">
                <div class="news-content">
                    <div class="news-date">10/04/2025</div>
                    <h3 class="news-title">Chương trình khuyến mãi tháng 4: Mua 2 tặng 1</h3>
                    <p class="news-excerpt">Nhân dịp kỷ niệm 3 năm thành lập, Bánh Mì Pew Pew triển khai chương trình khuyến mãi đặc biệt: Mua 2 bánh mì bất kỳ sẽ được tặng 1 bánh mì truyền thống.</p>
                    <a href="#" class="read-more">Đọc tiếp...</a>
                </div>
            </div>
            
            <div class="news-item">
                <img src="${pageContext.request.contextPath}/img/news4.jpg" alt="Hợp tác" class="news-image">
                <div class="news-content">
                    <div class="news-date">05/04/2025</div>
                    <h3 class="news-title">Hợp tác cùng Grab Food giảm 30% phí giao hàng</h3>
                    <p class="news-excerpt">Bánh Mì Pew Pew vừa ký kết hợp tác chiến lược với Grab Food, mang đến ưu đãi giảm 30% phí giao hàng cho tất cả khách hàng đặt món qua ứng dụng.</p>
                    <a href="#" class="read-more">Đọc tiếp...</a>
                </div>
            </div>
            
            <div class="news-item">
                <img src="${pageContext.request.contextPath}/img/news5.jpg" alt="Nguyên liệu" class="news-image">
                <div class="news-content">
                    <div class="news-date">01/04/2025</div>
                    <h3 class="news-title">Cam kết sử dụng nguyên liệu hữu cơ 100%</h3>
                    <p class="news-excerpt">Từ tháng 4/2025, tất cả các cơ sở của Bánh Mì Pew Pew sẽ chỉ sử dụng nguyên liệu hữu cơ 100%, đảm bảo an toàn thực phẩm và bảo vệ môi trường.</p>
                    <a href="#" class="read-more">Đọc tiếp...</a>
                </div>
            </div>
            
            <div class="news-item">
                <img src="${pageContext.request.contextPath}/img/news6.jpg" alt="Cộng đồng" class="news-image">
                <div class="news-content">
                    <div class="news-date">25/03/2025</div>
                    <h3 class="news-title">Chương trình "Bánh Mì Yêu Thương" tại các trường học</h3>
                    <p class="news-excerpt">Bánh Mì Pew Pew phát động chương trình "Bánh Mì Yêu Thương", tài trợ 1000 suất ăn sáng cho học sinh có hoàn cảnh khó khăn tại TP.HCM.</p>
                    <a href="#" class="read-more">Đọc tiếp...</a>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-section">
                <h4>Về Bánh Mì Pew Pew</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/jsp/about.jsp">Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/news.jsp">Tin tức</a></li>
                    <li><a href="${pageContext.request.contextPath}/careers.jsp">Tuyển dụng</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4>Hỗ trợ khách hàng</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/ordering-guide.jsp">Hướng dẫn đặt hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/payment-methods.jsp">Phương thức thanh toán</a></li>
                    <li><a href="${pageContext.request.contextPath}/delivery-policy.jsp">Chính sách giao hàng</a></li>
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