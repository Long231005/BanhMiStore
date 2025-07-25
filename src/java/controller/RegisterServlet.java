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

public class RegisterServlet extends HttpServlet {

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
    );
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^0[0-9]{9}$"
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
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");

        // Validation
        String errorMessage = validateInput(email, password, fullName, phone, city);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra email tồn tại
            if (userDAO.isEmailExist(email)) {
                request.setAttribute("error", "Email đã được sử dụng!");
                request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
                return;
            }

            // Tạo combined address
            String fullAddress = address;
            if (city != null && !city.trim().isEmpty()) {
                fullAddress = (address != null && !address.trim().isEmpty()) 
                    ? address + ", " + city 
                    : city;
            }

            // Tạo user mới với ID từ getNextUserID()
            User user = new User();
            user.setUserID(userDAO.getNextUserID()); // Sử dụng phương thức có sẵn
            user.setEmail(email);
            user.setPassword(password);
            user.setFullName(fullName);
            user.setAddress(fullAddress);
            user.setPhone(phone);
            user.setRoleID(2); // Role Customer
            user.setActivate(true);

            // Lưu user
            userDAO.register(user);
            
            HttpSession session = request.getSession();
            session.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            
        } catch (SQLException e) {
            System.err.println("Lỗi SQL: " + e.getMessage());
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Lỗi không xác định: " + e.getMessage());
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }

    private String validateInput(String email, String password, String fullName, String phone, String city) {
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
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }
        if (phone != null && !phone.trim().isEmpty() && !PHONE_PATTERN.matcher(phone).matches()) {
            return "Số điện thoại không đúng định dạng (bắt đầu bằng 0, gồm 10 số)!";
        }
        if (city == null || city.trim().isEmpty()) {
            return "Tỉnh/Thành phố không được để trống!";
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }
}