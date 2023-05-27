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
						<a href="${ADMIN_PATH}/content/banner" class="by-4">배너 관리</a>
						<a href="${ADMIN_PATH}/content/popup" class="by-4">팝업 관리</a>
						<a href="${ADMIN_PATH}/content/notice" class="by-4 is-selected">공지사항 관리</a>
						<a href="${ADMIN_PATH}/content/program" class="by-4">프로그램 관리</a>
					</div>
					<article class="container-body">
						<h3 class="h3-title">공지사항 리스트</h3>
						<div class="h3-desc">한마당 새소식에 소개되는 컨텐츠입니다.</div>

						<h3 class="h3-title">새 공지사항 등록하기</h3>
						<div class="table-basic">
							<form id="modForm" method="post" action="${ADMIN_PATH}/content/notice/save"  enctype="multipart/form-data">
							<table class="table-basic-type2">
								<colgroup>
									<col width="300px">
									<col width="*">
									<col width="150px">
								</colgroup>
								<thead>
									<tr>
										<th colspan="2">공지사항 내용</th>
										<th>등록/수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><div class="thumbnail-280"><img src="http://via.placeholder.com/1920x1080"></div></td>
										<td>
											<div class="add-banner">
												<div class="line-form">
													<label class="line-form-name" for="banner-word">제목</label>
													<input type="text" class="text" name="title" id="banner-word" style="width:400px;" placeholder="30자 이내 입력" />
												</div>
												<div class="line-form">
													<label class="line-form-name" for="banner-file">이미지 업로드</label>
													<input type="file" class="text" name="img" id="banner-file" style="width:200px;" />
													<input type="hidden" name="imgfile" value=""/>
												</div>
												<div class="line-form">
													<label class="line-form-name" for="banner-line">관련 링크</label>
													<textarea class="text" name="context" id="banner-line" style="width:400px;"></textarea>
													<!-- <span class="checkbox checkbox--type1">
														<input type="checkbox" name="select-scale" id="input2" checked="">
														<label for="input2">링크없음</label>
													</span> -->
												</div>
											</div>
										</td>
										<td><button type="submit" class="btn btn-level btn-default">등록하기</button></td>
									</tr>
								</tbody>
							</table>
							</form>
						</div>

						<h3 class="h3-title">등록된 공지사항 등록하기</h3>
						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="50px">
									<col width="300px">
									<col width="*">
									<col width="150px">
								</colgroup>
								<thead>
									<tr>
										<th>순번</th>
										<th colspan="2">공지사항 내용</th>
										<th>등록/수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td><div class="thumbnail-280"><img src="http://via.placeholder.com/1920x1080"></div></td>
										<td>
											<div class="add-banner">
												<div class="line-form">
													<label class="line-form-name" for="banner-word">제목</label>
													<input type="text" class="text" id="banner-word" style="width:400px;" placeholder="30자 이내 입력" />
												</div>
												<div class="line-form">
													<label class="line-form-name" for="banner-file">이미지 업로드</label>
													<input type="file" class="text" id="banner-file" style="width:200px;" />
												</div>
												<div class="line-form">
													<label class="line-form-name" for="banner-line">관련 링크</label>
													<input type="text" class="text" id="banner-line" style="width:400px;" />
													<span class="checkbox checkbox--type1">
														<input type="checkbox" name="select-scale" id="input2" checked="">
														<label for="input2">링크없음</label>
													</span>
												</div>
											</div>
										</td>
										<td><a href="#" class="btn btn-level btn-rental">수정</a><br><a href="#" class="btn btn-level btn-copy">삭제</a></td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="paging">
							<a href="#none" class="paging__btn-prev">이전</a>
							<a href="#none" class="paging__num is-selected">1</a>
							<span class="paging__bar">/</span>
							<a href="#none" class="paging__num">5</a>
							<a href="#none" class="paging__btn-next">다음</a>
						</div>
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
			     url:'${ADMIN_PATH}/content/notice/delete',
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
        	input_value = form.find('input[name="title"]').val();
            if(input_value == ''){
            	alert("제목을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('textarea[name="context"]').val();
            if(input_value == ''){
            	alert("내용을 입력해주세요.");
            	return false;
            }
            
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