package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * UserManagementServlet - Admin user management
 * @author
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/admin/users"})
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../login?redirect=admin/users");
            return;
        }
        
        // TODO: Check if user has admin role
        
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();
        
        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            List<User> users = userDAO.searchUsers(keyword);
            request.setAttribute("users", users);
            request.setAttribute("keyword", keyword);
        } else if ("view".equals(action)) {
            String userIdStr = request.getParameter("id");
            try {
                int userId = Integer.parseInt(userIdStr);
                User user = userDAO.getUserById(userId);
                request.setAttribute("viewUser", user);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID người dùng không hợp lệ");
            }
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
        } else {
            // List all users
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
        }
        
        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../login?redirect=admin/users");
            return;
        }
        
        // TODO: Check if user has admin role
        
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");
        
        if (userIdStr == null || userIdStr.isEmpty()) {
            response.sendRedirect("users?error=invalidId");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            boolean success = false;
            
            switch (action) {
                case "activate":
                    success = userDAO.setUserActiveStatus(userId, true);
                    break;
                case "deactivate":
                    success = userDAO.setUserActiveStatus(userId, false);
                    break;
                case "delete":
                    success = userDAO.deleteUser(userId);
                    break;
                case "permanentDelete":
                    success = userDAO.permanentDeleteUser(userId);
                    break;
                default:
                    response.sendRedirect("users?error=invalidAction");
                    return;
            }
            
            if (success) {
                response.sendRedirect("users?success=" + action);
            } else {
                response.sendRedirect("users?error=" + action);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("users?error=invalidId");
        }
    }

    @Override
    public String getServletInfo() {
        return "User Management Servlet for CARBOOK Admin";
    }
}
