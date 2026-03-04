package controller;

import dal.CarModelDAO;
import dal.CarBrandDAO;
import model.CarModel;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import com.google.gson.Gson; // Đảm bảo bạn đã add thư viện GSON vào Project

@WebServlet(name = "CarModelServlet", urlPatterns = {"/car-models"})
public class CarModelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        CarModelDAO modelDAO = new CarModelDAO();
        CarBrandDAO brandDAO = new CarBrandDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            String action = request.getParameter("action");

            if ("getByBrand".equals(action)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                    int brandId = Integer.parseInt(request.getParameter("brandId"));
                    List<CarModel> list = modelDAO.getModelsByBrandId(brandId);
                    
                    Gson gson = new Gson();
                    String json = gson.toJson(list);
                    
                    PrintWriter out = response.getWriter();
                    out.print(json);
                    out.flush();
                } catch (Exception e) {
                    response.getWriter().print("[]");
                }
                return; 
            }
          

            if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
                response.sendRedirect("home");
                return;
            }

            if ("add".equals(action)) {
                request.setAttribute("brands", brandDAO.getAllBrands());
                request.getRequestDispatcher("/model-add.jsp").forward(request, response);
            } 
            else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("model", modelDAO.getModelById(id));
                request.setAttribute("brands", brandDAO.getAllBrands());
                request.getRequestDispatcher("/model-edit.jsp").forward(request, response);
            } 
            else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (modelDAO.deleteModel(id)) {
                    session.setAttribute("success", "Xóa dòng xe thành công!");
                } else {
                    session.setAttribute("error", "Xóa thất bại!");
                }
                response.sendRedirect("car-models");
            } 
            else {
                request.setAttribute("models", modelDAO.getAllModels());
                request.getRequestDispatcher("/model-list.jsp").forward(request, response);
            }
        } finally {
            modelDAO.closeConnection();
            brandDAO.closeConnection();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        CarModelDAO modelDAO = new CarModelDAO();
        CarBrandDAO brandDAO = new CarBrandDAO();
        HttpSession session = request.getSession();
        
        int currentYear = LocalDate.now().getYear();

        try {
            String action = request.getParameter("action");
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            String name = request.getParameter("modelName");
            int year = Integer.parseInt(request.getParameter("year"));

            if (year > currentYear) {
                request.setAttribute("error", "Năm sản xuất (" + year + ") không được lớn hơn năm hiện tại (" + currentYear + ")");
                request.setAttribute("brands", brandDAO.getAllBrands());
                
                if ("create".equals(action)) {
                    request.getRequestDispatcher("/model-add.jsp").forward(request, response);
                } else {
                    int modelId = Integer.parseInt(request.getParameter("modelId"));
                    request.setAttribute("model", modelDAO.getModelById(modelId));
                    request.getRequestDispatcher("/model-edit.jsp").forward(request, response);
                }
                return; 
            }

            if ("create".equals(action)) {
                CarModel m = new CarModel(0, brandId, name, year);
                if (modelDAO.createModel(m)) {
                    session.setAttribute("success", "Thêm dòng xe mới thành công!");
                }
            } 
            else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("modelId"));
                CarModel m = new CarModel(id, brandId, name, year);
                if (modelDAO.updateModel(m)) {
                    session.setAttribute("success", "Cập nhật thành công!");
                }
            }
            response.sendRedirect("car-models");
            
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("car-models");
        } finally {
            modelDAO.closeConnection();
            brandDAO.closeConnection();
        }
    }
}