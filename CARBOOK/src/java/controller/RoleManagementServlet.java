package controller;

import dal.RoleDAO;
import model.Role;
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
 * RoleManagementServlet - Handles role management (Admin only)
 */
@WebServlet(name = "RoleManagementServlet", urlPatterns = {"/role-management"})
public class RoleManagementServlet extends HttpServlet {

    private RoleDAO roleDAO = new RoleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Only admin can access
        if (user == null || user.getRoleId() != 1) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listRoles(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRole(request, response);
                break;
            default:
                listRoles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Only admin can access
        if (user == null || user.getRoleId() != 1) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createRole(request, response);
        } else if ("update".equals(action)) {
            updateRole(request, response);
        }
    }

    private void listRoles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Role> roles = roleDAO.getAllRoles();
        
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("role-management.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("role-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int roleId = Integer.parseInt(request.getParameter("id"));
        Role role = roleDAO.getRoleById(roleId);
        
        if (role == null) {
            request.setAttribute("error", "Không tìm thấy vai trò");
            response.sendRedirect("role-management");
            return;
        }
        
        request.setAttribute("role", role);
        request.getRequestDispatcher("role-form.jsp").forward(request, response);
    }

    private void createRole(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String roleName = request.getParameter("roleName");
            String description = request.getParameter("description");
            
            Role role = new Role();
            role.setRoleName(roleName);
            role.setDescription(description);
            
            if (roleDAO.createRole(role)) {
                request.setAttribute("success", "Thêm vai trò thành công");
                response.sendRedirect("role-management");
            } else {
                request.setAttribute("error", "Lỗi khi thêm vai trò");
                showAddForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showAddForm(request, response);
        }
    }

    private void updateRole(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            String roleName = request.getParameter("roleName");
            String description = request.getParameter("description");
            
            Role role = new Role();
            role.setRoleId(roleId);
            role.setRoleName(roleName);
            role.setDescription(description);
            
            if (roleDAO.updateRole(role)) {
                request.setAttribute("success", "Cập nhật vai trò thành công");
                response.sendRedirect("role-management");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật vai trò");
                showEditForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deleteRole(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int roleId = Integer.parseInt(request.getParameter("id"));
        
        // Prevent deleting system roles
        if (roleId <= 4) {
            request.setAttribute("error", "Không thể xóa vai trò hệ thống");
            response.sendRedirect("role-management");
            return;
        }
        
        if (roleDAO.deleteRole(roleId)) {
            request.setAttribute("success", "Xóa vai trò thành công");
        } else {
            request.setAttribute("error", "Lỗi khi xóa vai trò");
        }
        
        response.sendRedirect("role-management");
    }
}
