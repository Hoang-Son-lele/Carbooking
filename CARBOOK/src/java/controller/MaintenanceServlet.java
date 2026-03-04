package controller;

import dal.MaintenanceRecordDAO;
import dal.CarDAO;
import model.MaintenanceRecord;
import model.Car;
import model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * MaintenanceServlet - Handles maintenance record management
 */
@WebServlet(name = "MaintenanceServlet", urlPatterns = {"/maintenance"})
public class MaintenanceServlet extends HttpServlet {

    private MaintenanceRecordDAO maintenanceDAO = new MaintenanceRecordDAO();
    private CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listMaintenance(request, response);
                break;
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteMaintenance(request, response);
                break;
            case "complete":
                completeMaintenance(request, response);
                break;
            default:
                listMaintenance(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createMaintenance(request, response, user);
        } else if ("update".equals(action)) {
            updateMaintenance(request, response, user);
        }
    }

    private void listMaintenance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String status = request.getParameter("status");
        String carIdStr = request.getParameter("carId");
        
        List<MaintenanceRecord> maintenanceList;
        Car car = null;
        
        if (carIdStr != null && !carIdStr.isEmpty()) {
            // Get maintenance for specific car
            int carId = Integer.parseInt(carIdStr);
            car = carDAO.getCarById(carId);
            maintenanceList = maintenanceDAO.getMaintenanceByCarId(carId);
            request.setAttribute("car", car);
        } else if (status != null && !status.isEmpty()) {
            // Filter by status
            maintenanceList = maintenanceDAO.getMaintenanceByStatus(status);
        } else {
            // Get all maintenance records
            maintenanceList = maintenanceDAO.getAllMaintenanceRecords();
        }
        
        request.setAttribute("maintenanceList", maintenanceList);
        request.setAttribute("carDAO", carDAO);
        request.getRequestDispatcher("maintenance-records.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String carIdStr = request.getParameter("carId");
        
        // Get all cars for selection
        List<Car> cars = carDAO.getAllCars();
        request.setAttribute("cars", cars);
        
        // If carId is provided, pre-select it
        if (carIdStr != null && !carIdStr.isEmpty()) {
            int carId = Integer.parseInt(carIdStr);
            Car car = carDAO.getCarById(carId);
            request.setAttribute("selectedCar", car);
        }
        
        request.getRequestDispatcher("maintenance-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int maintenanceId = Integer.parseInt(request.getParameter("id"));
        
        MaintenanceRecord maintenance = maintenanceDAO.getMaintenanceById(maintenanceId);
        
        if (maintenance == null) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Không tìm thấy lịch bảo trì!");
            response.sendRedirect("maintenance");
            return;
        }
        
        // Get all cars for selection
        List<Car> cars = carDAO.getAllCars();
        Car car = carDAO.getCarById(maintenance.getCarId());
        
        request.setAttribute("maintenance", maintenance);
        request.setAttribute("car", car);
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("maintenance-form.jsp").forward(request, response);
    }

    private void createMaintenance(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        try {
            MaintenanceRecord maintenance = new MaintenanceRecord();
            
            // Get form parameters
            int carId = Integer.parseInt(request.getParameter("carId"));
            String maintenanceType = request.getParameter("maintenanceType");
            String description = request.getParameter("description");
            String serviceProvider = request.getParameter("serviceProvider");
            String serviceDateStr = request.getParameter("serviceDate");
            String serviceCostStr = request.getParameter("serviceCost");
            String nextServiceDateStr = request.getParameter("nextServiceDate");
            String status = request.getParameter("status");
            String notes = request.getParameter("notes");
            
            // Set values
            maintenance.setCarId(carId);
            maintenance.setMaintenanceType(maintenanceType);
            maintenance.setDescription(description);
            maintenance.setServiceProvider(serviceProvider);
            
            // Convert date strings to appropriate types
            if (serviceDateStr != null && !serviceDateStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = sdf.parse(serviceDateStr);
                maintenance.setServiceDate(new Timestamp(date.getTime()));
            }
            
            if (serviceCostStr != null && !serviceCostStr.isEmpty()) {
                maintenance.setServiceCost(new BigDecimal(serviceCostStr));
            }
            
            if (nextServiceDateStr != null && !nextServiceDateStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = sdf.parse(nextServiceDateStr);
                maintenance.setNextServiceDate(new Date(date.getTime()));
            }
            
            maintenance.setStatus(status);
            maintenance.setNotes(notes);
            maintenance.setPerformedBy(user.getUserId());
            
            // Create maintenance record
            int result = maintenanceDAO.createMaintenance(maintenance);
            
            HttpSession session = request.getSession();
            if (result > 0) {
                session.setAttribute("success", "Thêm lịch bảo trì thành công!");
                response.sendRedirect("maintenance?carId=" + carId);
            } else {
                session.setAttribute("error", "Không thể thêm lịch bảo trì!");
                response.sendRedirect("maintenance?action=create&carId=" + carId);
            }
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("maintenance?action=create");
        }
    }

    private void updateMaintenance(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        try {
            int maintenanceId = Integer.parseInt(request.getParameter("maintenanceId"));
            
            MaintenanceRecord maintenance = maintenanceDAO.getMaintenanceById(maintenanceId);
            
            if (maintenance == null) {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Không tìm thấy lịch bảo trì!");
                response.sendRedirect("maintenance");
                return;
            }
            
            // Get form parameters
            int carId = Integer.parseInt(request.getParameter("carId"));
            String maintenanceType = request.getParameter("maintenanceType");
            String description = request.getParameter("description");
            String serviceProvider = request.getParameter("serviceProvider");
            String serviceDateStr = request.getParameter("serviceDate");
            String serviceCostStr = request.getParameter("serviceCost");
            String nextServiceDateStr = request.getParameter("nextServiceDate");
            String status = request.getParameter("status");
            String notes = request.getParameter("notes");
            
            // Update values
            maintenance.setCarId(carId);
            maintenance.setMaintenanceType(maintenanceType);
            maintenance.setDescription(description);
            maintenance.setServiceProvider(serviceProvider);
            
            // Convert date strings
            if (serviceDateStr != null && !serviceDateStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = sdf.parse(serviceDateStr);
                maintenance.setServiceDate(new Timestamp(date.getTime()));
            }
            
            if (serviceCostStr != null && !serviceCostStr.isEmpty()) {
                maintenance.setServiceCost(new BigDecimal(serviceCostStr));
            } else {
                maintenance.setServiceCost(null);
            }
            
            if (nextServiceDateStr != null && !nextServiceDateStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = sdf.parse(nextServiceDateStr);
                maintenance.setNextServiceDate(new Date(date.getTime()));
            } else {
                maintenance.setNextServiceDate(null);
            }
            
            maintenance.setStatus(status);
            maintenance.setNotes(notes);
            maintenance.setPerformedBy(user.getUserId());
            
            // Update maintenance record
            boolean result = maintenanceDAO.updateMaintenance(maintenance);
            
            HttpSession session = request.getSession();
            if (result) {
                session.setAttribute("success", "Cập nhật lịch bảo trì thành công!");
            } else {
                session.setAttribute("error", "Không thể cập nhật lịch bảo trì!");
            }
            
            response.sendRedirect("maintenance?carId=" + carId);
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("maintenance");
        }
    }

    private void deleteMaintenance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int maintenanceId = Integer.parseInt(request.getParameter("id"));
            String carIdStr = request.getParameter("carId");
            
            boolean result = maintenanceDAO.deleteMaintenance(maintenanceId);
            
            HttpSession session = request.getSession();
            if (result) {
                session.setAttribute("success", "Xóa lịch bảo trì thành công!");
            } else {
                session.setAttribute("error", "Không thể xóa lịch bảo trì!");
            }
            
            if (carIdStr != null && !carIdStr.isEmpty()) {
                response.sendRedirect("maintenance?carId=" + carIdStr);
            } else {
                response.sendRedirect("maintenance");
            }
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("maintenance");
        }
    }

    private void completeMaintenance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int maintenanceId = Integer.parseInt(request.getParameter("id"));
            String carIdStr = request.getParameter("carId");
            
            boolean result = maintenanceDAO.updateMaintenanceStatus(maintenanceId, "Completed");
            
            HttpSession session = request.getSession();
            if (result) {
                session.setAttribute("success", "Đã đánh dấu hoàn thành!");
            } else {
                session.setAttribute("error", "Không thể cập nhật trạng thái!");
            }
            
            if (carIdStr != null && !carIdStr.isEmpty()) {
                response.sendRedirect("maintenance?carId=" + carIdStr);
            } else {
                response.sendRedirect("maintenance");
            }
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("maintenance");
        }
    }
}
