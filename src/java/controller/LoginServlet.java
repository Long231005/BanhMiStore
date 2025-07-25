package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

public class LoginServlet extends HttpServlet {

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
    );
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation: Kiểm tra dữ liệu đầu vào
        String errorMessage = validateInput(email, password);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.login(email, password);
            if (user != null) {
                // Đăng nhập thành công, lưu user vào session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("roleID", user.getRoleID()); // Lưu roleID để dễ truy cập

                // Chuyển hướng đến dashboard phù hợp với vai trò
                redirectToDashboard(response, request.getContextPath(), user.getRoleID());
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không đúng, hoặc tài khoản đã bị khóa!");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể kết nối cơ sở dữ liệu. Vui lòng thử lại sau!");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    private void redirectToDashboard(HttpServletResponse response, String contextPath, int roleID) throws IOException {
        // Chuyển hướng đến dashboard phù hợp với vai trò
        // Dựa trên tblRoles: 1-Admin, 2-Customer, 3-Manager, 4-Staff, 5-Guest
        switch (roleID) {
            case 1: // Admin
                response.sendRedirect(contextPath + "/admin/dashboard.jsp");
                break;
            case 3: // Manager
                response.sendRedirect(contextPath + "/manager/dashboard.jsp");
                break;
            case 4: // Staff
                response.sendRedirect(contextPath + "/staff/dashboard.jsp");
                break;
            case 2: // Customer
                response.sendRedirect(contextPath + "/customer/dashboard.jsp");
                break;
            case 5: // Guest
                response.sendRedirect(contextPath + "/jsp/index.jsp"); // Guest quay lại trang chủ
                break;
            default:
                response.sendRedirect(contextPath + "/jsp/index.jsp");
                break;
        }
    }

    private String validateInput(String email, String password) {
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống!";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Email không đúng định dạng!";
        }
        if (password == null || password.trim().isEmpty()) {
            return "Mật khẩu không được để trống!";
        }
        if (password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự!";
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Không yêu cầu đăng nhập ngay, chuyển hướng đến index.jsp (trang công khai)
        response.sendRedirect(request.getContextPath() + "/jsp/index.jsp");
    }
}