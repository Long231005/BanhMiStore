package controller;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.Order;

@WebServlet(name = "OrdersServlet", urlPatterns = {"/order"})
public class OrdersServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        OrderDAO dao = new OrderDAO();
        Vector<Order> vector;
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Danh sách đơn hàng</title>");
            out.println("</head>");
            out.println("<body>");

            // Xử lý xóa đơn hàng
            if (service.equals("deleteOrder")) {
                String orderID = request.getParameter("orderID");
                int n = dao.deleteOrder(orderID);
                response.sendRedirect("order");
                return; // Exit after redirect
            }

            // Xử lý thêm đơn hàng
            if (service.equals("addOrder")) {
                try {
                    String userID = request.getParameter("userID");
                    java.util.Date orderDate = java.sql.Date.valueOf(request.getParameter("orderDate"));
                    double total = Double.parseDouble(request.getParameter("total"));
                    Order o = new Order(userID, orderDate, total);
                    int n = dao.insertOrders(o);
                    response.sendRedirect("order");
                    return; // Exit after redirect
                } catch (IllegalArgumentException e) {
                    out.println("<p>Lỗi: Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.</p>");
                }
            }

            // Form tìm kiếm
            out.println("<form action=\"order?service=listAll\">");
            out.println("Nhập ID người dùng:<input type=\"text\" name=\"userID\">");
            out.println("<input type=\"submit\" name=\"submit\" value=\"Tìm kiếm\">");
            out.println("<input type=\"reset\" value=\"Đặt lại\">");
            out.println("<input type=\"hidden\" name=\"service\" value=\"listAll\">");
            out.println("</form>");

            // Liên kết thêm đơn hàng
            out.println("<p><a href=\"addOrders.html\">Thêm đơn hàng mới</a></p>");

            out.println("<h2>Danh sách đơn hàng:</h2>");
            out.println("<table border=\"1\">");
            out.println("<tr>");
            out.println("<th>OrderID</th>");
            out.println("<th>UserID</th>");
            out.println("<th>Ngày đặt hàng</th>");
            out.println("<th>Tổng tiền</th>");
            out.println("<th>Xóa</th>");
            out.println("<th>Cập nhật</th>");
            out.println("</tr>");

            if (service.equals("listAll")) {
                String submit = request.getParameter("submit");
                String userID = request.getParameter("userID");
                if (submit == null) { // Không tìm kiếm => lấy tất cả
                    vector = dao.getAllOrders("SELECT * FROM [dbo].[tblOrders]");
                } else { // Tìm kiếm theo userID
                    vector = dao.searchOrdersByUserID(userID);
                }

                // Hiển thị danh sách đơn hàng
                for (Order o : vector) {
                    out.println("<tr>");
                    out.println("<td>" + o.getOrderID() + "</td>");
                    out.println("<td>" + o.getUserID() + "</td>");
                    out.println("<td>" + o.getOrderDate() + "</td>");
                    out.println("<td>" + o.getTotal() + "</td>");
                    out.println("<td><a href=\"order?service=deleteOrder&orderID=" + o.getOrderID() + "\">Xóa</a></td>");
                    out.println("<td></td>"); // Cột cập nhật để trống
                    out.println("</tr>");
                }
            }

            out.println("</table>");
            out.println("<p><a href=\"index.html\">Quay lại trang chính</a></p>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}