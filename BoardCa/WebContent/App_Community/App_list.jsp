<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="CommunityModel.Heart"%>
<%@page import="java.util.List"%>
<%@page import="CommunityModel.BoardList"%>
<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@page import="CommunityModel.CommunityDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardCa :: Community</title>
<style>
#menu li:hover {
	text-decoration: underline;
}
</style>
<!-- Favicon-->
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Custom Css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/css/style.min.css"
	type="text/css">
</head>
<body>
	<%
	String MEM_ID = "";
	if(request.getParameter("id") != null) {
		MEM_ID = request.getParameter("id");
	}
	int list_num = 0;
	if(request.getParameter("list") !=null){
		list_num = Integer.parseInt(request.getParameter("list"));
	}
	System.out.println(MEM_ID);
	System.out.println(list_num);
		List<CommunityDto> list = (List<CommunityDto>) request.getAttribute("list");
	BoardList viewname = (BoardList) request.getAttribute("viewname");
	String community_title = viewname.getCAT_NAME();
	int boardnum = viewname.getBRD_CAT_IDX();
	Date semple = new Timestamp((System.currentTimeMillis() / 1000L) * 1000L);
	SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	int leng = list.size();

	int showCount = 10;

	int pageCount = leng / showCount + 1;

	if (leng % showCount == 0) {
		pageCount -= 1;
	}

	int maxPage = 5;

	int pages = 1;
	if (request.getParameter("page") != null) {
		pages = Integer.parseInt(request.getParameter("page"));
	}

	int startNum = (pages - 1) * showCount;
	int endNum = (pages - 1) * showCount + showCount;

	int a = (pages - 1) / maxPage;

	int startPage = (a == 0) ? 1 : a * maxPage + 1;
	int endPage = startPage + maxPage - 1;
	%>
<section class="content">
	<!-- <section class="content"
		style="margin-left: auto; margin-right: auto; padding-left: 10%; padding-right: 10%;"> -->
	<%-- <div class="row">
			<div>
				<img src="${pageContext.request.contextPath}/imgs/logo1.png"
					height="250em" />
			</div>
		</div> --%>
	<%-- <div class="alert alert-warning" id="menu" role="alert">
			<ul
				style="list-style: none; padding: 0; margin: 0; overflow: hidden;">
				<li style="width: 25%; float: left; text-align: center;">?????? ?????????</li>
				<li style="width: 25%; float: left; text-align: center;">?????????</li>
				<li style="width: 25%; float: left; text-align: center;"><a
					href="${pageContext.request.contextPath}/Community_main.do">????????????</a></li>
				<li style="width: 25%; float: left; text-align: center;">?????? ??????</li>
			</ul>
		</div> --%>
	<div class="body_scroll">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12">
					<div class="card"">
						<div class="table-responsive">
							<table
								class="table table-hover product_item_list c_table theme-color mb-0"
								style="width: 100%;">
								<thead>
									<tr height="40px" width="100%"
										style="box-sizing: content-box; border: 1px ridge; background-color: #f8f9fa">
										<th width="10%" height="auto" style="text-align: center; color: black;">??????</th>
										<th width="10%" height="auto" style="text-align: center; color: black;">?????????</th>
										<th width="50%" height="auto" style="text-align: center; color: black;">??????</th>
										<th width="10%" height="auto" style="text-align: center; color: black;">??????</th>
										<th width="10%" height="auto" style="text-align: center; color: black;">?????????</th>
										<th width="10%" height="auto" style="text-align: center; color: black;">?????????</th>
									</tr>
								</thead>
								<tbody>
									<%
										for (int i = startNum; i < endNum; i++) {
										if (i >= list.size())
											break;
										CommunityDto dto = list.get(i);
									%>
									<tr class="list" style="box-sizing: content-box;">
										<td class="Ctd" width="10%" height="auto" align="center"
											style="white-space: normal;"><%=dto.getBRD_IDX()%></td>
										<td width="10%" height="auto" align="center"
											style="white-space: normal;"><%=dto.getBRD_WRT_NICKNAME()%></td>
										<td width="40%" height="auto" align="center"
											style="white-space: normal;"><%=dto.getBRD_TIT()%></td>
										<%
											if ((format1.format(semple)).equals(format1.format(dto.getBRD_SYSDATE()))) {
											SimpleDateFormat format2 = new SimpleDateFormat("HH???mm???");
										%>
										<td width="10%" height="auto" align="center"
											style="white-space: normal;"><%=format2.format(dto.getBRD_SYSDATE())%></td>
										<%
											} else {
										SimpleDateFormat format3 = new SimpleDateFormat("MM-dd HH:mm");
										%>
										<td width="10%" height="auto" align="center"
											style="white-space: normal;"><%=format3.format(dto.getBRD_SYSDATE())%></td>

										<%
											}
										%>
										<td width="10%" height="auto" align="center"
											style="white-space: normal;"><%=dto.getBRD_VIEWS()%></td>
										<td width="10%" height="auto" align="center"
											style="white-space: normal;"><%=dto.getCOUNT()%></td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</div>
					</div>
					<div class="card">
						<div class="body">
							<ul class="pagination pagination-primary m-b-0">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/App_list.do?list=<%=list.get(0).getCATEGORY_IDX() %>&page=<%=(startPage-maxPage>0)?startPage-maxPage:1%>"><%-- ?????? --%><i
										class="zmdi zmdi-arrow-left"></i></a></li>

								<%
									for (int i = startPage - 1; i < endPage; i++) {
									if (i >= pageCount)
										break;

									if (pages == i + 1) {
								%>


								<li class="page-item active"><a class="page-link"
									href="${pageContext.request.contextPath}/App_list.do?list=<%=list.get(i).getCATEGORY_IDX() %>&page=<%=i+1%>"><%-- ?????? --%><%=i + 1%></a></li>
								<%
									} else {
								%>

								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/App_list.do?list=<%=list.get(i).getCATEGORY_IDX() %>&page=<%=i+1%>"><%=i + 1%></a></li>
								<%
									}
								}
								%>

								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/App_list.do?list=<%=list.get(0).getCATEGORY_IDX() %>&page=<%=(endPage+maxPage>=pageCount)?pageCount:endPage+1%>"><i
										class="zmdi zmdi-arrow-right"></i></a></li>
								<div style="width: 100%"></div>
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

	<script src="http://code.jquery.com/jquery.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							$('.list').click(
									function() {
										var num = $(this).children(0).eq(0)
												.text();
										$(location).attr(
												'href',
												'${pageContext.request.contextPath}/App_detail.do?num=' // ??????
														+ num+"&MEM_ID=<%=MEM_ID%>&list_num=<%=list_num%>");
									});
						});
	</script>
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