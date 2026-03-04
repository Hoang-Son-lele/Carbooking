package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * RegisterServlet - Handles user registration
 * @author
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Get form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String driverLicenseNumber = request.getParameter("driverLicenseNumber");
        String driverLicenseExpiryStr = request.getParameter("driverLicenseExpiry");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate password strength
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        
        // Check if username exists
        if (userDAO.isUsernameExists(username.trim())) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check if email exists
        if (userDAO.isEmailExists(email.trim())) {
            request.setAttribute("error", "Email đã được sử dụng");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPasswordHash(password); // Will be hashed in DAO
        user.setFullName(fullName.trim());
        user.setPhoneNumber(phoneNumber != null ? phoneNumber.trim() : null);
        user.setAddress(address != null ? address.trim() : null);
        
        // Parse dates
        try {
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                user.setDateOfBirth(Date.valueOf(dateOfBirthStr));
            }
            if (driverLicenseExpiryStr != null && !driverLicenseExpiryStr.isEmpty()) {
                user.setDriverLicenseExpiry(Date.valueOf(driverLicenseExpiryStr));
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Định dạng ngày không hợp lệ");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        user.setDriverLicenseNumber(driverLicenseNumber != null ? driverLicenseNumber.trim() : null);
        
        // Register user
        boolean success = userDAO.register(user);
        
        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại");
            setFormData(request, username, email, fullName, phoneNumber, address, 
                       dateOfBirthStr, driverLicenseNumber, driverLicenseExpiryStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    private void setFormData(HttpServletRequest request, String username, String email, 
                            String fullName, String phoneNumber, String address,
                            String dateOfBirth, String driverLicenseNumber, 
                            String driverLicenseExpiry) {
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("address", address);
        request.setAttribute("dateOfBirth", dateOfBirth);
        request.setAttribute("driverLicenseNumber", driverLicenseNumber);
        request.setAttribute("driverLicenseExpiry", driverLicenseExpiry);
    }

    @Override
    public String getServletInfo() {
        return "Registration Servlet for CARBOOK";
    }
}
