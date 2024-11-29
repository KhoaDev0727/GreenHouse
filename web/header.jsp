<%-- 
    Document   : header
    Created on : Oct 27, 2024, 11:02:23 PM
    Author     : le minh khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="control.AddToCartServlet.CartItem" %>
<%@ page import="java.math.BigDecimal" %> 

<c:set var="cart" value="${sessionScope.cart}" />
<c:set var="cartCount" value="0" />
<c:if test="${not empty cart}">
    <c:forEach var="item" items="${cart}">
        <c:set var="cartCount" value="${cartCount + item.quantity}" />
    </c:forEach>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Green House Tea</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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

        <!-- Stylesheet -->
        <link rel="stylesheet" href="./css/style.css"/>
        <style>
            .user-dropdown {
                margin-top: 6px;
            }
            .welcome{
                margin-left: 7px;
                font-weight: bold;
                color: green;
            }
            .welcome a .welcome span {
                font-size: 17px;

            }
            .text-start h1{
                font-weight: bold;
                font-size: 65px;
            }
            .head-bar {
                border-bottom: 1px solid grey;
            }
            .icon-cart-shopping i {
                padding-top: 7px;
                padding-left: 7px;
            }
            .icon-user {
                padding-left: 15px;
            }
            #searchResults {
                position: absolute; /* Đặt dropdown dưới textbox */
                top: 100%; /* Đẩy xuống ngay dưới textbox */
                left: 0;
                right: 0;
                background: #ffffff;
                border: 1px solid #ccc;
                max-height: 300px;
                overflow-y: auto;
                z-index: 1000; /* Để nổi lên trên */
                display: none; /* Ẩn mặc định */
            }

            .dropdown-item {
                padding: 8px;
                border-bottom: 1px solid #f1f1f1;
            }

            .close-dropdown {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px;
                font-weight: bold;
                cursor: pointer;
                border-bottom: 1px solid #f1f1f1;
            }

            #searchResults ul {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            #searchResults li {
                padding: 8px;
                cursor: pointer;
            }

            #searchResults li:hover {
                background-color: #f0f0f0; /* Hiệu ứng hover */
            }

            .user-dropdown .dropdown-menu {
                display: none;
                position: absolute;
                top: 100%;
                right: -3%;
                background-color: #f1f1f1;
                min-width: 150px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1;
            }
        </style>
    </head>

    <body>
        <!-- Navbar start -->
        <div class="container-fluid fixed-top head-bar">
            <div class="container topbar bg-primary d-none d-lg-block">
                <div class="d-flex justify-content-between">
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#"
                                                                                                         class="text-white">Ninh Kieu, CanTho</a></small>
                        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#"
                                                                                                  class="text-white">GreenHouseTea99@gmail.com</a></small>
                    </div>
                    <div class="top-link pe-2">
                        <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                        <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                        <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
                    </div>
                </div>
            </div>
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="index.jsp" class="navbar-brand">
                        <h1 class="text-primary display-6">Green House</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="index.jsp" class="nav-item nav-link active">Home</a>                      
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Options</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="cart.jsp" class="dropdown-item">Cart</a>
                                    <a href="checkout.jsp" class="dropdown-item">Checkout</a> 
                                    <a href="#" class="dropdown-item">Service </a>
                                </div>
                            </div>
                            <a href="contact.html" class="nav-item nav-link">Contact</a>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <!-- search icon here -->
                            <div class="d-flex position-relative">
                                <form action="SearchServlet" method="get" class="d-flex">
                                    <input type="text" name="searchQuery" class="form-control me-2" placeholder="Search for products..." required>
                                    <button class="btn btn-primary" type="submit">Search</button>
                                </form>
                                <!-- Dropdown danh sách sản phẩm -->
                                <div id="searchResults" class="dropdown-menu position-absolute w-100" style="z-index: 1000; display: none;"></div>
                            </div>


                            <div class="position-relative">
                                <!-- Cart icon with count -->
                                <a href="cart.jsp" class="icon-cart-shopping" id="cartIcon">
                                    <i class="fas fa-shopping-cart fa-2x text-primary"></i>
                                    <span id="cartCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-button">
                                        <c:out value="${cartCount}" default="0" />
                                    </span>
                                </a>
                            </div>

                            <div class="user-dropdown">
                                <!-- User icon and dropdown for login/logout options -->
                                <a href="#" class="icon-user" id="userIcon">
                                    <i class="fas fa-user fa-2x"></i>
                                </a>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.fullName and sessionScope.isVerified}">
                                        <span class="user-greeting">Welcome, <c:out value="${sessionScope.fullName}" /></span>
                                        <a href="LogoutServlet" class="logout-button mt-3">Logout</a>
                                        <!-- User menu with personalized options -->
                                        <div id="userMenu" class="dropdown-menu">
                                            <a href="UserAccount.jsp" class="dropdown-item">My Account</a>
                                            <a href="LogoutServlet" class="dropdown-item">Log Out</a>
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="guest-greeting">Hello Guest</span>
                                        <div id="userMenu" class="dropdown-menu">
                                            <a href="SignIn.jsp" class="dropdown-item">Sign In</a>
                                            <a href="SignUp.jsp" class="dropdown-item">Sign Up</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>



                        </div> 
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
        <script src="./js/controller.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            document.getElementById('userIcon').addEventListener('click', function (event) {
                event.preventDefault();
                const userMenu = document.getElementById('userMenu');
                userMenu.style.display = userMenu.style.display === 'block' ? 'none' : 'block';
            });


            window.addEventListener('click', function (event) {
                if (!event.target.matches('#userIcon') && !event.target.matches('.fas.fa-user')) {
                    document.getElementById('userMenu').style.display = 'none';
                }
            });


            $(document).ready(function () {
                $("input[name='searchQuery']").on("input", function () {
                    let query = $(this).val();
                    if (query.length > 2) {
                        $.ajax({
                            url: "SearchServlet",
                            method: "GET",
                            data: {searchQuery: query},
                            success: function (html) {
                                let results = $("#searchResults");
                                results.html(html);
                                if (html.trim().length > 0) {
                                    results.show();
                                } else {
                                    results.hide();
                                }
                            },
                            error: function () {
                                console.log("Error fetching search results.");
                            }
                        });
                    } else {
                        $("#searchResults").hide();
                    }
                });

                // Thêm sự kiện để đóng dropdown khi click ra ngoài
                $(document).click(function (e) {
                    if (!$(e.target).closest("#searchResults, input[name='searchQuery']").length) {
                        $("#searchResults").hide();
                    }
                });

                // Đóng dropdown khi click vào nút "X"
                $(document).on("click", ".close-btn", function () {
                    $("#searchResults").hide();
                });

                // Thêm sản phẩm vào giỏ hàng
                $(document).on("click", ".add-to-cart-btn", function () {
                    let productId = $(this).data("id");
                    let productName = $(this).data("name");
                    let productPrice = $(this).data("price");
                    let productImage = $(this).data("image");

                    $.post("AddToCartServlet", {productID: productId, model: productName, price: productPrice, imageUrl: productImage}, function (response) {
                        // Cập nhật số lượng trong giỏ hàng trên giao diện
                        let cartCountElem = $("#cartCount");
                        let currentCount = parseInt(cartCountElem.text()) || 0;
                        cartCountElem.text(currentCount + 1);
                    });
                });

            });
        </script>

    </body>
</html>
