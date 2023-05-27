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
						<h2>직원 관리</h2>
					</article>

					<article class="container-body">
						<h3 class="h3-title">포스코 직원관리</h3>
						<div class="h3-desc">정기적으로 포스코 직원정보를 업데이트 해 주십시오.<br>
							<span class="cl-blue">해당 데이터로 모든 수강신청 및 시설예약의 권한여부가 처리됩니다.</span>
						</div>
						<form id="searchForm" method="post" action="${ADMIN_PATH}/employee/list">
						<h3 class="h3-title">직원 검색</h3>
						<div class="search-box">
							<span class="selectbox selectbox--type1">
								<select name="op">
									<option value="all" <c:if test="${op == 'all' }">selected</c:if>>검색 조건 (직번/이름)</option>
									<option value="emno" <c:if test="${op == 'emno' }">selected</c:if>>직번</option>
									<option value="name" <c:if test="${op == 'name' }">selected</c:if>>이름</option>
								</select>
							</span>

							<input type="text" class="text" id="search-lecture" name="keyword" value="<c:out value="${keyword }"/>" placeholder="검색어 입력" />
							<button type="submit" class="btn btn-block btn-default btn-level">검색하기</button>
						</div>
						</form>
						
						<h3 class="h3-title">직원 리스트 <span class="h3-sub">총 <c:out value="${paging.totalEntryCount}"/>명의 직원이 있습니다.</span></h3>
						<div class="h3-btn"><a href="#modal-staff-add" class="btn btn-default btn-level js-modal__btn-open">직원 등록하기</a></div>

						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="200px">
									<col width="200px">
									<col width="*">
									<col width="200px">
									<col width="200px">
								</colgroup>
								<thead>
									<tr>
										<th>직번 (사원번호)</th>
										<th>사원명</th>
										<th>부서명</th>
										<th>직무명</th>
										<th>수정/삭제</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.em_no}"/></td>
										<td><c:out value="${item.em_name}"/></td>
										<td><c:out value="${item.part_name}"/></td>
										<td><c:out value="${item.work_name}"/></td>
										<td><a href="#none" data-seq="<c:out value="${item.idx_no }"/>" class="btn btn-level btn-rental act-mod">수정</a> <a href="#none" data-seq="<c:out value="${item.idx_no }"/>" class="btn btn-level btn-copy act-del">삭제</a></td>
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

		<div class="modal-basic js-modal" id="modal-staff-add"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-640__scroll">
				<form id="modForm" method="post" action="${ADMIN_PATH}/employee/save">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">직원등록하기</div>
							<div class="modal-basic-desc">직원 등록을 위해 아래 내용을 입력해 주십시오.</div>
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-1">사원번호</label> <input type="text" name="em_no" style="width:200px;" class="text" id="num-1" placeholder="사원번호 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-2">사원명</label> <input type="text" name="em_name" style="width:200px;" class="text" id="num-2" placeholder="사원명 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-3">부서명</label> <input type="text" name="part_name" style="width:200px;" class="text" id="num-3" placeholder="부서명 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-4">직무명</label> <input type="text" name="work_name" style="width:200px;" class="text" id="num-4" placeholder="직무명 입력" />
						</div>
						<div class="note-text">모든 항목 필수 입력사항 입니다.</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">등록하기</button>
						</div>
					</div>
				</div>
				</form>
				<form id="modForm1" method="post" action="${ADMIN_PATH}/employee/save/file"  enctype="multipart/form-data" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">엑셀로 등록하기</div>
							<div class="modal-basic-desc">엑셀 파일을 업로드 해 주십시오.</div>
						</div>
						<div class="line-form">
							<label class="line-form-name" for="add-file">파일업로드</label> <input type="file" name="file" style="width:200px;" class="text" id="add-file" />
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">등록하기</button>
						</div>
					</div>
				</div>
				</form>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		
		<div class="modal-basic js-modal" id="modal-staff-mod"><!-- is-expanded -->
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
		var idx_no = $(this).data("seq");
		$('#modal-staff-mod .modal-basic__wrapper').remove();
		var url = "${ADMIN_PATH}/employee/item/" + idx_no;
		$('#modal-staff-mod').append($('<div class="modal-basic__wrapper">').load(url));
		$('#modal-staff-mod').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".act-del").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var idx_no = $(this).data("seq");
			$.ajax({
			     url:'${ADMIN_PATH}/employee/delete',
			  	data:"idx_no="+idx_no,
			     type: 'POST',
			     error: function(){
			    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
			     },
			     success: function(res){
			    	 /* console.log(res); */
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
            if(form.find('input[name="em_no"]').val() == ''){
            	alert("사원번호를 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="em_name"]').val() == ''){
            	alert("사원명을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="part_name"]').val() == ''){
            	alert("부서명을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="work_name"]').val() == ''){
            	alert("직무명 입력해주세요.");
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
	
	$('#modForm1').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            if(form.find('input[name="file"]').val() == ''){
            	alert("엑셀 파일을 선택해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("성공적으로 처리되었습니다.");
    			location.reload(true);
            }else if(response == 'NOT_MATCHE'){
            	alert("엑셀 형식이 올바르지 않습니다. 확인 후 다시 시도해주세요.");
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