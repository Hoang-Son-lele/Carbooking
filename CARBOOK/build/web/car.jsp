<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Xe cho thuê - CarBook</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="css/aos.css">

    <link rel="stylesheet" href="css/ionicons.min.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/style.css">
  </head>
  <body>
    
	 	  <%@ include file="includes/navbar.jsp" %>
    <!-- END nav -->
    
    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('images/bg_3.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span> <span>Xe cho thuê <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-3 bread">Chọn xe của bạn</h1>
          </div>
        </div>
      </div>
    </section>
		
    <!-- Search Filter Section -->
    <section class="ftco-section bg-light pt-4">
      <div class="container">
        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="row">
          <div class="col-md-12">
            <form action="cars" method="get" class="bg-white p-4 rounded">
              <div class="row">
                <div class="col-md-3">
                  <div class="form-group">
                    <label>Địa điểm nhận xe</label>
                    <input type="text" class="form-control" name="pickupLocation" placeholder="Thành phố..." value="${pickupLocation}">
                  </div>
                </div>
                <div class="col-md-2">
                  <div class="form-group">
                    <label>Ngày nhận</label>
                    <input type="text" class="form-control" name="pickupDate" id="pickupDate" placeholder="dd/mm/yyyy" value="${pickupDate}" autocomplete="off">
                  </div>
                </div>
                <div class="col-md-2">
                  <div class="form-group">
                    <label>Ngày trả</label>
                    <input type="text" class="form-control" name="dropoffDate" id="dropoffDate" placeholder="dd/mm/yyyy" value="${dropoffDate}" autocomplete="off">
                  </div>
                </div>
                <div class="col-md-2">
                  <div class="form-group">
                    <label>Danh mục</label>
                    <select class="form-control" name="categoryId">
                      <option value="">Tất cả</option>
                      <c:if test="${not empty categories}">
                        <c:forEach var="category" items="${categories}">
                          <option value="${category.categoryId}" ${selectedCategoryId == category.categoryId ? 'selected' : ''}>${category.categoryName}</option>
                        </c:forEach>
                      </c:if>
                    </select>
                  </div>
                </div>
                <div class="col-md-2">
                  <div class="form-group">
                    <label>Giá tối đa</label>
                    <input type="number" class="form-control" name="maxPrice" placeholder="VNĐ" value="${maxPrice > 0 ? maxPrice : ''}">
                  </div>
                </div>
                <div class="col-md-1">
                  <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn btn-primary btn-block">Lọc</button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>

		<section class="ftco-section bg-light pt-0">
    	<div class="container">
    		<div class="row">
    			<c:choose>
    				<c:when test="${empty cars}">
    					<div class="col-md-12">
    						<div class="alert alert-info text-center">
    							<h4>Không tìm thấy xe nào</h4>
    							<p>Vui lòng thử lại với bộ lọc khác.</p>
    						</div>
    					</div>
    				</c:when>
    				<c:otherwise>
    					<c:forEach var="car" items="${cars}">
			    			<div class="col-md-4">
			    				<div class="car-wrap rounded ftco-animate">
			    					<div class="img rounded d-flex align-items-end" style="background-image: url(${not empty car.imageUrl ? car.imageUrl : 'images/car-1.jpg'});">
			    					</div>
			    					<div class="text">
			    						<h2 class="mb-0"><a href="car-detail?id=${car.carId}">${car.model.brand.brandName} ${car.model.modelName}</a></h2>
			    						<div class="d-flex mb-3">
				    						<span class="cat">${car.category.categoryName}</span>
				    						<p class="price ml-auto">
				    							<fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₫" maxFractionDigits="0"/> 
				    							<span>/ngày</span>
				    						</p>
			    						</div>
			    						<p class="d-flex mb-0 d-block">
			    							<c:choose>
			    								<c:when test="${not empty sessionScope.user}">
			    									<a href="booking?action=create&carId=${car.carId}" class="btn btn-primary py-2 mr-1">Đặt ngay</a>
			    								</c:when>
			    								<c:otherwise>
			    									<a href="login.jsp" class="btn btn-primary py-2 mr-1">Đặt ngay</a>
			    								</c:otherwise>
			    							</c:choose>
			    							<a href="car-detail?id=${car.carId}" class="btn btn-secondary py-2 ml-1">Chi tiết</a>
			    						</p>
			    					</div>
			    				</div>
			    			</div>
			    		</c:forEach>
    				</c:otherwise>
    			</c:choose>
    		</div>
    	</div>
    </section>
    

    <footer class="ftco-footer ftco-bg-dark ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2"><a href="#" class="logo">Car<span>book</span></a></h2>
              <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
              <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-5">
              <h2 class="ftco-heading-2">Information</h2>
              <ul class="list-unstyled">
                <li><a href="#" class="py-2 d-block">About</a></li>
                <li><a href="#" class="py-2 d-block">Services</a></li>
                <li><a href="#" class="py-2 d-block">Term and Conditions</a></li>
                <li><a href="#" class="py-2 d-block">Best Price Guarantee</a></li>
                <li><a href="#" class="py-2 d-block">Privacy &amp; Cookies Policy</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
             <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Customer Support</h2>
              <ul class="list-unstyled">
                <li><a href="#" class="py-2 d-block">FAQ</a></li>
                <li><a href="#" class="py-2 d-block">Payment Option</a></li>
                <li><a href="#" class="py-2 d-block">Booking Tips</a></li>
                <li><a href="#" class="py-2 d-block">How it works</a></li>
                <li><a href="#" class="py-2 d-block">Contact Us</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Have a Questions?</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon icon-map-marker"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
	                <li><a href="#"><span class="icon icon-phone"></span><span class="text">+2 392 3929 210</span></a></li>
	                <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@yourdomain.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/bootstrap-datepicker.js"></script>
  <script src="js/jquery.timepicker.min.js"></script>
  <script src="js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
  
  <script>
    $(document).ready(function(){
      // Khởi tạo datepicker cho ngày nhận và ngày trả
      $('#pickupDate, #dropoffDate').datepicker({
        format: 'dd/mm/yyyy',
        autoclose: true,
        todayHighlight: true,
        startDate: new Date()
      });
      
      // Lấy search params từ URL hiện tại
      var urlParams = new URLSearchParams(window.location.search);
      var pickupLocation = urlParams.get('pickupLocation') || '';
      var dropoffLocation = urlParams.get('dropoffLocation') || '';
      var pickupDate = urlParams.get('pickupDate') || '';
      var dropoffDate = urlParams.get('dropoffDate') || '';
      var pickupTime = urlParams.get('pickupTime') || '';
      
      // Thêm params vào tất cả link "Đặt ngay"
      $('.btn-primary[href*="booking?action=create"]').each(function() {
        var href = $(this).attr('href');
        var params = [];
        
        if (pickupLocation) params.push('pickupLocation=' + encodeURIComponent(pickupLocation));
        if (dropoffLocation) params.push('dropoffLocation=' + encodeURIComponent(dropoffLocation));
        if (pickupDate) params.push('pickupDate=' + encodeURIComponent(pickupDate));
        if (dropoffDate) params.push('dropoffDate=' + encodeURIComponent(dropoffDate));
        if (pickupTime) params.push('pickupTime=' + encodeURIComponent(pickupTime));
        
        if (params.length > 0) {
          $(this).attr('href', href + '&' + params.join('&'));
        }
      });
    });
  </script>
    
  </body>
</html>