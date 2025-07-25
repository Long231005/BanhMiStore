package dal;

import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Roles;

public class RolesDAO extends DBContext {
    public Vector<Roles> getAllRoles(String sql) {
        Vector<Roles> vector = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Roles r = new Roles(
                    rs.getInt("roleID"),
                    rs.getString("roleName")
                );
                vector.add(r);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public int insertRole(Roles r) {
        String sql = "INSERT INTO [dbo].[tblRoles] ([roleName]) VALUES (?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, r.getRoleName());
            return ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
    }

    public Roles searchRole(int roleID) {
        String sql = "SELECT * FROM tblRoles WHERE roleID = ?";
        Roles r = null;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, roleID);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                r = new Roles(rs.getInt("roleID"), rs.getString("roleName"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return r;
    }

    public int updateRole(Roles r) {
        String sql = "UPDATE [dbo].[tblRoles] SET roleName = ? WHERE roleID = ?";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, r.getRoleName());
            ptm.setInt(2, r.getRoleID());
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int deleteRole(int roleID) {
        int n = 0;
        String sqlCheck = "SELECT * FROM tblUsers WHERE roleID = ?";
        String sqlDelete = "DELETE FROM tblRoles WHERE roleID = ?";
        try {
            // Kiểm tra xem roleID có trong tblUsers không
            PreparedStatement ptmCheck = connection.prepareStatement(sqlCheck);
            ptmCheck.setInt(1, roleID);
            ResultSet rs = ptmCheck.executeQuery();
            if (rs.next()) {
                System.out.println("Không xóa vai trò ID " + roleID + " vì có người dùng liên quan");
                return n; // Không xóa
            }

            // Xóa nếu không có người dùng liên quan
            PreparedStatement ptmDelete = connection.prepareStatement(sqlDelete);
            ptmDelete.setInt(1, roleID);
            n = ptmDelete.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public static void main(String[] args) {
        RolesDAO rdao = new RolesDAO();
        String sql = "SELECT * FROM [dbo].[tblRoles]";
        
        // In danh sách vai trò ban đầu
        System.out.println("Danh sách vai trò ban đầu:");
        Vector<Roles> vector = rdao.getAllRoles(sql);
        for (Roles r : vector) {
            System.out.println(r);
        }
/*
        // Thêm vai trò mới
        Roles rInsert = new Roles("NewRole");
        int n = rdao.insertRole(rInsert);
        if (n > 0) {
            System.out.println("\nSau khi thêm:");
            vector = rdao.getAllRoles(sql);
            for (Roles r : vector) {
                System.out.println(r);
            }
        } else {
            System.out.println("\nThêm thất bại.");
        }
*/
        // Cập nhật vai trò
        Roles rUpdate = rdao.searchRole(1); // Cập nhật roleID
        if (rUpdate != null) {
            rUpdate.setRoleName("Admin");
            int n2 = rdao.updateRole(rUpdate);
            if (n2 > 0) {
                System.out.println("\nSau khi cập nhật roleID:");
                vector = rdao.getAllRoles(sql);
                for (Roles r : vector) {
                    System.out.println(r);
                }
            } else {
                System.out.println("\nCập nhật thất bại.");
            }
        } else {
            System.out.println("\nKhông tìm thấy vai trò với ID"  );
        }
/*
        // Xóa vai trò
        System.out.println("\nThực hiện xóa roleID");
        int n3 = rdao.deleteRole(1002);
        if (n3 > 0) {
            System.out.println("Xóa vai trò ID thành công, số hàng ảnh hưởng: " + n3);
            vector = rdao.getAllRoles(sql);
            for (Roles r : vector) {
                System.out.println(r);
            }
        } else {
            System.out.println("Không xóa vai trò ID 1 (có thể do có người dùng liên quan).");
        }
*/
    }
}