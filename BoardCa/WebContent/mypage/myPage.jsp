<%@page import="Member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">

<title>:: BoardCa :: MYPAGE</title>
<link rel="icon" href="/BoardCa/stylesheet/favicon.ico"
	type="image/x-icon">
<!-- Favicon-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css">
<!-- Custom Css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/css/style.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/sweetalert/sweetalert.css">
</head>
<%
	MemberDto dto = (MemberDto) request.getAttribute("memInfo");
%>



<body class="ls-closed ls-toggle-menu ">
	<!-- header -->
	<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
	<!-- body -->

	<div class="body_scroll">
		<div class="block-header">
			<div class="row">
				<div class="card">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<h2>myPage</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/main/main.jsp"><i
									class="zmdi zmdi-home"></i> BoardCa</a></li>
							<li class="breadcrumb-item active">myPage</li>

						</ul>
						<a href="${pageContext.request.contextPath}/myPageEdit.do"
							class="btn btn-info btn-icon float-right"><i
							class="zmdi zmdi-edit"></i></a>

					</div>
				</div>

			</div>
		</div>
	</div>


	<div class="row clearfix">

		<div class="col-md-12">
			<div class="d-flex">
				<div class="mobile-left">
					<a class="btn btn-info btn-icon toggle-email-nav collapsed"
						data-toggle="collapse" href="#mypage-nav" role="button"
						aria-expanded="false" aria-controls="email-nav"> <span
						class="btn-label"><i class="zmdi zmdi-account"></i></span>
					</a>
				</div>
				<div class="inbox left collapse" id="mypage-nav" style="">
					<div class="mail-side">
						<a href="${pageContext.request.contextPath}/myPage.do"><h5>MYPAGE</h5></a>
						<ul class="nav">
							<li><a
								href="${pageContext.request.contextPath}/myPageEdit.do"><i
									class="zmdi zmdi-edit"></i>Edit</a></li>
							<li><a
								href="${pageContext.request.contextPath}/myWriteList.do"><i
									class="zmdi zmdi-file"></i>Writted</a></li>
							<li><a href="${pageContext.request.contextPath}/myFAQ.do"><i
									class="zmdi zmdi-comments"></i>FAQ</a></li>
							<li><a
								href="${pageContext.request.contextPath}/myFavorite.do"><i
									class="zmdi zmdi-favorite"></i>Favorite</a></li>
							<li><a href="${pageContext.request.contextPath}/mySaved.do"><i
									class="zmdi zmdi-folder-star"></i>Saved</a></li>


						</ul>
					</div>
				</div>

				<div class="col-lg-11 col-md-12 col-sm-11 inbox right">
					<div class="card mcard_3">
						<div class="body">
							<%
								if (dto.getMem_gender().equals("")) {
							%>
							<a href="${pageContext.request.contextPath}/myPage.do"><img
								src="${pageContext.request.contextPath}/mypage/imgs/?????????.png"
								class="rounded-circle shadow " alt="profile-image"
								style="width: 20%; height: 20%;"></a>
							<%
								} else if (dto.getMem_gender().equals("???")) {
							%>
							<a href="${pageContext.request.contextPath}/myPage.do"><img
								src="${pageContext.request.contextPath}/mypage/imgs/??????.png"
								class="rounded-circle shadow " alt="profile-image"
								style="width: 20%; height: 20%;"></a>
							<%
								} else if (dto.getMem_gender().equals("???")) {
							%>
							<a href="${pageContext.request.contextPath}/myPage.do"><img
								src="${pageContext.request.contextPath}/mypage/imgs/??????.png"
								class="rounded-circle shadow " alt="profile-image"
								style="width: 20%; height: 20%;"></a>
							<%
								}
							%>
							<h4 class="m-t-10"><%=dto.getMem_nickname()%></h4>

						</div>
					</div>
					<div class="card">
						<div class="body">
							<small class="text-muted">Gender: </small>
							<%
								String gender = dto.getMem_gender();
							if (gender.equals("")) {
								gender = "?????????";
							} else if (gender.equals("???")) {
								gender = "??????";
							} else if (gender.equals("???")) {
								gender = "??????";
							}
							%>
							<p><%=gender%></p>
							<hr>
							<small class="text-muted">AgeRange: </small>
							<p><%=dto.getMem_age_group()%></p>
							<hr>
							<small class="text-muted">Email Address: </small>
							<p><%=dto.getMem_email()%></p>
							<hr>
							<small class="text-muted">Address: </small>
							<p><%=dto.getMem_rocal() + " " + dto.getMem_state()%></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




	<jsp:include page="/WEB-INF/footer.jsp"></jsp:include>
	<!-- Jquery Core Js -->
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/libscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/vendorscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->

	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/plugins/light-gallery/js/lightgallery-all.min.js"></script>
	<!-- Light Gallery Plugin Js -->


	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/mainscripts.bundle.js"></script>
	<!-- Custom Js -->

</body>
</html>