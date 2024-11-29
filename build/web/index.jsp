<%-- 
    Document   : index
    Created on : Oct 11, 2024, 5:54:55 PM
    Author     : le minh khoa
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="control.AddToCartServlet.CartItem" %>
<%@ page import="java.util.List" %>

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
<html lang="en">

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
            .text-start h1{
                font-weight: bold;
                font-size: 65px;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords"
                                   aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->


        <!-- Hero Start -->
        <div class="container-fluid py-5 mb-5 hero-header">
            <div class="container py-5">
                <div class="row g-5 align-items-center">
                    <div class="col-md-12 col-lg-7">
                        <h4 class="mb-3 text-secondary">Enjoy green tea, enhance your senses</h4>
                        <h1 class="mb-5 display-3 text-primary">Natural taste, pure feeling</h1>
                        <div class="position-relative mx-auto">
                            <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="number"
                                   placeholder="Search">
                            <button type="submit"
                                    class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100"
                                    style="top: 0; right: 25%;">Submit Now</button>
                        </div>
                    </div>
                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active rounded">
                                    <img src="img/banner-1.jpg" class="img-fluid w-100 h-100 bg-secondary rounded"
                                         alt="First slide">
                                </div>
                                <div class="carousel-item rounded">
                                    <img src="img/banner-2.jpg" class="img-fluid w-100 h-100 rounded" alt="Second slide">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero End -->


        <!-- Featurs Section Start -->
        <div class="container-fluid featurs py-5">
            <div class="container py-5">
                <div class="row g-4 justify-content-center">
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-shipping-fast fa-3x text-white"></i> <!-- Changed icon -->
                            </div>
                            <div class="featurs-content text-center">
                                <h5>Free Shipping</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-comments fa-3x text-white"></i> <!-- Changed icon -->
                            </div>
                            <div class="featurs-content text-center">
                                <h5>Airy and Comfortable</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-hands-helping fa-3x text-white"></i> <!-- Changed icon -->
                            </div>
                            <div class="featurs-content text-center">
                                <h5>Attentive Service</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Featurs Section End -->


        <!-- Coffee Shop Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5" id="choose-item">
                <div class="tab-class text-center">
                    <div class="row g-4">
                        <div class=" text-center mx-auto mb-5 text-start" style="max-width: 700px;">
                            <h1>Our Products</h1>
                        </div>
                    </div>

                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#tab-1">
                                    <span class="text-dark" style="width: 130px;">All Products</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-2">
                                    <span class="text-dark" style="width: 130px;">Tea</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-3">
                                    <span class="text-dark" style="width: 130px;">Milk Tea</span>
                                </a>
                            </li> 
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-4">
                                    <span class="text-dark" style="width: 130px;">Yogurt</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>


                <sql:setDataSource var="conn"
                                   driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                   url="jdbc:sqlserver://DESKTOP-FAPV9II\\KHOADEV;databaseName=GreenHouseDB;encrypt=false"
                                   user="sa"
                                   password="12345"/>
                <sql:query var="products" dataSource="${conn}">
                    SELECT * FROM Products
                </sql:query>

                <!-- Start tab content -->
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4 menu-content">

                                    <c:forEach var="productVar" items="${products.rows}">  
                                        <div class="col-md-6 col-lg-4 col-xl-3 product-item" data-category="${productVar.category}">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="${productVar.imageUrl}" class="img-fluid w-100 rounded-top" alt="${productVar.productName}">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                     style="top: 10px; left: 10px;">${productVar.category}</div> 
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom text-center">
                                                    <h4>${productVar.productName}</h4>
                                                    <div class="d-flex justify-content-center flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0 text-center w-100">${productVar.price} $</p>

                                                        <form action="AddToCartServlet" method="POST">
                                                            <input type="hidden" name="model" value="${productVar.productName}">
                                                            <input type="hidden" name="price" value="${productVar.price}">
                                                            <input type="hidden" name="imageUrl" value="${productVar.imageUrl}">
                                                            <div class="pt-3">
                                                                <% if (email != null) { %>
                                                                <button type="submit" class="btn add-to-cart border border-secondary rounded-pill px-3 text-primary" onclick="addToCart(this)">Add to Cart</button>
                                                                <% } else { %>
                                                                <button type="button" class="btn add-to-cart" disabled>Add to Cart (Login required)</button>
                                                                <% } %>  
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End tab content -->


            </div>
        </div>
        <!-- Coffee Shop End-->

        <!-- Bestsaler Product Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                    <h1 class="display-4">Bestseller Products</h1>
                </div>

                <div class="row g-4">
                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <img src="./img/hongtrasua.jpg" class="img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="col-6">
                                    <a href="#" class="h5">Hong Tra Sua</a>
                                    <div class="d-flex my-3">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">1.88 $</h4>
                                    <a href="#choose-item" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Choose This</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <img src="./img/traolongdau.jpg" class="img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="col-6">
                                    <a href="#" class="h5">Tra O Long Dau</a>
                                    <div class="d-flex my-3">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                    </div>
                                    <h4 class="mb-3">2.29 $</h4>
                                    <a href="#choose-item" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Choose This</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <img src="./img/suachuaxoaidac.jpg" class="img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="col-6">
                                    <a href="#" class="h5">Sua Chua Xoai Dac</a>
                                    <div class="d-flex my-3">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                    </div>
                                    <h4 class="mb-3">2.92 $</h4>
                                    <a href="#choose-item" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Choose This</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <img src="./img/trasuagreenhouse.png" class="img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="col-6">
                                    <a href="#" class="h5">Tra Sua Green House</a>
                                    <div class="d-flex my-3">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">1.88 $</h4>
                                    <a href="#choose-item" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Choose This</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <img src="./img/olongbachhoa.png" class="img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="col-6">
                                    <a href="#" class="h5">Tra O Long Bach Hoa</a>
                                    <div class="d-flex my-3">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">2.71 $</h4>
                                    <a href="#choose-item" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Choose This</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <img src="./img/olongcamdao.jpg" class="img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="col-6">
                                    <a href="#" class="h5">Tra O Long Cam Dao</a>
                                    <div class="d-flex my-3">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                    </div>
                                    <h4 class="mb-3">2.29 $</h4>
                                    <a href="#choose-item" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Choose This</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- Bestsaler Product End -->

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 footer-content">
            <div class="container py-5">
                <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
                    <div class="row g-4">
                        <div class="col-lg-3">
                            <a href="#">
                                <h1 class="text-primary mb-0">GreenHouse</h1>
                                <p class="text-secondary mb-0">TEA</p>
                            </a>
                        </div>
                        <div class="col-lg-6">
                            <div class="position-relative mx-auto">
                                <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="number"
                                       placeholder="Your Email">
                                <button type="submit"
                                        class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                                        style="top: 0; right: 0;">Subscribe Now</button>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="d-flex justify-content-end pt-3">
                                <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                                        class="fab fa-twitter"></i></a>
                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                                        class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                                        class="fab fa-youtube"></i></a>
                                <a class="btn btn-outline-secondary btn-md-square rounded-circle" href=""><i
                                        class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-5">
                    <div class="col-lg-5 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-3">Why People Like us!</h4>
                            <p class="mb-4">Green House Coffee is more than a café – it's a community. We’re known for our cozy atmosphere and carefully crafted coffee made from locally sourced, organic beans, with a strong commitment to sustainability.
                                <a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read More</a>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-3">Contact</h4>
                            <p>Address: Ninh Kieu, CanTho</p>
                            <p>Email: GreenHouse@gmail.com</p>
                            <p>Phone: +8409 8888 8888</p>
                            <p>Payment Accepted</p>
                            <img src="img/payment.png" class="img-fluid" alt="">
                        </div>
                    </div>   

                    <div class="col-lg-3 col-md-6">
                        <div class="footer-item about-us">
                            <h4 class="text-light mb-3">About us</h4>
                            <p class="mb-4">
                                Nguyen Hoang Anh
                                <br>
                                Khuong Bao Ngoc
                                <br>
                                Chung Ngoc Quynh
                                <br>
                                Tran Vo Anh Kiet
                                <br>
                                Le Minh Khoa
                            </p>
                        </div>
                        <style>
                            .about-us{

                            }
                        </style>
                    </div>
                </div>
            </div>
        </div>
        <style>
            .footer-content{
                height: 470px;
                width: auto;
            }
        </style>

        <!-- Footer End -->

        <!-- Copyright Start -->
        <div class="container-fluid copyright bg-dark py-4">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>GreenHouse</a>, All right reserved.</span>
                    </div>
                    <div class="col-md-6 my-auto text-center text-md-end text-white">                    
                        Designed by <a class="border-bottom" href="#">Group 1 - SE1809</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Copyright End -->



        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                class="fa fa-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="./js/controller.js"></script>
        <script>
                                                                    document.addEventListener("DOMContentLoaded", function () {
                                                                        // Show only tab-1 by default
                                                                        document.querySelector("#tab-1").classList.add("show", "active");
                                                                        document.querySelector("#tab-2").classList.remove("show", "active");
                                                                        document.querySelector("#tab-3").classList.remove("show", "active");
                                                                        document.querySelector("#tab-4").classList.remove("show", "active");

                                                                        // Add event listeners to each tab
                                                                        document.querySelector('a[href="#tab-1"]').addEventListener("click", function () {
                                                                            showTab("#tab-1");
                                                                        });
                                                                        document.querySelector('a[href="#tab-2"]').addEventListener("click", function () {
                                                                            showTab("#tab-2");
                                                                        });
                                                                        document.querySelector('a[href="#tab-3"]').addEventListener("click", function () {
                                                                            showTab("#tab-3");
                                                                        });
                                                                        document.querySelector('a[href="#tab-4"]').addEventListener("click", function () {
                                                                            showTab("#tab-4");
                                                                        });
                                                                    });

                                                                    // Function to show only the selected tab and hide others
                                                                    function showTab(tabId) {
                                                                        const tabs = ["#tab-1", "#tab-2", "#tab-3", "#tab-4"];
                                                                        tabs.forEach(function (id) {
                                                                            const tab = document.querySelector(id);
                                                                            if (id === tabId) {
                                                                                tab.classList.add("show", "active");
                                                                            } else {
                                                                                tab.classList.remove("show", "active");
                                                                            }
                                                                        });
                                                                    }



                                                                    document.addEventListener("DOMContentLoaded", function () {
                                                                        const tabs = document.querySelectorAll(".nav-item a");
                                                                        const products = document.querySelectorAll(".product-item");

                                                                        tabs.forEach(tab => {
                                                                            tab.addEventListener("click", function (e) {
                                                                                e.preventDefault();
                                                                                const category = tab.textContent.trim(); // Lấy tên của tab như "Tea", "Milk Tea"

                                                                                // Thêm class active cho tab được chọn và loại bỏ cho các tab khác
                                                                                tabs.forEach(t => t.classList.remove("active"));
                                                                                tab.classList.add("active");

                                                                                // Hiển thị hoặc ẩn sản phẩm dựa trên category
                                                                                products.forEach(product => {
                                                                                    if (category === "All Products" || product.getAttribute("data-category") === category) {
                                                                                        product.style.display = "block";
                                                                                    } else {
                                                                                        product.style.display = "none";
                                                                                    }
                                                                                });
                                                                            });
                                                                        });
                                                                    });
        </script>

    </body>
</html>

