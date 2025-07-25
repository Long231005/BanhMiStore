<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Bánh Mì Pew Pew</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .checkout-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .checkout-title {
            color: #ff3333;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .checkout-section {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .checkout-section h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        .checkout-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }
        
        .checkout-table th, 
        .checkout-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .checkout-table th {
            background-color: #f9f9f9;
        }
        
        .promotion-item {
            color: #0066cc;
            margin: 5px 0;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            font-weight: bold;
            font-size: 18px;
            border-top: 2px solid #ddd;
            margin-top: 10px;
        }
        
        .discount {
            color: #cc0000;
        }
        
        .payment-options {
            text-align: center;
            margin: 30px 0;
        }
        
        .payment-btn {
            padding: 12px 24px;
            background-color: #ffcc00;
            color: #333;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            margin: 0 10px;
        }
        
        .continue-btn {
            background-color: #ff3333;
            color: white;
        }
        
        .back-btn {
            background-color: #999;
            color: white;
        }
        .payment-methods {
            margin-top: 30px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .payment-methods label {
            display: block;
            margin: 10px 0;
        }
        .payment-info {
            margin-top: 15px;
            text-align: center;
            display: none;
        }
        .payment-info img {
            max-width: 200px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Bánh Mì Pew Pew Logo">
            <h1>Bánh Mì Pew Pew</h1>
        </div>
        <nav class="nav">
            <a href="${pageContext.request.contextPath}/jsp/index.jsp">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/ProductServlet">Thực đơn</a>
            <a href="${pageContext.request.contextPath}/jsp/promotions.jsp">Khuyến mãi</a>
            <a href="${pageContext.request.contextPath}/CartServlet">Giỏ hàng</a>
        </nav>
        <div class="header-right">
            <div class="hotline">
                <span>Hotline:</span>
                <a href="tel:1900-1533" class="hotline-text">1900-1533</a>
            </div>
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <div class="dropdown">
                        <button class="account-button">My Account ▼</button>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/jsp/login.jsp">Sign In</a>
                            <a href="${pageContext.request.contextPath}/jsp/register.jsp">Sign Up</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="dropdown">
                        <button class="account-button">Tài khoản ▼</button>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/jsp/welcome.jsp">Thông tin tài khoản</a>
                            <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <!-- Checkout Content -->
    <div class="checkout-container">
        <h2 class="checkout-title">Xác nhận đơn hàng</h2>
        
        <div class="checkout-section">
            <h3>Chi tiết đơn hàng</h3>
            <table class="checkout-table">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tổng</th>
                </tr>
                <c:forEach var="item" items="${cart}">
                    <tr>
                        <td>${item.productName}</td>
                        <td><fmt:formatNumber value="${item.price}" type="currency" currencyCode="VND"/></td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencyCode="VND"/></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        
        <div class="checkout-section">
            <h3>Khuyến mãi áp dụng</h3>
            <c:choose>
                <c:when test="${empty appliedPromotions}">
                    <p>Không có khuyến mãi nào được áp dụng.</p>
                </c:when>
                <c:otherwise>
                    <ul>
                        <c:forEach var="promotion" items="${appliedPromotions}">
                            <li class="promotion-item">
                                <i class="fas fa-tag"></i> ${promotion}
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="checkout-section">
            <h3>Tổng cộng</h3>
            <div class="summary-row">
                <span>Tạm tính:</span>
                <span><fmt:formatNumber value="${subtotal}" type="currency" currencyCode="VND"/></span>
            </div>
            <div class="summary-row">
                <span>Giảm giá:</span>
                <span class="discount">-<fmt:formatNumber value="${discount}" type="currency" currencyCode="VND"/></span>
            </div>
            <div class="summary-row">
                <span>Phí vận chuyển:</span>
                <span><fmt:formatNumber value="${shippingFee}" type="currency" currencyCode="VND"/></span>
            </div>
            <div class="total-row">
                <span>Thành tiền:</span>
                <span><fmt:formatNumber value="${finalTotal}" type="currency" currencyCode="VND"/></span>
            </div>
        </div>

        <!-- Phương thức thanh toán -->
        <div class="checkout-section payment-methods">
            <h3>Phương thức thanh toán</h3>
            <form id="paymentForm" action="${pageContext.request.contextPath}/CartServlet" method="get">
                <input type="hidden" name="action" value="processPayment">
                <label>
                    <input type="radio" name="paymentMethod" value="COD" checked onchange="togglePaymentInfo()"> Thanh toán khi nhận hàng (COD)
                </label>
                <label>
                    <input type="radio" name="paymentMethod" value="Bank" onchange="togglePaymentInfo()"> Thanh toán qua ngân hàng
                </label>
                <label>
                    <input type="radio" name="paymentMethod" value="App" onchange="togglePaymentInfo()"> Thanh toán qua ứng dụng
                </label>

                <!-- Thông tin khi chọn Bank hoặc App -->
                <div id="bankInfo" class="payment-info">
                    <p>Quét mã QR để thanh toán:</p>
                    <img src="${pageContext.request.contextPath}/img/qrcode.jpg" alt="QR Code">
                </div>
                <div id="appInfo" class="payment-info">
                    <p>Thanh toán qua ứng dụng: App BanhMiPewPew trên CH Play. Vui lòng đăng nhập trên app để thanh toán.</p>
                </div>

                <div class="payment-options">
                    <button type="submit" class="payment-btn continue-btn">Thanh toán</button>
                    <a href="${pageContext.request.contextPath}/CartServlet" class="payment-btn back-btn">Quay lại giỏ hàng</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function togglePaymentInfo() {
            const bankInfo = document.getElementById("bankInfo");
            const appInfo = document.getElementById("appInfo");
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            
            bankInfo.style.display = paymentMethod === "Bank" ? "block" : "none";
            appInfo.style.display = paymentMethod === "App" ? "block" : "none";
            if (paymentMethod === "COD") {
                bankInfo.style.display = "none";
                appInfo.style.display = "none";
            }
        }

        // Dropdown account
        document.addEventListener('DOMContentLoaded', function() {
            const accountButton = document.querySelector('.account-button');
            const dropdownContent = document.querySelector('.dropdown-content');

            accountButton.addEventListener('click', function() {
                dropdownContent.classList.toggle('show');
            });

            window.addEventListener('click', function(event) {
                if (!event.target.matches('.account-button')) {
                    if (dropdownContent.classList.contains('show')) {
                        dropdownContent.classList.remove('show');
                    }
                }
            });
        });
    </script>

    <jsp:include page="footer.jsp" />
</body>
</html>
