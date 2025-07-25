<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Tuyển Dụng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .careers-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .careers-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px 0;
            background-color: #fff3e0;
            border-radius: 8px;
        }
        
        .careers-header h1 {
            color: #e94822;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .careers-header p {
            font-size: 16px;
            color: #666;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        .careers-intro {
            background-color: #fff;
            padding: 30px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .careers-intro h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 24px;
        }
        
        .careers-intro p {
            line-height: 1.6;
            color: #555;
            margin-bottom: 15px;
        }
        
        .benefits {
            background-color: #fff;
            padding: 30px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .benefits h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        
        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .benefit-item {
            text-align: center;
            padding: 20px;
        }
        
        .benefit-icon {
            font-size: 40px;
            color: #e94822;
            margin-bottom: 15px;
        }
        
        .benefit-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .benefit-desc {
            color: #666;
            font-size: 14px;
        }
        
        .job-listings {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .job-listings h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        
        .job-item {
            border-bottom: 1px solid #eee;
            padding: 20px 0;
        }
        
        .job-item:last-child {
            border-bottom: none;
        }
        
        .job-title {
            font-size: 20px;
            color: #e94822;
            margin-bottom: 10px;
        }
        
        .job-meta {
            display: flex;
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
        }
        
        .job-meta div {
            margin-right: 20px;
        }
        
        .job-meta i {
            margin-right: 5px;
        }
        
        .job-desc {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .apply-btn {
            display: inline-block;
            background-color: #e94822;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        .apply-btn:hover {
            background-color: #d43b1b;
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
                <li><a href="${pageContext.request.contextPath}/cart.jsp"
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