<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Không có quyền truy cập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .error-icon {
            font-size: 80px;
            color: #ff6b6b;
        }
        
        .error-title {
            color: #ff6b6b;
            margin-top: 20px;
        }
        
        .error-message {
            margin-top: 20px;
            color: #555;
        }
        
        .back-button {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #4caf50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⛔</div>
        <h1 class="error-title">Không có quyền truy cập</h1>
        <div class="error-message">
            <p>Bạn không có quyền truy cập vào trang này.</p>
            <p>Vui lòng quay lại hoặc đăng nhập với tài khoản có quyền truy cập.</p>
        </div>
        <a href="${pageContext.request.contextPath}/jsp/welcome.jsp" class="back-button">Quay lại trang chủ</a>
    </div>
</body>
</html>