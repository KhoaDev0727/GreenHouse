<%-- 
    Document   : admin
    Created on : Nov 2, 2024, 12:33:09 AM
    Author     : le minh khoa
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="DAOs.ProductDAO" %>
<%@ page import="Models.Product" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container-fluid {
                display: flex;
                height: 100vh;
            }
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                padding: 20px;
                color: white;
            }
            .sidebar h3 {
                font-weight: bold;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 5px;
            }
            .sidebar a:hover {
                background-color: #1abc9c;
            }
            .content {
                flex: 1;
                padding: 20px;
            }
            .table-container {
                margin-top: 20px;
            }
            /* Hide add product form initially */
            #addProductForm {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <!-- Sidebar -->
            <div class="sidebar">
                <h3>Admin Menu</h3>
                <a href="javascript:void(0)" onclick="showSection('addProductForm')">Add Product</a>
                <a href="javascript:void(0)" onclick="showSection('productList')">Product List</a>
                <a href="#orderList">Order List</a>
                <a href="LogoutServlet">Logout</a>
            </div>

            <!-- Content Area -->
            <div class="content">
                <!-- Add Product Form -->
                <div id="addProductForm">
                    <h2>Add Product</h2>
                    <form action="AddProductServlet" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="productName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="productName" name="productName">
                        </div>
                        <div class="mb-3">
                            <label for="category" class="form-label">Category</label>
                            <input type="text" class="form-control" id="category" name="category">
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" class="form-control" id="price" name="price" step="0.01">
                        </div>
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" >
                        </div>
                        <div class="mb-3">
                            <label for="imageUrl" class="form-label">Image URL</label>
                            <input type="text" class="form-control" id="imageUrl" name="imageUrl" placeholder="Enter image URL">
                        </div>
                        <button type="submit" class="btn btn-success">Add Product</button>
                    </form>
                </div>


                <!-- Product List -->
                <div id="productList" class="table-container">
                    <h2>Product List</h2>
                    <%
                        ProductDAO productDAO = new ProductDAO();
                        List<Product> productList = productDAO.getAllProducts();
                    %>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Image</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product product : productList) { %>
                            <tr>
                                <td><%= product.getProductID() %></td>
                                <td><%= product.getProductName() %></td>
                                <td><%= product.getCategory() %></td>
                                <td><%= product.getPrice() %></td>
                                <td><%= product.getQuantity() %></td>
                                <td><img src="<%= product.getImageUrl() %>" alt="Product Image" width="50"></td>
                                <td>
                                    <form action="EditProductServlet" method="get" style="display:inline;">
                                        <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                                        <button type="submit" class="btn btn-primary btn-sm">Edit</button>
                                    </form>
                                    <form action="DeleteProductServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    function showSection(sectionId) {
                        // Hide all sections
                        document.getElementById('addProductForm').style.display = 'none';
                        document.getElementById('productList').style.display = 'none';

                        // Show the selected section
                        document.getElementById(sectionId).style.display = 'block';
                    }

                    // By default, show the product list
                    showSection('productList');
        </script>
    </body>
</html>
