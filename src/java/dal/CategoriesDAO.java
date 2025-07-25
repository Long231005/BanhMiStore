package dal;

import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Categories;

public class CategoriesDAO extends DBContext {
    public Vector<Categories> getAllCategories() {
        Vector<Categories> vector = new Vector<>();
        String sql = "SELECT * FROM [dbo].[tblCategories]";
        try (PreparedStatement ptm = connection.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Categories c = new Categories(
                    rs.getString("categoryID"),
                    rs.getString("categoryName"),
                    rs.getString("describe")
                );
                vector.add(c);
            }
        } catch (SQLException ex) {
            System.err.println("Error fetching categories: " + ex.getMessage());
        }
        return vector;
    }

    public int insertCategory(Categories c) {
        String sql = "INSERT INTO [dbo].[tblCategories] ([categoryID], [categoryName], [describe]) VALUES (?, ?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, c.getCategoryID());
            ptm.setString(2, c.getCategoryName());
            ptm.setString(3, c.getDescribe());
            return ptm.executeUpdate();
        } catch (SQLException ex) { 
            return 0;
        }
    }

    public static void main(String[] args) {
        CategoriesDAO ddao = new CategoriesDAO();
        // Fetch all categories
        Vector<Categories> vector = ddao.getAllCategories();
        System.out.println("Categories:");
        for (Categories c : vector) {
            System.out.println(c);
        }
        // Insert a new category
        Categories cInsert = new Categories("C006", "Books", "Various types of books");
        int n = ddao.insertCategory(cInsert);
        if (n > 0) {
            System.out.println("After inserted:");
            vector = ddao.getAllCategories();
            for (Categories c : vector) {
                System.out.println(c);
            }
        } else {
            System.out.println("Insert failed.");
        }
    }
}