package controller;

import dal.UserDAO;
import dal.ProductDAO;
import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private UserDAO userDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khởi tạo giá trị mặc định
        int userCount = 0;
        int productCount = 0;
        int newOrderCount = 0;
        double totalRevenue = 0.0;

        try {
            // Lấy dữ liệu từ các DAO
            userCount = userDAO.getUserCount();
            productCount = productDAO.getProductCount();
            newOrderCount = orderDAO.getNewOrderCount();
            totalRevenue = orderDAO.getTotalRevenue();

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể lấy dữ liệu dashboard! Chi tiết: " + e.getMessage());
        } finally {
            // Luôn gán giá trị cho các attribute, ngay cả khi có lỗi
            request.setAttribute("userCount", userCount);
            request.setAttribute("productCount", productCount);
            request.setAttribute("newOrderCount", newOrderCount);
            request.setAttribute("totalRevenue", totalRevenue);

            // Forward đến dashboard.jsp
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display admin dashboard data";
    }
}