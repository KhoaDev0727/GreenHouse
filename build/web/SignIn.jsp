<%-- 
    Document   : SignIn
    Created on : Oct 11, 2024, 2:33:52 PM
    Author     : le minh khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Green House Tea</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> <!-- Bootstrap Import -->

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

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
        <link href= "./css/StyleLogin.css" rel="stylesheet">
        <style>
            .header {
                background-color: black;
            }
            .title-header {
                align-self: end;
                padding-bottom: 10px;
            }
            .container-signin{
                width: 700px;
                height: 420px;
            }
        </style>
    </head>

    <body>
      
        <!-- Navbar start -->
        <div class="container-fluid fixed-top">
            <div class="container topbar bg-primary d-none d-lg-block">
                <div class="d-flex justify-content-between">
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#"
                                                                                                         class="text-white">Ninh Kieu, CanTho</a></small>
                        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#"
                                                                                                  class="text-white">GreenHouse@gmail.com</a></small>
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
                                <a href="#" class="nav-link" data-bs-toggle="dropdown">
                                    Options <i class="fas fa-chevron-down"></i>
                                </a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="cart.jsp" class="dropdown-item">Cart</a>
                                    <a href="checkout.jsp" class="dropdown-item">Checkout</a> 
                                    <a href="#" class="dropdown-item">Service</a>
                                </div>
                            </div>

                            <a href="contact.html" class="nav-item nav-link">Contact</a>
                        </div>                       
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
        <section class="sign-in">
            <div class="container-signin position-relative">
                <!-- Button back -->
                <div class="back-btn">
                    <a href="index.jsp" class="position-absolute top-5 start-5 btn"><i
                            class="fs-1 fa fa-arrow-circle-left"></i></a>
                </div>

                <div class="signin-content">
                    <div class="signin-image">
                        <figure><img src="./img/logo.png" alt="sign in image"></figure>
                        <a href="SignUp.jsp" class="signup-image-link">Don't have an account?</a>
                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Sign In</h2>

                        <form action="LoginServlet" method="POST" class="register-form" id="login-form">

                            <div class="form-group">
                                <label for="your_name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="email" id="email" placeholder="Your Email" 
                                       value="<%= request.getAttribute("emailValue") != null ? request.getAttribute("emailValue") : "" %>"/>

                                <% 
                                    String emailError = (String) request.getAttribute("emailError");
                                    if (emailError != null && !emailError.isEmpty()) { 
                                %>
                                <span class="text-danger"><%= emailError %></span>
                                <% 
                                    } 
                                %>

                                <% 
                                    String errorMessage = (String) request.getAttribute("errorMessage");
                                    if (errorMessage != null && !errorMessage.isEmpty()) { 
                                %>
                                <span class="text-danger"><%= errorMessage %></span>
                                <% 
                                    } 
                                %>

                            </div>

                            <div class="form-group">
                                <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="password" id="password" placeholder="Password" />

                                <% 
                                    String passwordError = (String) request.getAttribute("passwordError");
                                    if (passwordError != null && !passwordError.isEmpty()) { 
                                %>
                                <span class="text-danger"><%= passwordError %></span>
                                <% 
                                    } 
                                %>
                            </div>                                              

                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Sign In"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </section>



        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>
