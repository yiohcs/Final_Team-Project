<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">

<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Favicon-->
<!-- Favicon-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css"
	type="text/css">

<!-- Custom Css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/css/style.min.css"
	type="text/css">

</head>



<!-- body -->

<body class="theme-blush ls-closed ls-toggle-menu ">
	<jsp:include page="/WEB-INF/header.jsp"></jsp:include>

	<div class="body_scroll">
		<div class="block-header">
			<div class="row">
				<div class="card">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<h2>myFavorite</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="index.html"><i
									class="zmdi zmdi-home"></i> Aero</a></li>
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/myPage.do">myPage</a></li>
							<li class="breadcrumb-item active">myFavorite</li>

						</ul>
						<button class="btn btn-primary btn-icon float-right n"
							type="button">
							<i class="zmdi zmdi-sort-amount-desc"></i>
						</button>
					</div>
				</div>

			</div>
		</div>

		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12">
					<div class="card">
						<div class="table-responsive">
							<table
								class="table table-hover product_item_list c_table theme-color mb-0">
								<thead>
									<tr>

										<th>Product Name</th>

									</tr>
								</thead>
								<tbody>
									<tr>

										<td><h5>Simple Black Clock</h5></td>

									</tr>
									<tr>

										<td><h5>Brone Candle</h5></td>

									</tr>
									<tr>

										<td><h5>Wood Simple Clock</h5></td>

									</tr>
									<tr>

										<td><h5>Unero Small Bag</h5></td>


									</tr>
									<tr>
										<td><h5>Simple Black Clock</h5></td>
									<tr>
										<td><h5>Simple Black Clock</h5></td>
									</tr>
									<tr>
										<td><h5>Simple Black Clock</h5></td>
									</tr>
								</tbody>
							</table>
						</div>

						<ul class="pagination pagination-primary m-b-0">
							<li class="page-item"><a class="page-link"
								href="javascript:void(0);"><i class="zmdi zmdi-arrow-left"></i></a></li>
							<li class="page-item active"><a class="page-link"
								href="javascript:void(0);">1</a></li>
							<li class="page-item"><a class="page-link"
								href="javascript:void(0);">2</a></li>
							<li class="page-item"><a class="page-link"
								href="javascript:void(0);">3</a></li>
							<li class="page-item"><a class="page-link"
								href="javascript:void(0);">4</a></li>
							<li class="page-item"><a class="page-link"
								href="javascript:void(0);"><i class="zmdi zmdi-arrow-right"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Jquery Core Js -->
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/libscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/vendorscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js -->

	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/bundles/mainscripts.bundle.js"></script>
	<!-- Custom Js -->

	<jsp:include page="/WEB-INF/footer.jsp"></jsp:include>