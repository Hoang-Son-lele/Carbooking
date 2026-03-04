<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Dòng Xe - CarBook</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body { background-color: #f4f7f6; }
        .container { margin-top: 100px; }
        .card { border-radius: 15px; border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .btn-update { background-color: #ffc107; color: #212529; border: none; font-weight: 600; }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card p-4">
                    <h2 class="text-center mb-4">Chỉnh Sửa Dòng Xe</h2>
                    <form action="car-models" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="modelId" value="${model.modelId}">

                        <div class="form-group mb-3">
                            <label class="font-weight-bold">Hãng Xe:</label>
                            <select name="brandId" class="form-control" required>
                                <c:forEach items="${brands}" var="b">
                                    <option value="${b.brandId}" ${b.brandId == model.brandId ? 'selected' : ''}>
                                        ${b.brandName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group mb-3">
                            <label class="font-weight-bold">Tên Dòng Xe:</label>
                            <input type="text" name="modelName" class="form-control" value="${model.modelName}" required>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold">Năm Sản Xuất:</label>
                            <input type="number" name="year" class="form-control" value="${model.year}" required>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="car-models" class="btn btn-outline-secondary">Hủy bỏ</a>
                            <button type="submit" class="btn btn-update px-4">Cập Nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>