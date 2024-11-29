<%-- 
    Document   : orderConfirmation
    Created on : Oct 28, 2024, 1:13:31 PM
    Author     : le minh khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Confirmation</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <style>
            .confirmation-container {
                padding: 40px 0;
                text-align: center;
                padding-top: 200px;
            }
            .confirmation-icon {
                width: 140px;
                height: auto;
            }
            .confirmation-message {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="container confirmation-container">
            <img src="./img/verified.gif" class="confirmation-icon" alt="done-icon">           
            <h2 class="mt-4">Thank You for Your Order!</h2>
            <p class="confirmation-message">Your order has been successfully placed. We will contact you shortly with the details.</p>
            <a href="index.jsp" class="btn btn-primary mt-3">Return to Home</a>
        </div>

        <!-- Bootstrap JS and dependencies (Popper.js) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>