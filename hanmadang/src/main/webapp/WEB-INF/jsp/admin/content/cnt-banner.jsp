<%@ page contentType = "text/html;charset=utf-8" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당 - 관리자</title>
<link rel="stylesheet" type="text/css" href="/admin/assets/css/style.css">
<link rel="stylesheet" type="text/css" href="/admin/assets/css/admin.css">
<!--[if lt IE 9]>
<script src="/admin/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/admin/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery-ui-datepicker-1.12.1.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- contents -->
	<main id="admin-sub" role="main">
		<div class="admin-page">
			<%@ include file="../common/menu.jsp"%>
			<div class="page-wrap">
				<div id="page-inner">
					<article class="container-header">
						<h2>컨텐츠 관리</h2>
					</article>
					<div class="container-tabs">
						<a href="${ADMIN_PATH}/content/banner" class="by-4 is-selected">배너 관리</a>
						<a href="${ADMIN_PATH}/content/popup" class="by-4">팝업 관리</a>
						<a href="${ADMIN_PATH}/content/notice" class="by-4">공지사항 관리</a>
						<a href="${ADMIN_PATH}/content/program" class="by-4">프로그램 관리</a>
					</div>
					<article class="container-body">
						<h3 class="h3-title">현재 배너 리스트</h3>
						<div class="h3-desc">업로드한 배너가 홈화면에 롤링 되며, 최대 3개의 배너를 업로드 할 수 있습니다.</div>

						<h3 class="h3-title">새 배너 등록하기</h3>
						<div class="col-caption">배너내용 / 등록</div>
						<form id="modForm" method="post" action="${ADMIN_PATH}/content/banner/save"  enctype="multipart/form-data">
						<div class="col-table clearfix">
							<div class="col-3 cell-m cell-c">
								<div class="thumbnail-280"><img src="http://via.placeholder.com/1920x1080"></div>
							</div>
							<div class="col-6 cell-t">
								<div class="add-banner">
									<div class="line-form">
										<label class="line-form-name" for="banner-word3">배너 문구</label>
										<input type="text" class="text" name="b_name" id="banner-word3" style="width:400px;" />
										<!-- <span class="checkbox checkbox--type1">
											<input type="checkbox" name="name_yn" id="b1" checked="">
											<label for="b1">문구없음</label>
										</span> -->
									</div>
									<div class="line-form">
										<label class="line-form-name" for="banner-file">이미지 업로드</label>
										<input type="file" class="text" name="img" id="banner-file" onchange="readURL(this)" accept="image/*" style="width:200px;" />* 최적화 사이즈 1920 X 1080
										<input type="hidden" name="b_img" value=""/>
									</div>
									<div class="line-form">
										<label class="line-form-name" for="banner-line1">배너 링크</label>
										<input type="text" class="text" name="b_link" id="banner-line1" style="width:400px;" />
										<!-- <span class="checkbox checkbox--type1">
											<input type="checkbox" name="link_yn" id="link1" checked="">
											<label for="link1">링크없음</label>
										</span> -->
									</div>
									<p class="line-form">* 모든 사항 입력 후, 등록버튼을 선택하면 현재 배너 리스트에 적용됩니다.</p>
								</div>
							</div>
							<div class="col-3 cell-c cell-m">
								<button type="submit" class="btn btn-level btn-default">등록</button>
							</div>
						</div>
						</form>
						<!-- <div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="300px">
									<col width="*">
									<col width="100px">
								</colgroup>
								<thead>
									<tr>
										<th colspan="2">배너내용</th>
										<th>등록</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><div class="thumbnail-280"><img src="http://via.placeholder.com/1920x1080"></div></td>
										<td>
											<div class="add-banner">
												<div class="line-form">
													<label class="line-form-name" for="banner-word3">배너 문구</label>
													<input type="text" class="text" id="banner-word3" style="width:400px;" />
													<span class="checkbox checkbox--type1">
														<input type="checkbox" name="" id="b1" checked="">
														<label for="b1">문구없음</label>
													</span>
												</div>
												<div class="line-form">
													<label class="line-form-name" for="banner-file">이미지 업로드</label>
													<input type="file" class="text" id="banner-file" style="width:200px;" />* 최적화 사이즈 1920 X 1080
												</div>
												<div class="line-form">
													<label class="line-form-name" for="banner-line1">배너 링크</label>
													<input type="text" class="text" id="banner-line1" style="width:400px;" />
													<span class="checkbox checkbox--type1">
														<input type="checkbox" name="" id="link1" checked="">
														<label for="link1">링크없음</label>
													</span>
												</div>
												<p class="line-form">* 모든 사항 입력 후, 등록버튼을 선택하면 현재 배너 리스트에 적용됩니다.</p>
											</div>
										</td>
										<td><a href="#" class="btn btn-level btn-default">등록</a></td>
									</tr>
								</tbody>
							</table>
						</div> -->

						<h3 class="h3-title">현재 배너 리스트</h3>
						<div class="h3-desc">업로드한 배너가 홈화면에 롤링 되며, 최대 3개의 배너를 업로드 할 수 있습니다.</div>
						<div class="col-caption">배너내용 / 등록,수정,삭제</div>
						<c:forEach items="${list }" var="item" varStatus="status">
						<form id="modForm1" method="post" action="${ADMIN_PATH}/content/banner/save"  enctype="multipart/form-data">
						<div class="col-table clearfix">
							<div class="col-1 cell-m cell-c"><c:out value="${item.idx_no}"/></div>
							<div class="col-3 cell-m cell-c">
								<div class="thumbnail-280"><img src="/upload/<c:out value="${item.b_img}"/>"></div>
							</div>
							<div class="col-6 cell-t">
								<div class="add-banner">
									<div class="line-form">
										<label class="line-form-name" for="banner-wordv">배너 문구</label>
										<input type="text" class="text" name="b_name" id="banner-wordv" style="width:400px;" value="<c:out value="${item.b_name}"/>"/>
										<%-- <span class="checkbox checkbox--type1">
											<input type="checkbox" name="name_yn" id="aaa" <c:if test="${empty item.b_name}">checked</c:if>>
											<label for="aaa">문구없음</label>
										</span> --%>
									</div>
									<div class="line-form">
										<label class="line-form-name" for="banner-file">이미지 업로드</label>
										<input type="file" class="text" name="img" id="banner-file" onchange="readURL(this)" accept="image/*" style="width:200px;" style="width:200px;" />* 최적화 사이즈 1920 X 1080
										<input type="hidden" name="b_img" value="<c:out value="${item.b_img}"/>"/>
									</div>
									<div class="line-form">
										<label class="line-form-name" for="banner-linev">배너 링크</label>
										<input type="text" class="text" name="b_link" id="banner-linev" style="width:400px;" value="<c:out value="${item.b_link}"/>"/>
										<%-- <span class="checkbox checkbox--type1">
											<input type="checkbox" name="link_yn" id="bbb" <c:if test="${empty item.b_link}">checked</c:if>>
											<label for="bbb">링크없음</label>
										</span> --%>
									</div>
									<p class="line-form">* 모든 사항 입력 후, 등록버튼을 선택하면 현재 배너 리스트에 적용됩니다.</p>
								</div>
							</div>
							<div class="col-3 cell-c cell-m">
								<button type="submit" class="btn btn-level btn-rental">수정</button><br><a href="#" data-seq="<c:out value="${item.idx_no}"/>" class="btn btn-level btn-copy">삭제</a>
							</div>
						</div>
						<input type="hidden" name="idx_no" value="<c:out value="${item.idx_no}"/>"/>
						</form>
						</c:forEach>
						
					</article>
				</div>
			</div>
		</div>
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
function readURL(input) {
	var url = input.value;
	var $fileInput = $(input);
	var $img = $fileInput.parents('.col-table').find(".thumbnail-280 img");
	
	if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    	$img.attr('src', e.target.result);
	    }
	    reader.readAsDataURL(input.files[0]);
	}
}


$(function(){
	
	$(".btn-copy").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var seq = $(this).data("seq");
			$.ajax({
			     url:'${ADMIN_PATH}/content/banner/delete',
			  	data:"idx_no="+seq,
			     type: 'POST',
			     error: function(){
			    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
			     },
			     success: function(res){
			    	/*  console.log(res); */
			         if(res=='SUCCESS'){
			             alert("성공적으로 처리되었습니다.")
			             location.reload(true);
			         }else{
			        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
			         }
			     }
			 });
		}
	});
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            input_value = form.find('input[name="b_img"]').val();
            if(input_value == ''  && form.find('input[name="img"]').val() == ''){
            	alert("이미지를 선택해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("성공적으로 처리되었습니다.");
    			location.reload(true);
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
});

</script>
</body>
</html>