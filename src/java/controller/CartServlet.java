    package controller;

    import dal.OrderDAO;
    import dal.ProductDAO;
    import dal.PromotionDAO; 
    import model.CartItem;
    import model.Order;
    import model.OrderDetail;
    import model.Product;
    import model.User;
    import model.Promotion; 
    import jakarta.servlet.ServletException;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import jakarta.servlet.http.HttpSession;
    import java.io.IOException;
    import java.sql.SQLException;
    import java.util.ArrayList;
    import java.util.Date;
    import java.util.List;

    public class CartServlet extends HttpServlet {

        private ProductDAO productDAO;
        private OrderDAO orderDAO;
        private PromotionDAO promotionDAO;

        @Override
        public void init() throws ServletException {
            productDAO = new ProductDAO();
            orderDAO = new OrderDAO();
            promotionDAO = new PromotionDAO();
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) 
                throws ServletException, IOException {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            if (action == null) {
                applyPromotions(request, cart);
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
                return;
            }

            try {
                switch (action) {
                    case "add":
                        addToCart(request, cart);
                        break;
                    case "update":
                        updateCart(request, cart);
                        break;
                    case "remove":
                        removeFromCart(request, cart);
                        break;
                    case "checkout":
                        checkout(request, response, cart);
                        return;
                    case "processPayment": // Đảm bảo khớp với URL từ checkout.jsp
                        processPayment(request, response, cart);
                        return;
                }
                applyPromotions(request, cart);
                session.setAttribute("cart", cart);
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            }
        }

        private void addToCart(HttpServletRequest request, List<CartItem> cart) throws SQLException {
            String comboParam = request.getParameter("comboProducts");
            boolean isCombo = comboParam != null && comboParam.equals("true");

            if (isCombo) {
                addComboToCart(request, cart);
            } else {
                String productIdParam = request.getParameter("productId");
                String productIDParam = request.getParameter("productID");
                String finalProductIdParam = (productIdParam != null) ? productIdParam : productIDParam;

                if (finalProductIdParam == null || finalProductIdParam.isEmpty()) {
                    request.setAttribute("error", "Sản phẩm không hợp lệ hoặc không tồn tại!");
                    return;
                }

                try {
                    int productID = Integer.parseInt(finalProductIdParam);
                    Product product = productDAO.getProductByID(productID);

                    if (product == null) {
                        request.setAttribute("error", "Khuyến mãi đã hết!");
                        return;
                    }

                    CartItem item = cart.stream()
                            .filter(i -> i.getProductID() == productID)
                            .findFirst()
                            .orElse(null);

                    if (item == null) {
                        item = new CartItem(productID, product.getProductName(), product.getPrice(), 1);
                        cart.add(item);
                    } else {
                        item.setQuantity(item.getQuantity() + 1);
                    }

                    request.setAttribute("message", "Đã thêm " + product.getProductName() + " vào giỏ hàng!");
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID sản phẩm không hợp lệ!");
                }
            }
        }

        private void addComboToCart(HttpServletRequest request, List<CartItem> cart) throws SQLException {
            StringBuilder messageBuilder = new StringBuilder("Đã thêm combo gồm: ");
            boolean addedAny = false;

            for (int i = 1; i <= 5; i++) {
                String productIdParam = request.getParameter("productId" + i);

                if (productIdParam != null && !productIdParam.isEmpty()) {
                    try {
                        int productID = Integer.parseInt(productIdParam);
                        Product product = productDAO.getProductByID(productID);

                        if (product != null) {
                            CartItem item = cart.stream()
                                    .filter(cartItem -> cartItem.getProductID() == productID)
                                    .findFirst()
                                    .orElse(null);

                            if (item == null) {
                                item = new CartItem(productID, product.getProductName(), product.getPrice(), 1);
                                cart.add(item);
                            } else {
                                item.setQuantity(item.getQuantity() + 1);
                            }

                            if (addedAny) {
                                messageBuilder.append(", ");
                            }
                            messageBuilder.append(product.getProductName());
                            addedAny = true;
                        }
                    } catch (NumberFormatException e) {
                        // Bỏ qua nếu ID không hợp lệ
                    }
                }
            }

            if (addedAny) {
                messageBuilder.append(" vào giỏ hàng!");
                request.setAttribute("message", messageBuilder.toString());
            } else {
                request.setAttribute("error", "Không thể thêm combo vào giỏ hàng, vui lòng thử lại!");
            }
        }

        private void updateCart(HttpServletRequest request, List<CartItem> cart) {
            String productIDParam = request.getParameter("productID");
            String quantityParam = request.getParameter("quantity");

            if (productIDParam == null || quantityParam == null) {
                request.setAttribute("error", "Thông tin sản phẩm không hợp lệ!");
                return;
            }

            try {
                int productID = Integer.parseInt(productIDParam);
                int quantity = Integer.parseInt(quantityParam);

                CartItem item = cart.stream()
                        .filter(i -> i.getProductID() == productID)
                        .findFirst()
                        .orElse(null);

                if (item != null && quantity > 0) {
                    item.setQuantity(quantity);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Định dạng số không hợp lệ!");
            }
        }

        private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
            String productIDParam = request.getParameter("productID");

            if (productIDParam == null) {
                request.setAttribute("error", "Thông tin sản phẩm không hợp lệ!");
                return;
            }

            try {
                int productID = Integer.parseInt(productIDParam);
                cart.removeIf(item -> item.getProductID() == productID);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Định dạng số không hợp lệ!");
            }
        }

        private void applyPromotions(HttpServletRequest request, List<CartItem> cart) {
            if (cart.isEmpty()) return;

            HttpSession session = request.getSession();

            double subtotal = cart.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum();
            session.setAttribute("subtotal", subtotal);

            double discount = 0;
            List<String> appliedPromotions = new ArrayList<>();

            if (subtotal >= 100000) {
                discount += 20000;
                appliedPromotions.add("Giảm 20.000 VNĐ cho đơn hàng từ 100.000 VNĐ");
            }

            if (subtotal >= 150000) {
                discount += 10000;
                appliedPromotions.add("Giảm thêm 10.000 VNĐ cho đơn hàng từ 150.000 VNĐ");
            }

            boolean freeShipping = false;
            if (subtotal >= 200000) {
                freeShipping = true;
                appliedPromotions.add("Miễn phí giao hàng cho đơn hàng từ 200.000 VNĐ");
            }

            for (CartItem item : cart) {
                if (item.getQuantity() >= 3) {
                    int freeItems = item.getQuantity() / 3;
                    discount += freeItems * item.getPrice();
                    appliedPromotions.add("Mua 3 tặng 1: Giảm " + freeItems + " " + item.getProductName());
                }
            }

            session.setAttribute("discount", discount);
            session.setAttribute("appliedPromotions", appliedPromotions);
            session.setAttribute("freeShipping", freeShipping);

            double shippingFee = freeShipping ? 0 : 15000;
            session.setAttribute("shippingFee", shippingFee);

            double finalTotal = subtotal - discount + shippingFee;
            session.setAttribute("finalTotal", finalTotal);
        }

        private void checkout(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart) 
                throws SQLException, IOException, ServletException {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String userID = user != null ? user.getUserID() : null;

            if (userID == null || cart.isEmpty()) {
                request.setAttribute("error", "Giỏ hàng trống hoặc bạn chưa đăng nhập!");
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
                return;
            }

            applyPromotions(request, cart);
            request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
        }

        private void processPayment(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart) 
                throws ServletException, IOException {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String userID = user != null ? user.getUserID() : null;

            if (userID == null || cart.isEmpty()) {
                request.setAttribute("error", "Giỏ hàng trống hoặc bạn chưa đăng nhập!");
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
                return;
            }

            Double finalTotal = (Double) session.getAttribute("finalTotal");
            if (finalTotal == null || finalTotal <= 0) {
                request.setAttribute("error", "Tổng tiền không hợp lệ. Vui lòng kiểm tra lại giỏ hàng!");
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
                return;
            }

            try {
                // Tạo đơn hàng (không tự tạo orderID, để DB tự sinh)
                Order order = new Order(userID, new Date(), finalTotal);

                // Tạo chi tiết đơn hàng
                List<OrderDetail> orderDetails = new ArrayList<>();
                for (CartItem item : cart) {
                    OrderDetail detail = new OrderDetail(0, item.getProductID(), item.getQuantity(), item.getPrice());
                    detail.setProductName(item.getProductName());
                    orderDetails.add(detail);
                }

                // Lưu vào cơ sở dữ liệu và lấy orderID
                int orderID = orderDAO.createOrder(order, orderDetails);
                if (orderID <= 0) {
                    throw new SQLException("Không thể tạo đơn hàng.");
                }

                // Xóa giỏ hàng
                cart.clear();
                session.setAttribute("cart", cart);
                session.setAttribute("orderSuccess", true);
                session.setAttribute("orderID", orderID);
                session.setAttribute("confirmMessage", "Đơn hàng của bạn đã được xác nhận. Vui lòng đợi trong khi chúng tôi xử lý đơn hàng của bạn.");

                // Chuyển hướng đến trang thành công
                response.sendRedirect(request.getContextPath() + "/jsp/orderSuccess.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra khi lưu đơn hàng vào cơ sở dữ liệu: " + e.getMessage());
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi không xác định xảy ra: " + e.getMessage());
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            }
        }
    }
