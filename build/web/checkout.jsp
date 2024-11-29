<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="control.AddToCartServlet.CartItem" %>
<%@ page import="java.math.BigDecimal" %>

<%   
    List<CartItem> cart = null;
    if (session != null) {
        cart = (List<CartItem>) session.getAttribute("cart");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Checkout</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <style>
            .checkout-container {
                padding: 40px 0;
                padding-top: 150px;
            }
            .checkout-form {
                background-color: #f8f9fa;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .cart-summary {
                margin-bottom: 30px;
            }
            .cart-summary table {
                width: 100%;
            }
            .cart-summary th, .cart-summary td {
                padding: 10px;
                text-align: left;
            }
            .cart-summary th {
                background-color: #e9ecef;
            }
            .back-button {
                position: relative;
                top: 20px;
                left: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="container checkout-container">

            <div class="back-button">
                <a href="cart.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Cart
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8">
                    <h2 class="mb-4 text-center">Checkout</h2>

                    <%
                        if (cart == null || cart.isEmpty()) {
                    %>
                    <div class="alert alert-info" role="alert">
                        Your cart is empty. <a href="index.jsp" class="alert-link">Continue shopping</a>.
                    </div>
                    <%
                        } else {
                            BigDecimal total = new BigDecimal(0);
                            for (CartItem item : cart) {
                                BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                                total = total.add(itemTotal);
                            }
                    %>

                    <div class="cart-summary">
                        <h4>Cart Summary</h4>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Model</th>
                                    <th>Price ($)</th>
                                    <th>Quantity</th>
                                    <th>Total ($)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (CartItem item : cart) {
                                        BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                                %>
                                <tr>
                                    <td><%= item.getModel() %></td>
                                    <td><%= String.format("%.2f", item.getPrice()) %></td>
                                    <td><%= item.getQuantity() %></td>
                                    <td><%= String.format("%.2f", itemTotal) %></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <th colspan="3" class="text-end">Grand Total:</th>
                                    <th><%= String.format("%.2f", total) %> $</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="checkout-form">
                        <h4>Billing Information</h4>

                        <form action="CheckoutServlet" method="post">
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${param.fullName}">
                                <div class="text-danger">${errors.fullNameError}</div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" value="${param.email}">
                                <div class="text-danger">${errors.emailError}</div>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="${param.phone}">
                                <div class="text-danger">${errors.phoneError}</div>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">Shipping Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3">${param.address}</textarea>
                                <div class="text-danger">${errors.addressError}</div>
                            </div>

                            <h4 class="mt-4">Payment Information</h4>

                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" name="cardNumber" value="${param.cardNumber}">
                                <div class="text-danger">${errors.cardNumberError}</div>
                            </div>

                            <div class="mb-3">
                                <label for="expiryDate" class="form-label">Expiry Date</label>
                                <input type="month" class="form-control" id="expiryDate" name="expiryDate" value="${param.expiryDate}">
                                <div class="text-danger">${errors.expiryDateError}</div>
                            </div>

                            <div class="mb-3">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="text" class="form-control" id="cvv" name="cvv" value="${param.cvv}">
                                <div class="text-danger">${errors.cvvError}</div>
                            </div>

                            <button type="submit" class="btn btn-success">Place Order</button>
                        </form>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies (Popper.js) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
