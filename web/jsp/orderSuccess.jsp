<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đặt hàng thành công - Bánh Mì Pew Pew</title>
    <title>Bánh Mì Pew Pew - Trang Quản Lý Khách Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/success-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="header.jsp"/>
    
    <div class="container">
        <div class="success-container">
            <h1>Đặt hàng thành công!</h1>
            
            <% if (session.getAttribute("confirmMessage") != null) { %>
                <div class="alert alert-success">
                    <%= session.getAttribute("confirmMessage") %>
                </div>
            <% } %>
            
            <% if (session.getAttribute("orderID") != null) { %>
                <p>Mã đơn hàng của bạn: <strong><%= session.getAttribute("orderID") %></strong></p>
            <% } %>
            
            <p>Cảm ơn bạn đã mua hàng tại Bánh Mì Pew Pew!</p>
            <p>Đơn hàng của bạn đang được xử lý. Chúng tôi sẽ giao hàng trong thời gian sớm nhất.</p>
            
            <div class="buttons">
                <a href="${pageContext.request.contextPath}/ProductServlet" class="btn btn-primary">Tiếp tục mua sắm</a>
                <a href="${pageContext.request.contextPath}/customer/orders.jsp" class="btn btn-secondary">Xem lịch sử đơn hàng</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"/>
</body>
</html>