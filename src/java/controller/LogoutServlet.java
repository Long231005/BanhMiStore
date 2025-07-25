package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy session hiện tại (không tạo mới nếu không tồn tại)
        HttpSession session = request.getSession(false);
        
        // Nếu session tồn tại, hủy nó
        if (session != null) {
            session.invalidate();
        }
        
        // Chuyển hướng về trang chủ hoặc trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}