<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khuyến mãi - Bánh Mì Pew Pew</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
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
        
        /* Promotions Section */
        .promotions {
            background-color: #fff5cc;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        .promotion-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            overflow: hidden;
            text-align: center;
        }
        .promotion-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .promotion-card h3 {
            color: #ff3333;
            margin: 10px 0;
            font-size: 18px;
        }
        .promotion-card p {
            color: #333;
            margin: 0 10px 20px;
            font-size: 14px;
        }
        .order-now-btn {
            background-color: #ff6600;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 15px;
            transition: background-color 0.3s;
        }
        .order-now-btn:hover {
            background-color: #e65c00;
        }
        .discount-tag {
            background-color: #ff3333;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            display: inline-block;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <!-- Header -->
            <jsp:include page="header.jsp" />


    <!-- Promotions Section -->
    <div class="promotions">
        <!-- Combo 1 -->
        <div class="promotion-card">
            <img src="${pageContext.request.contextPath}/img/combo75k.jpg" alt="Combo Bánh Mì Thịt & Xúc Xích">
            <h3>COMBO BÁNH MÌ & XÚC XÍCH 25K</h3>
            <div class="discount-tag">(HIỆN ĐANG HẾT HÀNG)</div>
            <p>Combo gồm 1 bánh mì kẹp thịt và 1 xúc xích nóng hổi. Áp dụng thứ 3 đến thứ 5 hàng tuần, khung giờ 14h - 17h.</p>
            <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="1"> <!-- Bánh Mì Pew Pew Thịt -->
                <button type="submit" class="order-now-btn">Đặt ngay</button>
            </form>
        </div>

        <!-- Combo 2 -->
        <div class="promotion-card">
            <img src="${pageContext.request.contextPath}/img/combo2.jpg" alt="Combo Gia Đình">
            <h3>COMBO GIA ĐÌNH 150K</h3>
            <p>Gồm 3 bánh mì kẹp thịt tự chọn, 2 phần bún trộn thịt nướng và 2 lon trà chanh. Áp dụng cho đơn hàng từ 150k trở lên.</p>
            <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="comboProducts" value="true">
                <input type="hidden" name="productId1" value="2"> <!-- Bánh Mì Pew Pew Thịt Xiên -->
                <input type="hidden" name="productId2" value="7"> <!-- Bún Trộn Thịt Nướng -->
                <input type="hidden" name="productId3" value="9"> <!-- Trà Chanh Pew Pew -->
                <button type="submit" class="order-now-btn">Đặt ngay</button>
            </form>
        </div>

        <!-- Chính sách khuyến mãi 1 -->
        <div class="promotion-card">
            <img src="${pageContext.request.contextPath}/img/combo3.jpg" alt="Happy Hour Combo">
            <h3>COMBO 2 NGƯỜI HAPPY HOUR</h3>
            <div class="discount-tag">GIẢM CÒN 60.000 đ</div>
            <p>Combo cho 2 người gồm 2 bánh mì trứng và 2 ly trà đào cam sả size L. Giá gốc 80.000đ, giảm còn 60.000đ. Áp dụng cả ngày thứ 2-6.</p>
            <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="comboProducts" value="true">
                <input type="hidden" name="productId1" value="6"> <!-- Bánh Mì Pew Pew Trứng -->
                <input type="hidden" name="productId2" value="10"> <!-- Trà Đào Cam Sả -->
                <button type="submit" class="order-now-btn">Đặt ngay</button>
            </form>
        </div>

        <!-- Chính sách khuyến mãi 2 -->
        <div class="promotion-card">
            <img src="${pageContext.request.contextPath}/img/combo4.jpg" alt="Giảm giá Online">
            <h3>GIẢM GIÁ 20% CHO ĐƠN HÀNG ONLINE</h3>
            <p>Đặt hàng qua website hoặc app Bánh Mì Pew Pew, nhận ngay ưu đãi giảm 20% cho mọi đơn hàng. Áp dụng thứ 2 & thứ 4 hàng tuần, không áp dụng trong khung giờ 11:30-13:30.</p>
            <form action="${pageContext.request.contextPath}/ProductServlet" method="get">
                <button type="submit" class="order-now-btn">Mua ngay</button>
            </form>
        </div>
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