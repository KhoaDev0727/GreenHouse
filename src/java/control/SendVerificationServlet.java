package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;

public class SendVerificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Tạo mã xác minh ngẫu nhiên 6 chữ số
    private String generateVerificationCode() {
        SecureRandom random = new SecureRandom();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null || session.getAttribute("fullName") == null) {
            response.sendRedirect("SignIn.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String fullName = (String) session.getAttribute("fullName");
        String verificationCode = generateVerificationCode();

        // Tạo thời gian hết hạn (2 phút)
        long currentTime = System.currentTimeMillis();
        long expiryTime = currentTime + (2 * 60 * 1000);
        // Lưu mã xác minh và thời gian hết hạn vào session
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("codeExpiryTime", expiryTime);

        String subject = "Login Verification Code - GreenHouse";
        String bannerImageURL = "https://i.imgur.com/3IeRp25.jpeg";
        String logoImageURL = "https://i.imgur.com/mP36lVN.png";

        String body = "<html>"
                + "<body style='font-family: Arial, sans-serif; text-align: center;'>"
                + "<div style='padding: 10px;'>"
                + "<img src='" + bannerImageURL + "' alt='GreenHouse Banner' style='width: 100%; max-width: 950px; border-bottom: 1px solid grey;'>"
                + "</div>"
                + "<div style='padding: 10px;'>"
                + "<img src='" + logoImageURL + "' alt='GreenHouse Logo' style='width: 50px;'>"
                + "</div>"
                + "<p>Dear " + fullName + ",</p>"
                + "<p>You requested a verification code to log into your account at GreenHouse Tea. Please use the verification code below to complete your login process:</p>"
                + "<h2>Your new verification code: " + verificationCode + "</h2>"
                + "<p>Please enter this code on the login page to confirm your account. Note that this verification code will expire after 2 minutes.</p>"
                + "<p>If you did not request this verification code, please ignore this email.</p>"
                + "<br>"
                + "<p>Best regards,</p>"
                + "<p>GreenHouse Tea Support Team</p>"
                + "<p>GreenHouseTea99@gmail.com | 0888888888</p>"
                + "<p>GreenHouseTea.vn</p>"
                + "</body>"
                + "</html>";


        try {
            EmailUtility.sendEmail(email, subject, body);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "The verification email could not be sent. Please try again later.");
            request.getRequestDispatcher("SignIn.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("Verification.jsp");
    }
}
