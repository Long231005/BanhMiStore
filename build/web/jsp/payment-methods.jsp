<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bánh Mì Pew Pew - Phương Thức Thanh Toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .payment-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .payment-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px 0;
            background-color: #fff3e0;
            border-radius: 8px;
        }
        
        .payment-header h1 {
            color: #e94822;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .payment-header p {
            font-size: 16px;
            color: #666;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        .payment-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .payment-section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f5f5f5;
        }
        
        .payment-methods {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
        }
        
        .payment-method {
            flex: 1;
            min-width: 250px;
            padding: 20px;
            border-radius: 8px;
            background-color: #f9f9f9;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .payment-method:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .payment-icon {
            font-size: 30px;
            color: #e94822;
            margin-bottom: 15px;
            display: inline-block;
            width: 60px;
            height: 60px;
            line-height: 60px;
            text-align: center;
            background-color: #fff3e0;
            border-radius: 50%;
        }
        
        .payment-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .payment-desc {
            color: #666;
            line-height: 1.5;
            margin-bottom: 15px;
        }
        
        .payment-info {
            background-color: #f2f2f2;
            padding: 10px;
            border-radius: 4px;
            font-size: 14px;
            color: #555;
        }
        
        .payment-info p {
            margin: 5px 0;
        }
        
        .info-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .info-section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f5f5f5;
        }
        
        .info-section p {
            line-height: 1.6;
            color: #555;
            margin-bottom: 15px;
        }
        
        .security-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .security-section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f5f5f5;
        }
        
        .security-features {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .security-feature {
            flex: 1;
            min-width: 200px;
            display: flex;
            align-items: flex-start;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        
        .security-icon {
            color: #e94822;
            margin-right: 15px;
            font-size: 24px;
        }
        
        .security-text h3 {
            font-size: 16px;
            margin-bottom: 5px;
            color: #333;
        }
        
        .security-text p {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
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
    
    <div class="payment-container">
        <div class="payment-header">
            <h1>PHƯƠNG THỨC THANH TOÁN</h1>
            <p>Bánh Mì Pew Pew cung cấp nhiều phương thức thanh toán linh hoạt giúp bạn dễ dàng thanh toán đơn hàng một cách an toàn và tiện lợi.</p>
        </div>
        
        <div class="payment-section">
            <h2>Các phương thức thanh toán</h2>
            <div class="payment-methods">
                <div class="payment-method">
                    <div class="payment-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="payment-title">Tiền mặt khi nhận hàng (COD)</div>
                    <div class="payment-desc">Thanh toán bằng tiền mặt khi nhận hàng tại nhà. Phương thức đơn giản, tiện lợi và phổ biến nhất.</div>
                    <div class="payment-info">
                        <p>Lưu ý: Vui lòng chuẩn bị đúng số tiền để thuận tiện cho quá trình giao nhận.</p>
                    </div>
                </div>
                
                <div class="payment-method">
                    <div class="payment-icon">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <div class="payment-title">Thẻ tín dụng/ghi nợ</div>
                    <div class="payment-desc">Thanh toán nhanh chóng bằng thẻ tín dụng hoặc thẻ ghi nợ Visa, MasterCard, JCB. 
    Đảm bảo an toàn tuyệt đối qua cổng thanh toán bảo mật.
</div>
<div class="payment-info">
    <p>Lưu ý: Một số ngân hàng có thể yêu cầu xác thực OTP để hoàn tất giao dịch.</p>
</div>
</div>

<div class="payment-method">
    <div class="payment-icon">
        <i class="fas fa-wallet"></i>
    </div>
    <div class="payment-title">Ví điện tử (Momo, ZaloPay, VNPay)</div>
    <div class="payment-desc">
        Thanh toán nhanh chóng chỉ với vài thao tác qua các ví điện tử phổ biến.
    </div>
    <div class="payment-info">
        <p>Hỗ trợ tất cả các ví điện tử lớn tại Việt Nam.</p>
    </div>
</div>

<div class="payment-method">
    <div class="payment-icon">
        <i class="fas fa-university"></i>
    </div>
    <div class="payment-title">Chuyển khoản ngân hàng</div>
    <div class="payment-desc">
        Chuyển khoản trực tiếp đến tài khoản ngân hàng của Bánh Mì Pew Pew.
    </div>
    <div class="payment-info">
        <p>Thông tin tài khoản ngân hàng sẽ được cung cấp sau khi đặt hàng.</p>
    </div>
</div>
   