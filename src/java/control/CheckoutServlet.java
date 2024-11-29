package control;

import java.io.IOException;
import java.math.BigDecimal; // Thêm import cho BigDecimal
import java.sql.*;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:sqlserver://DESKTOP-FAPV9II\\KHOADEV;databaseName=GreenHouseDB;encrypt=false";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "12345";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        Map<String, String> errors = new HashMap<>();

        // Kiểm tra đầu vào
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullNameError", "Full name is required.");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errors.put("emailError", "Invalid email address.");
        }
        if (phone == null || !phone.matches("\\d{10,15}")) {
            errors.put("phoneError", "Invalid phone number. Enter 10-15 digits.");
        }
        if (address == null || address.trim().isEmpty()) {
            errors.put("addressError", "Address is required.");
        }
        if (cardNumber == null || !cardNumber.matches("\\d{16}")) {
            errors.put("cardNumberError", "Card number must be 16 digits.");
        }
        if (expiryDate == null || !expiryDate.matches("\\d{4}-\\d{2}")) {
            errors.put("expiryDateError", "Expiry date must be in YYYY-MM format.");
        }
        if (cvv == null || !cvv.matches("\\d{3}")) {
            errors.put("cvvError", "CVV must be 3 digits.");
        }

        // Nếu có lỗi, chuyển tiếp lại về form với thông điệp lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Xử lý đặt hàng nếu không có lỗi
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("cart.jsp?error=Session expired. Please try again.");
            return;
        }

        List<AddToCartServlet.CartItem> cart = (List<AddToCartServlet.CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Your cart is empty.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement orderStmt = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);

            String updateQuantitySQL = "UPDATE Products SET Quantity = Quantity - ? WHERE ProductName = ? AND Quantity >= ?";
            pstmt = conn.prepareStatement(updateQuantitySQL);

            BigDecimal grandTotal = new BigDecimal(0); // Khởi tạo grandTotal

            for (AddToCartServlet.CartItem item : cart) {
                pstmt.setInt(1, item.getQuantity());
                pstmt.setString(2, item.getModel());
                pstmt.setInt(3, item.getQuantity());

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected == 0) {
                    conn.rollback();
                    response.sendRedirect("cart.jsp?error=Insufficient quantity for product: " + item.getModel());
                    return;
                }

                // Tính tổng tiền cho từng sản phẩm
                BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                grandTotal = grandTotal.add(itemTotal);
            }

            // Lấy UserID từ session (giả sử bạn đã lưu UserID trong session khi người dùng đăng nhập)
            Integer userID = (Integer) session.getAttribute("userID");
            if (userID == null) {
                response.sendRedirect("cart.jsp?error=User not logged in.");
                return;
            }

            // Thêm thông tin đơn hàng vào bảng Orders
            String insertOrderSQL = "INSERT INTO Orders (UserID, FullName, Email, Phone, Address, OrderDate, Status, TotalAmount) VALUES (?, ?, ?, ?, ?, GETDATE(), 'chưa giao', ?)";
            orderStmt = conn.prepareStatement(insertOrderSQL);
            orderStmt.setInt(1, userID);
            orderStmt.setString(2, fullName);
            orderStmt.setString(3, email);
            orderStmt.setString(4, phone);
            orderStmt.setString(5, address);
            orderStmt.setBigDecimal(6, grandTotal); // Sử dụng grandTotal để lưu vào database
            orderStmt.executeUpdate();

            conn.commit();
            session.removeAttribute("cart");
            response.sendRedirect("orderConfirmation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendRedirect("cart.jsp?error=Internal error. Please try again.");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (orderStmt != null) orderStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
