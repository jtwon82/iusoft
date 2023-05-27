<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
						<h2>수강신청 관리</h2>
					</article>
					<div class="container-tabs">
						<%@ include file="tab_menu.jsp"%>
					</div>
					<article class="container-body">
						<h3 class="h3-title">수강신청 항목 및 요건 설정</h3>
						<div class="h3-desc">강좌 정보를 등록하며, 기존 강좌의 내용을 수정/삭제합니다.</div>

						<h3 class="h3-title">수강신청 기간</h3>
						<div class="lecture-date">
							<div class="day-day"><c:out value="${fn:substring(classDate.startdate, 0, 4)}"/>년 <c:out value="${fn:substring(classDate.startdate, 5, 7)}"/>월 <c:out value="${fn:substring(classDate.startdate, 8, 10)}"/>일 ~ 
							<c:out value="${fn:substring(classDate.enddate, 0, 4)}"/>년 <c:out value="${fn:substring(classDate.enddate, 5, 7)}"/>월 <c:out value="${fn:substring(classDate.enddate, 8, 10)}"/>일</div>
							<a href="#modal-lecture-day-setting" class="btn btn-default btn-level1 js-modal__btn-open">수정하기</a>
						</div>

						<h3 class="h3-title">강좌 등록</h3>
						<h3 class="tab-title">운동 종목 선택</h3>
						<div class="tab-btn"><a href="#modal-lecture-type-add" class="btn btn-level0 btn-complete js-modal__btn-open">운동종목 추가/편집하기</a></div>
						<div class="rent-tabs sub-tabs">
						
						<c:forEach items="${mainClass }" var="item" varStatus="status">	
							<a href="#none" data-value="<c:out value="${item.b_cate}"/>" data-name="<c:out value="${item.b_cate_name}"/>" class="select-class-cate by-6 <c:if test="${status.index == 0}">is-selected</c:if>"><span><c:out value="${item.class_name}"/></span></a>
						</c:forEach>
							<!-- <a href="#" class="by-6  is-selected"><span>휘트니스+승마</span></a> -->
						</div>
						
						<form id="class_sub_add" method="post" action="${ADMIN_PATH}/entry/class/sub/add">
						<input type="hidden" name="b_cate" value="<c:out value="${mainClass[0].b_cate }"/>"/>
						<input type="hidden" name="b_cate_name" value="<c:out value="${mainClass[0].b_cate_name }"/>"/>
						<div class="register-type-input">
							<div class="fl by-3 add-lecture">
								<label for="lecture-name">강좌명</label>
								<input type="text" class="text" name="m_cate_name" id="lecture-name" style="width:180px" placeholder="강좌명 입력">
							</div>
							<!-- <div class="fl by-3 add-lecture">
								<label for="lecture-teacher">강사명</label>
								<input type="text" class="text" id="lecture-teacher" style="width:180px" placeholder="강사명 입력">
							</div> -->
							<div class="fl by-3 add-lecture">
								<label for="lecture-teacher">수강시간</label>
								<input type="text" class="text" name="class_time" id="lecture-time" style="width:180px" placeholder="수강시간 입력">
							</div>
						</div>
						<div class="register-type-input">
							<div class="fl by-4 add-lecture">
								<label for="lecture-member">정회원 정원</label>
								<input type="text" class="text" name="class_a_count" id="lecture-member" style="width:100px" placeholder="정회원 정원"><span class="words">명</span>
							</div>
							<div class="fl by-4 add-lecture">
								<label for="lecture-member2">준회원 정원</label>
								<input type="text" class="text" name="class_b_count" id="lecture-member2" style="width:100px" placeholder="준회원 정원"><span class="words">명</span>
							</div>
							<div class="fl by-4 add-lecture">
								<label for="lecture-member3">일반회원 정원</label>
								<input type="text" class="text" name="class_c_count" id="lecture-member2" style="width:100px" placeholder="일반회원 정원"><span class="words">명</span>
							</div>
							<div class="fl by-4 add-lecture">
								<label for="lecture-member4">대기자 정원</label>
								<input type="text" class="text" name="class_standby_count" id="lecture-member3" style="width:100px" placeholder="대기자 정원"><span class="words">명</span>
							</div>
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">등록하기</button>
						</div>
						</form>
						
						<h3 class="h3-title">강좌 리스트</h3>
						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="*">
									<col width="8%">
									<col width="12%">
									<col width="9%">
									<col width="10%">
									<col width="12%">
									<col width="10%">
									<col width="7%">
									<col width="11%">
								</colgroup>
								<thead>
									<tr>
										<th>운동종목</th>
										<th>강좌명</th>
										<th>수강시간</th>
										<th>총정원</th>
										<th>정회원 정원</th>
										<th>준회원 정원</th>
										<th>일반회원 정원</th>
										<th>대기자 정원</th>
										<th>신청여부</th>
										<th>수정 / 삭제</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${subClass }" var="item" varStatus="status">	
									<tr>
										<td class="col-left"><c:out value="${item.b_cate_name }"/></td>
										<td><c:out value="${item.class_name }"/></td>
										<td><c:out value="${item.class_time }"/></td>
										<td><c:out value="${item.class_a_count + item.class_b_count + item.class_c_count}"/></td>
										<td><c:out value="${item.class_a_count }"/></td>
										<td><c:out value="${item.class_b_count }"/></td>
										<td><c:out value="${item.class_c_count }"/></td>
										<td><c:out value="${item.class_standby_count }"/></td>
										<td><a href="#none" data-idx="<c:out value="${item.idx_no }"/>" data-value="<c:out value="${item.viewyn }"/>" class="btn btn-yn act-sub-view"><c:out value="${item.viewyn }"/></a></td>
										<td><a href="#none" data-value="<c:out value="${item.idx_no }"/>" class="btn btn-level btn-rental act-sub-mod">수정</a><a href="#none" data-value="<c:out value="${item.idx_no }"/>" class="btn btn-level btn-copy act-sub-del">삭제</a></td>
									</tr>
								</c:forEach>
								</tbody>
								<tbody>
							</table>
						</div>

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


		<div class="modal-basic js-modal <c:if test="${mode == 1 }">is-expanded</c:if>" id="modal-lecture-type-add"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__scroll">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">운동종목 추가하기</div>
							<div class="modal-basic-desc">등록할 운동종목을 입력해 주십시오.</div>
						</div>
						<form id="class_add_form" method="post" action="${ADMIN_PATH}/entry/class/main/add">
						<div class="line-form">
							<input type="text" class="text" name="class_name" placeholder="운동종목 입력" style="width:250px;" /><button type="submit" class="btn btn-default btn-level">등록하기</button>
							<input type="hidden" name="b_sort" value="${mainClass[fn:length(mainClass) - 1].b_sort + 1 }"/>
						</div>
						</form>
						<div class="note-text">등록된 운동종목의 내용 (종목명, 노출 순서) 을 수정하거나 삭제 합니다.</div>

						<div class="table-basic">
							<table class="table-basic-type2 top-box">
								<colgroup>
									<col width="200px">
									<col width="*">
									<col width="200px">
								</colgroup>
								<tbody>
								<c:set var="max_sort" value="${mainClass[fn:length(mainClass) - 1].b_sort }"/>
								
								<c:forEach items="${mainClass }" var="item" varStatus="status">	
									<tr>
										<td class="col-left">
										<input type="text" class="text" name="class_name" value="<c:out value="${item.m_cate_name }"/>" placeholder="운동종목 입력" style="width:200px;" />
										</td>
										<td class="col-left">
											<span class="selectbox selectbox--type1">
												<select id="select-sort" name="b_sort">
													<c:forEach var="i" begin="1" end="${max_sort }" step="1">
													<option value="${i}" <c:if test="${i == item.b_sort }">selected </c:if>>${i}</option>
													</c:forEach>
													<option value="">2</option>
												</select>
											</span>
										</td>
										<td><a href="#none" data-value="<c:out value="${item.idx_no }"/>" class="btn btn-level btn-rental act-main-class-mod">수정</a><a href="#none" data-value="<c:out value="${item.idx_no }"/>" class="btn btn-level btn-copy act-main-class-del">삭제</a></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>

					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close class-cate-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->

		<div class="modal-basic js-modal" id="modal-lecture-modify"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			
		</div>
		<!-- layer popup//end -->
		
		<form id="class_date_mod" method="post" action="${ADMIN_PATH}/entry/class/date">
		<div class="modal-basic js-modal " id="modal-lecture-day-setting"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">응모 기간 재설정</div>
							<div class="modal-basic-desc">응모기간을 재설정 해 주십시오</div>
						</div>
						<div class="line-form">
							시작일 <div class="datebox-basic"><input type="text" name="startdate" id="startInput" class="date-day"></div> <span class="hyphen">~</span> 종료일 <div class="datebox-basic"><input type="text" name="enddate" id="endInput" class="date-day"></div>
						</div>
						<div class="note-text">정확한 날짜를 선택해 주십시오. 잘못 선택한 경우, 재입력 하시면 재설정 됩니다.</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">등록하기</button>
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
<script type="text/javascript">

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

$(function(){
	$(".act-sub-mod").on("click", function(){
		var idx_no = $(this).data("value");
		$('#modal-lecture-modify .modal-basic__wrapper').remove();
		var url = "${ADMIN_PATH}/entry/class/item/" + idx_no;
		$('#modal-lecture-modify').append($('<div class="modal-basic__wrapper">').load(url));
		$('#modal-lecture-modify').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".select-class-cate").on("click", function(){
		
		$('.select-class-cate').each(function(index) { 
			$(this).removeClass("is-selected")
		});
		$(this).addClass("is-selected")
		
		var value = $(this).data("value");
		$("#class_sub_add").find('input[name="b_cate"]').val(value);
		
		value = $(this).data("name");
		$("#class_sub_add").find('input[name="b_cate_name"]').val(value);
	});
	
	$(".date-day").datepicker({
	    buttonImageOnly: true,
		prevText: '이전달',
		nextText: '다음달',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:["일","월","화","수","목","금","토"],
		dateFormat:"yy-mm-dd",
		changeMonth: true,
		changeYear: true
	});
	
	$(".class-cate-close").on("click", function(){
		
		var mode = getUrlParameter('mode');
		
		if(getUrlParameter('mode') != undefined){
			location.replace("${ADMIN_PATH}/entry/info");
		}else{
			var _$this = $(this),
	        _$modal = _$this.closest('.js-modal'),
	        _$btn = $(_$this.attr('href'));
	   		 _$modal.removeClass('is-expanded').attr('tabindex', '-1');	
		}
	});
	
	$(".act-main-class-mod").on("click", function(){
		if(!confirm('종목명과 노출순서를 수정하시겠습니까?'))
			return;
		
		var name = $(this).parents('tr').find('input[name="class_name"]').val();
		var b_sort = $(this).parents('tr').find('#select-sort').val();
		var idx = $(this).data("value");
		  
		$.ajax({
		     url:'${ADMIN_PATH}/entry/class/main/add',
		  	data:"class_name=" + name + "&b_sort="+ b_sort + "&idx_no=" + idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		            location.replace("${ADMIN_PATH}/entry/info?mode=1");
		         }else{
		        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
			
	});
	
	$(".act-main-class-del").on("click", function(){
		
		if(!confirm('삭제하시겠습니까?'))
			return;
		
		var idx = $(this).data("value");
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/class/main/del',
		  	data:"idx_no=" + idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		            location.replace("${ADMIN_PATH}/entry/info?mode=1");
		         }else{
		        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
			
	});
	
	$(".act-sub-del").on("click", function(){
		
		if(!confirm('삭제하시겠습니까?'))
			return;
		
		var idx = $(this).data("value");
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/class/sub/del',
		  	data:"idx_no=" + idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		            location.reload(true);
		         }else{
		        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
			
	});
	
	$(".act-sub-view").on("click", function(){
		var idx = $(this).data("idx");
		var view_yn = $(this).data("value");
		
		if(view_yn == 'Y') view_yn = 'N';
		else view_yn = 'Y';
			
		$.ajax({
		     url:'${ADMIN_PATH}/entry/class/sub/view',
		  	data:"view_yn=" + view_yn + "&idx_no=" + idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		            location.reload(true);
		         }else{
		        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
			
	});
	
	$('#class_date_mod').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	
            //validation체크 
            start_value = form.find('input[name="startdate"]').val();
            if(start_value == ''){
            	alert("시작일을 선택해주세요.");
            	return false;
            }
            
            end_value = form.find('input[name="enddate"]').val();
            if(end_value == ''){
            	alert("종료일을 선택해주세요.");
            	return false;
            }
            
            if(start_value > end_value){
            	alert("정확한 시작일과 종료일을 선택해주세요.");
            	return false;
            }
            
            if(!confirm("등록하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("등록되었습니다.");
    			location.reload(true);
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
	$('#class_add_form').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	
            //validation체크 
            start_value = form.find('input[name="class_name"]').val();
            if(start_value == ''){
            	alert("운동종목을 입력해주세요.");
            	return false;
            }
            
            if(!confirm("등록하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("등록되었습니다.");
    			location.replace("${ADMIN_PATH}/entry/info?mode=1");
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
	$('#class_sub_add').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	
            //validation체크 
            input_value = form.find('input[name="b_cate"]').val();
            if(input_value == ''){
            	alert("운동종목을 선택해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="m_cate_name"]').val();
            if(input_value == ''){
            	alert("강좌명을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_time"]').val();
            if(input_value == ''){
            	alert("수강시간을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_a_count"]').val();
            if(input_value == ''){
            	alert("정회원 정원을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_b_count"]').val();
            if(input_value == ''){
            	alert("준회원 정원을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_c_count"]').val();
            if(input_value == ''){
            	alert("일반회원 정원을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_standby_count"]').val();
            if(input_value == ''){
            	alert("대기자 정원을 입력해주세요. ");
            	return false;
            }
            
            if(!confirm("등록하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("등록되었습니다.");
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