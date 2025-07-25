package dal;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import model.User;

@WebFilter({"/admin/*", "/manager/*", "/staff/*", "/customer/*"})
public class AuthorizationFilter implements Filter {
    
    private static final Map<Integer, List<String>> ROLE_PERMISSIONS = new HashMap<>();
    private static final List<String> PUBLIC_URLS = Arrays.asList(
        "/jsp/login.jsp", "/jsp/register.jsp", "/jsp/index.jsp", 
        "/jsp/products.jsp", "/jsp/cart.jsp", "/jsp/promotions.jsp",
        "/jsp/checkout.jsp", "/jsp/welcome.jsp", "/jsp/orderSuccess.jsp"
    );
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo các quyền cho các role
        // Dựa trên tblRoles: 1-Admin, 2-Customer, 3-Manager, 4-Staff, 5-Guest
        
        // Admin có quyền truy cập mọi URL
        ROLE_PERMISSIONS.put(1, Arrays.asList(
            "/admin", "/manager", "/staff", "/customer"
        ));
        
        // Manager có quyền truy cập dashboard của manager
        ROLE_PERMISSIONS.put(3, Arrays.asList(
            "/manager"
        ));
        
        // Staff có quyền truy cập dashboard của staff
        ROLE_PERMISSIONS.put(4, Arrays.asList(
            "/staff"
        ));
        
        // Customer có quyền truy cập dashboard của customer
        ROLE_PERMISSIONS.put(2, Arrays.asList(
            "/customer"
        ));
        
        // Guest không có quyền truy cập dashboard nào
        ROLE_PERMISSIONS.put(5, new ArrayList<>());
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String urlPattern = requestURI.substring(contextPath.length());
        
        // Cho phép truy cập các tài nguyên tĩnh mà không cần xác thực
        if (isPublicResource(urlPattern)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Lấy thông tin người dùng từ session
        HttpSession session = httpRequest.getSession(true); // Tạo session mới nếu không có
        User user = (User) session.getAttribute("user");
        
        // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
        if (user == null) {
            httpResponse.sendRedirect(contextPath + "/jsp/login.jsp");
            return;
        }
        
        // Đến đây nghĩa là người dùng đã đăng nhập
        // Kiểm tra quyền truy cập của người dùng
        int roleID = user.getRoleID();
        List<String> permissions = ROLE_PERMISSIONS.get(roleID);

        // Cho phép admin truy cập mọi nơi
        if (roleID == 1) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra quyền truy cập cho các vai trò khác
        boolean hasPermission = false;
        if (permissions != null) {
            for (String pattern : permissions) {
                if (urlPattern.startsWith(pattern)) {
                    hasPermission = true;
                    break;
                }
            }
        }
        
        if (hasPermission) {
            chain.doFilter(request, response);
        } else {
            // Chuyển hướng đến trang access-denied.jsp nếu không có quyền
            httpResponse.sendRedirect(contextPath + "/jsp/access-denied.jsp");
        }
    }
    
    private boolean isPublicResource(String urlPattern) {
        // Kiểm tra nếu URL là tài nguyên công khai
        for (String publicUrl : PUBLIC_URLS) {
            if (urlPattern.equals(publicUrl)) {
                return true;
            }
        }
        
        // Kiểm tra nếu là tài nguyên tĩnh
        return urlPattern.startsWith("/css/") || 
               urlPattern.startsWith("/js/") || 
               urlPattern.startsWith("/img/");
    }
    
    @Override
    public void destroy() {
        // Không cần làm gì khi destroy
    }
}