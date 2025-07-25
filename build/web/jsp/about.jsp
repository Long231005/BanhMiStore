<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Giới Thiệu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .about-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .about-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .about-header h2 {
            font-size: 32px;
            margin-bottom: 10px;
            color: #ff6600;
        }
        
        .about-header p {
            font-size: 16px;
            color: #666;
        }
        
        .about-content {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .about-image {
            flex: 1;
            border-radius: 5px;
            overflow: hidden;
        }
        
        .about-image img {
            width: 100%;
            height: auto;
            display: block;
        }
        
        .about-text {
            flex: 1;
        }
        
        .about-text h3 {
            font-size: 24px;
            margin-bottom: 15px;
            color: #333;
        }
        
        .about-text p {
            margin-bottom: 15px;
            line-height: 1.6;
            color: #555;
        }
        
        .values-section {
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 5px;
            margin-bottom: 40px;
        }
        
        .values-section h3 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        
        .values-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        
        .value-item {
            text-align: center;
            padding: 20px;
        }
        
        .value-icon {
            font-size: 40px;
            color: #ff6600;
            margin-bottom: 15px;
        }
        
        .value-item h4 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }
        
        .value-item p {
            font-size: 14px;
            color: #666;
        }
        
        .team-section {
            margin-bottom: 40px;
        }
        
        .team-section h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        
        .team-member {
            text-align: center;
        }
        
        .team-photo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 15px;
        }
        
        .team-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .team-member h4 {
            font-size: 18px;
            margin-bottom: 5px;
        }
        
        .team-member p {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <% 
    // Kiểm tra đăng nhập (optional for public pages)
    User user = (User) session.getAttribute("user");
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
            <% if(user != null) { %>
            <div class="account-dropdown">
                <button class="dropdown-btn">Tài khoản <i class="fas fa-chevron-down"></i></button>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/jsp/customer/dashboard.jsp">Trang cá nhân</a>
                    <a href="${pageContext.request.contextPath}/jsp/customer/profile.jsp">Thông tin cá nhân</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                </div>
            </div>
            <% } else { %>
            <div class="login-buttons">
                <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="login-btn">Đăng nhập</a>
                <a href="${pageContext.request.contextPath}/jsp/register.jsp" class="register-btn">Đăng ký</a>
            </div>
            <% } %>
        </div>
    </header>
    
    <div class="container">
        <main class="main-content full-width">
            <section class="about-container">
                <div class="about-header">
                    <h2>GIỚI THIỆU VỀ BÁNH MÌ PEW PEW</h2>
                    <p>Hương vị truyền thống kết hợp với sự sáng tạo hiện đại</p>
                </div>
                
                <div class="about-content">
                    <div class="about-image">
                        <img src="${pageContext.request.contextPath}/img/about-store.jpg" alt="Cửa hàng Bánh Mì Pew Pew">
                    </div>
                    <div class="about-text">
                        <h3>Câu Chuyện Của Chúng Tôi</h3>
                        <p>Bánh Mì Pew Pew được thành lập vào năm 2020, bắt đầu từ một cửa hàng nhỏ trên phố Lê Đại Hành, Hà Nội. Với tình yêu dành cho ẩm thực Việt Nam và đặc biệt là bánh mì - món ăn đường phố nổi tiếng của Việt Nam, chúng tôi đã bắt đầu hành trình của mình với mong muốn mang hương vị truyền thống đến gần hơn với người dân thành thị.</p>
                        <p>Tên gọi "Pew Pew" xuất phát từ âm thanh vui nhộn và năng động, tượng trưng cho sự trẻ trung và sáng tạo mà chúng tôi mang vào trong từng chiếc bánh mì. Chúng tôi tin rằng bánh mì không chỉ là món ăn mà còn là nghệ thuật, và mỗi chiếc bánh mì đều được chuẩn bị với tất cả tâm huyết và sự chăm chút.</p>
                        <p>Sau 5 năm hoạt động, Bánh Mì Pew Pew đã phát triển thành chuỗi cửa hàng với hơn 15 chi nhánh trên toàn quốc, phục vụ hàng ngàn khách hàng mỗi ngày với những chiếc bánh mì thơm ngon, tươi mới.</p>
                    </div>
                </div>
                
                <div class="values-section">
                    <h3>GIÁ TRỊ CỐT LÕI</h3>
                    <div class="values-grid">
                        <div class="value-item">
                            <div class="value-icon">
                                <i class="fas fa-heart"></i>
                            </div>
                            <h4>Đam Mê</h4>
                            <p>Chúng tôi đặt tình yêu và đam mê vào từng sản phẩm, từ việc lựa chọn nguyên liệu đến quy trình chế biến.</p>
                        </div>
                        
                        <div class="value-item">
                            <div class="value-icon">
                                <i class="fas fa-seedling"></i>
                            </div>
                            <h4>Tươi Mới</h4>
                            <p>Cam kết sử dụng nguyên liệu tươi ngon, được chọn lọc cẩn thận từ các nguồn cung cấp uy tín.</p>
                        </div>
                        
                        <div class="value-item">
                            <div class="value-icon">
                                <i class="fas fa-lightbulb"></i>
                            </div>
                            <h4>Sáng Tạo</h4>
                            <p>Không ngừng đổi mới và sáng tạo để mang đến những trải nghiệm ẩm thực độc đáo cho khách hàng.</p>
                        </div>
                        
                        <div class="value-item">
                            <div class="value-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h4>Cộng Đồng</h4>
                            <p>Xây dựng mối quan hệ gắn kết với cộng đồng và đóng góp tích cực cho xã hội.</p>
                        </div>
                        
                        <div class="value-item">
                            <div class="value-icon">
                                <i class="fas fa-medal"></i>
                            </div>
                            <h4>Chất Lượng</h4>
                            <p>Đặt chất lượng lên hàng đầu, đảm bảo mỗi sản phẩm đều đạt tiêu chuẩn cao nhất.</p>
                        </div>
                        
                        <div class="value-item">
                            <div class="value-icon">
                                <i class="fas fa-smile"></i>
                            </div>
                            <h4>Khách Hàng</h4>
                            <p>Lấy sự hài lòng của khách hàng làm thước đo thành công, luôn lắng nghe và cải thiện.</p>
                        </div>
                    </div>
                </div>
                
                <div class="team-section">
                    <h3>ĐỘI NGŨ LÃNH ĐẠO</h3>
                    <div class="team-grid">
                        <div class="team-member">
                            <div class="team-photo">
                                <img src="${pageContext.request.contextPath}/img/team1.jpg" alt="Người sáng lập">
                            </div>
                            <h4>Nguyễn Văn A</h4>
                            <p>Người Sáng Lập & CEO</p>
                        </div>
                        
                        <div class="team-member">
                            <div class="team-photo">
                                <img src="${pageContext.request.contextPath}/img/team2.jpg" alt="Bếp trưởng">
                            </div>
                            <h4>Trần Thị B</h4>
                            <p>Bếp Trưởng</p>
                        </div>
                        
                        <div class="team-member">
                            <div class="team-photo">
                                <img src="${pageContext.request.contextPath}/img/team3.jpg" alt="Giám đốc marketing">
                            </div>
                            <h4>Lê Văn C</h4>
                            <p>Giám Đốc Marketing</p>
                        </div>
                        
                        <div class="team-member">
                            <div class="team-photo">
                                <img src="${pageContext.request.contextPath}/img/team4.jpg" alt="Giám đốc vận hành">
                            </div>
                            <h4>Phạm Thị D</h4>
                            <p>Giám Đốc Vận Hành</p>
                        </div>
                    </div>
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
            if (dropdownBtn) {
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
            }
        });
    </script>
</body>
</html>

                        