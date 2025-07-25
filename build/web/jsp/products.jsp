<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm - Bánh Mì Pew Pew</title>
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
        
        /* Products Container */
        .products-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            padding: 0 20px;
            margin-bottom: 20px;
        }

        .product-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            width: 200px;
            padding: 10px;
            text-align: center;
            margin-bottom: 10px;
        }

        .product-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 4px;
        }

        .product-card h3 {
            font-size: 16px;
            margin: 10px 0;
            height: 40px;
            overflow: hidden;
        }

        .product-card .price {
            font-size: 16px;
            font-weight: bold;
            color: #ff3333;
            margin: 10px 0;
        }

        .product-card .add-to-cart {
            background-color: #ffcc00;
            color: #333;
            padding: 8px 0;
            width: 100%;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            display: block;
        }

        /* Search Container */
        .search-container {
            text-align: center;
            margin: 20px 0;
            padding: 0 20px;
        }

        .search-container form {
            display: inline-flex;
            gap: 10px;
            align-items: center;
            max-width: 600px;
            margin: 0 auto;
        }

        .search-container input[type="text"] {
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            flex-grow: 1;
            width: 300px;
        }

        .search-container select {
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .search-container button {
            background-color: #ffcc00;
            color: #333;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }
        
        /* Error Message */
        .error {
            color: red;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
        <jsp:include page="header.jsp" />


    <!-- Search Form -->
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/ProductServlet" method="get">
            <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..." value="${param.keyword}">
            <select name="categoryID">
                <option value="">Tất cả danh mục</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryID}" 
                            <c:if test="${param.categoryID == category.categoryID}">selected</c:if>>
                        ${category.categoryName}
                    </option>
                </c:forEach>
            </select>
            <button type="submit">Tìm kiếm</button>
        </form>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty requestScope.error}">
        <p class="error">${requestScope.error}</p>
    </c:if>

    <!-- Products -->
    <div class="products-container">
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/img/${product.image != null && !empty product.image ? product.image : 'placeholder.jpg'}" alt="${product.productName}">
                <h3>${product.productName}</h3>
                <p class="price">${product.price} VNĐ</p>
                <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productID" value="${product.productID}">
                    <button type="submit" class="add-to-cart">Thêm vào giỏ hàng</button>
                </form>
            </div>
        </c:forEach>
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