package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserManagementServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                listUsers(request, response);
            } else if (action.equals("edit")) {
                showEditForm(request, response);
            } else if (action.equals("delete")) {
                deleteUser(request, response);
            } else if (action.equals("remove")) {
                removeUser(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể kết nối hoặc truy vấn dữ liệu. Vui lòng kiểm tra cơ sở dữ liệu!");
            request.getRequestDispatcher("admin/users.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equals("add")) {
                addUser(request, response);
            } else if (action.equals("update")) {
                updateUser(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể thêm hoặc cập nhật tài khoản. Vui lòng kiểm tra cơ sở dữ liệu!");
            request.getRequestDispatcher("admin/users.jsp").forward(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        if (users == null || users.isEmpty()) {
            request.setAttribute("message", "Không có tài khoản nào trong hệ thống. Vui lòng thêm tài khoản mới!");
        }
        request.setAttribute("users", users);
        request.getRequestDispatcher("admin/users.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String userID = request.getParameter("userID");
        User user = userDAO.getUserById(userID);
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản với ID: " + userID);
            listUsers(request, response);
        } else {
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin/edit.jsp").forward(request, response);
        }
    }

   private void addUser(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, IOException, ServletException {
    try {
        String email = request.getParameter("email");
        if (userDAO.isEmailExist(email)) {
            request.setAttribute("error", "Email đã tồn tại trong hệ thống!");
            request.getRequestDispatcher("admin/users.jsp").forward(request, response);
            return;
        }

        User user = new User();
        String userID = userDAO.getNextUserID();
        user.setUserID(userID);
        user.setFullName(request.getParameter("fullName"));
        user.setPassword(request.getParameter("password"));
        user.setRoleID(Integer.parseInt(request.getParameter("roleID")));
        user.setAddress(request.getParameter("address"));
        user.setPhone(request.getParameter("phone"));
        user.setEmail(email);
        user.setActivate(Boolean.parseBoolean(request.getParameter("activate")));

        int rowsAffected = userDAO.insertUser(user);
        if (rowsAffected > 0) {
            request.setAttribute("message", "Thêm tài khoản thành công!");
        } else {
            request.setAttribute("error", "Không thể thêm tài khoản. ID đã tồn tại hoặc có lỗi xảy ra!");
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
    }
    listUsers(request, response);
}
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String userID = request.getParameter("userID");
        User user = userDAO.getUserById(userID);
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản với ID: " + userID);
        } else {
            userDAO.deleteUser(userID);
            request.setAttribute("message", "Đã khóa tài khoản: " + userID);
        }
        listUsers(request, response);
    }

    private void removeUser(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String userID = request.getParameter("userID");
        User user = userDAO.getUserById(userID);
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản với ID: " + userID);
        } else {
            userDAO.removeUser(userID);
            request.setAttribute("message", "Đã xóa tài khoản: " + userID);
        }
        listUsers(request, response);
    }

private void updateUser(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, IOException, ServletException {
    try {
        String userID = request.getParameter("userID");
        String email = request.getParameter("email");
        
        // Kiểm tra email đã tồn tại cho người dùng khác chưa
        User existingUser = userDAO.getUserById(userID);
        if (!existingUser.getEmail().equals(email) && userDAO.isEmailExist(email)) {
            request.setAttribute("error", "Email đã được sử dụng bởi tài khoản khác!");
            showEditForm(request, response);
            return;
        }
        
        User user = new User();
        user.setUserID(userID);
        user.setFullName(request.getParameter("fullName"));
        user.setPassword(request.getParameter("password"));
        user.setRoleID(Integer.parseInt(request.getParameter("roleID")));
        user.setAddress(request.getParameter("address"));
        user.setPhone(request.getParameter("phone"));
        user.setEmail(email);
        user.setActivate(Boolean.parseBoolean(request.getParameter("activate")));
        
        userDAO.updateUser(user);
        request.setAttribute("message", "Cập nhật tài khoản thành công!");
        listUsers(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi khi cập nhật: " + e.getMessage());
        request.getRequestDispatcher("admin/users.jsp").forward(request, response);
    }
}
}