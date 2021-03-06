<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<title></title>
<link rel="stylesheet"
	href="/BoardCa/stylesheet/assets/plugins/dropify/css/dropify.min.css">
<link rel="icon" href="/BoardCa/stylesheet/favicon.ico"
	type="image/x-icon">
<!-- Favicon-->
<link rel="stylesheet"
	href="/BoardCa/stylesheet/assets/plugins/bootstrap/css/bootstrap.min.css">
<!-- Custom Css -->
<link rel="stylesheet"
	href="/BoardCa/stylesheet/assets/css/style.min.css">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
	
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$('#like').text();
	var count = 0;
	var order_cnt = 1;
	var cnt = 1;
	var check = true;
	
	var fileValue = '';
	var fileName = '';
	
	var ingre_info = '';
	var cooking_order = '';
	var new_fileName = '';
	
	var order1 = [];
	var order2 = [];
	
	$(function() {
		$('#heart').click(
				function() {
					count++;
					console.log(count)
					$('#like').html(
							'<small class="bg-orange" id="like">' + count
									+ '</small>')
				})
	});
	function remove_list(item) {
		$(item).parent().parent().remove();
		order_cnt -= 1;
		
		$('.order_count').each(function(index,item){
			$(item).text(index+1);
		})
	}
	
	function getContextPath(){
		var hostIndex = location.href.indexOf(location.host) + location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
	}
	
	function fileNameCheck(index, item){
		var formData = new FormData($('#file_form')[0]);
		$.ajax({
			type : "post",
			url : "/BoardCa/cFileNameCheckApp.do",
			data : formData,
			contentType:false,
			processData:false,
			success : function test(a){
				cnt += 1;
				/* $('#fileNameCheckT').val(a);
				
				var new_fileName = $('#fileNameCheckT').val(); */
				new_fileName = a;
				
				//cooking_order += new_fileName + '&';
				order2.push(new_fileName + '&');
				console.log(new_fileName);
				//console.log(cooking_order);
				
				$('#file_form').empty();
				
				if(order_cnt == cnt && check == true){
					$('#write_form').submit();
				}
				
			},
			error : function error(){ 
				alert("error");
			}
		});		
	}
	
	$(document)
			.ready(
					function() {
						var $main_img = $('#main_img');
						var flex_check = $('.flex_check');

						var r_detail_h = $('.r_detail').height()+70;
						//console.log(r_detail_h);
						if ($main_img.width() >= 350) {
							r_detail_h = $('.r_detail').height()
									- $main_img.height();
						}
						$('#content_area').css('height', r_detail_h + 'px');

						$(window)
								.resize(
										function() {
											//console.log(flex_check.css('flex'));
											r_detail_h = $('.r_detail').height() - 100;
											//console.log($('#content_area').val());
											/* if($main_img.width() >= 350){
												r_detail_h = 300;
											} */
											if (flex_check.css('flex') == '0 0 100%'
													|| flex_check.css('flex') == '0 1 auto') {
												r_detail_h = 250;
											}
											$('#content_area').css('height',
													r_detail_h + 'px');
										});
						
						// ?????? ??????
						$('#ingre_addBtn')
								.on(
										'click',
										function() {
											var ingre = $('#ingre_text').val();
											if (ingre == '') {
												alert('????????? ????????? ?????????.');
												return;
											}

											var tag = '<tr><td style="width: 150px;" class="ingre_info">'
													+ ingre
													+ '</td><td>??????: <input type="text" size="10" class="ingre_info"></td>';
											tag += '<td><button type="button" onclick="remove_list(this)">??????</button></td></tr>';
											$('#ingre_list').append(tag);
											$('.ingre_info').last().focus();
											$('#ingre_text').val('');
										});
						
						// ???????????? ??????
						$('#order_addBtn')
						.on(
								'click',
								function() {
									var tag = '<tr><td style="padding: 20px;"><p class="order_count">'+order_cnt+'</p></td>'
									+ '<td><textarea style="width: 250px; height: 195px; resize: none; margin-right:100px;" name="order_text" class="order_info"></textarea></td>'
									+ '<td><input type="file" class="dropify r_detail order_info" name="file2"></td>'
									+'<td><button type="button" onclick="remove_list(this)" style="margin-left: 10px;">??????</button></td></tr>';
									
									$('#cooking_order_table').append(tag);
									console.log(getContextPath())
									/* new Element("script", {src: getContextPath()+"/stylesheet/assets/plugins/dropify/js/dropify.min.js", type: "text/javascript"});
									new Element("script", {src: getContextPath()+"/stylesheet/assets/js/pages/forms/dropify.js", type: "text/javascript"});
									 */
									var body= document.getElementsByTagName('body')[0];
									
									var script= document.createElement('script');
									script.type= 'text/javascript';
									script.src= getContextPath()+'/stylesheet/assets/js/pages/forms/dropify.js';
									script.className = "newScript";
									body.appendChild(script);
									
									var script1= document.createElement('script');
									script1.type= 'text/javascript';
									script1.src= getContextPath()+'/stylesheet/assets/plugins/dropify/js/dropify.min.js';
									script1.className = "newScript";
									body.appendChild(script1);
									
									$('.newScript').remove();
									order_cnt += 1;
								});
						/* $(window).resize(function() {
							var detail_h = $('.r_detail').height();
							var header_h = $('.detail_header').height();
							console.log(detail_h);
							console.log(header_h);
							var mg = detail_h - header_h;
							console.log(mg);
							if(mg-37>0){
								mg = mg - 37;
								$('.detail_footer').css('margin-top', mg+'px');
							}else{
								$('.detail_footer').css('margin-top', '0px');
							}
						}); */
						
						// ????????? ????????????
						$('#write_form').submit(function(event){
							//event.preventDefault();
							
							for(var i=0;i<order1.length;i++){
								cooking_order += order1[i];
								cooking_order += order2[i];
							}

							$('.order_text_list').val(cooking_order);
							console.log($('.order_text_list').val());
							
						});
						
						$("#ingre_text").keyup(function(event) {
						    if (event.keyCode === 13) {
						        $('#ingre_addBtn').click();
						    }
						});
						
						$(document).on('keyup', ".ingre_info", function(event) {
						    if (event.keyCode === 13) {
						        $('#ingre_text').focus();
						    }
						});
						
						$('#write_btn').on('click',function(){
							check = true;
							ingre_info = '';
							cooking_order = '';
							
							order1 = [];
							order2 = [];
							
							if(form.file.value == ''){
								alert("?????? ???????????? ??????????????????");
								return false;
							}else if(form.title.value == ''){
								alert("????????? ??????????????????");
								return false;
							}else if(form.explain.value == ''){
								alert("????????? ??????????????????");
								return false;
							}else if(form.standard.value == ''){
								alert("??????????????? ??????????????????");
								return false;
							}else if(form.cooking_time.value == ''){
								alert("??????????????? ??????????????????");
								return false;
							}else if(form.difficult.value == ''){
								alert("???????????? ??????????????????");
								return false;
							}
							
							// ?????? ???????????? ??????
							$('.ingre_info').each(function(index, item){
								if(index %2 == 0){
									ingre_info += $(item).text() + '&';
									//console.log($(item).text());
								}else{
									ingre_info += $(item).val() + '&';
									//console.log($(item).val());
								}
							});
							
							
							// ???????????? ???????????? ??????
							$('.order_info').each(function(index, item){
								if(index %2 == 0){
									//cooking_order += $(item).val() + '&';
									order1.push($(item).val() + '&');
									//console.log($(item).val());
								}else{
									fileValue = $(item).val().split("\\");
									fileName = fileValue[fileValue.length-1];
									//console.log(fileName);
									var copy = $(item).clone();
									$('#file_form').append(copy);
									$('#file_form').eq(0).removeClass('order_info');
									fileNameCheck();
								}
							});
							
							//console.log(ingre_info);
							$('.ingre_text_list').val(ingre_info);
							
							if(form.ingredient.value == ''){
								alert("????????? ??????????????????");
								check = false;
								return false;
							}
							
							$('.ingre_info').each(function(index, item){
								if(index%2==1){
									if($(item).val() == ''){
										alert("?????? ????????? ??????????????????");
										check = false;
										return false;
									}
								}
							})
							
							if(check == false){
								return false;
							}
							
							$('.order_info').each(function(index, item){
								if(index%2==0){
									if($(item).val() == ''){
										alert("???????????? ????????? ??????????????????");
										check = false;
										return false;
									}
								}else if(index%2==1){
									if($(item).val() == ''){
										alert("???????????? ???????????? ??????????????????");
										check = false;
										return false;
									}
								}
							})
							
							if(check == false){
								return false;
							}
							
							if($('.order_info').length==0){
								alert("??????????????? ??????????????????");
								return false;
							}
							
							
							//console.log($('.ingre_text_list').val());
							
							/* var timeAttack = new Promise(function (resolve, reject) {
								setTimeout(function () {
									for(var i=0;i<order1.length;i++){
										cooking_order += order1[i];
										cooking_order += order2[i];
									}

									$('.order_text_list').val(cooking_order);
									console.log($('.order_text_list').val());
									
									if ($('.order_text_list').val() != '') {
										resolve();
									} else {
										reject();
									}
								}, 10000);
							});
							
							timeAttack.then(function () {
								  console.log('complete');
								}, function () {
								  console.log('error');
								}); */
							
							
							
							//$('#write_form').submit();
						});
						
					});
</script>
</head>


<body class="ls-closed ls-toggle-menu ">
	

	<div class="body_scroll">
		<div class="block-header">
			<div class="row">
				<div class="col-lg-7 col-md-6 col-sm-12">
					<h2>RecipeDetail</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/mainApp.do"><i
								class="zmdi zmdi-home"></i> BoardCa</a></li>
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/cListAllApp.do">RecipeDetail</a></li>
						<li class="breadcrumb-item active">RecipeDetail</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<form id="write_form" name="form" action="${pageContext.request.contextPath}/cUploadApp.do" method="post" enctype="multipart/form-data">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12">
					<div class="card">
						<div class="body">
							<div class="row "> <!-- r_detail -->
								<div class="col-xl-3 col-lg-4 col-md-12 flex_check">
									<!-- <img id="main_img" src="https://recipe1.ezmember.co.kr/cache/recipe/2020/08/25/0fbfab533f6ade9b81906d52a91585551.jpg" style="width:100%; height:100%"> -->
										<input type="file" class="dropify r_detail" name="file">
									</div>
								<div class="col-xl-9 col-lg-8 col-md-12">
									<div class="product details detail_header">
										?????? <input type="text" style="width: 100%;" name="title"
											value="????????? ????????????:???????????????????????? ??????????????????">

										<hr>
										?????? ??????
										<textarea id="content_area" name="explain"
											style="width: 100%; height: 200px; resize: none;">????????? ?????? ?????? ????????? ????????? ????????? ??????????????????.</textarea>
									</div>

								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="body">
							<div class="row">
								<div class="col-lg-12">
									<div>
										<h6>???????????????</h6>
										<hr>
										<p>
											????????????: <input type="text" value="1" size="10" dir="rtl" name="standard"><br>
											????????????: <input type="text" value="10" size="10"dir="rtl" name="cooking_time"><br>
											?????????: <input type="text" value="??????" style="margin-left: 14px" size="10" dir="rtl" name="difficult">
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="body">
							<div class="row">
								<div class="col-lg-12">
									<div>
										<h6>??????</h6>
										<hr>
										<input id="ingre_text" type="text" placeholder="????????????">
										<button id="ingre_addBtn" type="button">????????????</button>
										<table id="ingre_list" style="margin-top: 20px;">
											<!-- ?????? ?????? ?????? -->
										</table>
										<input type="text" class="ingre_text_list" style="visibility: hidden;" name="ingredient">
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="body">
							<div class="row">
								<div class="col-lg-12">
									<div>
										<h6>????????????</h6>
										<button type="button" id="order_addBtn">??????</button>
										<hr>
										<table id="cooking_order_table">
											<tr>
												<!-- <td style="padding: 20px;">1</td>
												<td><textarea style="width: 250px; height: 195px; resize: none; margin-right:100px;"></textarea></td>
												<td><input type="file" class="dropify r_detail" name="file"></td> -->
											</tr>
										</table>
										<input type="text" class="order_text_list" style="visibility: hidden;" name="cooking_order" value="asd">
										<input type="text" id="fileNameCheckT" style="visibility: hidden ;">
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<input id="write_btn" type="button" value="?????????">
	</form>
	<form id="file_form" action="${pageContext.request.contextPath}/cFileNameCheckApp.do" method="post" enctype="multipart/form-data" style="visibility: hidden;">
	</form>



		


		<!-- Jquery Core Js -->
		<script src="https://embed.tawk.to/5c6d4867f324050cfe342c69/default"
			charset="UTF-8"></script>
		<script
			src="${pageContext.request.contextPath}/stylesheet/assets/bundles/libscripts.bundle.js"></script>
		<!-- Lib Scripts Plugin Js -->
		<script
			src="${pageContext.request.contextPath}/stylesheet/assets/bundles/vendorscripts.bundle.js"></script>
		<!-- Lib Scripts Plugin Js -->

		<script
			src="${pageContext.request.contextPath}/stylesheet/assets/bundles/mainscripts.bundle.js"></script>
		<!-- Custom Js -->
		<script
			src="${pageContext.request.contextPath}/stylesheet/assets/plugins/dropify/js/dropify.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/stylesheet/assets/js/pages/forms/dropify.js"></script>
</body>
</html>