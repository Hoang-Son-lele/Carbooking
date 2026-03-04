<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Carbook - Free Bootstrap 4 Template by Colorlib</title>
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
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.jsp">Home <i class="ion-ios-arrow-forward"></i></a></span> <span class="mr-2"><a href="blog">Blog <i class="ion-ios-arrow-forward"></i></a></span> <span>Blog Single <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-3 bread">${blog.title}</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section ftco-degree-bg">
      <div class="container">
        <div class="row">
          <div class="col-md-8 ftco-animate">
            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.success}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <c:remove var="success" scope="session" />
            </c:if>
            
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>
            
            <!-- Blog Meta Info -->
            <div class="mb-4">
                <c:if test="${not empty blog.categoryName}">
                    <span class="badge badge-primary">${blog.categoryName}</span>
                </c:if>
                <span class="text-muted ml-2">
                    <i class="icon-calendar"></i> <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy" />
                </span>
                <span class="text-muted ml-2">
                    <i class="icon-person"></i> 
                    <c:choose>
                        <c:when test="${not empty blog.author}">
                            ${blog.author.fullName}
                        </c:when>
                        <c:otherwise>
                            Admin
                        </c:otherwise>
                    </c:choose>
                </span>
                <span class="text-muted ml-2">
                    <i class="icon-eye"></i> ${blog.viewCount} lượt xem
                </span>
            </div>
            
            <h2 class="mb-3">${blog.title}</h2>
            
            <!-- Featured Image -->
            <c:if test="${not empty blog.imageURL}">
                <p>
                    <img src="${blog.imageURL}" alt="${blog.title}" class="img-fluid">
                </p>
            </c:if>
            
            <!-- Blog Summary -->
            <c:if test="${not empty blog.summary}">
                <p class="lead">${blog.summary}</p>
            </c:if>
            
            <!-- Blog Content -->
            <div class="blog-content">
                ${blog.content}
            </div>
            
            <!-- Tags -->
            <c:if test="${not empty blog.categoryName}">
                <div class="tag-widget post-tag-container mb-5 mt-5">
                  <div class="tagcloud">
                    <a href="blog?action=category&name=${blog.categoryName}" class="tag-cloud-link">${blog.categoryName}</a>
                  </div>
                </div>
            </c:if>
            
            <!-- Author Info -->
            <c:if test="${not empty blog.author}">
                <div class="about-author d-flex p-4 bg-light">
                  <div class="bio mr-5">
                    <c:choose>
                        <c:when test="${not empty blog.author.profileImageURL}">
                            <img src="${blog.author.profileImageURL}" alt="${blog.author.fullName}" class="img-fluid mb-4">
                        </c:when>
                        <c:otherwise>
                            <img src="images/person_1.jpg" alt="${blog.author.fullName}" class="img-fluid mb-4">
                        </c:otherwise>
                    </c:choose>
                  </div>
                  <div class="desc">
                    <h3>${blog.author.fullName}</h3>
                    <p>
                        <c:choose>
                            <c:when test="${not empty blog.author.address}">
                                ${blog.author.address}
                            </c:when>
                            <c:otherwise>
                                Tác giả tại CarBook - Chia sẻ kinh nghiệm và kiến thức về thuê xe
                            </c:otherwise>
                        </c:choose>
                    </p>
                  </div>
                </div>
            </c:if>


            <div class="pt-5 mt-5" id="comments">
              <h3 class="mb-5">${commentCount} Bình luận</h3>
              
              <c:choose>
                <c:when test="${not empty comments}">
                    <ul class="comment-list">
                        <c:forEach var="comment" items="${comments}">
                            <li class="comment">
                             
                              <div class="comment-body">
                                <h3>${comment.userName}</h3>
                                <div class="meta">
                                    <fmt:formatDate value="${comment.createdAt}" pattern="dd/MM/yyyy 'lúc' HH:mm" />
                                </div>
                                <p>${comment.commentText}</p>
                                <c:if test="${not empty sessionScope.user}">
                                    <p><a href="#" class="reply" onclick="showReplyForm(${comment.commentId}, '${comment.userName}'); return false;">Trả lời</a></p>
                                    <!-- Reply form (hidden by default) -->
                                    <div id="reply-form-${comment.commentId}" style="display:none;" class="mt-3">
                                        <form action="blog" method="post" class="p-3 bg-light">
                                            <input type="hidden" name="action" value="addComment">
                                            <input type="hidden" name="blogId" value="${blog.blogId}">
                                            <input type="hidden" name="parentCommentId" value="${comment.commentId}">
                                            <div class="form-group">
                                                <label>Trả lời ${comment.userName}:</label>
                                                <textarea name="commentText" rows="3" class="form-control" required placeholder="Nhập câu trả lời của bạn..."></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-sm">Gửi</button>
                                            <button type="button" class="btn btn-secondary btn-sm" onclick="hideReplyForm(${comment.commentId})">Hủy</button>
                                        </form>
                                    </div>
                                </c:if>
                              </div>
                              
                              <!-- Nested replies -->
                              <c:if test="${comment.hasReplies()}">
                                  <ul class="children">
                                      <c:forEach var="reply" items="${comment.replies}">
                                          <li class="comment">
                                              
                                              <div class="comment-body">
                                                <h3>${reply.userName}</h3>
                                                <div class="meta">
                                                    <fmt:formatDate value="${reply.createdAt}" pattern="dd/MM/yyyy 'lúc' HH:mm" />
                                                </div>
                                                <p>${reply.commentText}</p>
                                                
                                                <!-- Support for nested replies (2 levels deep) -->
                                                <c:if test="${reply.hasReplies()}">
                                                    <ul class="children">
                                                        <c:forEach var="nestedReply" items="${reply.replies}">
                                                            <li class="comment">
                                                               
                                                                <div class="comment-body">
                                                                  <h3>${nestedReply.userName}</h3>
                                                                  <div class="meta">
                                                                      <fmt:formatDate value="${nestedReply.createdAt}" pattern="dd/MM/yyyy 'lúc' HH:mm" />
                                                                  </div>
                                                                  <p>${nestedReply.commentText}</p>
                                                                </div>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </c:if>
                                              </div>
                                          </li>
                                      </c:forEach>
                                  </ul>
                              </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
                </c:otherwise>
              </c:choose>
              <!-- END comment-list -->
              
              <div class="comment-form-wrap pt-5">
                <h3 class="mb-5">Để lại bình luận</h3>
                <c:choose>
                  <c:when test="${not empty sessionScope.user}">
                    <form action="blog" method="post" class="p-5 bg-light">
                      <input type="hidden" name="action" value="addComment">
                      <input type="hidden" name="blogId" value="${blog.blogId}">
                      
                      <div class="form-group">
                        <label for="commentText">Nội dung bình luận *</label>
                        <textarea name="commentText" id="commentText" cols="30" rows="10" class="form-control" required placeholder="Nhập bình luận của bạn..."></textarea>
                      </div>
                      <div class="form-group">
                        <button type="submit" class="btn py-3 px-4 btn-primary">Gửi bình luận</button>
                      </div>
                    </form>
                  </c:when>
                  <c:otherwise>
                    <div class="p-5 bg-light text-center">
                      <p>Bạn cần <a href="login.jsp">đăng nhập</a> để có thể bình luận.</p>
                      <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
                      <a href="register.jsp" class="btn btn-secondary ml-2">Đăng ký</a>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>

            <script>
              // Show reply form
              function showReplyForm(commentId, userName) {
                // Hide all reply forms first
                document.querySelectorAll('[id^="reply-form-"]').forEach(function(form) {
                  form.style.display = 'none';
                });
                // Show the selected reply form
                document.getElementById('reply-form-' + commentId).style.display = 'block';
              }
              
              // Hide reply form
              function hideReplyForm(commentId) {
                document.getElementById('reply-form-' + commentId).style.display = 'none';
              }
            </script>

          </div> <!-- .col-md-8 -->
          <div class="col-md-4 sidebar ftco-animate">
            <div class="sidebar-box">
              <form action="blog" method="get" class="search-form">
                <input type="hidden" name="action" value="search">
                <div class="form-group">
                  <span class="icon icon-search"></span>
                  <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm bài viết..." required>
                </div>
              </form>
            </div>
            <div class="sidebar-box ftco-animate">
              <div class="categories">
                <h3>Danh mục</h3>
                <li><a href="blog?action=category&name=Mẹo thuê xe">Mẹo thuê xe</a></li>
                <li><a href="blog?action=category&name=An toàn lái xe">An toàn lái xe</a></li>
                <li><a href="blog?action=category&name=Bảo dưỡng xe">Bảo dưỡng xe</a></li>
                <li><a href="blog?action=category&name=Du lịch">Du lịch</a></li>
                <li><a href="blog?action=category&name=Kinh nghiệm lái xe">Kinh nghiệm lái xe</a></li>
                <li><a href="blog?action=category&name=Tin tức">Tin tức</a></li>
              </div>
            </div>

            <div class="sidebar-box ftco-animate">
              <h3>Bài viết gần đây</h3>
              <c:choose>
                <c:when test="${not empty recentBlogs}">
                  <c:forEach var="recentBlog" items="${recentBlogs}">
                    <div class="block-21 mb-4 d-flex">
                      <c:choose>
                        <c:when test="${not empty recentBlog.imageURL}">
                          <a href="blog?action=view&id=${recentBlog.blogId}" class="blog-img mr-4" style="background-image: url(${recentBlog.imageURL});"></a>
                        </c:when>
                        <c:otherwise>
                          <a href="blog?action=view&id=${recentBlog.blogId}" class="blog-img mr-4" style="background-image: url(images/image_1.jpg);"></a>
                        </c:otherwise>
                      </c:choose>
                      <div class="text">
                        <h3 class="heading"><a href="blog?action=view&id=${recentBlog.blogId}">${recentBlog.title}</a></h3>
                        <div class="meta">
                          <div><a href="#"><span class="icon-calendar"></span><fmt:formatDate value="${recentBlog.createdAt}" pattern="dd/MM/yyyy" /></a></div>
                          <div><a href="#"><span class="icon-person"></span> 
                            <c:choose>
                              <c:when test="${not empty recentBlog.author}">
                                ${recentBlog.author.fullName}
                              </c:when>
                              <c:otherwise>
                                Admin
                              </c:otherwise>
                            </c:choose>
                          </a></div>
                          <div><a href="#"><span class="icon-eye"></span> ${recentBlog.viewCount}</a></div>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <p class="text-muted">Chưa có bài viết nào</p>
                </c:otherwise>
              </c:choose>
            </div>

            <div class="sidebar-box ftco-animate">
              <h3>Danh mục phổ biến</h3>
              <div class="tagcloud">
                <a href="blog?action=category&name=Mẹo thuê xe" class="tag-cloud-link">Mẹo thuê xe</a>
                <a href="blog?action=category&name=An toàn lái xe" class="tag-cloud-link">An toàn lái xe</a>
                <a href="blog?action=category&name=Bảo dưỡng xe" class="tag-cloud-link">Bảo dưỡng</a>
                <a href="blog?action=category&name=Du lịch" class="tag-cloud-link">Du lịch</a>
                <a href="blog?action=category&name=Kinh nghiệm lái xe" class="tag-cloud-link">Kinh nghiệm</a>
                <a href="blog?action=category&name=Tin tức" class="tag-cloud-link">Tin tức</a>
              </div>
            </div>

            <c:if test="${not empty popularBlogs && popularBlogs.size() > 0}">
              <div class="sidebar-box ftco-animate">
                <h3>Bài viết phổ biến</h3>
                <c:forEach var="popularBlog" items="${popularBlogs}" begin="0" end="2">
                  <div class="block-21 mb-4 d-flex">
                    <c:choose>
                      <c:when test="${not empty popularBlog.imageURL}">
                        <a href="blog?action=view&id=${popularBlog.blogId}" class="blog-img mr-4" style="background-image: url(${popularBlog.imageURL});"></a>
                      </c:when>
                      <c:otherwise>
                        <a href="blog?action=view&id=${popularBlog.blogId}" class="blog-img mr-4" style="background-image: url(images/image_1.jpg);"></a>
                      </c:otherwise>
                    </c:choose>
                    <div class="text">
                      <h3 class="heading"><a href="blog?action=view&id=${popularBlog.blogId}">${popularBlog.title}</a></h3>
                      <div class="meta">
                        <div><span class="icon-eye"></span> ${popularBlog.viewCount} lượt xem</div>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:if>
          </div>

        </div>
      </div>
    </section> <!-- .section -->

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