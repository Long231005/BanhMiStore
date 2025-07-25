package dal;

import dal.DBContext;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDAO extends DBContext {

    public User login(String email, String password) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT userID, fullName, roleID FROM tblUsers WHERE email = ? AND password = ? AND activate = 1";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setRoleID(rs.getInt("roleID"));
                return user;
            }
            return null;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public int insertUser(User u) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtCheck = null;
        PreparedStatement stmtInsert = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            
            if (conn == null || conn.isClosed()) {
                throw new SQLException("Không thể kết nối tới cơ sở dữ liệu");
            }
            
            String sqlCheck = "SELECT 1 FROM tblUsers WHERE userID = ?";
            stmtCheck = conn.prepareStatement(sqlCheck);
            stmtCheck.setString(1, u.getUserID());
            rs = stmtCheck.executeQuery();
            if (rs.next()) {
                return 0; // userID đã tồn tại
            }

            String sql = "INSERT INTO [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [phone], [email], [activate], [dateOfBirth], [paymentMethod]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmtInsert = conn.prepareStatement(sql);
            stmtInsert.setString(1, u.getUserID());
            stmtInsert.setString(2, u.getFullName());
            stmtInsert.setString(3, u.getPassword());
            stmtInsert.setInt(4, u.getRoleID());
            stmtInsert.setString(5, u.getAddress());
            stmtInsert.setString(6, u.getPhone());
            stmtInsert.setString(7, u.getEmail());
            stmtInsert.setBoolean(8, u.isActivate());
            stmtInsert.setDate(9, u.getDateOfBirth() != null ? new java.sql.Date(u.getDateOfBirth().getTime()) : null);
            stmtInsert.setString(10, u.getPaymentMethod());
            return stmtInsert.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Lỗi SQL trong insertUser: " + ex.getMessage());
            throw ex;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignore */ }
            if (stmtCheck != null) try { stmtCheck.close(); } catch (SQLException e) { /* ignore */ }
            if (stmtInsert != null) try { stmtInsert.close(); } catch (SQLException e) { /* ignore */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignore */ }
        }
    }

    public String getNextUserID() throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT ISNULL(MAX(CAST(SUBSTRING(userID, 2, LEN(userID)) AS BIGINT)), 0) FROM tblUsers";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            long nextNumber = 1;
            if (rs.next()) {
                nextNumber = rs.getLong(1) + 1;
            }
            
            if (nextNumber > 999999) {
                nextNumber = 1;
            }
            
            return String.format("U%03d", nextNumber);
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public boolean emailExists(String email) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM tblUsers WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM tblUsers";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getInt("roleID"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setActivate(rs.getBoolean("activate"));
                user.setDateOfBirth(rs.getDate("dateOfBirth"));
                user.setPaymentMethod(rs.getString("paymentMethod"));
                users.add(user);
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        return users;
    }

    public int getUserCount() throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM tblUsers";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public void addUser(User user) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        try {
            String sql = "INSERT INTO tblUsers (userID, fullName, password, roleID, address, phone, email, activate, dateOfBirth, paymentMethod) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUserID());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, user.getRoleID());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getEmail());
            stmt.setBoolean(8, user.isActivate());
            stmt.setDate(9, user.getDateOfBirth() != null ? new java.sql.Date(user.getDateOfBirth().getTime()) : null);
            stmt.setString(10, user.getPaymentMethod());
            stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public void updateUser(User user) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        try {
            String sql = "UPDATE tblUsers SET fullName = ?, password = ?, roleID = ?, address = ?, phone = ?, email = ?, activate = ?, dateOfBirth = ?, paymentMethod = ? " +
                        "WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getPassword());
            stmt.setInt(3, user.getRoleID());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getEmail());
            stmt.setBoolean(7, user.isActivate());
            stmt.setDate(8, user.getDateOfBirth() != null ? new java.sql.Date(user.getDateOfBirth().getTime()) : null);
            stmt.setString(9, user.getPaymentMethod());
            stmt.setString(10, user.getUserID());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Không thể cập nhật người dùng: Không tìm thấy userID " + user.getUserID());
            }
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public void deleteUser(String userID) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        try {
            String sql = "UPDATE tblUsers SET activate = 0 WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userID);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public void removeUser(String userID) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        try {
            String sql = "DELETE FROM tblUsers WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userID);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public User getUserById(String userID) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM tblUsers WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userID);
            rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getInt("roleID"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setActivate(rs.getBoolean("activate"));
                user.setDateOfBirth(rs.getDate("dateOfBirth"));
                user.setPaymentMethod(rs.getString("paymentMethod"));
                return user;
            }
            return null;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public boolean isEmailExist(String email) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM tblUsers WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public void register(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = getConnection();
            
            if (conn == null || conn.isClosed()) {
                throw new SQLException("Không thể kết nối tới cơ sở dữ liệu");
            }
            
            String sql = "INSERT INTO tblUsers (userID, email, password, fullName, address, phone, roleID, activate, dateOfBirth, paymentMethod) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUserID());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getPhone());
            stmt.setInt(7, user.getRoleID());
            stmt.setBoolean(8, user.isActivate());
            stmt.setDate(9, user.getDateOfBirth() != null ? new java.sql.Date(user.getDateOfBirth().getTime()) : null);
            stmt.setString(10, user.getPaymentMethod());
            
            int result = stmt.executeUpdate();
            if (result <= 0) {
                throw new SQLException("Không thể thêm người dùng mới");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong register: " + e.getMessage());
            throw e;
        } finally {
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { /* ignore */ }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { /* ignore */ }
            }
        }
    }

    public boolean changePassword(String userID, String newPassword) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        try {
            String sql = "UPDATE tblUsers SET password = ? WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, userID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
}