package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class VerifyCodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String enteredCode = request.getParameter("code");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("verificationCode") == null || session.getAttribute("codeExpiryTime") == null) {
            response.sendRedirect("SignIn.jsp");
            return;
        }

        String actualCode = (String) session.getAttribute("verificationCode");
        Long expiryTime = (Long) session.getAttribute("codeExpiryTime");
        long currentTime = System.currentTimeMillis();

        if (currentTime > expiryTime) {
            // Mã đã hết hạn
            session.removeAttribute("verificationCode");
            session.removeAttribute("codeExpiryTime");
            request.setAttribute("errorMessage", "Verification code has expired. Please resend a new code.");
            request.getRequestDispatcher("Verification.jsp").forward(request, response);
            return;
        }

        if (enteredCode != null && enteredCode.equals(actualCode)) {
            // Xác thực thành công, loại bỏ mã xác minh khỏi session
            session.removeAttribute("verificationCode");
            session.removeAttribute("codeExpiryTime");
            session.setAttribute("isVerified", true);
            
            response.sendRedirect("index.jsp");
        } else {
            // Xác thực thất bại, nhưng không đặt lại thời gian hết hạn
            request.setAttribute("errorMessage", "Verification code is incorrect or empty. Please try again.");
            request.getRequestDispatcher("Verification.jsp").forward(request, response);
        }
    }
}
