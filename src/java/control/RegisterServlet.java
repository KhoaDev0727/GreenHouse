/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    
    private static final String JDBC_URL = "jdbc:sqlserver://DESKTOP-FAPV9II\\KHOADEV;databaseName=GreenHouseDB;encrypt=false";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "12345";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {      
        response.sendRedirect("SignUp.jsp");              
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String fullName = request.getParameter("fullname").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        
        String fullnameError = "";
        String emailError = "";
        String passwordError = "";

        boolean hasError = false;

        
        if (fullName == null || fullName.isEmpty()) {
            fullnameError = "Full Name is required.";
            hasError = true;
        }

        if (email == null || email.isEmpty()) {
            emailError = "Email is required.";
            hasError = true;
        } else if (!isValidEmail(email)) {
            emailError = "Invalid email format.";
            hasError = true;
        }

        if (password == null || password.isEmpty()) {
            passwordError = "Password is required.";
            hasError = true;
        } else if (password.length() < 6) {
            passwordError = "Password must be at least 6 characters long.";
            hasError = true;
        }

        if (hasError) {
            
            request.setAttribute("fullnameError", fullnameError);
            request.setAttribute("emailError", emailError);
            request.setAttribute("passwordError", passwordError);
            request.setAttribute("fullnameValue", fullName);
            request.setAttribute("emailValue", email);
            

            
            RequestDispatcher dispatcher = request.getRequestDispatcher("SignUp.jsp");
            dispatcher.forward(request, response);
            return;
        }

        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            
            String checkSql = "SELECT * FROM Users WHERE Email = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                
                emailError = "Email is already in use. Please choose another email.";
                request.setAttribute("emailError", emailError);
                request.setAttribute("fullnameValue", fullName);
                request.setAttribute("emailValue", email);
                

                RequestDispatcher dispatcher = request.getRequestDispatcher("SignUp.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // SQL Insert statement
            String sql = "INSERT INTO Users (FullName, Email, Password) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, fullName);
            pstmt.setString(2, email);
            pstmt.setString(3, password); 

            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                
                rs = pstmt.getGeneratedKeys();
                int userID = -1;
                if (rs.next()) {
                    userID = rs.getInt(1);
                }

                
                HttpSession session = request.getSession();
                session.setAttribute("userID", userID);
                session.setAttribute("fullName", fullName);
                session.setAttribute("email", email);

                // Redirect to Home.jsp
                response.sendRedirect("SignIn.jsp");
            } else {
                // Registration failed
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.setAttribute("fullnameValue", fullName);
                request.setAttribute("emailValue", email);
                RequestDispatcher dispatcher = request.getRequestDispatcher("SignUp.jsp");
                dispatcher.forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "JDBC Driver not found.");
            request.setAttribute("fullnameValue", fullName);
            request.setAttribute("emailValue", email);
            RequestDispatcher dispatcher = request.getRequestDispatcher("SignUp.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.setAttribute("fullnameValue", fullName);
            request.setAttribute("emailValue", email);
            RequestDispatcher dispatcher = request.getRequestDispatcher("SignUp.jsp");
            dispatcher.forward(request, response);
        } finally {
            // Đóng các tài nguyên
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }
}
