<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Sửa Danh Mục Xe - CarBook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .container { 
            margin-top: 120px; 
            max-width: 500px; 
            background: #fff; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0 0 10px rgba(0,0,0,0.1); 
        }
        .btn-update { background-color: #01d28e; border: none; color: white; }
        .btn-update:hover { background-color: #01a871; color: white; }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    <div class="container">
        <h3 class="text-center mb-4" style="color: #01d28e;">CHỈNH SỬA DANH MỤC</h3>
        
      
        <form action="car-category" method="post">
            
            <input type="hidden" name="action" value="edit">
            
            <input type="hidden" name="categoryId" value="${category.categoryId}">
            
            <div class="form-group">
                <label>Tên danh mục:</label>
                <input type="text" name="categoryName" class="form-control" 
                       value="${category.categoryName}" required>
            </div>
            
            <div class="form-group">
                <label>Mô tả:</label>
              
                <textarea name="description" class="form-control" rows="4">${category.description}</textarea>
            </div>
            
            <button type="submit" class="btn btn-update btn-block mt-4">Cập nhật danh mục</button>
            <a href="car-category?action=list" class="btn btn-secondary btn-block">Hủy</a>
        </form>
    </div>
</body>
</html>