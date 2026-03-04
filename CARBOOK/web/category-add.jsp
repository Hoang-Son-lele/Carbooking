<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Danh Mục Xe Mới - CarBook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background-color: #f8f9fa; }
        .form-container { 
            margin-top: 120px; 
            background: #fff; 
            padding: 40px; 
            border-radius: 15px; 
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            max-width: 600px;
        }
        .btn-save { background-color: #01d28e; border: none; color: white; }
        .btn-save:hover { background-color: #01a871; color: white; }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <div class="container d-flex justify-content-center">
        <div class="form-container w-100">
            <h2 class="mb-4 text-center" style="color: #01d28e;">THÊM DANH MỤC XE MỚI</h2>
            
          
            <form action="car-category" method="post">
              
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label>Tên danh mục:</label>
                  
                    <input type="text" name="categoryName" class="form-control" placeholder="Ví dụ: Sedan, SUV, Xe điện..." required>
                </div>
                
                <div class="form-group">
                    <label>Mô tả danh mục:</label>
                    
                    <textarea name="description" class="form-control" rows="4" placeholder="Mô tả đặc điểm của loại xe này..."></textarea>
                </div>
                
                <div class="mt-4">
                    <button type="submit" class="btn btn-save btn-block py-3">Lưu Danh Mục</button>
               
                    <a href="car-category?action=list" class="btn btn-secondary btn-block py-3">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>