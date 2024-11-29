<%-- 
    Document   : cart
    Created on : Oct 27, 2024, 2:42:47 PM
    Author     : le minh khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="control.AddToCartServlet.CartItem" %>
<%@ page import="java.math.BigDecimal" %> 

<%
    List<CartItem> cart = null;
    int cartCount = 0;

    // Kiểm tra session cho giỏ hàng
    if (session != null) {
        cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            for (CartItem item : cart) {
                cartCount += item.getQuantity();
            }
        }
    }

    // Lấy thông tin người dùng từ session
    String email = (String) session.getAttribute("email");
    Boolean isVerified = (Boolean) session.getAttribute("isVerified");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> <!-- Bootstrap Import -->

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
              integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMJ8jW+eMT2HhDZcOW5eL5Qeb1Dg6bgU3x6f4F" crossorigin="anonymous">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <style>
            .cart-container {
                padding: 20px;
                position: relative;
                z-index: 100;
                padding-top: 170px;
            }
            .cart-item, .cart-item.header {
                display: flex;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px solid #ccc;
            }
            .cart-item:last-child {
                border-bottom: none;
            }
            .cart-header-column, .cart-item-column {
                text-align: center;
                flex: 1;
                color: black;
            }
            .cart-item-column.image, .cart-header-column.image {
                flex: 0.5;
            }

            .cart-item-column.model, .cart-header-column.model {
                flex: 2;
            }
            .cart-item-column.price, .cart-header-column.price,
            .cart-item-column.quantity, .cart-header-column.quantity,
            .cart-item-column.total, .cart-header-column.total,
            .cart-item-column.actions, .cart-header-column.actions {
                flex: 1;
            }
            .cart-actions {
                display: flex;
                gap: 10px;
                align-items: center;
                justify-content: center;
            }

            .btn-remove {
                background-color: red;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 4px;
            }
            .btn-remove:hover {
                background-color: darkred;
            }
            .btn-quantity {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 4px;
            }
            .btn-quantity:hover {
                background-color: #0056b3;
            }
            .quantity-display {
                width: 40px;
                text-align: center;
                font-weight: bold;
                display: inline-block;
            }
            .header .cart-count {
                font-weight: bold;
            }
            .cart-summary {
                margin-top: 20px;
                text-align: right;
            }
            /* Custom styles for the back button */
            .back-button {
                position: relative;
                top: 20px;
                left: 20px;
            }
            .cart-title {
                margin-top: 25px;
            }
            .cart-image {
                width: 90px;
                height: auto;
            }


            .alert-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            /* Định dạng hộp thông báo */
            .alert-box {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                max-width: 400px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                animation: fadeIn 0.3s ease-in-out;
            }

            .alert-box p {
                margin-bottom: 20px;
                font-size: 1.1em;
            }

            /* Tạo animation nhẹ cho hộp thông báo */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.9);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div id="loginAlert" class="alert-overlay" style="display: none;">
            <div class="alert-box">
                <p>You need to login to proceed with checkout.</p>
                <button onclick="goToLogin()" class="btn btn-primary">Login</button>
                <button onclick="closeAlert()" class="btn btn-secondary">Cancel</button>
            </div>
        </div>

        <div class="cart-container">          
            <div class="back-button">
                <a href="index.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Back to home
                </a>               
            </div>

            <h2 class="text-center mt-4 cart-title">Your Cart</h2>
            <%
                if (cart == null || cart.isEmpty()) {
            %>
            <div class="mt-4">
                <p class="text-center fs-4 text-black">Your cart is empty.</p>
            </div>
            <%
                } else {
            %>

            <div class="cart-items mt-4">
                <div class="cart-item header">
                    <span class="cart-header-column image"></span>
                    <span class="cart-header-column model"><strong>Name</strong></span>
                    <span class="cart-header-column price"><strong>Price</strong></span>
                    <span class="cart-header-column quantity"><strong>Quantity</strong></span>
                    <span class="cart-header-column total"><strong>Total</strong></span>
                    <span class="cart-header-column actions"><strong>Actions</strong></span>
                </div>
                <%
                    BigDecimal grandTotal = new BigDecimal(0);
                    for (CartItem item : cart) {
                        // Tính tổng tiền cho từng sản phẩm
                        BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                        grandTotal = grandTotal.add(itemTotal);
                %>
                <div class="cart-item">
                    <span class="cart-item-column image">
                        <img src="<%= item.getImageUrl() %>" alt="<%= item.getModel() %>" class="cart-image">
                    </span>
                    <span class="cart-item-column model"><%= item.getModel() %></span>
                    <span class="cart-item-column price"><%= String.format("%.2f", item.getPrice()) %> $</span> 
                    <span class="cart-item-column quantity">
                        <form action="UpdateCartServlet" method="post" style="display:inline;">
                            <input type="hidden" name="model" value="<%= item.getModel() %>">
                            <input type="hidden" name="action" value="decrease">
                            <button type="submit" class="btn-quantity"><i class="bi bi-dash"></i></button>
                        </form>
                        <span class="quantity-display"><%= item.getQuantity() %></span>
                        <form action="UpdateCartServlet" method="post" style="display:inline;">
                            <input type="hidden" name="model" value="<%= item.getModel() %>">
                            <input type="hidden" name="action" value="increase">
                            <button type="submit" class="btn-quantity"><i class="bi bi-plus"></i></button>
                        </form>
                    </span>
                    <span class="cart-item-column total"><%= String.format("%.2f", itemTotal) %> $</span> 
                    <span class="cart-item-column actions cart-actions">
                        <form action="RemoveFromCartServlet" method="post" style="display:inline;">
                            <input type="hidden" name="model" value="<%= item.getModel() %>">
                            <button type="submit" class="btn-remove">Remove</button>
                        </form>
                    </span>
                </div>
                <%
                    }
                %>
            </div>

            <div class="cart-summary">
                <h4>Grand Total: <%= String.format("%.2f", grandTotal) %> $</h4> 
            </div>


            <div class="cart-actions mt-4">
                <%                   
                    if (email != null) {
                %>
                <a href="checkout.jsp" class="btn btn-primary">Proceed to Checkout</a>
                <%
                    } else {
                %>
                <button type="button" class="btn btn-primary" onclick="redirectToLogin()">Proceed to Checkout</button>
                <%
                    }
                %>
                <a href="index.jsp" class="btn btn-secondary">Continue Shopping</a>
                <form action="ClearCartServlet" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-danger">Clear All</button>
                </form> 
            </div>

            <%
                }
            %>


            <script>
                function redirectToLogin() {
                    
                    document.getElementById("loginAlert").style.display = "flex";
                }

                function goToLogin() {
                    // Chuyển hướng đến trang đăng nhập khi nhấn nút Login
                    window.location.href = "SignIn.jsp";
                }

                function closeAlert() {
                    // Đóng hộp thoại thông báo
                    document.getElementById("loginAlert").style.display = "none";
                }
            </script>
    </body>
</html>