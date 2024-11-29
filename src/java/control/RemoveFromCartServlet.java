package control;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import jakarta.servlet.*;

import jakarta.servlet.http.*;

//@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String model = request.getParameter("model");
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            List<AddToCartServlet.CartItem> cart = (List<AddToCartServlet.CartItem>) session.getAttribute("cart");
            if (cart != null) {
                Iterator<AddToCartServlet.CartItem> iterator = cart.iterator();
                while(iterator.hasNext()) {
                    AddToCartServlet.CartItem item = iterator.next();
                    if(item.getModel().equals(model)) {
                        iterator.remove();
                    }
                }
                session.setAttribute("cart", cart);
            }
        }
        
        response.sendRedirect("cart.jsp");
    }
}