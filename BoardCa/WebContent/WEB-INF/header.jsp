<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<head>
<style>
#followChat {position: absolute; display: none; z-index: 99; top: 0%; right: 2%; opacity: 0.9;}
#chatBtn {position: absolute; display:inline; z-index: 99; bottom: 0%; right: 1%; border-radius: 50px; width:85px; height:85px; background-color: none;}
#chatBtnImg{position: absolute; width:80px; height:80px; z-index: 99;}

.nav-item col-md-3 {display: inline-block; float: none;}

.navbar-collapse {text-align:center;}
</style> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
	 $(document).ready( function() {
	 		$( '#chatBtn' ).click( function() {
	 			$( '#followChat' ).toggle( 'slow' );
	 	});
	 		
	 		$('#chatBtn').animate({top:$(window).scrollTop()+$(window).height()/1.3+"px"},{queue: false, duration: 0});
	 		$('#followChat').animate({top:$(window).scrollTop()+$(window).height()/7 +"px"},{queue: false, duration: 0});
	 	
	 });

	 $(window).scroll(function(){
	 	$('#followChat').animate({top:$(window).scrollTop()+$(window).height()/7 +"px"},{queue: false, duration: 500});
	 });

	 $(window).scroll(function(){
	 	$('#chatBtn').animate({top:$(window).scrollTop()+$(window).height()/1.3+"px"},{queue: false, duration: 0});
	 }); 

	$(function() {
		var userToken = '${userToken2}';

		$('#logoutBtn').click(function() {
			if (userToken == '1') {
				window.location.href = "kakaoLogout.do";
			} else {
				window.location.href = "logout.do";
			}

		})
	})
</script>
</head>

<link rel="icon" href="${pageContext.request.contextPath}/stylesheet/favicon.ico" type="image/x-icon">
<!-- Favicon-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/jvectormap/jquery-jvectormap-2.0.3.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/charts-c3/plugin.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/morrisjs/morris.min.css" />
<!-- Custom Css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/css/style.min.css">

<style>
ul.nav li.dropdown:hover > ul.dropdown-menu{display:block; margin-top:15px; margin-right:150px; padding:0;}
</style>

<!-- Page Loader -->
<div class="page-loader-wrapper">
	<!-- 	<div class="loader"> -->
	<div class="m-t-30">
		<img class="zmdi-hc-spin"
			src="${pageContext.request.contextPath}/imgs/logo2.png" width="48"
			height="48" alt="BoardCa">
	</div>
	<p>Please wait...</p>
</div>
<section class="content" style="margin: auto;">
	<div class="body_scroll">
		<div class="container-fluid">
			<!-- Tabs With Icon Title -->
			<div class="row clearfix">
				<div class="col-sm-12">
					<div class="card">
						<div class="header">
							<ul class="header-dropdown">
								<!-- 
								<li class="dropdown"><a href="javascript:void(0);"
									class="dropdown-toggle" title="Notifications"
									data-toggle="dropdown" role="button"> <i
										class="zmdi zmdi-notifications"></i>
										<div class="notify">
											<span class="heartbit"></span><span class="point"></span>
										</div>
								</a> ??????????????? ?????? ?????? list
									<ul class="dropdown-menu slideUp2">
										<li class="header">Notifications</li>
										<li class="body">
											<ul class="menu list-unstyled">
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-blue">
															<i class="zmdi zmdi-account"></i>
														</div>
														<div class="menu-info">
															<h4>8 New Members joined</h4>
															<p>
																<i class="zmdi zmdi-time"></i> 14 mins ago
															</p>
														</div>
												</a></li>
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-amber">
															<i class="zmdi zmdi-shopping-cart"></i>
														</div>
														<div class="menu-info">
															<h4>4 Sales made</h4>
															<p>
																<i class="zmdi zmdi-time"></i> 22 mins ago
															</p>
														</div>
												</a></li>
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-red">
															<i class="zmdi zmdi-delete"></i>
														</div>
														<div class="menu-info">
															<h4>
																<b>Nancy Doe</b> Deleted account
															</h4>
															<p>
																<i class="zmdi zmdi-time"></i> 3 hours ago
															</p>
														</div>
												</a></li>
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-green">
															<i class="zmdi zmdi-edit"></i>
														</div>
														<div class="menu-info">
															<h4>
																<b>Nancy</b> Changed name
															</h4>
															<p>
																<i class="zmdi zmdi-time"></i> 2 hours ago
															</p>
														</div>
												</a></li>
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-grey">
															<i class="zmdi zmdi-comment-text"></i>
														</div>
														<div class="menu-info">
															<h4>
																<b>John</b> Commented your post
															</h4>
															<p>
																<i class="zmdi zmdi-time"></i> 4 hours ago
															</p>
														</div>
												</a></li>
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-purple">
															<i class="zmdi zmdi-refresh"></i>
														</div>
														<div class="menu-info">
															<h4>
																<b>John</b> Updated status
															</h4>
															<p>
																<i class="zmdi zmdi-time"></i> 3 hours ago
															</p>
														</div>
												</a></li>
												<li><a href="javascript:void(0);">
														<div class="icon-circle bg-light-blue">
															<i class="zmdi zmdi-settings"></i>
														</div>
														<div class="menu-info">
															<h4>Settings Updated</h4>
															<p>
																<i class="zmdi zmdi-time"></i> Yesterday
															</p>
														</div>
												</a></li>
											</ul>
										</li>
										<li class="footer"><a href="javascript:void(0);">View
												All Notifications</a></li>
									</ul></li> -->
								
								<c:choose>
									<c:when test="${sessionScope.userId == null}">
										<li><a
											href="${pageContext.request.contextPath}/signIn.do">?????????</a></li>
									</c:when>

									<c:when test="${sessionScope.adgwon == 1}">
										<li class="dropdown"><a href="javascript:void(0);"
											class="dropdown-toggle" data-toggle="dropdown" role="button"
											aria-haspopup="true" aria-expanded="false">
												<p>${sessionScope.userId}??????????????????.</p>
										</a>
											<ul class="dropdown-menu dropdown-menu-right">
												<li><a
													href="${pageContext.request.contextPath}/adminPage.do"><i
														class="zmdi zmdi-chart"></i>?????? ?????????</a></li>
												<li><a
													href="${pageContext.request.contextPath}/adminEdit.do"><i
														class="zmdi zmdi-assignment-account"></i>?????? ??????</a></li>
												<li><a
													href="${pageContext.request.contextPath}/adminList.do"><i
														class="zmdi zmdi-alert-circle"></i>?????? ??????</a></li>
												<li><a
													href="${pageContext.request.contextPath}/adminFAQ.do"><i
														class="zmdi zmdi-comments"></i>?????? ??????</a></li>
												<li><a id="logoutBtn" href=#><i
														class="zmdi zmdi-flight-takeoff"></i>?????? ??????</a></li>
											</ul></li>
									</c:when>

									<c:otherwise>
										<li class="dropdown"><a href="javascript:void(0);"
											class="dropdown-toggle" data-toggle="dropdown" role="button"
											aria-haspopup="true" aria-expanded="false">
												<p>${sessionScope.userNickname}??????????????????.</p>
										</a>
											<ul class="dropdown-menu dropdown-menu-right">
												<li><a
													href="${pageContext.request.contextPath}/myPage.do">???????????????</a></li>
												<li><a
													href="${pageContext.request.contextPath}/myPageEdit.do">????????????</a></li>
												<li><a
													href="${pageContext.request.contextPath}/myFAQ.do">1:1??????</a></li>
												<li><a id="logoutBtn" href=#>????????????</a></li>
											</ul></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
					</div>
					<div class="navbar-collapse">
						<!-- Nav tabs -->
						<ul class="nav col-md-12 col-xs-12 nav-tabs">
							<li class="nav-item col-md-12 col-xs-1" role="presentation"
								class="active"><a
								href="${pageContext.request.contextPath}/main.do"> <img
									alt="logo"
									src="${pageContext.request.contextPath}/imgs/logo2.png">
							</a></li>
							<li class="nav-item col-md-3" role="presentation"><a
								href="${pageContext.request.contextPath}/cListAll.do"> <h4><i
									class="zmdi zmdi-email"></i>???????????????</h4>
							</a></li>
							<li class="nav-item col-md-3" role="presentation"><a
								href="${pageContext.request.contextPath}/gameMain.do"> <h4><i
									class="zmdi zmdi-email"></i>?????????</h4>
							</a></li>
							<li class="nav-item col-md-3 dropdown" role="presentation" class="community_li"><a
								href="${pageContext.request.contextPath}/Community_main.do">
									<h4><i class="zmdi zmdi-email"></i>????????????</h4>
									
							</a>
							<ul class="dropdown-menu">
								<li><a
									href="${pageContext.request.contextPath}/Community_list.do?list=1">???????????????</a></li>
								<li><a
									href="${pageContext.request.contextPath}/Community_list.do?list=2">????????????</a></li>
								<li><a 
									href="${pageContext.request.contextPath}/Community_list.do?list=3">QnA</a></li>
								<li><a id="logoutBtn" href="${pageContext.request.contextPath}/Community_list.do?list=4">???????????????</a></li>
							</ul>
							</li>
							<li class="nav-item col-md-3" role="presentation"><a
								href="${pageContext.request.contextPath}/search_list.do"> <h4><i
									class="zmdi zmdi-email"></i>????????????</h4>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="chatBtn">
		<img id="chatBtnImg" src="${pageContext.request.contextPath}/imgs/chatBtn.png">
	</div>
								
	<div id="followChat">
		<iframe id="chatFrame" src="${pageContext.request.contextPath}/index.jsp" width=400px; height=600px; frameborder=0 scrolling=yes></iframe>
	</div> 