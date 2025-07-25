<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Hướng Dẫn Đặt Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .guide-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .guide-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px 0;
            background-color: #fff3e0;
            border-radius: 8px;
        }
        
        .guide-header h1 {
            color: #e94822;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .guide-header p {
            font-size: 16px;
            color: #666;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        .ordering-options {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .option-card {
            flex: 1;
            min-width: 300px;
            background-color: #fff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .option-icon {
            font-size: 40px;
            color: #e94822;
            margin-bottom: 15px;
        }
        
        .option-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .option-desc {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.5;
        }
        
        .option-btn {
            display: inline-block;
            background-color: #e94822;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        .option-btn:hover {
            background-color: #d43b1b;
        }
        
        .step-by-step {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        
        .step-by-step h2 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            color: #333;
        }
        
        .steps {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .step {
            flex: 1;
            min-width: 220px;
            position: relative;
            padding: 20px;
            text-align: center;
        }
        
        .step-number {
            display: inline-block;
            width: 40px;
            height: 40px;
            background-color: #e94822;
            color: white;
            border-radius: 50%;
            line-height: 40px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .step h3 {
            margin-bottom: 10px;
            color: #333;
        }
        
        .step p {
            color: #666;
            line-height: 1.5;
        }
        
        .faq-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .faq-section h2 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            color: #333;
        }
        
        .faq-item {
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }
        
        .faq-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        
        .faq-question {
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            font-size: 18px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .faq-question i {
            color: #e94822;
        }
        
        .faq-answer {
            color: #666;
            line-height: 1.6;
            padding-left: 10px;
            border-left: 3px solid #e94822;
            margin-top: 10px;
            display: none;
        }
        
        .faq-item.active .faq-answer {
            display: block;
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
    
    <div class="guide-container">
        <div class="guide-header">
            <h1>HƯỚNG DẪN ĐẶT HÀNG</h1>
            <p>Đặt hàng Bánh Mì Pew Pew dễ dàng với nhiều phương thức khác nhau. Dưới đây là các bước chi tiết giúp bạn có trải nghiệm đặt hàng thuận tiện nhất.</p>
        </div>
        
        <div class="ordering-options">
            <div class="option-card">
                <div class="option-icon">
                    <i class="fas fa-globe"></i>
                </div>
                <div class="option-title">Đặt hàng qua Website</div>
                <div class="option-desc">Trải nghiệm đặt hàng dễ dàng và nhanh chóng thông qua website chính thức của Bánh Mì Pew Pew.</div>
                <a href="${pageContext.request.contextPath}/ProductServlet" class="option-btn">Đặt hàng ngay</a>
            </div>
            
            <div class="option-card">
                <div class="option-icon">
                    <i class="fas fa-mobile-alt"></i>
                </div>
                <div class="option-title">Đặt hàng qua Hotline</div>
                <div class="option-desc">Gọi ngay đến số hotline 1900-1533 để được nhân viên tư vấn và đặt hàng nhanh chóng.</div>
                <a href="tel:19001533" class="option-btn">Gọi ngay</a>
            </div>
            
            <div class="option-card">
                <div class="option-icon">
                    <i class="fas fa-shipping-fast"></i>
                </div>
                <div class="option-title">Đặt qua Ứng dụng Giao hàng</div>
                <div class="option-desc">Đặt hàng thông qua các ứng dụng giao hàng phổ biến như GrabFood, Shopeefood, Baemin.</div>
                <a href="#" class="option-btn">Xem chi tiết</a>
            </div>
        </div>
        
        <div class="step-by-step">
            <h2>Các bước đặt hàng qua Website</h2>
            <div class="steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Chọn món</h3>
                    <p>Truy cập mục "Thực đơn" và chọn những món bánh mì, đồ uống yêu thích vào giỏ hàng.</p>
                </div>
                
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Giỏ hàng</h3>
                    <p>Kiểm tra giỏ hàng, điều chỉnh số lượng hoặc xóa món nếu cần.</p>
                </div>
                
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Thanh toán</h3>
                    <p>Chọn phương thức thanh toán phù hợp và địa chỉ giao hàng.</p>
                </div>
                
                <div class="step">
                    <div class="step-number">4</div>
                    <h3>Xác nhận</h3>
                    <p>Kiểm tra thông tin đơn hàng một lần nữa và xác nhận đặt hàng.</p>
                </div>
                
                <div class="step">
                    <div class="step-number">5</div>
                    <h3>Theo dõi</h3>
                    <p>Theo dõi trạng thái đơn hàng trong mục "Đơn hàng của tôi" trên tài khoản.</p>
                </div>
            </div>
        </div>
        
        <div class="faq-section">
            <h2>Câu hỏi thường gặp</h2>
            
            <div class="faq-item">
                <div class="faq-question">
                    Thời gian giao hàng là bao lâu? <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Thời gian giao hàng thông thường từ 30-45 phút tùy thuộc vào khoảng cách và tình trạng giao thông. Vào giờ cao điểm, thời gian có thể kéo dài hơn. Bạn có thể theo dõi trạng thái đơn hàng trên trang web hoặc ứng dụng giao hàng.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question">
                    Có mức đơn hàng tối thiểu để được giao hàng không? <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Đơn hàng từ 100.000đ trở lên sẽ được miễn phí giao hàng trong phạm vi 5km. Với đơn hàng dưới 100.000đ, phí giao hàng sẽ được tính từ 15.000đ - 30.000đ tùy khoảng cách.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question">
                    Tôi có thể hủy đơn hàng sau khi đã đặt không? <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Bạn có thể hủy đơn hàng trong vòng 5 phút sau khi đặt. Sau thời gian này, đơn hàng sẽ được chuyển đến bếp và không thể hủy. Vui lòng liên hệ hotline 1900-1533 nếu cần hỗ trợ thêm.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question">
                    Các phương thức thanh toán được chấp nhận? <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Bánh Mì Pew Pew chấp nhận nhiều phương thức thanh toán bao gồm: Tiền mặt khi nhận hàng (COD), thẻ tín dụng/ghi nợ, ví điện tử (MoMo, ZaloPay, VNPay), và chuyển khoản ngân hàng.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question">
                    Tôi có thể đặt hàng trước cho một thời điểm cụ thể không? <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Có, bạn có thể đặt hàng trước cho một thời điểm cụ thể trong ngày. Khi thanh toán, hãy chọn mục "Đặt hàng trước" và chọn thời gian bạn muốn nhận hàng. Lưu ý đặt trước ít nhất 2 tiếng và không quá 24 giờ.
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
            
            // FAQ toggle
            const faqQuestions = document.querySelectorAll('.faq-question');
            
            faqQuestions.forEach(question => {
                question.addEventListener('click', () => {
                    const faqItem = question.parentElement;
                    faqItem.classList.toggle('active');
                    
                    // Toggle icon
                    const icon = question.querySelector('i');
                    if (faqItem.classList.contains('active')) {
                        icon.classList.remove('fa-chevron-down');
                        icon.classList.add('fa-chevron-up');
                    } else {
                        icon.classList.remove('fa-chevron-up');
                        icon.classList.add('fa-chevron-down');
                    }
                });
            });
        });
    </script>
</body>
</html>