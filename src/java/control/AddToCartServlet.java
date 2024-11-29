package control;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public static class CartItem {
        private String model;
        private BigDecimal price;
        private int quantity;
        private String imageUrl;  

        public CartItem(String model, BigDecimal price, String imageUrl) {
            this.model = model;
            this.price = price;
            this.quantity = 1;
            this.imageUrl = imageUrl;  // Initialize the image URL
        }

        // Getters and Setters
        public String getModel() { return model; }
        public BigDecimal getPrice() { return price; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
        public String getImageUrl() { return imageUrl; }  // Getter for image URL
    }
    
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String model = request.getParameter("model");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");  // Retrieve the image URL
        BigDecimal price = new BigDecimal(priceStr);
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        boolean itemExists = false;
        for (CartItem item : cart) {
            if (item.getModel().equals(model)) {
                item.setQuantity(item.getQuantity() + 1);
                itemExists = true;
                break;
            }
        }
        
        if (!itemExists) {
            cart.add(new CartItem(model, price, imageUrl));  // Include the image URL when adding an item
        }
        
        response.sendRedirect("index.jsp");
    }
}
