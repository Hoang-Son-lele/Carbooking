<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Sửa Hãng Xe</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>.container { margin-top: 120px; max-width: 500px; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }</style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    <div class="container">
        <h3 class="text-center mb-4">CHỈNH SỬA HÃNG XE</h3>
        <form action="brand" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="brandId" value="${brand.brandId}">
            
            <div class="form-group">
                <label>Tên hãng:</label>
                <input type="text" name="brandName" class="form-control" value="${brand.brandName}" required>
            </div>
            <div class="form-group">
                <label>Quốc gia:</label>
                <input type="text" name="country" class="form-control" value="${brand.country}" required>
            </div>
            <div class="form-group">
                <label>Link Logo:</label>
                <input type="text" name="logoURL" class="form-control" value="${brand.logoURL}">
            </div>
            <button type="submit" class="btn btn-success btn-block mt-4">Cập nhật</button>
            <a href="brand?action=list" class="btn btn-secondary btn-block">Hủy</a>
        </form>
    </div>
</body>
</html>