<%@page import="CommunityModel.BoardList"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js " lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<meta name="description" content="Responsive Bootstrap 4 and web Application ui kit.">

<title>BoardCa :: Community</title>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Favicon-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/assets/plugins/summernote/dist/summernote.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/assets/plugins/bootstrap-select/css/bootstrap-select.css" />
<!-- Custom Css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/assets/css/style.min.css">

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css">

</head>
<body class="theme-blush">
	<%
		ArrayList<BoardList> boardList = (ArrayList<BoardList>) request.getAttribute("boardList");
	%>
<script src="http://code.jquery.com/jquery.js"></script>

	<jsp:include page="/WEB-INF/header.jsp" />
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
                    <div class="card">
                        <div class="body">
                            <div class="form-group">
                                <input type="text" class="form-control" id="title" placeholder="제목을 입력해주세요" maxlength="200"/>
                            </div>
							<select class="form-control show-tick" id="select">
								<option>게시판을 선택해주세요.</option>
								<%
									for (int i = 0; i < boardList.size(); i++) {
										
										if(i==4){
											continue;
										}
										
								%>
								<option><%=boardList.get(i).getCAT_NAME()%></option>
								<%
									} // end of for
								%>
							</select>
						</div>
                    </div>
                    <div class="card">
                        <div class="body">
                            <div class="summernote" id="content">
                            </div>
                            <button type="button" id="submit" class="btn btn-info waves-effect m-t-20">전송</button>
                        </div>
                    </div>
                </div>            
            </div>
        </div>
    </div>
    	<jsp:include page="/WEB-INF/footer.jsp" />

	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
      $( document ).ready( function() {
    	  $('#submit').click(function() {
    		  var select = $('#select').val(); // 게시판
    		  var title = $('#title').val(); // 제목
    		  var username = "${sessionScope.userNickname}"; // 작성자 닉네임
    		  var content = $( '.note-editable' ).html(); // 내용
   
    		  
    		  var title_trim = $.trim($("#title").val());
    		  var content_sub;
    		  var boardnum;
  			<%for (int i = 0; i < boardList.size(); i++) {%>
  				if((select)=="<%=boardList.get(i).getCAT_NAME()%>"){
  					boardnum=<%=boardList.get(i).getBRD_CAT_IDX()%>
  					console.log(boardnum)
  				}
  				<%}%>
    		  
    		  if(select == "게시판을 선택해주세요."){
    	 		  alert("게시판을 선택해주세요")
    		  }else{
    			  if(title == "" || title_trim == ""){
    				  alert("제목을 입력해주세요")  
    			  }
    			  else{
 					var dto = {
 							BRD_TIT: title,
 							CATEGORY_IDX: boardnum,
 							BRD_WRT_ID: username,
 							BRD_CONTENT: content
							};
					
					$.ajax({
						url: "Community_inputContent.do",
						type: "POST",
						datatype: 'application/json',
						data: dto,
						success: function() {
							alert('게시글 작성이 완료되었습니다!');
							// 게시글 작성후 해당 리스트로
							$(location).attr('href', '${pageContext.request.contextPath}/Community_list.do?list='+boardnum);
						}
					})

    		  }
    			
		};
      })
      });
    </script>


	<!-- Jquery Core Js --> 
<script src="${pageContext.request.contextPath}/stylesheet/assets/bundles/libscripts.bundle.js"></script> <!-- Lib Scripts Plugin Js --> 
<script src="${pageContext.request.contextPath}/stylesheet/assets/bundles/vendorscripts.bundle.js"></script> <!-- Lib Scripts Plugin Js --> 

<script src="${pageContext.request.contextPath}/stylesheet/assets/plugins/dropzone/dropzone.js"></script> <!-- Dropzone Plugin Js --> 

<script src="${pageContext.request.contextPath}/stylesheet/assets/bundles/mainscripts.bundle.js"></script><!-- Custom Js -->
<script src="${pageContext.request.contextPath}/stylesheet/assets/plugins/summernote/dist/summernote.js"></script>
</body>
</html>