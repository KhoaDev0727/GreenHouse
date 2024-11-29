<%-- 
    Document   : searchResults
    Created on : Oct 31, 2024, 2:57:23 PM
    Author     : le minh khoa
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Product" %>
<jsp:include page="header.jsp" />

<%-- Retrieve the search results list from the servlet --%>
<%
    List<Product> searchResults = (List<Product>) request.getAttribute("searchResults");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link rel="stylesheet" href="css/style.css"> <%-- Ensure the path is correct --%>
    <style>
        /* Style for search results list */
        .search-results-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .result-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border: 1px solid #ddd;
            margin-bottom: 15px;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .result-item img {
            width: 80px;
            height: 80px;
            margin-right: 20px;
            border-radius: 5px;
        }
        .result-info h4 {
            margin: 0;
            color: #333;
        }
        .result-info p {
            margin: 5px 0;
            color: #666;
        }
        .btn-add-to-cart {
            margin-left: auto;
            padding: 8px 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-add-to-cart:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="search-results-container">
    <h2>Search results for "<%= request.getParameter("searchQuery") %>"</h2>

    <c:choose>
        <c:when test="${not empty searchResults}">
            <c:forEach var="product" items="${searchResults}">
                <div class="result-item">
                    <img src="${product.imageUrl}" alt="${product.productName}">
                    <div class="result-info">
                        <h4>${product.productName}</h4>
                        <p>Category: ${product.category}</p>
                        <p>Price: ${product.price} $</p>
                    </div>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productID" value="${product.productID}">
                        <button type="submit" class="btn-add-to-cart">Add to Cart</button>
                    </form>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>No products found matching your search.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
