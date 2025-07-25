package controller;

import dal.RolesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.Roles;

@WebServlet(name = "RoleServlet", urlPatterns = {"/RoleServlet"})
public class RoleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RolesDAO dao = new RolesDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        String sql = "SELECT * FROM [dbo].[tblRoles]";
        if (service.equals("addOrUpdate")) {
            try {
                int roleID = Integer.parseInt(request.getParameter("roleID"));
                String roleName = request.getParameter("roleName");
                Roles role = new Roles(roleID, roleName);
                // Kiểm tra nếu roleID đã tồn tại thì cập nhật, nếu không thì thêm mới
                Roles existingRole = dao.searchRole(roleID);
                if (existingRole != null) {
                    dao.updateRole(role);
                } else {
                    dao.insertRole(role);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect("RoleServlet?service=listAll");
            return;
        }
        if (service.equals("delete")) {
            try {
                int roleID = Integer.parseInt(request.getParameter("roleID"));
                dao.deleteRole(roleID);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect("RoleServlet?service=listAll");
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Quản lý Vai trò</title>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
            out.println("table { width: 50%; border-collapse: collapse; margin-top: 20px; }");
            out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
            out.println("th { background-color: #f2f2f2; }");
            out.println(".form-container { margin-bottom: 20px; }");
            out.println(".form-container input[type=\"text\"] { margin: 5px 0; padding: 5px; }");
            out.println(".form-container input[type=\"submit\"] { padding: 5px 10px; margin-right: 10px; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");

            // Xử lý sửa vai trò (hiển thị form với dữ liệu đã có)
            String roleIDToEdit = "";
            String roleNameToEdit = "";
            if (service.equals("edit")) {
                try {
                    int roleID = Integer.parseInt(request.getParameter("roleID"));
                    Roles role = dao.searchRole(roleID);
                    if (role != null) {
                        roleIDToEdit = String.valueOf(role.getRoleID());
                        roleNameToEdit = role.getRoleName();
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            out.println("<h2>Quản lý Vai trò</h2>");
            out.println("<div class=\"form-container\">");
            out.println("<form action=\"RoleServlet\" method=\"post\">");
            out.println("<label for=\"roleID\">Mã Vai trò:</label><br>");
            out.println("<input type=\"text\" id=\"roleID\" name=\"roleID\" value=\"" + roleIDToEdit + "\" required><br>");
            out.println("<label for=\"roleName\">Tên Vai trò:</label><br>");
            out.println("<input type=\"text\" id=\"roleName\" name=\"roleName\" value=\"" + roleNameToEdit + "\" required><br>");
            out.println("<input type=\"hidden\" name=\"service\" value=\"addOrUpdate\">");
            out.println("<input type=\"submit\" name=\"submit\" value=\"Thêm/Sửa Vai trò\">");
            out.println("<input type=\"reset\" value=\"Đặt lại\">");
            out.println("</form>");
            out.println("</div>");

            out.println("<table border=\"1\">");
            out.println("<thead>");
            out.println("<tr>");
            out.println("<th>Mã Vai trò</th>");
            out.println("<th>Tên Vai trò</th>");
            out.println("<th>Sửa</th>");
            out.println("<th>Xóa</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");

            Vector<Roles> vector = dao.getAllRoles(sql);
            for (Roles role : vector) {
                out.println("<tr>");
                out.println("<td>" + role.getRoleID() + "</td>");
                out.println("<td>" + role.getRoleName() + "</td>");
                out.println("<td><a href=\"RoleServlet?service=edit&roleID=" + role.getRoleID() + "\">Sửa</a></td>");
                out.println("<td><a href=\"RoleServlet?service=delete&roleID=" + role.getRoleID() + "\">Xóa</a></td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
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
        return "Servlet for managing roles";
    }
}