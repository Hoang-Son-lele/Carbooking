<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Dòng Xe - CarBook</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        .error-text { color: #dc3545; font-size: 14px; margin-top: 5px; font-weight: 500; }
        .is-invalid { border-color: #dc3545 !important; }
    </style>
</head>
<body style="background:#f8f9fa;">
    <%@ include file="includes/navbar.jsp" %>
    
    <div class="container" style="margin-top:120px; max-width: 600px;">
        <div class="card shadow p-4 border-0" style="border-radius: 15px;">
            <h3 class="text-center mb-4" style="color: #01d28e;">THÊM DÒNG XE MỚI</h3>
            
            <form action="car-models" method="post">
                <input type="hidden" name="action" value="create">

                <div class="form-group mb-3">
                    <label class="font-weight-bold">Hãng Xe:</label>
                    <select name="brandId" class="form-control" required>
                        <option value="">-- Chọn hãng xe --</option>
                        <c:forEach items="${brands}" var="b">
                            <option value="${b.brandId}" ${param.brandId == b.brandId ? 'selected' : ''}>
                                ${b.brandName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group mb-3">
                    <label class="font-weight-bold">Tên Dòng Xe:</label>
                    <input type="text" name="modelName" class="form-control" 
                           value="${param.modelName}" placeholder="Ví dụ: Camry" required>
                </div>

                <div class="form-group mb-4">
                    <label class="font-weight-bold">Năm Sản Xuất:</label>
                    <%-- Nếu có lỗi, input sẽ có class is-invalid của Bootstrap --%>
                    <input type="number" name="year" 
                           class="form-control ${not empty error ? 'is-invalid' : ''}" 
                           value="${param.year}" placeholder="Ví dụ: 2024" required>
                    
           
                    <c:if test="${not empty error}">
                        <div class="error-text">
                            <i class="fas fa-exclamation-triangle"></i> ${error}
                        </div>
                    </c:if>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success btn-block py-2" style="background: #01d28e; border: none;">
                        Lưu Dòng Xe
                    </button>
                    <a href="car-models" class="btn btn-secondary btn-block py-2">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>