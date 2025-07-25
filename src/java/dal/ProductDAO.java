package dal;

import model.Categories;
import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        // Modified to show all products including those with status = 0
        String sql = "SELECT * FROM tblProducts";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategoryID(rs.getString("categoryID"));
                product.setImportDate(rs.getDate("importDate"));
                product.setUsingDate(rs.getDate("usingDate"));
                product.setStatus(rs.getInt("status"));
                product.setExpirationDate(rs.getDate("expirationDate"));
                products.add(product);
            }
        }
        return products;
    }

    public List<Product> getActiveProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM tblProducts WHERE status = 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategoryID(rs.getString("categoryID"));
                product.setImportDate(rs.getDate("importDate"));
                product.setUsingDate(rs.getDate("usingDate"));
                product.setStatus(rs.getInt("status"));
                product.setExpirationDate(rs.getDate("expirationDate"));
                products.add(product);
            }
        }
        return products;
    }

    public List<Product> searchProducts(String keyword, String categoryID) throws SQLException {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tblProducts WHERE status = 1");
        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("productName LIKE ?");
            params.add("%" + keyword + "%");
        }
        if (categoryID != null && !categoryID.trim().isEmpty()) {
            conditions.add("categoryID = ?");
            params.add(categoryID);
        }

        if (!conditions.isEmpty()) {
            sql.append(" AND ").append(String.join(" AND ", conditions));
        }

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            // Fix: Set parameters before executing the query
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("productID"));
                    product.setProductName(rs.getString("productName"));
                    product.setImage(rs.getString("image"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setCategoryID(rs.getString("categoryID"));
                    product.setImportDate(rs.getDate("importDate"));
                    product.setUsingDate(rs.getDate("usingDate"));
                    product.setStatus(rs.getInt("status"));
                    product.setExpirationDate(rs.getDate("expirationDate"));
                    products.add(product);
                }
            }
        }
        return products;
    }

    public List<Categories> getAllCategories() throws SQLException {
        List<Categories> categories = new ArrayList<>();
        String sql = "SELECT categoryID, categoryName FROM tblCategories";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String categoryID = rs.getString("categoryID");
                String categoryName = rs.getString("categoryName");
                categories.add(new Categories(categoryID, categoryName, null));
            }
        }
        return categories;
    }

    public int insertProduct(Product p) throws SQLException {
        String sql = "INSERT INTO [dbo].[tblProducts] " +
                     "([productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status], [expirationDate]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, p.getProductName());
            stmt.setString(2, p.getImage());
            stmt.setDouble(3, p.getPrice());
            stmt.setInt(4, p.getQuantity());
            stmt.setString(5, p.getCategoryID());
            stmt.setDate(6, new java.sql.Date(p.getImportDate().getTime()));
            stmt.setDate(7, new java.sql.Date(p.getUsingDate().getTime()));
            stmt.setInt(8, p.getStatus());
            stmt.setDate(9, p.getExpirationDate() != null ? new java.sql.Date(p.getExpirationDate().getTime()) : null);
            
            int affectedRows = stmt.executeUpdate();
            
            // Lấy ID đã được tạo và cập nhật lại đối tượng Product
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        p.setProductID(rs.getInt(1));
                    }
                }
            }
            
            return affectedRows;
        }
    }

    public Product getProductByID(int productID) throws SQLException {
        String sql = "SELECT * FROM tblProducts WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("productID"));
                    product.setProductName(rs.getString("productName"));
                    product.setImage(rs.getString("image"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setCategoryID(rs.getString("categoryID"));
                    product.setImportDate(rs.getDate("importDate"));
                    product.setUsingDate(rs.getDate("usingDate"));
                    product.setStatus(rs.getInt("status"));
                    product.setExpirationDate(rs.getDate("expirationDate"));
                    return product;
                }
            }
        }
        return null;
    }

    public int updateProduct(Product p) throws SQLException {
        String sql = "UPDATE tblProducts SET productName = ?, image = ?, price = ?, quantity = ?, " +
                     "categoryID = ?, importDate = ?, usingDate = ?, status = ?, expirationDate = ? " +
                     "WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, p.getProductName());
            stmt.setString(2, p.getImage());
            stmt.setDouble(3, p.getPrice());
            stmt.setInt(4, p.getQuantity());
            stmt.setString(5, p.getCategoryID());
            stmt.setDate(6, new java.sql.Date(p.getImportDate().getTime()));
            stmt.setDate(7, new java.sql.Date(p.getUsingDate().getTime()));
            stmt.setInt(8, p.getStatus());
            stmt.setDate(9, p.getExpirationDate() != null ? new java.sql.Date(p.getExpirationDate().getTime()) : null);
            stmt.setInt(10, p.getProductID());
            return stmt.executeUpdate();
        }
    }

    public int deleteProduct(int productID) throws SQLException {
        System.out.println("Attempting to delete product with ID: " + productID);
        
        // Try hard delete first
        String deleteSql = "DELETE FROM tblProducts WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
            deleteStmt.setInt(1, productID);
            int deleteResult = deleteStmt.executeUpdate();
            System.out.println("Hard delete result: " + deleteResult + " rows affected");
            
            if (deleteResult > 0) {
                return deleteResult;
            }
        } catch (SQLException e) {
            System.out.println("Hard delete failed: " + e.getMessage());
            // If hard delete fails due to constraints, try soft delete as fallback
        }
        
        // If hard delete fails or no rows affected, try soft delete as fallback
        String updateSql = "UPDATE tblProducts SET status = 0 WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
            updateStmt.setInt(1, productID);
            int updateResult = updateStmt.executeUpdate();
            System.out.println("Soft delete result: " + updateResult + " rows affected");
            return updateResult;
        } catch (SQLException e) {
            System.out.println("Soft delete failed: " + e.getMessage());
            throw e; // Re-throw the exception for proper handling
        }
    }

    public int getProductCount() throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM tblProducts WHERE status = 1";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
        return count;
    }
}