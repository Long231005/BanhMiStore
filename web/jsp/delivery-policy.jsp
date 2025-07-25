<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Chính Sách Giao Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .policy-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .policy-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px 0;
            background-color: #fff3e0;
            border-radius: 8px;
        }

        .policy-header h1 {
            color: #e94822;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .policy-header p {
            font-size: 16px;
            color: #666;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .policy-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .policy-section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            border-bottom: 2px solid #f5f5f5;
            padding-bottom: 10px;
        }

        .policy-section p, .policy-section ul {
            color: #555;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .policy-section ul {
            padding-left: 20px;
            list-style-type: disc;
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

    <div class="policy-container">
        <div class="policy-header">
            <h1>CHÍNH SÁCH GIAO HÀNG</h1>
            <p>Bánh Mì Pew Pew cam kết mang đến cho quý khách hàng dịch vụ giao hàng nhanh chóng, an toàn và tận tâm nhất.</p>
        </div>

        <div class="policy-section">
            <h2>1. Khu vực giao hàng</h2>
            <p>Hiện tại, chúng tôi hỗ trợ giao hàng trong khu vực nội thành các thành phố lớn như Hồ Chí Minh, Hà Nội, Đà Nẵng và một số khu vực lân cận.</p>
            <ul>
                <li>Giao hàng tận nơi trong bán kính 10km miễn phí cho đơn hàng từ 150.000đ trở lên.</li>
                <li>Phí giao hàng sẽ được tính tùy theo khoảng cách nếu đơn hàng dưới 150.000đ.</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>2. Thời gian giao hàng</h2>
            <p>Thời gian giao hàng dự kiến:</p>
            <ul>
                <li>Nội thành: 30 - 60 phút kể từ khi xác nhận đơn hàng.</li>
                <li>Khu vực lân cận: 1 - 2 tiếng tùy vào điều kiện giao thông.</li>
                <li>Giao hàng từ 8h00 - 21h00 mỗi ngày, kể cả cuối tuần và ngày lễ.</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>3. Quy định giao nhận</h2>
            <p>Quý khách vui lòng:</p>
            <ul>
                <li>Luôn giữ điện thoại liên lạc trong quá trình giao nhận.</li>
                <li>Kiểm tra kỹ sản phẩm trước khi nhận hàng.</li>
                <li>Thông báo ngay cho chúng tôi nếu có bất kỳ vấn đề nào về sản phẩm hoặc đơn hàng.</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>4. Các lưu ý khác</h2>
            <p>Trong trường hợp:</p>
            <ul>
                <li>Địa chỉ giao hàng không chính xác hoặc khách không nhận cuộc gọi nhiều lần, đơn hàng có thể bị hủy.</li>
                <li>Thời gian giao hàng có thể thay đổi do điều kiện thời tiết xấu, lễ hội hoặc lưu lượng giao thông.</li>
            </ul>
            <p>Chúng tôi cam kết luôn thông báo cho quý khách sớm nhất nếu có thay đổi phát sinh.</p>
        </div>

        <div class="policy-section">
            <h2>5. Liên hệ hỗ trợ</h2>
            <p>Nếu quý khách có bất kỳ thắc mắc hay yêu cầu hỗ trợ về việc giao hàng, vui lòng liên hệ Hotline: <strong>1900-1533</strong> hoặc email: <strong>hotro@banhmipewpew.vn</strong>.</p>
        </div>
    </div>
</body>
</html>
