package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.GoogleAccount;
import controller.GoogleLogin;
/**
 * LoginServlet - Handles user login
 * @author
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        HttpSession session = request.getSession();
if (session != null && session.getAttribute("user") != null) {
    response.sendRedirect("home");
    return;
}
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        // log gg
        if (code != null && !code.isEmpty()) {
               try {
        String accessToken = GoogleLogin.getToken(code);
        GoogleAccount acc = GoogleLogin.getUserInfo(accessToken);
        String googleId = acc.getId();
        String email = acc.getEmail();
        String fullName = acc.getName();

        UserDAO dao = new UserDAO();
        User user = dao.getUserByGoogleId(googleId);

        if (user == null) {
            user = dao.getUserByEmail(email);

            if (user != null) {
                dao.updateGoogleId(user.getUserId(), googleId);
            } else {
                User newUser = new User();
                newUser.setUsername(email); 
                newUser.setEmail(email);
                newUser.setFullName(fullName);
                newUser.setGoogleId(googleId);

                dao.insertGoogleUser(newUser);
            }
            user = dao.getUserByGoogleId(googleId);
        }

        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("fullName", user.getFullName());

        response.sendRedirect("home");
        return;

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp?error=google_login_failed");
    }
    
} else {
        // Forward to login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
          
    String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(username.trim(), password);
        
        if (user == null) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
            request.setAttribute("username", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (!user.isActive()) {
            request.setAttribute("error", "Tài khoản đã bị khóa. Vui lòng liên hệ admin");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Login successful
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            
            // Redirect to home or requested page
            String redirectUrl = request.getParameter("redirect");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect("home");
            }
        }


        
       
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet for CARBOOK";
    }
}
