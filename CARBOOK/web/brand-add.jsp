<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Hãng Xe Mới - CarBook</title>
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
        /* Style cho alert */
        .alert { border-radius: 10px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <div class="container d-flex justify-content-center">
        <div class="form-container w-100">
            <h2 class="mb-4 text-center" style="color: #01d28e;">THÊM HÃNG XE MỚI</h2>
            
            <%-- HIỂN THỊ THÔNG BÁO LỖI NẾU CÓ --%>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Lỗi!</strong> ${sessionScope.error}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>

            <form action="brand" method="post">
                <%-- Action ẩn để Servlet biết là đang thực hiện lệnh ADD --%>
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label>Tên hãng xe:</label>
                    <input type="text" name="brandName" class="form-control" placeholder="Ví dụ: Vinfast" required>
                </div>
                
                <div class="form-group">
                    <label>Quốc gia:</label>
                    <input type="text" name="country" class="form-control" placeholder="Ví dụ: Vietnam" required>
                </div>
                
                <div class="form-group">
                    <label>Link Logo (URL):</label>
                    <input type="text" name="logoURL" class="form-control" placeholder="Dán link ảnh tại đây...">
                </div>
                
                <div class="mt-4">
                    <button type="submit" class="btn btn-save btn-block py-3">Lưu Hãng Xe</button>
                    <a href="brand?action=list" class="btn btn-secondary btn-block py-3">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>