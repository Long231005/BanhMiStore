package controller;

import dal.ProductDAO;
import model.Product;
import model.Categories;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class ProductManagementServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            System.out.println("doGet action: " + action);

            if (action != null && action.equals("delete")) {
                // Handle delete in doGet to support direct URL deletion
                deleteProduct(request, response);
                return; // Important to return after redirect
            } else if (action != null && action.equals("edit")) {
                String productIDParam = request.getParameter("productID");
                if (productIDParam != null && !productIDParam.isEmpty()) {
                    try {
                        int productID = Integer.parseInt(productIDParam);
                        Product product = productDAO.getProductByID(productID);
                        if (product != null) {
                            request.setAttribute("product", product);
                        } else {
                            request.setAttribute("error", "Không tìm thấy sản phẩm!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "ID sản phẩm không hợp lệ!");
                    }
                }
            }

            List<Categories> categories = productDAO.getAllCategories();
            List<Product> products = productDAO.getAllProducts();
            Collections.sort(products, new Comparator<Product>() {
                @Override
                public int compare(Product p1, Product p2) {
                    return Integer.compare(p1.getProductID(), p2.getProductID());
                }
            });
            request.setAttribute("categories", categories);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/admin/products_management.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
            request.getRequestDispatcher("/admin/products_management.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("doPost action: " + action);

        try {
            if (action != null) {
                if (action.equals("add")) {
                    addProduct(request, response);
                } else if (action.equals("update")) {
                    updateProduct(request, response);
                } else if (action.equals("delete")) {
                    deleteProduct(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau: " + e.getMessage());
            loadProductsAndForward(request, response);
        }
    }

    private void loadProductsAndForward(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Categories> categories = productDAO.getAllCategories();
            List<Product> products = productDAO.getAllProducts();
            Collections.sort(products, new Comparator<Product>() {
                @Override
                public int compare(Product p1, Product p2) {
                    return Integer.compare(p1.getProductID(), p2.getProductID());
                }
            });
            request.setAttribute("categories", categories);
            request.setAttribute("products", products);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách sản phẩm: " + e.getMessage());
        }
        request.getRequestDispatcher("/admin/products_management.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {
    try {
        String productName = request.getParameter("productName");

        if (!productName.matches("^[\\p{L}\\s]+$")) {
            request.setAttribute("error", "Tên sản phẩm không được chứa số hoặc ký tự đặc biệt!");
            loadProductsAndForward(request, response);
            return;
        }


        Product product = new Product();
        product.setProductName(productName);
        product.setImage(request.getParameter("image"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        product.setCategoryID(request.getParameter("categoryID"));

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        product.setImportDate(dateFormat.parse(request.getParameter("importDate")));
        product.setUsingDate(dateFormat.parse(request.getParameter("usingDate")));
        product.setExpirationDate(dateFormat.parse(request.getParameter("expirationDate")));
        product.setStatus(Integer.parseInt(request.getParameter("status")));

        int result = productDAO.insertProduct(product);
        if (result > 0) {
            request.setAttribute("message", "Thêm sản phẩm thành công!");
        } else {
            request.setAttribute("error", "Thêm sản phẩm thất bại!");
        }
    } catch (ParseException | NumberFormatException e) {
        e.printStackTrace();
        request.setAttribute("error", "Dữ liệu không hợp lệ, vui lòng kiểm tra lại!");
    }

    loadProductsAndForward(request, response);
}


    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        try {
            Product product = new Product();
            product.setProductID(Integer.parseInt(request.getParameter("productID")));
            product.setProductName(request.getParameter("productName"));
            product.setImage(request.getParameter("image"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            product.setCategoryID(request.getParameter("categoryID"));

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            product.setImportDate(dateFormat.parse(request.getParameter("importDate")));
            product.setUsingDate(dateFormat.parse(request.getParameter("usingDate")));
            product.setExpirationDate(dateFormat.parse(request.getParameter("expirationDate")));
            product.setStatus(Integer.parseInt(request.getParameter("status")));

            int result = productDAO.updateProduct(product);
            if (result > 0) {
                request.setAttribute("message", "Cập nhật sản phẩm thành công!");
            } else {
                request.setAttribute("error", "Cập nhật sản phẩm thất bại!");
            }
        } catch (ParseException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ, vui lòng kiểm tra lại!");
        }

        loadProductsAndForward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String productIDParam = request.getParameter("productID");
        System.out.println("Attempting to delete product ID: " + productIDParam);
        
        if (productIDParam == null || productIDParam.isEmpty()) {
            request.setAttribute("error", "ID sản phẩm không được cung cấp!");
            loadProductsAndForward(request, response);
            return;
        }
        
        try {
            int productID = Integer.parseInt(productIDParam);
            System.out.println("Parsed product ID for deletion: " + productID);
            
            int result = productDAO.deleteProduct(productID);
            System.out.println("Delete result: " + result);
            
            if (result > 0) {
                request.setAttribute("message", "Xóa sản phẩm thành công!");
            } else {
                request.setAttribute("error", "Xóa sản phẩm thất bại! Sản phẩm không tồn tại hoặc có lỗi khi xóa.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "ID sản phẩm không hợp lệ: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu khi xóa sản phẩm: " + e.getMessage());
        }

        // After delete, redirect to the product list page
        response.sendRedirect(request.getContextPath() + "/ProductManagementServlet");
    }
}