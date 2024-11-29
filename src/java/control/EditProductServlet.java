package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAOs.ProductDAO;
import Models.Product;


public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy ID sản phẩm từ tham số request
        int productID = Integer.parseInt(request.getParameter("productID"));

        // Lấy thông tin sản phẩm từ database
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProduct(productID);

        // Đưa sản phẩm vào request và chuyển tiếp đến trang edit.jsp
        request.setAttribute("product", product);
        request.getRequestDispatcher("edit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy dữ liệu sản phẩm từ form
        int productID = Integer.parseInt(request.getParameter("productID"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imageUrl = request.getParameter("imageUrl");

        // Cập nhật thông tin sản phẩm trong database
        Product product = new Product(productID, name, category, price, quantity, imageUrl);
        ProductDAO productDAO = new ProductDAO();
        productDAO.updateProduct(product);

        // Chuyển hướng lại trang admin.jsp sau khi cập nhật
        response.sendRedirect("admin.jsp");
    }
}
