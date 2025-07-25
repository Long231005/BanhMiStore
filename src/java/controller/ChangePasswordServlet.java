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

public class ChangePasswordServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form đổi mật khẩu
        request.getRequestDispatcher("/customer/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Kiểm tra mật khẩu cũ
            User currentUser = userDAO.getUserById(user.getUserID());
            if (!currentUser.getPassword().equals(oldPassword)) {
                request.setAttribute("error", "Mật khẩu cũ không đúng!");
                request.getRequestDispatcher("/customer/change-password.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu mới và xác nhận mật khẩu mới
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
                request.getRequestDispatcher("/customer/change-password.jsp").forward(request, response);
                return;
            }

            // Kiểm tra độ dài mật khẩu mới (tối thiểu 6 ký tự)
            if (newPassword.length() < 6) {
                request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
                request.getRequestDispatcher("/customer/change-password.jsp").forward(request, response);
                return;
            }

            // Cập nhật mật khẩu mới
            boolean success = userDAO.changePassword(user.getUserID(), newPassword);
            if (success) {
                request.setAttribute("message", "Đổi mật khẩu thành công!");
                // Cập nhật lại mật khẩu trong session
                currentUser.setPassword(newPassword);
                session.setAttribute("user", currentUser);
            } else {
                request.setAttribute("error", "Không thể đổi mật khẩu. Vui lòng thử lại!");
            }
            request.getRequestDispatcher("/jsp/change-password.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể đổi mật khẩu. Vui lòng thử lại sau!");
            request.getRequestDispatcher("/customer/change-password.jsp").forward(request, response);
        }
    }
}