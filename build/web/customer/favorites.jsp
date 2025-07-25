<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="dal.OrderDetailsDAO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashSet" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bánh Mì Pew Pew - Sản Phẩm Đã Mua</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .product-card {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            display: flex;
            align-items: center;
        }
        .product-card img {
            width: 100px;
            margin-right: 15px;
        }
        .product-card h4 {
            margin: 0 0 10px;
        }
        .add-to-cart-btn {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <% 
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
    Vector<OrderDetail> purchasedProducts = orderDetailsDAO.getPurchasedProductsByUser(user.getUserID());    // Loại bỏ sản phẩm trùng lặp bằng HashSet dựa trên productID
    HashSet<Integer> uniqueProductIDs = new HashSet<>();
    Vector<OrderDetail> uniqueProducts = new Vector<>();
    for (OrderDetail product : purchasedProducts) {
        if (uniqueProductIDs.add(product.getProductID())) {
            uniqueProducts.add(product);
        }
    }
    %>

    <jsp:include page="../jsp/header.jsp" />

    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>TÀI KHOẢN CỦA TÔI</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/customer/dashboard.jsp">QUẢN LÝ TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/orders.jsp">ĐƠN HÀNG CỦA TÔI</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">ĐỊA CHỈ GIAO HÀNG</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">THÔNG TIN TÀI KHOẢN</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/customer/favorites.jsp">DANH SÁCH SẢN PHẨM ĐÃ MUA</a></li>
            </ul>
        </div>

        <main class="main-content">
            <section class="account-header">
                <h2>SẢN PHẨM ĐÃ MUA</h2>
                <p>Xem lại các sản phẩm bạn đã mua và đặt lại nếu muốn.</p>
            </section>

            <section class="purchased-products-section">
                <% if (uniqueProducts.isEmpty()) { %>
                    <p class="empty-info">Bạn chưa mua sản phẩm nào.</p>
                <% } else { %>
                    <% for (OrderDetail product : uniqueProducts) { %>
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/img/<%= product.getImage() %>" alt="<%= product.getProductName() %>">
                            <div>
                                <h4><%= product.getProductName() %></h4>
                                <p>Giá: <%= String.format("%,.0fđ", product.getPrice()) %></p>
                                <button class="add-to-cart-btn" onclick="addToCart('<%= product.getProductID() %>')">Thêm vào giỏ hàng</button>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </section>
        </main>
    </div>

    <jsp:include page="../jsp/footer.jsp" />

    <script>
        function addToCart(productID) {
            window.location.href = '${pageContext.request.contextPath}/CartServlet?action=add&productID=' + productID + '&quantity=1';
        }
    </script>
</body>
</html>