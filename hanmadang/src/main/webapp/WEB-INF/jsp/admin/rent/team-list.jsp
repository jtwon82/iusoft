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
						<h2>대관관리</h2>
					</article>
					<div class="container-tabs">
						<%@ include file="tab_menu.jsp"%>
					</div>
					<article class="container-body">
						<h3 class="h3-title"><strong>동호회 관리</strong></h3>
						<div class="h3-desc">동호회를 추가 / 삭제 할 수 있습니다.</div>

						<h3 class="h3-title sr-only">동호회 관리</h3>
						<div class="h3-btn"><a href="#modal-team-add" class="btn btn-line js-modal__btn-open">동호회 등록하기</a></div>
						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="*">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>동호회명</th>
										<th>아이디</th>
										<th>비밀번호</th>
										<th>추첨 선정(30일)</th>
										<th>이용횟수</th>
										<th>개설일</th>
										<th>승인여부</th>
										<th>수정/삭제</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.cl_name}"/></td>
										<td><c:out value="${item.cl_id}"/></td>
										<td><c:out value="${item.cl_passwd}"/></td>
										<td><c:out value="${empty item.real_cnt ? 0 : item.real_cnt}"/></td>
										<td><c:out value="${empty item.cnt ? 0 : item.cnt}"/></td>
										<td><c:out value="${item.cl_wdate}"/></td>
										<td>승인</td>
										<td><a href="#none" data-cl_num="<c:out value="${item.cl_num }"/>" class="btn btn-level btn-rental act-mod">수정</a> <a href="#none" data-cl_num="<c:out value="${item.cl_num }"/>" class="btn btn-level btn-copy act-del">삭제</a></td>
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

		<div class="modal-basic js-modal" id="modal-team-add"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<form id="modForm" method="post" action="${ADMIN_PATH}/rent/team/save">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">동호회 등록하기</div>
							<div class="modal-basic-desc">동호회 등록을 위해 아래 내용을 입력해 주십시오.</div>
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-1">동호회명</label> <input type="text" name="cl_name" style="width:200px;" class="text" id="num-1" placeholder="동호회명 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-2">아이디</label> <input type="text" name="cl_id" style="width:200px;" class="text" id="num-2" placeholder="아이디 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-3">비밀번호</label> <input type="text" name="cl_passwd" style="width:200px;" class="text" id="num-3" placeholder="비밀번호 입력" />
						</div>
						<div class="note-text">모든 항목 필수 입력사항 입니다.</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">등록하기</button>
						</div>
					</div>
					<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
				</div>
				
				<input type="hidden" name="cl_num" value="0"/>
				</form>
			</div>
		</div>
		<!-- layer popup//end -->
		<div class="modal-basic js-modal" id="modal-team-mod"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			
		</div>
		<!-- layer popup//end -->
		
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

$(function(){
	$(".act-mod").on("click", function(){
		var cl_num = $(this).data("cl_num");
		$('#modal-team-mod .modal-basic__wrapper').remove();
		var url = "${ADMIN_PATH}/rent/team/item/" + cl_num;
		$('#modal-team-mod').append($('<div class="modal-basic__wrapper">').load(url));
		$('#modal-team-mod').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".act-del").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var cl_num = $(this).data("cl_num");
			$.ajax({
			     url:'${ADMIN_PATH}/rent/team/delete',
			  	data:"cl_num="+cl_num,
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
	
	$('#modForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            if(form.find('input[name="cl_name"]').val() == ''){
            	alert("동호회명을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="cl_id"]').val() == ''){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="cl_passwd"]').val() == ''){
            	alert("비밀번호를 입력해주세요.");
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