<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Bánh Mì Pew Pew</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .account-button {
            background-color: #fff;
            color: #333;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            right: 0;
        }

        .dropdown-content.show {
            display: block;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }
        
        /* Cart styles */
        .cart-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .cart-title {
            color: #ff3333;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .error {
            color: red;
            text-align: center;
            margin: 10px 0;
        }
        
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .cart-table th, 
        .cart-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .cart-table th {
            background-color: #f9f9f9;
        }
        
        .quantity-input {
            width: 60px;
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .update-btn,
        .remove-btn,
        .checkout-btn {
            padding: 8px 12px;
            background-color: #ffcc00;
            color: #333;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .remove-btn {
            background-color: #ff3333;
            color: white;
        }
        
        .checkout-btn {
            padding: 10px 20px;
            font-size: 16px;
        }
        
        .cart-summary {
            text-align: right;
            font-size: 18px;
            margin: 20px 0;
        }
        
        .cart-links {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        
        .cart-links a {
            color: #ff3333;
            text-decoration: none;
        }
        
        .cart-links a:hover {
            text-decoration: underline;
        }

        /* Promotion styles */
        .promotion-container {
            background-color: #fff9e6;
            border: 1px dashed #ffcc00;
            border-radius: 6px;
            padding: 15px;
            margin: 20px 0;
        }
        
        .promotion-title {
            color: #ff6600;
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        .promotion-list {
            list-style-type: none;
            padding: 0;
        }
        
        .promotion-item {
            padding: 5px 0;
            color: #333;
        }
        
        .promotion-item i {
            color: #ff6600;
            margin-right: 8px;
        }
        
        .deal-badge {
            background-color: #ff3333;
            color: white;
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 4px;
            margin-left: 8px;
        }
        
        /* Cart summary with discounts */
        .total-summary {
            background-color: #f9f9f9;
            border-radius: 6px;
            padding: 15px;
            margin: 20px 0;
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
    </style>
</head>
<body>
    <!-- Header -->
            <jsp:include page="header.jsp" />


    <!-- Cart Content -->
    <div class="cart-container">
        <h2 class="cart-title">Giỏ hàng của bạn</h2>
        
        <c:if test="${not empty requestScope.error}">
            <p class="error">${requestScope.error}</p>
        </c:if>
        
        <!-- Promotion Banner -->
        <div class="promotion-container">
            <h3 class="promotion-title"><i class="fas fa-gift"></i> Khuyến mãi đặc biệt</h3>
            <ul class="promotion-list">
                <li class="promotion-item"><i class="fas fa-tag"></i> Giảm ngay 20.000 VNĐ cho đơn hàng từ 100.000 VNĐ <span class="deal-badge">HOT</span></li>
                <li class="promotion-item"><i class="fas fa-tag"></i> Giảm thêm 10.000 VNĐ cho đơn hàng từ 150.000 VNĐ</li>
                <li class="promotion-item"><i class="fas fa-truck"></i> Miễn phí giao hàng cho đơn hàng từ 200.000 VNĐ</li>
                <li class="promotion-item"><i class="fas fa-percent"></i> Mua 3 tặng 1 với mỗi sản phẩm cùng loại</li>
            </ul>
        </div>
        
        <c:choose>
            <c:when test="${empty cart}">
                <p style="text-align: center;">Giỏ hàng của bạn đang trống!</p>
                <p style="text-align: center;"><a href="${pageContext.request.contextPath}/ProductServlet">Tiếp tục mua sắm</a></p>
            </c:when>
            <c:otherwise>
                <table class="cart-table">
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                        <th>Hành động</th>
                    </tr>
                    <c:forEach var="item" items="${cart}">
                        <tr>
                            <td>${item.productName}</td>
                            <td>${item.price} VNĐ</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="productID" value="${item.productID}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input">
                                    <button type="submit" class="update-btn">Cập nhật</button>
                                </form>
                            </td>
                            <td>${item.price * item.quantity} VNĐ</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productID" value="${item.productID}">
                                    <button type="submit" class="remove-btn">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                
                <!-- Cart Summary with Discount -->
                <div class="total-summary">
                    <div class="summary-row">
                        <span>Tạm tính:</span>
                        <span>${subtotal} VNĐ</span>
                    </div>
                    
                    <c:if test="${discount > 0}">
                        <div class="summary-row">
                            <span>Giảm giá:</span>
                            <span class="discount">-${discount} VNĐ</span>
                        </div>
                    </c:if>
                    
                    <div class="summary-row">
                        <span>Phí vận chuyển:</span>
                        <span>${shippingFee} VNĐ</span>
                    </div>
                    
                    <div class="total-row">
                        <span>Thành tiền:</span>
                        <span>${finalTotal} VNĐ</span>
                    </div>
                </div>
                
                <!-- Applied Promotions -->
                <c:if test="${not empty appliedPromotions}">
                    <div style="margin: 15px 0; font-size: 14px; color: #0066cc;">
                        <p><i class="fas fa-check-circle"></i> Các khuyến mãi đã áp dụng:</p>
                        <ul style="list-style-type: none; padding-left: 20px;">
                            <c:forEach var="promotion" items="${appliedPromotions}">
                                <li><i class="fas fa-angle-right"></i> ${promotion}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                
                <div style="text-align: center; margin-top: 20px;">
                    <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                        <input type="hidden" name="action" value="checkout">
                        <button type="submit" class="checkout-btn">Thanh toán</button>
                    </form>
                </div>
                
                <div class="cart-links">
                    <a href="${pageContext.request.contextPath}/ProductServlet">Tiếp tục mua sắm</a>
                    <a href="${pageContext.request.contextPath}/jsp/welcome.jsp">Quay lại trang chủ</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const accountButton = document.querySelector('.account-button');
            const dropdownContent = document.querySelector('.dropdown-content');

            accountButton.addEventListener('click', function() {
                dropdownContent.classList.toggle('show');
            });

            // Close the dropdown if the user clicks outside of it
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