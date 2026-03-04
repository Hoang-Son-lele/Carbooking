<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Danh Mục Xe - CarBook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .main-container { margin-top: 100px; padding: 30px; background: #fff; border-radius: 15px; box-shadow: 0 0 20px rgba(0,0,0,0.05); }
        .table thead { background-color: #01d28e; color: white; }
        .btn-add { background-color: #01d28e; color: white; border-radius: 5px; padding: 10px 20px; font-weight: bold; }
        .btn-add:hover { background-color: #01a871; color: white; }
        .action-btns a { margin-right: 5px; }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <div class="container main-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: #333;">DANH SÁCH DANH MỤC XE</h2>
            <a href="car-category?action=add" class="btn btn-add">
                <i class="fas fa-plus-circle"></i> Thêm Danh Mục Mới
            </a>
        </div>

    
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show">
                ${sessionScope.success}
                <c:remove var="success" scope="session"/>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${sessionScope.error}
                <c:remove var="error" scope="session"/>
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table table-hover border">
                <thead>
                    <tr class="text-center">
                        <th>ID</th>
                        <th>Tên Danh Mục</th>
                        <th>Mô Tả</th>
                        <th>Ngày Tạo</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="cat">
                        <tr>
                            <td class="text-center font-weight-bold">${cat.categoryId}</td>
                            <td style="min-width: 150px;">
                                <span class="badge badge-info p-2">${cat.categoryName}</span>
                            </td>
                            <td>${cat.description}</td>
                            <td class="text-center">${cat.createdAt}</td>
                            <td class="text-center action-btns" style="min-width: 150px;">
                               
                                <a href="car-category?action=edit&id=${cat.categoryId}" 
                                   class="btn btn-sm btn-outline-warning" title="Sửa">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                            
                                <a href="car-category?action=delete&id=${cat.categoryId}" 
                                   class="btn btn-sm btn-outline-danger" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')" title="Xóa">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty categories}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">Chưa có danh mục nào được tạo.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <div class="mt-3">
            <a href="car-management" class="btn btn-link text-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại quản lý xe
            </a>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>