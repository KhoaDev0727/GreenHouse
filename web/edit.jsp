<%-- 
    Document   : edit
    Created on : Nov 2, 2024, 10:17:06 PM
    Author     : le minh khoa
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.Product" %>
<%
    // Nhận đối tượng Product từ request
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Edit Product</h2>
        <form action="EditProductServlet" method="post">
            <input type="hidden" name="productID" value="<%= product.getProductID() %>">
            
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= product.getProductName() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="category" class="form-label">Category</label>
                <input type="text" class="form-control" id="category" name="category" value="<%= product.getCategory() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <input type="number" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" step="0.01" required>
            </div>
            
            <div class="mb-3">
                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="<%= product.getQuantity() %>" required>
            </div>
            
            <div class="mb-3">
                <label for="imageUrl" class="form-label">Image URL</label>
                <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="<%= product.getImageUrl() %>" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
