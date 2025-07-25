package controller;

import dal.ProductDAO;
import model.Categories; // Thêm import cho Categories
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Lấy tham số action
            String action = request.getParameter("action");
            
            // Xử lý các action khác nhau
            if (action != null && action.equals("detail")) {
                // Hiển thị chi tiết sản phẩm
                String productIDParam = request.getParameter("productID");
                if (productIDParam != null && !productIDParam.isEmpty()) {
                    try {
                        int productID = Integer.parseInt(productIDParam);
                        Product product = productDAO.getProductByID(productID);
                        if (product != null) {
                            request.setAttribute("product", product);
                            request.getRequestDispatcher("/jsp/productDetail.jsp").forward(request, response);
                            return;
                        } else {
                            request.setAttribute("error", "Không tìm thấy sản phẩm!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "ID sản phẩm không hợp lệ!");
                    }
                }
            }
            
            // Hiển thị danh sách sản phẩm (mặc định)
            List<Categories> categories = productDAO.getAllCategories(); // Sử dụng List<Categories>
            request.setAttribute("categories", categories);
            
            String keyword = request.getParameter("keyword");
            String categoryID = request.getParameter("categoryID");
            
            List<Product> products = productDAO.searchProducts(keyword, categoryID);
            request.setAttribute("products", products);
            
            request.getRequestDispatcher("/jsp/products.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
            request.getRequestDispatcher("/jsp/products.jsp").forward(request, response);
        }
    }
}