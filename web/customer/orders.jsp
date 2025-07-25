<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="dal.OrderDAO" %>
<%@ page import="dal.OrderDetailsDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bánh Mì Pew Pew - Đơn Hàng Của Tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .order-card {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .order-card h4 {
            margin: 0 0 10px;
        }
        .order-details {
            margin-top: 10px;
        }
        .order-details p {
            margin: 5px 0;
        }
        .payment-method {
            margin-top: 10px;
        }
        .payment-method select {
            padding: 5px;
            margin-right: 10px;
        }
        .qr-code {
            display: none;
            margin-top: 10px;
        }
        .qr-code img {
            width: 150px;
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

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getOrdersByUser(user.getUserID()); // Sửa kiểu từ List<OrderDetail> thành List<Order>
    OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
    %>
    <jsp:include page="/jsp/header.jsp" />

    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>TÀI KHOẢN CỦA TÔI</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/customer/dashboard.jsp">QUẢN LÝ TÀI KHOẢN</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/customer/orders.jsp">ĐƠN HÀNG CỦA TÔI</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">ĐỊA CHỈ GIAO HÀNG</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/profile.jsp">THÔNG TIN TÀI KHOẢN</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/favorites.jsp">DANH SÁCH SẢN PHẨM ĐÃ MUA</a></li>
            </ul>
        </div>

        <main class="main-content">
            <section class="account-header">
                <h2>ĐƠN HÀNG CỦA TÔI</h2>
                <p>Xem và quản lý các đơn hàng của bạn tại đây.</p>
            </section>

            <section class="orders-section">
                <% if (orders.isEmpty()) { %>
                    <p class="empty-info">Bạn chưa có đơn hàng nào.</p>
                <% } else { %>
                    <% for (Order order : orders) { 
                        List<OrderDetail> details = orderDetailsDAO.getOrderDetailsByOrderID(order.getOrderID());
                    %>
                        <div class="order-card">
                            <h4>Đơn hàng #<%= order.getOrderID() %></h4>
                            <p>Ngày đặt: <%= order.getOrderDate() %></p>
                            <p>Tổng tiền: <%= String.format("%,.0fđ", order.getTotal()) %></p>
                            <div class="order-details">
                                <h5>Chi tiết đơn hàng:</h5>
                                <% for (OrderDetail detail : details) { %>
                                    <p>- <%= detail.getProductName() %> (x<%= detail.getQuantity() %>) - <%= String.format("%,.0fđ", detail.getPrice()) %></p>
                                <% } %>
                            </div>

                            <div class="payment-method">
                                <label>Phương thức thanh toán:</label>
                                <select onchange="showQRCode(this, '<%= order.getOrderID() %>')">
                                    <option value="Cash">Tiền mặt</option>
                                    <option value="Bank">Ngân hàng</option>
                                    <option value="Mobile">Ứng dụng di động</option>
                                </select>
                                <div class="qr-code" id="qr-<%= order.getOrderID() %>">
                                    <img src="${pageContext.request.contextPath}/img/qrcode.jpg" alt="QR Code">
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </section>
        </main>
    </div>

    <jsp:include page="/jsp/footer.jsp" />

    <script>
        function showQRCode(select, orderID) {
            const qrDiv = document.getElementById('qr-' + orderID);
            if (select.value === 'Bank') {
                qrDiv.style.display = 'block';
            } else {
                qrDiv.style.display = 'none';
            }
        }
    </script>
</body>
</html>