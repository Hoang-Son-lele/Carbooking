<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Blog - CarBook</title>
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
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.jsp">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span> <span>Blog <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-3 bread">Blog của chúng tôi</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section">
      <div class="container">
        <c:if test="${not empty error}">
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
        </c:if>
        
        <c:if test="${not empty searchKeyword}">
          <div class="alert alert-info">
            Kết quả tìm kiếm cho: <strong>"${searchKeyword}"</strong> - Tìm thấy ${blogs.size()} kết quả
          </div>
        </c:if>
        
        <c:if test="${not empty categoryName}">
          <div class="alert alert-info">
            Danh mục: <strong>${categoryName}</strong>
          </div>
        </c:if>
        
        <div class="row d-flex justify-content-center">
          <c:choose>
            <c:when test="${not empty blogs}">
              <c:forEach var="blog" items="${blogs}">
                <div class="col-md-12 text-center d-flex ftco-animate">
                  <div class="blog-entry justify-content-end mb-md-5">
                    <a href="blog?action=view&id=${blog.blogId}" class="block-20 img" 
                       style="background-image: url('${not empty blog.imageURL ? blog.imageURL : 'images/image_1.jpg'}');">
                    </a>
                    <div class="text px-md-5 pt-4">
                      <div class="meta mb-3">
                        <div><a href="#"><fmt:formatDate value="${blog.createdAt}" pattern="MMM dd, yyyy" /></a></div>
                        <div><a href="#">${not empty blog.author ? blog.author.fullName : 'Admin'}</a></div>
                        <div><a href="#" class="meta-chat"><span class="icon-eye"></span> ${blog.viewCount}</a></div>
                      </div>
                      <h3 class="heading mt-2"><a href="blog?action=view&id=${blog.blogId}">${blog.title}</a></h3>
                      <p>${blog.excerpt}</p>
                      <p>
                        <a href="blog?action=view&id=${blog.blogId}" class="btn btn-primary">
                          Đọc tiếp <span class="icon-long-arrow-right"></span>
                        </a>
                        <c:if test="${not empty blog.categoryName}">
                          <a href="blog?action=category&name=${blog.categoryName}" class="btn btn-outline-primary ml-2">
                            <span class="icon-tag"></span> ${blog.categoryName}
                          </a>
                        </c:if>
                      </p>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="col-md-12 text-center">
                <div class="alert alert-warning">
                  <h4>Không tìm thấy bài viết nào</h4>
                  <p>Hiện tại chưa có bài viết blog nào. Vui lòng quay lại sau.</p>
                  <a href="index.jsp" class="btn btn-primary mt-3">Về trang chủ</a>
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
        
        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
          <div class="row mt-5">
            <div class="col text-center">
              <div class="block-27">
                <ul>
                  <!-- Previous button -->
                  <c:if test="${currentPage > 1}">
                    <li><a href="blog?page=${currentPage - 1}">&lt;</a></li>
                  </c:if>
                  <c:if test="${currentPage == 1}">
                    <li class="disabled"><span>&lt;</span></li>
                  </c:if>
                  
                  <!-- Page numbers -->
                  <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <c:choose>
                      <c:when test="${pageNum == currentPage}">
                        <li class="active"><span>${pageNum}</span></li>
                      </c:when>
                      <c:otherwise>
                        <li><a href="blog?page=${pageNum}">${pageNum}</a></li>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>
                  
                  <!-- Next button -->
                  <c:if test="${currentPage < totalPages}">
                    <li><a href="blog?page=${currentPage + 1}">&gt;</a></li>
                  </c:if>
                  <c:if test="${currentPage == totalPages}">
                    <li class="disabled"><span>&gt;</span></li>
                  </c:if>
                </ul>
              </div>
            </div>
          </div>
        </c:if>
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