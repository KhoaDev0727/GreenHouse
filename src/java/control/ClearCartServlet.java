package control;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

//@WebServlet("/ClearCartServlet")
public class ClearCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Xóa giỏ hàng bằng cách đặt giá trị của 'cart' về null
            session.setAttribute("cart", null);
        }
        
        // Chuyển hướng về trang giỏ hàng sau khi xóa
        response.sendRedirect("cart.jsp");
    }
}
