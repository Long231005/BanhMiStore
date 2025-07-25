package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;
import model.Order;
import model.OrderDetail;

public class OrderDAO extends DBContext {

    public int createOrder(Order order, List<OrderDetail> orderDetails) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int generatedOrderID = 0;

        try {
            // Insert into tblOrders (orderID tự tăng, không cần set)
            String sqlOrder = "INSERT INTO tblOrders (userID, orderDate, total) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, order.getUserID());
            stmt.setTimestamp(2, new java.sql.Timestamp(order.getOrderDate().getTime()));
            stmt.setDouble(3, order.getTotal());
            stmt.executeUpdate();

            // Lấy orderID vừa tạo
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                generatedOrderID = rs.getInt(1);
                order.setOrderID(String.valueOf(generatedOrderID)); // Chuyển thành String
            }

            // Insert into tblOrderDetails
            String sqlDetail = "INSERT INTO tblOrderDetails (orderID, productID, quantity, price) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlDetail);
            for (OrderDetail detail : orderDetails) {
                detail.setOrderID(generatedOrderID);
                stmt.setInt(1, detail.getOrderID());
                stmt.setInt(2, detail.getProductID());
                stmt.setInt(3, detail.getQuantity());
                stmt.setDouble(4, detail.getPrice());
                stmt.executeUpdate();
            }

            return generatedOrderID;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            // Connection not closed to allow reuse
        }
    }

    public Vector<Order> getAllOrders(String sql) {
        Vector<Order> vector = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                    String.valueOf(rs.getInt("orderID")), // Chuyển thành String
                    rs.getString("userID"),
                    rs.getTimestamp("orderDate"),
                    rs.getDouble("total")
                );
                vector.add(o);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public int insertOrders(Order o) {
        String sql = "INSERT INTO [dbo].[tblOrders] ([userID], [orderDate], [total]) VALUES (?, ?, ?)";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ptm.setString(1, o.getUserID());
            ptm.setTimestamp(2, new Timestamp(o.getOrderDate().getTime()));
            ptm.setDouble(3, o.getTotal());
            n = ptm.executeUpdate();
            ResultSet rs = ptm.getGeneratedKeys();
            if (rs.next()) {
                o.setOrderID(String.valueOf(rs.getInt(1))); // Chuyển thành String
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.err.println("Insert error: " + ex.getMessage());
        }
        return n;
    }

    public int updateOrder(Order o) {
        String sql = "UPDATE [dbo].[tblOrders] SET userID = ?, orderDate = ?, total = ? WHERE orderID = ?";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, o.getUserID());
            ptm.setTimestamp(2, new Timestamp(o.getOrderDate().getTime()));
            ptm.setDouble(3, o.getTotal());
            ptm.setInt(4, Integer.parseInt(o.getOrderID())); // Chuyển String thành int
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int deleteOrder(String orderID) { // Đổi thành String
        String sql = "DELETE FROM [dbo].[tblOrders] WHERE orderID = ?";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, Integer.parseInt(orderID)); // Chuyển String thành int
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public Vector<Order> searchOrdersByUserID(String userID) {
        Vector<Order> vector = new Vector<>();
        String sql = "SELECT * FROM [dbo].[tblOrders] WHERE userID LIKE ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, "%" + userID + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                    String.valueOf(rs.getInt("orderID")), // Chuyển thành String
                    rs.getString("userID"),
                    rs.getTimestamp("orderDate"),
                    rs.getDouble("total")
                );
                vector.add(o);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public List<Order> getRecentOrders(int limit) throws SQLException {
        List<Order> orders = new Vector<>();
        String sql = "SELECT TOP (?) * FROM tblOrders ORDER BY orderDate DESC";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(String.valueOf(rs.getInt("orderID")));
                    order.setUserID(rs.getString("userID"));
                    order.setOrderDate(rs.getTimestamp("orderDate"));
                    order.setTotal(rs.getDouble("total"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    public List<Order> getOrdersByUser(String userID) throws SQLException {
        Vector<Order> orders = new Vector<>();
        String sql = "SELECT * FROM [dbo].[tblOrders] WHERE userID = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, userID);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                    String.valueOf(rs.getInt("orderID")), // Chuyển thành String
                    rs.getString("userID"),
                    rs.getTimestamp("orderDate"),
                    rs.getDouble("total")
                );
                orders.add(order);
            }
        }
        return orders;
    }

    public Order getOrderById(String orderID) throws SQLException {
        Order order = null;
        String sql = "SELECT * FROM tblOrders WHERE orderID = ?";
        
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, Integer.parseInt(orderID)); // Chuyển String thành int
            ResultSet rs = ptm.executeQuery();
            
            if (rs.next()) {
                order = new Order();
                order.setOrderID(String.valueOf(rs.getInt("orderID")));
                order.setUserID(rs.getString("userID"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotal(rs.getDouble("total"));
            }
        } catch (NumberFormatException ex) {
            throw new SQLException("Invalid orderID format: " + orderID, ex);
        }
        return order;
    }

    public int getNewOrderCount() throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM tblOrders WHERE orderDate >= DATEADD(HOUR, -24, GETDATE())";
        
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ResultSet rs = ptm.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
        return count;
    }

    public double getTotalRevenue() throws SQLException {
        double totalRevenue = 0;
        String sql = "SELECT SUM(total) FROM tblOrders";
        
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ResultSet rs = ptm.executeQuery();
            
            if (rs.next()) {
                totalRevenue = rs.getDouble(1);
            }
        }
        return totalRevenue;
    }
}