<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>${car.model.brand.brandName} ${car.model.modelName} - CarBook</title>
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
    <style>
    	.price-detail {
    		font-size: 24px;
    		margin-bottom: 10px;
    	}
    	.price-value {
    		color: #01d28e;
    		font-weight: bold;
    		font-size: 32px;
    	}
    	.price-unit {
    		color: #666;
    		font-size: 18px;
    	}
    	
    	/* Car Image Carousel Styles */
    	#carImageCarousel .carousel-item {
    		height: 500px;
    	}
    	#carImageCarousel .carousel-control-prev,
    	#carImageCarousel .carousel-control-next {
    		width: 50px;
    		height: 50px;
    		top: 50%;
    		transform: translateY(-50%);
    		background-color: rgba(0, 0, 0, 0.5);
    		border-radius: 50%;
    		opacity: 0.7;
    	}
    	#carImageCarousel .carousel-control-prev:hover,
    	#carImageCarousel .carousel-control-next:hover {
    		opacity: 1;
    	}
    	#carImageCarousel .carousel-indicators {
    		bottom: 20px;
    	}
    	#carImageCarousel .carousel-indicators li {
    		width: 12px;
    		height: 12px;
    		border-radius: 50%;
    		background-color: rgba(255, 255, 255, 0.5);
    	}
    	#carImageCarousel .carousel-indicators li.active {
    		background-color: #01d28e;
    	}
    </style>
  </head>
  <body>
    
	 	  <%@ include file="includes/navbar.jsp" %>
    <!-- END nav -->
    
    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('images/bg_3.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span> <span class="mr-2"><a href="cars">Xe cho thuê <i class="ion-ios-arrow-forward"></i></a></span> <span>Chi tiết xe <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-3 bread">Chi tiết xe</h1>
          </div>
        </div>
      </div>
    </section>
		

		<section class="ftco-section ftco-car-details">
      <div class="container">
      	<div class="row justify-content-center">
      		<div class="col-md-12">
      			<div class="car-details">
      				<!-- Car Image Gallery -->
      				<c:choose>
      					<c:when test="${not empty carImages and carImages.size() > 1}">
      						<!-- Multiple images - show carousel -->
      						<div id="carImageCarousel" class="carousel slide" data-ride="carousel">
      							<!-- Indicators -->
      							<ol class="carousel-indicators">
      								<c:forEach var="img" items="${carImages}" varStatus="status">
      									<li data-target="#carImageCarousel" data-slide-to="${status.index}" 
      										class="${status.index == 0 ? 'active' : ''}"></li>
      								</c:forEach>
      							</ol>
      							
      							<!-- Slides -->
      							<div class="carousel-inner">
      								<c:forEach var="img" items="${carImages}" varStatus="status">
      									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
      										<div class="img rounded" style="background-image: url(${img.imageURL}); height: 500px; background-size: cover; background-position: center;"></div>
      									</div>
      								</c:forEach>
      							</div>
      							
      							<!-- Controls -->
      							<a class="carousel-control-prev" href="#carImageCarousel" role="button" data-slide="prev">
      								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
      								<span class="sr-only">Trước</span>
      							</a>
      							<a class="carousel-control-next" href="#carImageCarousel" role="button" data-slide="next">
      								<span class="carousel-control-next-icon" aria-hidden="true"></span>
      								<span class="sr-only">Tiếp</span>
      							</a>
      						</div>
      					</c:when>
      					<c:otherwise>
      						<!-- Single image or no images -->
      						<div class="img rounded" style="background-image: url(${not empty car.imageUrl ? car.imageUrl : 'images/bg_1.jpg'});"></div>
      					</c:otherwise>
      				</c:choose>
      				
      				<div class="text text-center">
      					<span class="subheading">${car.category.categoryName}</span>
      					<h2>${car.model.brand.brandName} ${car.model.modelName} ${car.model.year}</h2>
      				</div>
      			</div>
      		</div>
      	</div>
      	<div class="row">
      		<div class="col-md d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services">
              <div class="media-body py-md-4">
              	<div class="d-flex mb-3 align-items-center">
	              	<div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-dashboard"></span></div>
	              	<div class="text">
		                <h3 class="heading mb-0 pl-3">
		                	Số Km đã đi
		                	<span><fmt:formatNumber value="${car.mileage}" maxFractionDigits="0"/> km</span>
		                </h3>
	                </div>
                </div>
              </div>
            </div>      
          </div>
          <div class="col-md d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services">
              <div class="media-body py-md-4">
              	<div class="d-flex mb-3 align-items-center">
	              	<div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-pistons"></span></div>
	              	<div class="text">
		                <h3 class="heading mb-0 pl-3">
		                	Hộp số
		                	<span>${car.transmission}</span>
		                </h3>
	                </div>
                </div>
              </div>
            </div>      
          </div>
          <div class="col-md d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services">
              <div class="media-body py-md-4">
              	<div class="d-flex mb-3 align-items-center">
	              	<div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-car-seat"></span></div>
	              	<div class="text">
		                <h3 class="heading mb-0 pl-3">
		                	Số chỗ
		                	<span>${car.seats} chỗ</span>
		                </h3>
	                </div>
                </div>
              </div>
            </div>      
          </div>
          <div class="col-md d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services">
              <div class="media-body py-md-4">
              	<div class="d-flex mb-3 align-items-center">
	              	<div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-backpack"></span></div>
	              	<div class="text">
		                <h3 class="heading mb-0 pl-3">
		                	Màu sắc
		                	<span>${car.color}</span>
		                </h3>
	                </div>
                </div>
              </div>
            </div>      
          </div>
          <div class="col-md d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services">
              <div class="media-body py-md-4">
              	<div class="d-flex mb-3 align-items-center">
	              	<div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-diesel"></span></div>
	              	<div class="text">
		                <h3 class="heading mb-0 pl-3">
		                	Nhiên liệu
		                	<span>${car.fuelType}</span>
		                </h3>
	                </div>
                </div>
              </div>
            </div>      
          </div>
      	</div>
      	<div class="row">
      		<div class="col-md-12 pills">
						<div class="bd-example bd-example-tabs">
							<div class="d-flex justify-content-center">
							  <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">

							    <li class="nav-item">
							      <a class="nav-link active" id="pills-description-tab" data-toggle="pill" href="#pills-description" role="tab" aria-controls="pills-description" aria-expanded="true">Features</a>
							    </li>
							    <li class="nav-item">
							      <a class="nav-link" id="pills-manufacturer-tab" data-toggle="pill" href="#pills-manufacturer" role="tab" aria-controls="pills-manufacturer" aria-expanded="true">Description</a>
							    </li>
							    <li class="nav-item">
							      <a class="nav-link" id="pills-review-tab" data-toggle="pill" href="#pills-review" role="tab" aria-controls="pills-review" aria-expanded="true">Review</a>
							    </li>
							  </ul>
							</div>

						  <div class="tab-content" id="pills-tabContent">
						    <div class="tab-pane fade show active" id="pills-description" role="tabpanel" aria-labelledby="pills-description-tab">
						    	<c:choose>
						    		<c:when test="${not empty car.featuresList}">
						    			<div class="row">
						    				<c:set var="featuresPerColumn" value="${(car.featuresList.size() + 2) / 3}" />
						    				<c:forEach var="columnIndex" begin="0" end="2">
						    					<div class="col-md-4">
						    						<ul class="features">
						    							<c:forEach var="feature" items="${car.featuresList}" varStatus="status">
						    								<c:if test="${status.index >= columnIndex * featuresPerColumn && status.index < (columnIndex + 1) * featuresPerColumn}">
						    									<li class="check"><span class="ion-ios-checkmark"></span>${feature}</li>
						    								</c:if>
						    							</c:forEach>
						    						</ul>
						    					</div>
						    				</c:forEach>
						    			</div>
						    		</c:when>
						    		<c:otherwise>
						    			<div class="row">
						    				<div class="col-md-12">
						    					<p class="text-muted">Không có thông tin về tính năng của xe này.</p>
						    				</div>
						    			</div>
						    		</c:otherwise>
						    	</c:choose>
						    </div>

						    <div class="tab-pane fade" id="pills-manufacturer" role="tabpanel" aria-labelledby="pills-manufacturer-tab">
						      <h3>Thông tin chi tiết</h3>
						      <p><strong>Biển số xe:</strong> ${car.licensePlate}</p>
						      <p><strong>Số VIN:</strong> ${car.vinNumber}</p>
						      <p><strong>Vị trí:</strong> ${car.location}</p>
						      <p><strong>Mô tả:</strong></p>
						      <p>${car.description}</p>
						    </div>

						    <div class="tab-pane fade" id="pills-review" role="tabpanel" aria-labelledby="pills-review-tab">
						      <div id="reviews"></div>
						      <div class="row">
							   		<div class="col-md-7">
							   			<h3 class="head">${reviewCount} Đánh giá</h3>
							   			<c:choose>
							   				<c:when test="${not empty reviews}">
								   				<c:forEach var="review" items="${reviews}">
										   			<div class="review d-flex">
												   		<div class="user-img" style="background-image: url(${not empty review.customerProfileImage ? review.customerProfileImage : 'images/person_1.jpg'})"></div>
												   		<div class="desc">
												   			<h4>
												   				<span class="text-left">${review.customerName}</span>
												   				<span class="text-right"><fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy" /></span>
												   			</h4>
												   			<p class="star">
												   				<span>
												   					<c:forEach begin="1" end="5" var="i">
												   						<c:choose>
												   							<c:when test="${i <= review.rating}">
												   								<i class="ion-ios-star"></i>
												   							</c:when>
												   							<c:otherwise>
												   								<i class="ion-ios-star-outline"></i>
												   							</c:otherwise>
												   						</c:choose>
												   					</c:forEach>
											   					</span>
												   			</p>
												   			<p>${review.comment}</p>
												   		</div>
												   	</div>
											   	</c:forEach>
										   	</c:when>
										   	<c:otherwise>
										   		<p class="text-muted">Chưa có đánh giá nào cho xe này.</p>
										   	</c:otherwise>
									   	</c:choose>
							   		</div>
							   		<div class="col-md-5">
							   			<div class="rating-wrap">
								   			<h3 class="head">Đánh giá tổng quan</h3>
								   			<div class="wrap">
								   				<c:choose>
								   					<c:when test="${reviewCount > 0}">
										   			<p class="star mb-4">
										   				<span style="font-size: 24px; font-weight: bold;">
										   					<fmt:formatNumber value="${averageRating}" maxFractionDigits="1" minFractionDigits="1"/>
										   					<c:forEach begin="1" end="5" var="i">
										   						<c:choose>
										   							<c:when test="${i <= averageRating}">
										   								<i class="ion-ios-star text-warning"></i>
										   							</c:when>
										   							<c:when test="${i - averageRating < 1 && i - averageRating > 0}">
										   								<i class="ion-ios-star-half text-warning"></i>
										   							</c:when>
										   							<c:otherwise>
										   								<i class="ion-ios-star-outline"></i>
										   							</c:otherwise>
										   						</c:choose>
										   					</c:forEach>
									   					</span>
									   					<br>
									   					<span class="text-muted">Dựa trên ${reviewCount} đánh giá</span>
										   			</p>
										   			</c:when>
										   			<c:otherwise>
										   				<p class="text-muted">Chưa có đánh giá</p>
										   			</c:otherwise>
										   		</c:choose>
										   		
										   		<div class="mt-4">
										   			<c:if test="${not empty sessionScope.user}">
										   				<p><strong>Bạn đã thuê xe này?</strong></p>
										   				<p class="text-muted">Hãy để lại đánh giá của bạn sau khi hoàn thành chuyến đi!</p>
										   			</c:if>
										   			<c:if test="${empty sessionScope.user}">
										   				<p class="text-muted">Vui lòng <a href="login">đăng nhập</a> để xem và gửi đánh giá.</p>
										   			</c:if>
										   		</div>
									   		</div>
								   		</div>
							   		</div>
							   	</div>
						    </div>
						  </div>
						</div>
		      </div>
		      
		      <!-- Pricing and Booking Section -->
		      <div class="row mt-5">
		      	<div class="col-md-12">
		      		<div class="bg-light p-4 rounded">
		      			<div class="row align-items-center">
		      				<div class="col-md-6">
		      					<h3 class="mb-3">Giá thuê xe</h3>
		      					<p class="price-detail">
		      						<span class="price-value"><fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></span>
		      						<span class="price-unit"> / ngày</span>
		      					</p>
		      					<c:if test="${not empty car.pricePerHour && car.pricePerHour > 0}">
		      						<p class="price-detail">
		      							<span class="price-value"><fmt:formatNumber value="${car.pricePerHour}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></span>
		      							<span class="price-unit"> / giờ</span>
		      						</p>
		      					</c:if>
		      				</div>
		      				<div class="col-md-6 text-md-right">
		      					<c:choose>
		      						<c:when test="${not empty sessionScope.user}">
		      							<a href="booking?action=create&carId=${car.carId}" class="btn btn-primary btn-lg px-5 py-3">
		      								<i class="icon-calendar mr-2"></i>Đặt xe ngay
		      							</a>
		      						</c:when>
		      						<c:otherwise>
		      							<a href="login.jsp" class="btn btn-primary btn-lg px-5 py-3">
		      								<i class="icon-user mr-2"></i>Đăng nhập để đặt xe
		      							</a>
		      						</c:otherwise>
		      					</c:choose>
		      				</div>
		      			</div>
		      		</div>
		      	</div>
		      </div>
				</div>
      </div>
    </section>

    <section class="ftco-section ftco-no-pt">
    	<div class="container">
    		<div class="row justify-content-center">
          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
          	<span class="subheading">Choose Car</span>
            <h2 class="mb-2">Related Cars</h2>
          </div>
        </div>
        <div class="row">
        	<div class="col-md-4">
    				<div class="car-wrap rounded ftco-animate">
    					<div class="img rounded d-flex align-items-end" style="background-image: url(images/car-1.jpg);">
    					</div>
    					<div class="text">
    						<h2 class="mb-0"><a href="car-single.html">Mercedes Grand Sedan</a></h2>
    						<div class="d-flex mb-3">
	    						<span class="cat">Cheverolet</span>
	    						<p class="price ml-auto">$500 <span>/day</span></p>
    						</div>
    						<p class="d-flex mb-0 d-block"><a href="#" class="btn btn-primary py-2 mr-1">Book now</a> <a href="car-single.html" class="btn btn-secondary py-2 ml-1">Details</a></p>
    					</div>
    				</div>
    			</div>
    			<div class="col-md-4">
    				<div class="car-wrap rounded ftco-animate">
    					<div class="img rounded d-flex align-items-end" style="background-image: url(images/car-2.jpg);">
    					</div>
    					<div class="text">
    						<h2 class="mb-0"><a href="car-single.html">Range Rover</a></h2>
    						<div class="d-flex mb-3">
	    						<span class="cat">Subaru</span>
	    						<p class="price ml-auto">$500 <span>/day</span></p>
    						</div>
    						<p class="d-flex mb-0 d-block"><a href="#" class="btn btn-primary py-2 mr-1">Book now</a> <a href="car-single.html" class="btn btn-secondary py-2 ml-1">Details</a></p>
    					</div>
    				</div>
    			</div>
    			<div class="col-md-4">
    				<div class="car-wrap rounded ftco-animate">
    					<div class="img rounded d-flex align-items-end" style="background-image: url(images/car-3.jpg);">
    					</div>
    					<div class="text">
    						<h2 class="mb-0"><a href="car-single.html">Mercedes Grand Sedan</a></h2>
    						<div class="d-flex mb-3">
	    						<span class="cat">Cheverolet</span>
	    						<p class="price ml-auto">$500 <span>/day</span></p>
    						</div>
    						<p class="d-flex mb-0 d-block"><a href="#" class="btn btn-primary py-2 mr-1">Book now</a> <a href="car-single.html" class="btn btn-secondary py-2 ml-1">Details</a></p>
    					</div>
    				</div>
    			</div>
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
    
  </body>
</html>