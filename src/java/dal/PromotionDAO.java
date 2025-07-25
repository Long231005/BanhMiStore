package dal;

import model.Promotion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAO {
    private final DBContext db;
    
    public PromotionDAO() {
        db = new DBContext();
    }
    
    public List<Promotion> getAllActivePromotions() throws SQLException {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM Promotions WHERE isActive = 1";
        
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Promotion promotion = new Promotion(
                    rs.getInt("promotionID"),
                    rs.getString("promotionName"),
                    rs.getString("description"),
                    rs.getDouble("discountAmount"),
                    rs.getDouble("minimumOrderValue"),
                    rs.getBoolean("isActive")
                );
                promotions.add(promotion);
            }
        }
        
        return promotions;
    }
    
    public Promotion getPromotionByID(int promotionID) throws SQLException {
        String sql = "SELECT * FROM Promotions WHERE promotionID = ?";
        
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, promotionID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Promotion(
                        rs.getInt("promotionID"),
                        rs.getString("promotionName"),
                        rs.getString("description"),
                        rs.getDouble("discountAmount"),
                        rs.getDouble("minimumOrderValue"),
                        rs.getBoolean("isActive")
                    );
                }
            }
        }
        
        return null;
    }
    
    public List<Promotion> getApplicablePromotions(double orderTotal) throws SQLException {
        List<Promotion> applicablePromotions = new ArrayList<>();
        String sql = "SELECT * FROM Promotions WHERE isActive = 1 AND minimumOrderValue <= ?";
        
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDouble(1, orderTotal);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Promotion promotion = new Promotion(
                        rs.getInt("promotionID"),
                        rs.getString("promotionName"),
                        rs.getString("description"),
                        rs.getDouble("discountAmount"),
                        rs.getDouble("minimumOrderValue"),
                        rs.getBoolean("isActive")
                    );
                    applicablePromotions.add(promotion);
                }
            }
        }
        
        return applicablePromotions;
    }
    
    // For the special case of the current implementation, we don't need database access
    // This method provides the hardcoded promotions used in the CartServlet
    public List<Promotion> getHardcodedPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        
        promotions.add(new Promotion(1, "Giảm 20k", "Giảm 20.000 VNĐ cho đơn hàng từ 100.000 VNĐ", 20000, 100000, true));
        promotions.add(new Promotion(2, "Giảm thêm 10k", "Giảm thêm 10.000 VNĐ cho đơn hàng từ 150.000 VNĐ", 10000, 150000, true));
        promotions.add(new Promotion(3, "Miễn phí giao hàng", "Miễn phí giao hàng cho đơn hàng từ 200.000 VNĐ", 15000, 200000, true));
        
        return promotions;
    }
}