package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

//@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String model = request.getParameter("model");
        String action = request.getParameter("action");
        
        // Lấy giỏ hàng từ session
        HttpSession session = request.getSession(false);
        if (session == null) {
            // Nếu không có session, chuyển hướng về trang giỏ hàng với thông báo lỗi
            response.sendRedirect("cart.jsp?error=Session expired. Please try again.");
            return;
        }
        
        List<AddToCartServlet.CartItem> cart = (List<AddToCartServlet.CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            // Nếu giỏ hàng trống, chuyển hướng về trang giỏ hàng với thông báo lỗi
            response.sendRedirect("cart.jsp?error=Your cart is empty.");
            return;
        }
        
        // Tìm kiếm sản phẩm trong giỏ hàng
        for (AddToCartServlet.CartItem item : cart) {
            if (item.getModel().equals(model)) {
                if ("increase".equals(action)) {
                    // Tăng số lượng
                    item.setQuantity(item.getQuantity() + 1);
                } else if ("decrease".equals(action)) {                 
                    if (item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    } else {                    
                        cart.remove(item);
                        break;
                    }
                }
                break;
            }
        }
        
        // Cập nhật giỏ hàng trong session
        session.setAttribute("cart", cart);
        
        // Chuyển hướng về trang giỏ hàng
        response.sendRedirect("cart.jsp");
    }
}
