package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

//@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:sqlserver://DESKTOP-FAPV9II\\KHOADEV;databaseName=GreenHouseDB;encrypt=false";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            String sql = "UPDATE Users SET FullName = ?, Password = ? WHERE Email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fullName);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.executeUpdate();

            // Update session attribute if needed
            session.setAttribute("fullName", fullName);
            response.sendRedirect("UserAccount.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserAccount.jsp"); 
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
