package model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

public class RoleUtil {
    
    // Các hằng số đại diện cho vai trò
    public static final int ADMIN = 1;
    public static final int MANAGER = 2;
    public static final int STAFF = 3;
    public static final int CUSTOMER = 4;
    public static final int GUEST = 5;
    
    /**
     * Kiểm tra xem người dùng hiện tại có phải là Admin hay không
     * @param request HttpServletRequest
     * @return true nếu là Admin, ngược lại false
     */
    public static boolean isAdmin(HttpServletRequest request) {
        return hasRole(request, ADMIN);
    }
    
    /**
     * Kiểm tra xem người dùng hiện tại có phải là Manager hay không
     * @param request HttpServletRequest
     * @return true nếu là Manager, ngược lại false
     */
    public static boolean isManager(HttpServletRequest request) {
        return hasRole(request, MANAGER);
    }
    
    /**
     * Kiểm tra xem người dùng hiện tại có phải là Staff hay không
     * @param request HttpServletRequest
     * @return true nếu là Staff, ngược lại false
     */
    public static boolean isStaff(HttpServletRequest request) {
        return hasRole(request, STAFF);
    }
    
    /**
     * Kiểm tra xem người dùng hiện tại có phải là Customer hay không
     * @param request HttpServletRequest
     * @return true nếu là Customer, ngược lại false
     */
    public static boolean isCustomer(HttpServletRequest request) {
        return hasRole(request, CUSTOMER);
    }
    
    /**
     * Kiểm tra xem người dùng hiện tại có phải là Guest hay không
     * @param request HttpServletRequest
     * @return true nếu là Guest, ngược lại false
     */
    public static boolean isGuest(HttpServletRequest request) {
        return hasRole(request, GUEST);
    }
    
    /**
     * Kiểm tra xem người dùng hiện tại có vai trò cụ thể hay không
     * @param request HttpServletRequest
     * @param roleID ID của vai trò cần kiểm tra
     * @return true nếu người dùng có vai trò cần kiểm tra, ngược lại false
     */
    public static boolean hasRole(HttpServletRequest request, int roleID) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return false;
        }
        
        return user.getRoleID() == roleID;
    }
    
    /**
     * Kiểm tra xem người dùng hiện tại có quyền truy cập vào tài nguyên cụ thể hay không
     * @param request HttpServletRequest
     * @param requiredRoleID ID vai trò tối thiểu cần thiết để truy cập
     * @return true nếu người dùng có quyền truy cập, ngược lại false
     */
    public static boolean hasAccess(HttpServletRequest request, int requiredRoleID) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return false;
        }
        
        // Admin luôn có quyền truy cập mọi tài nguyên
        if (user.getRoleID() == ADMIN) {
            return true;
        }
        
        // Kiểm tra nếu vai trò của người dùng đủ quyền
        // Giả sử: số ID càng nhỏ, quyền càng cao
        return user.getRoleID() <= requiredRoleID;
    }
    
    /**
     * Lấy tên vai trò dựa trên roleID
     * @param roleID ID của vai trò
     * @return Tên của vai trò
     */
    public static String getRoleName(int roleID) {
        switch (roleID) {
            case ADMIN:
                return "Admin";
            case MANAGER:
                return "Manager";
            case STAFF:
                return "Staff";
            case CUSTOMER:
                return "Customer";
            case GUEST:
                return "Guest";
            default:
                return "Unknown";
        }
    }
}