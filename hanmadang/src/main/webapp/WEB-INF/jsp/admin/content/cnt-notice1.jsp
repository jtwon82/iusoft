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
<script src="/admin/ckeditor/ckeditor.js" type="text/javascript"></script>
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

						<h3 class="h3-title">등록된 공지사항 리스트</h3>
						<div class="h3-btn"><a href="#modal-cnt-notice-write" class="btn btn-default btn-level js-modal__btn-open">새 공지사항 등록하기</a></div>

						<!-- <h3 class="h3-title">등록된 공지사항 등록하기</h3> -->
						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="100px">
									<col width="*">
									<col width="200px">
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>공지사항 제목</th>
										<th>수정/삭제</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.rownum }"/></td>
										<td class="col-left">
											<a href="#"><c:out value="${item.title }"/></a>
										</td>
										<td><a href="#none" data-seq="<c:out value="${item.idx }"/>" class="btn btn-level btn-rental js-modal__btn-open act-mod">수정</a><a href="#none" data-seq="<c:out value="${item.idx }"/>" class="btn btn-level btn-copy">삭제</a></td>
									</tr>
								</c:forEach>
								</c:if>
								</tbody>
							</table>
						</div>

						<%@ include file="../common/paging.jsp"%>
					</article>
				</div>
			</div>
		</div>

		<div class="modal-basic js-modal" id="modal-cnt-notice-modify"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			
		</div>
		<!-- layer popup//end -->

		<form id="modForm" method="post" action="${ADMIN_PATH}/content/notice/save"  enctype="multipart/form-data">
		<div class="modal-basic js-modal" id="modal-cnt-notice-write"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-wide__body">
					<div class="modal-wide__contents">
						<p class="modal-wide-title">새 공지사항 등록하기</p>
						<div class="modal-wide__scroll">
							<div class="modal-wide__subject">공지사항 등록을 위해 아래 내용을 입력해 주십시오.</div>

							<div class="table-basic">
								<table class="table-basic-type2">
									<colgroup>
										<col width="80px">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<td>제목</td>
											<td class="col-left">
												<input type="text" name="title" class="text" placeholder="제목입력" />
											</td>
										</tr>
										<tr>
											<td>내용</td>
											<td class="col-left">
												<textarea name="context1" id="editor1" rows="12" cols="80"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="btn-group">
								<button type="submit" class="btn btn-level1 btn-register">등록완료</button>
							</div>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		</form>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
CKEDITOR.replace( 'editor1' , {
	filebrowserUploadUrl: '${ADMIN_PATH}/file/upload/image'
});

$(function(){
	
	$(".act-mod").on("click", function(){
		var id = $(this).data("seq");
		$('#modal-cnt-notice-modify .modal-basic__wrapper').remove();
		var url = "${ADMIN_PATH}/content/notice/item/" + id;
		$('#modal-cnt-notice-modify').append($('<div class="modal-basic__wrapper">').load(url));
		$('#modal-cnt-notice-modify').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".btn-copy").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var seq = $(this).data("seq");
			$.ajax({
			     url:'${ADMIN_PATH}/content/notice/delete',
			  	data:"idx="+seq,
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
            
            var content = CKEDITOR.instances.editor1.getData();
            if(content.length === 0){
            	alert("내용을 입력해주세요.");
                return false;
            }
            
            data.push({name:'context', value:content});
            
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