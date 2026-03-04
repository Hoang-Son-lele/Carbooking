<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Dòng xe - CarBook</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { background:#f8f9fa; }
        .main-container { margin-top:100px; }
        .card { border-radius: 15px; border: none; }
        .table thead { background-color: #01d28e; color: white; }
        .header-title { color: #01d28e; font-weight: bold; }
        .btn-success { background-color: #01d28e; border: none; }
        .btn-success:hover { background-color: #01a871; }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    
    <div class="container main-container">
       
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${sessionScope.success}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <c:remove var="success" scope="session"/>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <c:remove var="error" scope="session"/>
            </div>
        </c:if>

        <div class="card p-4 shadow">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="header-title">DANH SÁCH DÒNG XE (MODEL)</h3>
                <a href="car-models?action=add" class="btn btn-success">
                    <i class="fas fa-plus-circle"></i> Thêm Mới
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover border">
                    <thead class="text-center">
                        <tr>
                            <th>ID</th>
                            <th>Hãng Xe</th>
                            <th>Tên Dòng Xe</th>
                            <th>Năm SX</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${models}" var="m">
                            <tr class="text-center">
                                <td class="align-middle">#${m.modelId}</td>
                                <td class="align-middle">
                                    <span class="badge badge-info p-2" style="font-size: 0.9rem;">
                                        ${m.brand.brandName} <%-- Lưu ý: Phải dùng m.brand.brandName --%>
                                    </span>
                                </td>
                                <td class="align-middle font-weight-bold">${m.modelName}</td>
                                <td class="align-middle">${m.year}</td>
                                <td class="align-middle">
                                    <a href="car-models?action=edit&id=${m.modelId}" class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                    <a href="car-models?action=delete&id=${m.modelId}" 
                                       class="btn btn-sm btn-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa dòng xe ${m.modelName} này không?')">
                                        <i class="fas fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty models}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">Chưa có dòng xe nào được tạo.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <%-- NÚT QUAY LẠI QUẢN LÝ XE --%>
            <div class="mt-3">
                <a href="car-management" class="btn btn-link text-secondary p-0">
                    <i class="fas fa-arrow-left"></i> Quay lại quản lý xe
                </a>
            </div>
        </div>
    </div>

   
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>