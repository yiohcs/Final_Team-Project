<%@page import="Food.CDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js " lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">

<title>:: Aero Bootstrap4 Admin :: Profile</title>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Favicon-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css"
	type="text/css">
<!-- Light Gallery Plugin Css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/light-gallery/css/lightgallery.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/plugins/fullcalendar/fullcalendar.min.css"
	type="text/css">
<!-- Custom Css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/stylesheet/assets/css/style.min.css"
	type="text/css">
<script src="http://code.jquery.com/jquery.js"></script>
<style>
.num_btn_div{
width: 230px;
margin: 0 auto;
}
</style>
</head>

<%
	// 최대 보일 리스트 개수
	int maxList = 10;
	request.setAttribute("maxList", maxList);

	// 페이지당 리스트 개수
	int listNum = 20;
	
	int now_page = 1;

	//보여줄 리스트 배열 번호 선언
	int itemCount = 0;

	// 리스트 목록
	List<CDto> list = (List<CDto>)request.getAttribute("cList");
	System.out.println("리스트 개수: " + list.size());
	
	// 보여줄 리스트 배열 번호 (페이지번호 * 페이지에 보여주는 리스트 개수)
	if(request.getParameter("page") != null){
		now_page = Integer.parseInt(request.getParameter("page"));
		if(now_page <= 0)
			response.sendRedirect("${pageContext.request.contextPath}/cListAll.do?page=1");
		itemCount = (Integer.parseInt(request.getParameter("page")) -1) * listNum;
	}
	
	// 리스트 개수
	int listCount = list.size()/listNum;
	
	// 시작 페이지
	int startList = now_page/(maxList+1) * maxList + 1;
	
	// 최대 페이지
	int endList = now_page/(maxList+1) * maxList + maxList;
	
%>

<script>
function Request(){
    var requestParam ="";
	 
	//getParameter 펑션
	this.getParameter = function(param){
        //현재 주소를 decoding
        var url = unescape(location.href); 
        //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다. 
        var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&"); 
        
        for(var i = 0 ; i < paramArr.length ; i++){
           var temp = paramArr[i].split("="); //파라미터 변수명을 담음
        
           if(temp[0].toUpperCase() == param.toUpperCase()){
             // 변수명과 일치할 경우 데이터 삽입
             requestParam = paramArr[i].split("=")[1]; 
             break;
           }
        }
        return requestParam;
    }
}
/* 
// Request 객체 생성
var request = new Request();
// test 라는 파라메터 값을 얻기
request.getParameter("test");
 */
</script>

<body class="ls-closed ls-toggle-menu theme-orange">
	<script>
		var request = new Request();
		var page = request.getParameter("page");
		var maxList = <%= request.getAttribute("maxList") %>
		$('document').ready(function(){
			if(page <= 0)
				page = 1;
			if(page >= maxList+1)
			page = page % maxList + 2;
			
			// 목록 버튼 사이즈 조절 
			var wd = 0;
			if($('.page-item').length >= maxList+2)
			{
				wd = 40 * (maxList+2) - 40;
			}else{
				wd = 40 * $('.page-item').length - 40;
			}
			$('.num_btn_div').css('width',wd+'px');
			
			// 버튼 눌림 효과클래스 추가
			$('.page-item').eq(page).addClass('active');
		});
	</script>
	<header class="body_header">
		<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
	</header>
	<!-- Loding Page -->
	<div class="page-loader-wrapper">
		<div class="loader">
			<div class="m-t-30">
				<img class="zmdi-hc-spin"
					src="${pageContext.request.contextPath}/stylesheet/assets/images/loader.svg"
					style="width: 48px; height: 48px; alt: Aero;">
			</div>
			<p>Please wait...</p>
		</div>
	</div>

	
<section class="content file_manager"style="margin: auto;">
    <div class="body_scroll">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="tab-content">
                            <div class="tab-pane active" id="2019">
                                <div class="row clearfix">
                                <% for(int i=itemCount;i<list.size();i++) {
                                	if(i>itemCount+listNum-1)
                                		break;
                                	CDto dto = list.get(i);
                                %> 
                                    <div class="col-lg-3 col-md-4 col-sm-12">
                                        <div class="card">
                                            <div class="file">
                                                <a href="<%=dto.getR_crawling_addr()%>">
                                                    <div class="hover">
                                                        <button type="button" class="bg-orange btn btn-icon btn-icon-mini btn-round bg-orange">
                                                            <i class="ti-heart"></i>
                                                        </button>
                                                    </div>
                                                    <div class="icon" >
                                                        <img src="<%=dto.getR_main_thumbs()%>" height="150" >
                                                    </div>
                                                    <div class="file-name" style="height:100px">
                                                        <p class="m-b-5 text-muted"><%=dto.getR_title() %></p>
                                                       
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <% }%>
                                </div>
                            </div>     
                        </div>
                    </div>
                </div>
            </div>
            <div class="num_btn_div">
            	<ul class="pagination pagination-primary m-b-0">
                     <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/cListAll.do?page=<%=(startList-10>0)?startList-10:1 %>"><i class="zmdi zmdi-arrow-left"></i></a></li>
                     <!-- class = "active" -->
                     <% for(int i=startList;i<=endList;i++){ 
                     	if(i>listCount)
                     		break;
                     %>
                     <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/cListAll.do?page=<%=i%>"><%=i %></a></li>
                     <%} %>
                     <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/cListAll.do?page=<%=endList+1%>"><i class="zmdi zmdi-arrow-right"></i></a></li>
                  </ul>
            </div>
        </div>
    </div>
</section>
<footer>
	<jsp:include page="/WEB-INF/footer.jsp"></jsp:include>
</footer>
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
	<script
		src="${pageContext.request.contextPath}/stylesheet/assets/js/pages/medias/image-gallery.js"></script>
</body>
</html>