<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Bánh Mì Pew Pew</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />

    <!-- Slider -->
    <div class="slider-container">
        <div class="slider-wrapper" id="sliderWrapper">
            <div class="slide">
                <img src="${pageContext.request.contextPath}/img/combo1.jpg" alt="Combo 1">
                <div class="slide-content">
                    <h2>Bánh mì PewPew xin chào</h2>
                    <h3>Siêu ngon</h3>
                    <p>Combo 99K (Áp dụng nhóm 2 người)</p>
                    <p>2 Bánh mì + 2 Nước ngọt + 1 Phần khoai tây chiên</p>
                    <a href="${pageContext.request.contextPath}/ProductServlet" class="order-btn">Đặt ngay</a>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/img/combo2.jpg" alt="Combo 2">
                <div class="slide-content">
                    <h2>Combo Tiết Kiệm</h2>
                    <h3>Chỉ 79K</h3>
                    <p>Combo đặc biệt giá ưu đãi</p>
                    <p>1 Bánh mì thịt + 1 Nước ngọt + 1 Phần khoai tây chiên</p>
                    <a href="${pageContext.request.contextPath}/jsp/promotions.jsp" class="order-btn">Mua Ngay</a>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/img/combo3.jpg" alt="Combo 3">
                <div class="slide-content">
                    <h2>Combo Gia Đình</h2>
                    <h3>Giá Sốc 149K</h3>
                    <p>Combo 4 người ấm no</p>
                    <p>4 Bánh mì + 4 Nước ngọt + 2 Phần khoai tây chiên</p>
                    <a href="${pageContext.request.contextPath}/ProductServlet" class="order-btn">Mua Ngay</a>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/img/combo4.jpg" alt="Combo 4">
                <div class="slide-content">
                    <h2>Combo Văn Phòng</h2>
                    <h3>Siêu Ưu Đãi</h3>
                    <p>Combo 5 người chỉ 199K</p>
                    <p>5 Bánh mì + 5 Nước ngọt + 3 Phần khoai tây chiên</p>
                    <a href="${pageContext.request.contextPath}/jsp/promotions.jsp" class="order-btn">Mua Ngay</a>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/img/combo5.jpg" alt="Combo 5">
                <div class="slide-content">
                    <h2>Combo Cuối Tuần</h2>
                    <h3>Giảm 25%</h3>
                    <p>Combo vui vẻ chỉ 119K</p>
                    <p>3 Bánh mì + 3 Nước ngọt + 1 Phần khoai tây chiên</p>
                    <a href="${pageContext.request.contextPath}/ProductServlet" class="order-btn">Mua Ngay</a>
                </div>
            </div>
        </div>
        <div class="dot-navigation"></div>
    </div>

    <!-- Benefits Section -->
    <section class="benefits">
        <div class="benefit-item">
            <div class="benefit-icon">✓</div>
            <span class="benefit-text">Chất Lượng An Toàn</span>
        </div>
        <div class="benefit-item">
            <div class="benefit-icon">🚚</div>
            <span class="benefit-text">Miễn Phí Vận Chuyển</span>
        </div>
        <div class="benefit-item">
            <div class="benefit-icon">⏩</div>
            <span class="benefit-text">Giao Hàng Nhanh</span>
        </div>
        <div class="benefit-item">
            <div class="benefit-icon">📞</div>
            <span class="benefit-text">CSKH 24/7</span>
        </div>
    </section>

    <!-- Products Section -->
    <section class="products">
        <div class="product-item">
            <div class="product-image-container">
                <img src="${pageContext.request.contextPath}/img/banh-mi.jpg" alt="Bánh Mì">
                <div class="product-overlay">
                    <a href="${pageContext.request.contextPath}/ProductServlet" class="search-icon">
                        <i class="fas fa-search"></i>
                    </a>
                    <button onclick="addToCart(7)" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="product-item">
            <div class="product-image-container">
                <img src="${pageContext.request.contextPath}/img/nuoc-ngot.jpg" alt="Nước Ngọt">
                <div class="product-overlay">
                    <a href="${pageContext.request.contextPath}/ProductServlet" class="search-icon">
                        <i class="fas fa-search"></i>
                    </a>
                    <button onclick="addToCart(18)" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="product-item">
            <div class="product-image-container">
                <img src="${pageContext.request.contextPath}/img/khoai-tay.jpg" alt="Khoai Tây Chiên">
                <div class="product-overlay">
                    <a href="${pageContext.request.contextPath}/ProductServlet" class="search-icon">
                        <i class="fas fa-search"></i>
                    </a>
                    <button onclick="addToCart(12)" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Thêm script cho chức năng thêm vào giỏ hàng -->
    <script>
        function addToCart(productId) {
            window.location.href = "${pageContext.request.contextPath}/CartServlet?action=add&productId=" + productId;
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>