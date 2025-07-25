<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Bánh Mì Pew Pew</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .register-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        .register-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #ff3333;
        }
        .register-container form {
            display: flex;
            flex-direction: column;
        }
        .register-container label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        .register-container input,
        .register-container select {
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
        }
        .register-container button {
            background-color: #ffcc00;
            color: #333;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }
        .register-container button:hover {
            background-color: #e6b800;
        }
        .register-container .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        .register-container .success {
            color: green;
            text-align: center;
            margin-bottom: 15px;
        }
        .register-container .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .register-container .login-link a {
            color: #ff3333;
            text-decoration: none;
        }
        .register-container .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Đăng ký tài khoản</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="success"><%= request.getAttribute("message") %></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>

            <label for="fullName">Họ tên:</label>
            <input type="text" id="fullName" name="fullName" required>

            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" name="address">

            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone">

            <label for="city">Tỉnh/Thành phố:</label>
            <select id="city" name="city" required>
                <option value="">Chọn tỉnh/thành phố</option>
                <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                <option value="Đà Nẵng">Đà Nẵng</option>
                <option value="Hà Nội">Hà Nội</option>
            </select>

            <button type="submit">Đăng ký</button>
        </form>
        <div class="login-link">
            <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/jsp/login.jsp">Đăng nhập</a></p>
        </div>
    </div>
</body>
</html>