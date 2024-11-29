package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:sqlserver://DESKTOP-FAPV9II\\KHOADEV;databaseName=GreenHouseDB;encrypt=false";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "12345";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("SignIn.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        email = (email != null) ? email.trim() : "";
        password = (password != null) ? password.trim() : "";

        String emailError = "";
        String passwordError = "";
        String generalError = "";
        boolean hasError = false;
        boolean isAdmin = email.equals("admin@greenhouse.com");

        if (!isAdmin) {  // Kiểm tra định dạng email chỉ với tài khoản người dùng thông thường
            if (email.isEmpty()) {
                emailError = "Email is required.";
                hasError = true;
            } else if (!isValidEmail(email)) {
                emailError = "Invalid email format.";
                hasError = true;
            }
        }

        if (password.isEmpty()) {
            passwordError = "Password is required.";
            hasError = true;
        }

        if (hasError) {
            request.setAttribute("emailError", emailError);
            request.setAttribute("passwordError", passwordError);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("SignIn.jsp").forward(request, response);
            return;
        }

        try ( Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            String sql = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
            try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, email);
                pstmt.setString(2, password);
                try ( ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userID", rs.getInt("UserID"));
                        session.setAttribute("fullName", rs.getString("FullName"));
                        session.setAttribute("email", rs.getString("Email"));

                        // Kiểm tra nếu là admin thì chuyển hướng đến trang quản trị
                        if (isAdmin) {
                            response.sendRedirect("admin.jsp");
                        } else {
                            response.sendRedirect("SendVerificationServlet");
                        }
                    } else {
                        generalError = isAdmin ? "Admin account does not exist." : "Invalid email or password. Please try again.";
                        request.setAttribute("errorMessage", generalError);
                        request.setAttribute("emailValue", email);
                        request.getRequestDispatcher("SignIn.jsp").forward(request, response);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            generalError = "JDBC Driver not found.";
            request.setAttribute("errorMessage", generalError);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("SignIn.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            generalError = "Database error: " + e.getMessage();
            request.setAttribute("errorMessage", generalError);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("SignIn.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }
}
