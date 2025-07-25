package dal;

import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.OrderDetail;

public class OrderDetailsDAO extends DBContext {

    // Lấy tất cả chi tiết đơn hàng
    public Vector<OrderDetail> getAllOrderDetails(String sql) {
        Vector<OrderDetail> vector = new Vector<>();
        try (PreparedStatement ptm = connection.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                OrderDetail od = new OrderDetail(
                    rs.getInt("orderID"),
                    rs.getInt("productID"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                );
                vector.add(od);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    // Thêm chi tiết đơn hàng mới
    public int insertOrderDetails(OrderDetail od) {
        String sql = "INSERT INTO [dbo].[tblOrderDetails] ([orderID], [productID], [quantity], [price]) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, od.getOrderID());
            ptm.setInt(2, od.getProductID());
            ptm.setInt(3, od.getQuantity());
            ptm.setDouble(4, od.getPrice());
            return ptm.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Insert error: " + ex.getMessage());
            return 0;
        }
    }

    // Xóa chi tiết đơn hàng
    public int deleteOrderDetails(int orderID, int productID) {
        String sql = "DELETE FROM [dbo].[tblOrderDetails] WHERE orderID = ? AND productID = ?";
        int n = 0;
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, orderID);
            ptm.setInt(2, productID);
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Delete error: " + ex.getMessage());
            ex.printStackTrace();
        }
        return n;
    }

    // Tìm kiếm chi tiết đơn hàng theo orderID
    public Vector<OrderDetail> getOrderDetailsByOrderID(String orderID) {
        Vector<OrderDetail> vector = new Vector<>();
        String sql = "SELECT od.*, p.productName " +
                     "FROM [dbo].[tblOrderDetails] od " +
                     "JOIN [dbo].[tblProducts] p ON od.productID = p.productID " +
                     "WHERE od.orderID = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, Integer.parseInt(orderID)); // Chuyển String thành int
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(
                    rs.getInt("orderID"),
                    rs.getInt("productID"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                );
                od.setProductName(rs.getString("productName"));
                vector.add(od);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NumberFormatException ex) {
            System.err.println("Invalid orderID format: " + orderID);
        }
        return vector;
    }

    // Lấy tất cả sản phẩm đã mua của một người dùng
    public Vector<OrderDetail> getPurchasedProductsByUser(String userID) {
        Vector<OrderDetail> vector = new Vector<>();
        String sql = "SELECT od.*, p.productName, p.image " +
                     "FROM [dbo].[tblOrders] o " +
                     "JOIN [dbo].[tblOrderDetails] od ON o.orderID = od.orderID " +
                     "JOIN [dbo].[tblProducts] p ON od.productID = p.productID " +
                     "WHERE o.userID = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, userID);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(
                    rs.getInt("orderID"),
                    rs.getInt("productID"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                );
                od.setProductName(rs.getString("productName"));
                od.setImage(rs.getString("image"));
                vector.add(od);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public static void main(String[] args) {
        OrderDetailsDAO odao = new OrderDetailsDAO();
        String sql = "SELECT * FROM [dbo].[tblOrderDetails]";
        Vector<OrderDetail> vector = odao.getAllOrderDetails(sql);
        for (OrderDetail od : vector) {
            System.out.println(od);
        }
        OrderDetail odInsert = new OrderDetail(1, 1, 2, 29990.0);
        int n = odao.insertOrderDetails(odInsert);
        if (n > 0) {
            System.out.println("After inserted:");
            vector = odao.getAllOrderDetails(sql);
            for (OrderDetail od : vector) {
                System.out.println(od);
            }
        } else {
            System.out.println("Insert failed.");
        }
    }
}