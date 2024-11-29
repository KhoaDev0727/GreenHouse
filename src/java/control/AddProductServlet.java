package control;

import DAOs.ProductDAO;
import Models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy thông tin từ biểu mẫu
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String priceParam = request.getParameter("price");
        String quantityParam = request.getParameter("quantity");
        String imageUrl = request.getParameter("imageUrl"); // Thay đổi ở đây để lấy URL hình ảnh từ trường đầu vào
        
        double price = 0.0;
        int quantity = 0;

        // Kiểm tra các trường nhập liệu
        if (productName == null || productName.trim().isEmpty() || 
            category == null || category.trim().isEmpty() ||
            priceParam == null || priceParam.trim().isEmpty() || 
            quantityParam == null || quantityParam.trim().isEmpty() || 
            imageUrl == null || imageUrl.trim().isEmpty()) { // Kiểm tra URL hình ảnh
            
            // Nếu có trường không hợp lệ, gửi lại thông báo lỗi
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi giá và số lượng, xử lý lỗi
        try {
            price = Double.parseDouble(priceParam);
            quantity = Integer.parseInt(quantityParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Price and quantity must be valid numbers.");
            request.getRequestDispatcher("addProductForm.jsp").forward(request, response);
            return;
        }

        // Tạo sản phẩm mới
        Product product = new Product(productName, category, price, quantity, imageUrl); // Sử dụng imageUrl đã lấy
        ProductDAO productDAO = new ProductDAO();
        productDAO.create(product); // Lưu sản phẩm vào database

        // Chuyển hướng trở lại trang admin hoặc trang thành công
        response.sendRedirect("admin.jsp"); // Hoặc trang bạn muốn hiển thị
    }
}
