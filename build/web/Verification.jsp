<%-- 
    Document   : Verification
    Created on : Oct 7, 2024, 8:58:34 PM
    Author     : le minh khoa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Email Verification</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Teko:700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">  
        <style>
            /* Header styling */
            .header {
                background-color: #52c23b;
                color: #f8f9fa;
                padding: 20px;
                text-align: center;
                font-family: 'Lobster', cursive;
                border-bottom: 3px solid #d2691e; /* Darker border for emphasis */
            }

            .header h1 {
                font-size: 2.5em;
                margin: 0;
                letter-spacing: 1px;
                text-shadow: 2px 2px #654321; /* Shadow for depth */
            }

            .title-animation {
                animation: fadeIn 1.5s ease-in-out;
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            /* Container and form styling */
            .container {
                max-width: 500px;
                margin-top: 40px;
                background-color: #fffaf0;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            /* Button and text styling */
            .btn-primary {
                background-color: #8B4513;
                border: none;
            }

            .btn-link {
                color: #8B4513;
            }

            .timer {
                text-align: center;
                margin-top: 15px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1 class="title-animation">GreenHouse Tea</h1>
        </div>
        <div class="container">
            <h3 class="text-center">Email Verification</h3>
            <form action="VerifyCodeServlet" method="POST">
                <div class="mb-3">
                    <label for="code" class="form-label">Verification Code</label>
                    <input type="text" class="form-control" id="code" name="code" placeholder="Enter verification code">
                    <% 
                       String errorMessage = (String) request.getAttribute("errorMessage");
                       if (errorMessage != null) { %>
                    <div class="text-danger mt-2"><%= errorMessage %></div>
                    <% } %>
                </div>
                <button type="submit" class="btn btn-primary">Verify</button>
            </form>
            <form action="ResendVerificationServlet" method="POST" class="resend-btn">
                <button type="submit" class="btn btn-link">Resend Verification Code</button>
            </form>
            <div class="timer">
                Remaining time: <span id="time">02:00</span>
            </div>
            <div class="mt-3">
                <button class="btn btn-secondary" onclick="location.href = 'SignIn.jsp'">Back to Sign In</button>
            </div>
        </div>

        <script>
            function startTimer(duration, display) {
                var timer = duration, minutes, seconds;
                var countdown = setInterval(function () {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.textContent = minutes + ":" + seconds;

                    if (--timer < 0) {
                        clearInterval(countdown);
                        display.textContent = "Code has expired.";
                    }
                }, 1000);
            }

            window.onload = function () {
            <% 
                    if (session != null && session.getAttribute("codeExpiryTime") != null) {
                        long expiryTime = (Long) session.getAttribute("codeExpiryTime");
                        long currentTime = System.currentTimeMillis();
                        long remainingTime = (expiryTime - currentTime) / 1000;
                        if (remainingTime < 0) {
                            remainingTime = 0;
                        }
            %>
                var duration = <%= remainingTime %>;
                var display = document.querySelector('#time');
                startTimer(duration, display);
            <% 
                    } else { 
            %>
                // Đặt lại thời gian 2 phút nếu không có thời gian hết hạn
                session.setAttribute("codeExpiryTime", System.currentTimeMillis() + 120 * 1000);
                var duration = 120;
                var display = document.querySelector('#time');
                startTimer(duration, display);
            <% 
                    }
            %>
            };
        </script>
    </body>
</html>