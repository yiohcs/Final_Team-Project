<%@page import="CommunityModel.BoardList"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardCa</title>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Favicon-->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="assets/plugins/summernote/dist/summernote.css" />
<link rel="stylesheet"
	href="assets/plugins/bootstrap-select/css/bootstrap-select.css" />
<!-- Custom Css -->
<link rel="stylesheet" href="assets/css/style.min.css">
</head>
<body>
	<%
		ArrayList<BoardList> boardList = (ArrayList<BoardList>) request.getAttribute("boardList");
	%>
	<script src="http://code.jquery.com/jquery.js"></script>

	<jsp:include page="/WEB-INF/header.jsp" />
	<!-- <section class="content blog-page"
		style="margin-left: auto; margin-right: auto; padding-left: 10%; padding-right: 10%;"> -->
	<div class="body_scroll">
		<div class="block-header">
			<div class="col-lg-7 col-md-6 col-sm-12">
				<h2>글쓰기</h2>
				<ul class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html"><i
							class="zmdi zmdi-home"></i> BoardCa</a></li>
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/Community_main.do">Community</a></li>
					<li class="breadcrumb-item active">글올리기</li>
				</ul>
				<button class="btn btn-primary btn-icon mobile_menu" type="button">
					<i class="zmdi zmdi-sort-amount-desc"></i>
				</button>
			</div>
			<div class="col-lg-5 col-md-6 col-sm-12"></div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<form
						action="${pageContext.request.contextPath}/Community_inputContent.do"
						method="post">
						<div class="card">
							<div class="body">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="제목"
										name="title" /> 
										<select name="" class="form-control show-tick">
										<option>Select Option</option>
										<%
											for (int i = 0; i < boardList.size(); i++) {
										%>
										<option value="<%=boardList.get(i).getBoard_name()%>"><%=boardList.get(i).getBoard_name()%></option>
										<%
											} // end of for
										%>
									</select>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="body">
								<div class="summernote">
									<textarea name="content" class="form-control" rows=30
										id="content"></textarea>
								</div>
								<input type="submit" class="btn btn-info waves-effect m-t-20"
									id="submit" value="글올리기">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- </section> -->
	<jsp:include page="/WEB-INF/footer.jsp" />
	<!-- Jquery Core Js -->
	<script src="assets/bundles/libscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->
	<script src="assets/bundles/vendorscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->

	<script src="assets/plugins/dropzone/dropzone.js"></script>
	<!-- Dropzone Plugin Js -->

	<script src="assets/bundles/mainscripts.bundle.js"></script>
	<!-- Custom Js -->
	<script src="assets/plugins/summernote/dist/summernote.js"></script>
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/libscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/vendorscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/mainscripts.bundle.js"></script>
</body>
</html>