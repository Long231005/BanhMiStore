package controller;

import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.UserDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "OrderDetailsServlet", urlPatterns = {"/admin/order-details"})
public class OrderDetailsServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderDetailsDAO orderDetailsDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderDetailsDAO = new OrderDetailsDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderID = request.getParameter("orderID");

        if (orderID == null || orderID.trim().isEmpty()) {
            request.setAttribute("error", "Mã đơn hàng không hợp lệ!");
            request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
            return;
        }

        try {
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderID);
            if (order == null) {
                request.setAttribute("error", "Không tìm thấy đơn hàng!");
                request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
                return;
            }

            // Lấy chi tiết đơn hàng
            order.setOrderDetails(orderDetailsDAO.getOrderDetailsByOrderID(orderID));
            if (order.getOrderDetails() == null || order.getOrderDetails().isEmpty()) {
                request.setAttribute("error", "Không tìm thấy chi tiết đơn hàng!");
                request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
                return;
            }

            // Lấy thông tin khách hàng
            User customer = userDAO.getUserById(order.getUserID());
            if (customer == null) {
                request.setAttribute("error", "Không tìm thấy thông tin khách hàng!");
                request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
                return;
            }

            request.setAttribute("order", order);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/admin/order-details.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể lấy thông tin đơn hàng!");
            request.getRequestDispatcher("/admin/admin_orders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display order details for admin";
    }
}