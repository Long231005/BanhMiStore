package controller;

import dal.OrderDAO;
import dal.OrderDetailsDAO;
import model.Order;
import model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

@WebServlet(name = "AdminOrdersServlet", urlPatterns = {"/admin/orders"})
public class AdminOrdersServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderDetailsDAO orderDetailsDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderDetailsDAO = new OrderDetailsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy 10 đơn hàng gần nhất
            List<Order> orders = orderDAO.getRecentOrders(10); // Phương thức mới sẽ được thêm vào OrderDAO
            double totalRevenue = 0.0;

            for (Order order : orders) {
                // Lấy chi tiết đơn hàng
                Vector<OrderDetail> details = orderDetailsDAO.getOrderDetailsByOrderID(order.getOrderID());
                order.setOrderDetails(details);
                // Tính tổng doanh thu
                totalRevenue += order.getTotal();
            }

            request.setAttribute("orders", orders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
            request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
        }
    }
}