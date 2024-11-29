package control;

import DAOs.ProductDAO;
import Models.Product;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("searchQuery");
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.searchProducts(keyword);

        // Tạo chuỗi HTML để trả về
        StringBuilder html = new StringBuilder();
        html.append("<div class='close-dropdown'>Kết quả tìm kiếm<span class='close-btn'>X</span></div>");
        for (Product product : productList) {
            html.append("<li class='dropdown-item'>")
                    .append("<img src='").append(product.getImageUrl()).append("' alt='").append(product.getProductName()).append("' width='30'> ")
                    .append(product.getProductName()).append(" - ").append(product.getPrice()).append("$ ")
                    .append("<button class='btn btn-sm btn-success float-end add-to-cart-btn' data-id='").append(product.getProductID()).append("' ")
                    .append("data-name='").append(product.getProductName()).append("' ")
                    .append("data-price='").append(product.getPrice()).append("' ")
                    .append("data-image='").append(product.getImageUrl()).append("'>+</button></li>");
        }

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(html.toString());
    }

}
