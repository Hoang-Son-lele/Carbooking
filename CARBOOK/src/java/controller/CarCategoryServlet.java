package controller;

import dal.CarCategoryDAO;
import model.CarCategory;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name="CarCategoryServlet", urlPatterns={"/car-category"})
public class CarCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        CarCategoryDAO dao = new CarCategoryDAO();

       
        if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
            response.sendRedirect("home");
            return;
        }

        if (action == null || "list".equals(action)) {
            request.setAttribute("categories", dao.getAllCategories());
            request.getRequestDispatcher("/category-list.jsp").forward(request, response);
        } 
        else if ("add".equals(action)) {
            request.getRequestDispatcher("/category-add.jsp").forward(request, response);
        }
        else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("category", dao.getCategoryById(id));
            request.getRequestDispatcher("/category-edit.jsp").forward(request, response);
        }
        else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
          
            if (dao.isCategoryInUse(id)) {
                session.setAttribute("error", "Không thể xóa danh mục đang có xe sử dụng!");
            } else {
                dao.deleteCategory(id);
                session.setAttribute("success", "Xóa danh mục thành công!");
            }
            response.sendRedirect("car-category?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CarCategoryDAO dao = new CarCategoryDAO();
        HttpSession session = request.getSession();
        
        String name = request.getParameter("categoryName");
        String description = request.getParameter("description");

        CarCategory c = new CarCategory();
        c.setCategoryName(name);
        c.setDescription(description);

        if ("add".equals(action)) {
            if(dao.createCategory(c)) {
                session.setAttribute("success", "Thêm danh mục mới thành công!");
            } else {
                session.setAttribute("error", "Lỗi khi thêm danh mục.");
            }
        } else if ("edit".equals(action)) {
            c.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            if(dao.updateCategory(c)) {
                session.setAttribute("success", "Cập nhật danh mục thành công!");
            } else {
                session.setAttribute("error", "Lỗi khi cập nhật danh mục.");
            }
        }
        response.sendRedirect("car-category?action=list");
    }
}