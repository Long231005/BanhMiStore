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
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class ProfileUpdateServlet extends HttpServlet {

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

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String paymentMethod = request.getParameter("paymentMethod");

            // Validate input
            String errorMessage = validateInput(phone);
            if (errorMessage != null) {
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
                return;
            }

            // Fetch the latest user data from the database
            User user = userDAO.getUserById(currentUser.getUserID());
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng!");
                request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
                return;
            }

            // Log user data before update
            System.out.println("Before update - User: " + user.getUserID() + ", FullName: " + user.getFullName() + 
                              ", Address: " + user.getAddress() + ", Phone: " + user.getPhone() + 
                              ", Email: " + user.getEmail() + ", DateOfBirth: " + user.getDateOfBirth() + 
                              ", PaymentMethod: " + user.getPaymentMethod());

            // Update fields with form data
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setPaymentMethod(paymentMethod.isEmpty() ? null : paymentMethod);

            // Parse date of birth
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    user.setDateOfBirth(dateFormat.parse(dateOfBirthStr));
                } catch (ParseException e) {
                    request.setAttribute("error", "Định dạng ngày sinh không hợp lệ!");
                    request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
                    return;
                }
            } else {
                user.setDateOfBirth(null);
            }

            // Log user data after update
            System.out.println("After update - User: " + user.getUserID() + ", FullName: " + user.getFullName() + 
                              ", Address: " + user.getAddress() + ", Phone: " + user.getPhone() + 
                              ", Email: " + user.getEmail() + ", DateOfBirth: " + user.getDateOfBirth() + 
                              ", PaymentMethod: " + user.getPaymentMethod());

            // Update in database
            userDAO.updateUser(user);

            // Update session
            session.setAttribute("user", user);
            request.setAttribute("success", "Cập nhật thông tin cá nhân thành công!");
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể cập nhật thông tin. Chi tiết: " + e.getMessage());
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
        }
    }

    private String validateInput(String phone) {
        if (phone != null && !phone.isEmpty() && !phone.matches("[0-9]{10,11}")) {
            return "Số điện thoại phải có 10-11 chữ số!";
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/customer/profile.jsp");
    }
}