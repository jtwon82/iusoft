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
						<a href="${ADMIN_PATH}/content/popup" class="by-4 is-selected">팝업 관리</a>
						<a href="${ADMIN_PATH}/content/notice" class="by-4">공지사항 관리</a>
						<a href="${ADMIN_PATH}/content/program" class="by-4">프로그램 관리</a>
					</div>
					<article class="container-body">
						<h3 class="h3-title">팝업 리스트</h3>
						<div class="h3-desc">업로드한 내용이 홈화면 접근시 팝업창으로 적용됩니다.</div>

						<h3 class="h3-title">새 팝업 등록하기</h3>
						<div class="col-caption">팝업내용 / 노출날짜 / 등록</div>
						<form id="modForm" method="post" action="${ADMIN_PATH}/content/popup/save"  enctype="multipart/form-data">
						<div class="col-table clearfix">
							<div class="col-3 cell-m cell-c">
								<div class="thumbnail-280"><img src="http://via.placeholder.com/1920x1080"></div>
							</div>
							<div class="col-5 cell-t">
								<div class="add-banner">
									<div class="line-form">
										<label class="line-form-name" for="banner-file2">이미지 업로드</label>
										<input type="file" class="text" name="img" id="banner-file2" onchange="readURL(this)" accept="image/*" style="width:300px;" />
										<input type="hidden" name="b_img" value=""/>
									</div>
									<div class="line-form">
										<label class="line-form-name" for="banner-line1">배너 링크</label>
										<input type="text" class="text" name="b_link" id="banner-line1" style="width:300px;" />
										<!-- <span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="input2" checked="">
											<label for="input2">링크없음</label>
										</span> -->
									</div>
								</div>
							</div>
							<div class="col-2 cell-c cell-m">
								시작일 <div class="datebox-basic"><input type="text" name="b_start" id="startInput" class="date-day"></div><br>
								종료일 <div class="datebox-basic"><input type="text" name="b_end" id="endInput" class="date-day"></div>
							</div>
							<div class="col-2 cell-c cell-m">
								<button type="submit" class="btn btn-level btn-default">등록하기</button>
							</div>
						</div>
						</form>
						
						<h3 class="h3-title">현재 팝업 리스트</h3>
						<div class="col-caption">팝업내용 / 노출날짜 / 등록</div>
						<c:forEach items="${list }" var="item" varStatus="status">
						<form id="modForm1" method="post" action="${ADMIN_PATH}/content/popup/save"  enctype="multipart/form-data">
						<div class="col-table clearfix">
							<div class="col-1 cell-m cell-c"><c:out value="${item.idx_no}"/></div>
							<div class="col-3 cell-m cell-c">
								<div class="thumbnail-280"><img src="/upload/<c:out value="${item.b_img}"/>"></div>
							</div>
							<div class="col-4 cell-t">
								<div class="add-banner">
									<div class="line-form">
										<label class="line-form-name" for="banner-file2bb">이미지 업로드</label>
										<input type="file" name="img" class="text" id="banner-file2bb" onchange="readURL(this)" accept="image/*" style="width:300px;" />
										<input type="hidden" name="b_img" value="<c:out value="${item.b_img}"/>"/>
									</div>
									<div class="line-form">
										<label class="line-form-name" for="banner-line1bb">배너 링크</label>
										<input type="text" class="text" name="b_link" id="banner-line1bb" style="width:300px;" value="<c:out value="${item.b_link}"/>"/>
										<!-- <span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="input2bb" checked="">
											<label for="input2bb">링크없음</label>
										</span> -->
									</div>
								</div>
							</div>
							<div class="col-2 cell-c cell-m">
								시작일 <div class="datebox-basic"><input type="text" name="b_start" id="startInputbb<c:out value="${item.idx_no}"/>" class="date-day" value="<c:out value="${item.b_start}"/>"></div><br>
								종료일 <div class="datebox-basic"><input type="text" name="b_end" id="endInputbb<c:out value="${item.idx_no}"/>" class="date-day" value="<c:out value="${item.b_end}"/>"></div>
							</div>
							<div class="col-1 cell-m cell-c">
								<div class="switch-inner">
								<c:choose>
								<c:when test="${item.b_open_yn == 'Y'}">
								<span class="switch-txt">on</span> <div class="switch-box"><a href="#" data-seq="<c:out value="${item.idx_no}"/>" class="switch is-on"></a></div>
								</c:when>
								<c:otherwise>
								<span class="switch-txt">off</span> <div class="switch-box"><a href="#" data-seq="<c:out value="${item.idx_no}"/>" class="switch is-off"></a></div>
								</c:otherwise>
								</c:choose>
								</div>
							</div>
							<div class="col-2 cell-c cell-m">
								<button type="submit" class="btn btn-level btn-rental">수정</button><br><a href="#" data-seq="<c:out value="${item.idx_no}"/>" class="btn btn-level btn-copy">삭제</a>
							</div>
						</div>
						<input type="hidden" name="b_open_yn" value="<c:out value="${item.b_open_yn}"/>"/>
						<input type="hidden" name="idx_no" value="<c:out value="${item.idx_no}"/>"/>
						</form>
						</c:forEach>
					

						<!-- <div class="paging">
							<a href="#none" class="paging__btn-prev">이전</a>
							<a href="#none" class="paging__num is-selected">1</a>
							<span class="paging__bar">/</span>
							<a href="#none" class="paging__num">5</a>
							<a href="#none" class="paging__btn-next">다음</a>
						</div> -->
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
	  $( ".date-day" ).datepicker({
		buttonImageOnly: true,
		prevText: '이전달',
		nextText: '다음달',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:["일","월","화","수","목","금","토"],
		dateFormat:"mm/dd/yy",
		changeMonth: true,
		changeYear: true
		//showOn: "both",
		//buttonImage: "../assets/img/btn_date.gif"
	});

	$(".btn-copy").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var seq = $(this).data("seq");
			$.ajax({
			     url:'${ADMIN_PATH}/content/popup/delete',
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
	
	$(".switch").on("click", function(){
			var seq = $(this).data("seq");
			var open_yn = 'N';
			if($(this).hasClass( "is-on" ))
				open_yn = 'Y';
			else
				open_yn = 'N';
			$.ajax({
			     url:'${ADMIN_PATH}/content/popup/onoff',
			  	data:"idx_no="+seq+"&open_yn="+open_yn,
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
	});
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            input_value = form.find('input[name="b_img"]').val();
            if(input_value == ''  && form.find('input[name="img"]').val() == ''){
            	alert("이미지를 선택해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="b_start"]').val();
            if(input_value == ''){
            	alert("시작일을 선택해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="b_end"]').val();
            if(input_value == ''){
            	alert("종료일을 선택해주세요.");
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