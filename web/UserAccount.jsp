<%-- 
    Document   : UserAccount
    Created on : Nov 1, 2024, 4:45:14 PM
    Author     : le minh khoa
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("email");
    String fullName = (String) session.getAttribute("fullName");
    String password = ""; // Initialize to empty

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Database connection
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-FAPV9II\\KHOADEV;databaseName=MercedesDB;encrypt=false", "sa", "12345");

        String sql = "SELECT Password FROM Users WHERE Email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            password = rs.getString("Password");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>User Account</title>
        <style>
            .box-useraccount {
                max-width: 500px;
                background: #ffffff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                margin: auto;
            }
            .title-user {
                font-family: 'Cursive', sans-serif;
                color: rgb(123, 194, 76);
                text-align: center;
            }
            .btn-custom {
                background-color: #388e3c; /* Màu xanh lá đậm */
                color: white;
            }
            .btn-custom:hover {
                background-color: #2e7d32;
            }
            .btn-secondary {
                background-color: #8d6e63; /* Màu nâu nhạt */
                color: white;
            }
            .form-label {
                font-weight: bold;
            }
            .box-useraccount {
                padding-top: 250px;
            }

            .alert-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.6);
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .alert-box {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="mt-5 box-useraccount">
            <h1 class="title-user">Green House Account</h1>
            <form action="UpdateUserServlet" method="post" onsubmit="return validateForm();">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" value="<%= fullName %>">
                    <span id="nameError" class="text-danger"></span> 
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" value="<%= email %>" readonly>                  
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" value="<%= password %>">
                    <span id="passwordError" class="text-danger"></span> 
                </div>

                <button type="submit" class="btn btn-custom bg-success text-white w-100">Update</button>
                <a href="index.jsp" class="btn btn-secondary w-100 mt-2">Home</a>
            </form>
            <button onclick="showDeleteConfirm()" class="btn btn-danger w-100 mt-2">Delete Account</button>
        </div>

        <div id="deleteAlert" class="alert-overlay" style="display: none;">
            <div class="alert-box">
                <p>Are you sure you want to delete your account?</p>
                <button onclick="deleteAccount()" class="btn btn-danger">Yes, Delete</button>
                <button onclick="closeDeleteAlert()" class="btn btn-secondary">Cancel</button>
            </div>
        </div>

        <script>
            function validateForm() {
                const fullName = document.getElementById("fullName").value;
                const password = document.getElementById("password").value;
                const nameRegex = /^[a-zA-Z0-9\s]+$/;
                const passwordRegex = /^[a-zA-Z0-9]+$/;

                // Validate full name
                if (!nameRegex.test(fullName)) {
                    document.getElementById("nameError").innerText = "Full Name must contain only letters, numbers, and spaces.";
                    return false;
                } else {
                    document.getElementById("nameError").innerText = "";
                }

                // Validate password
                if (password.length < 6) {
                    document.getElementById("passwordError").innerText = "Password must be at least 6 characters long.";
                    return false;
                }
                if (password.trim() === "") {
                    document.getElementById("passwordError").innerText = "Password cannot be empty or contain only spaces.";
                    return false;
                }
                if (!passwordRegex.test(password)) {
                    document.getElementById("passwordError").innerText = "Password must contain only letters and numbers.";
                    return false;
                } else {
                    document.getElementById("passwordError").innerText = ""; // Clear error message
                }

                return true; // All validations passed
            }

            function showDeleteConfirm() {
                document.getElementById("deleteAlert").style.display = "flex";
            }

            function closeDeleteAlert() {
                document.getElementById("deleteAlert").style.display = "none";
            }

            function deleteAccount() {
                window.location.href = "DeleteUserServlet";
            }
        </script>
    </body>
</html>
