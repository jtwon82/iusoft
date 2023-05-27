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
						<h3 class="h3-title">수강신청 회원 리스트 검색 및 미리 선정</h3>
						<div class="h3-desc">항목별로 수강신청 회원을 검색하며, 추첨전에 미리 선정할 수 있습니다.</div>

						<h3 class="h3-title">수강신청 회원 검색</h3>
						
						<form id="class_search" method="post" action="${ADMIN_PATH}/entry/apply/list">
						<input type="hidden" name="b_cate" value="<c:out value="${param.b_cate }"/>"/>
						<input type="hidden" name="em_type" value="<c:out value="${param.em_type }"/>"/>
						<input type="hidden" name="class_yn" value="<c:out value="${param.class_yn }"/>"/>
						<input type="hidden" name="mode" value="<c:out value="${mode }"/>"/>
						
						<h3 class="tab-title">운동 종목</h3>
						<div class="rent-tabs sub-tabs">
							<a href="#none" data-value="00" class="select-class-cate by-6 <c:if test="${empty param.b_cate or param.b_cate == '00' }">is-selected</c:if>"><span>전체</span></a>
							<c:forEach items="${mainClass }" var="item" varStatus="status">	
							<a href="#none" data-value="<c:out value="${item.b_cate}"/>" class="select-class-cate by-6 <c:if test="${param.b_cate == item.b_cate }">is-selected</c:if>"><span><c:out value="${item.class_name}"/></span></a>
						</c:forEach>
						</div>
						<h3 class="tab-title">회원구분</h3>
						<div class="rent-tabs sub-tabs">
							<a href="#none" data-value="00" class="select-class-member by-4 <c:if test="${empty param.em_type or param.em_type == '00' }">is-selected</c:if>"><span>전체</span></a>
							<a href="#none" data-value="01" class="select-class-member by-4 <c:if test="${param.em_type == '01' }">is-selected</c:if>"><span>정회원(포스코패밀리)</span></a>
							<a href="#none" data-value="02" class="select-class-member by-4 <c:if test="${param.em_type == '02' }">is-selected</c:if>"><span>준회원(포스코패밀리)</span></a>
							<a href="#none" data-value="03" class="select-class-member by-4 <c:if test="${param.em_type == '03' }">is-selected</c:if>"><span>일반회원</span></a>
						</div>
						<h3 class="tab-title">선정여부</h3>
						<div class="rent-tabs sub-tabs">
							<a href="#none" data-value="YN" class="select-class-result by-3 <c:if test="${empty param.class_yn or param.class_yn == 'YN' }">is-selected</c:if>"><span>전체</span></a>
							<a href="#none" data-value="Y" class="select-class-result by-3 <c:if test="${param.class_yn == 'Y' }">is-selected</c:if>"><span>선정</span></a>
							<a href="#none" data-value="N" class="select-class-result by-3 <c:if test="${param.class_yn == 'N' }">is-selected</c:if>"><span>미선정</span></a>
						</div>

						<h3 class="tab-title">상세검색</h3>
						<div class="search-box">
							<span class="selectbox selectbox--type1">
								<select name="op">
									<option value="all" <c:if test="${empty param.op or param.op == 'all' }">selected</c:if>>전체</option>
									<option value="e_name" <c:if test="${param.op == 'e_name' }">selected</c:if>>직원명</option>
									<option value="o_name" <c:if test="${param.op == 'o_name' }">selected</c:if>>이용자명</option>
									<option value="e_no" <c:if test="${param.op == 'e_no' }">selected</c:if>>사원번호</option>
									<option value="class_name" <c:if test="${param.op == 'class_name' }">selected</c:if>>클래스명</option>
								</select>
							</span>

							<input type="text" name="keyword" class="text" id="search-lecture" placeholder="검색어 입력" value="<c:out value="${param.keyword }"/>"/>
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-default btn-level2">검색하기</button>
						</div>
						</form>
						
						<form id="listForm" method="post" action="${ADMIN_PATH}/entry/apply/result/change">
						<!-- 우선선정자일경우// -->
						<h3 class="h3-title">수강신청 회원 리스트</h3>
						<div class="h3-btn"><a href="#modal-add-vip" class="btn btn-default btn-level js-modal__btn-open">우선 선정자 등록하기</a></div>
						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="3%">
									<col width="*">
									<col width="6%">
									<col width="8%">
									<col width="6%">
									<col width="7%">
									<col width="11%">
									<col width="5%">
									<col width="6%">
									<col width="11%">
									<col width="4%">
									<col width="4%">
									<col width="9%">
									<c:if test="${mode == 1 }">
									<col width="11%">
									</c:if>
								</colgroup>
								<thead>
									<tr>
										<th>순번</th>
										<th>운동종목</th>
										<th>강좌명</th>
										<th>수강시간</th>
										<th>회원구분</th>
										<th>이용자명</th>
										<th>전화번호</th>
										<th>직번</th>
										<th>직원명</th>
										<th>부서명</th>
										<th>관계</th>
										<th>성별</th>
										<th>선정방법</th>
										<c:if test="${mode == 1 }">
										<th>선정/대기 추가</th>
										</c:if>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.rownum}"/></td>
										<td><c:out value="${item.classInfo.b_cate_name}"/></td>
										<td><c:out value="${item.classInfo.class_name}"/></td>
										<td><c:out value="${item.classInfo.class_time}"/></td>
										<td>${item.em_typeStr }
<%-- 										<c:choose> --%>
<%-- 										<c:when test="${item.em_type == '01' }">정회원</c:when> --%>
<%-- 										<c:when test="${item.em_type == '02' }">준회원</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 										일반회원 -->
<%-- 										</c:otherwise> --%>
<%-- 										</c:choose> --%>
										</td>
										<td><c:out value="${item.o_name}"/></td>
										<td><c:out value="${item.hp}"/></td>
										<td><c:out value="${item.e_no}"/></td>
										<td><c:out value="${item.e_name}"/></td>
										<td><c:out value="${item.partname}"/></td>
										<td><c:out value="${item.mem_type}"/></td>
										
										<c:choose>
										<c:when test="${item.gender == 0 }">
										<td>남</td>
										</c:when>
										<c:when test="${item.gender == 1 }">
										<td>여</td>
										</c:when>
										<c:otherwise>
										<td></td>
										</c:otherwise>
										</c:choose>
										
										<c:choose>
										<c:when test="${item.class_ok == 'Y' }">
										<td><div class="tag"><span class="tag-vip">우선선정</span></div></td>
										</c:when>
										<c:otherwise>
										<td><div class="tag"><span class="tag-member">추첨항목</span></div></td>
										</c:otherwise>
										</c:choose>
										<c:if test="${mode == 1 }">
										<td><a href="#none" data-value="#<c:out value="${item.idx_no}"/>" data-mode="Y" class="btn btn-level btn-rental">선정</a><a href="#none" data-value="#<c:out value="${item.idx_no}"/>" data-mode="D" class="btn btn-level btn-rental">대기</a></td>
										</c:if>
									</tr>
								</c:forEach>
								</c:if>
								</tbody>
							</table>
						</div>
						<c:if test="${mode == 0 }">
						<div class="btn-group">
							<a href="${ADMIN_PATH}/entry/apply/excel" class="btn btn-level1 btn-register">엑셀로 다운로드받기</a>
							<a href="${ADMIN_PATH}/entry/apply/list?mode=1" class="btn btn-level1 btn-register">선정/대기자 추가하기</a>
						</div>
						</c:if>
						<c:if test="${mode == 1 }">
						<div class="btn-group">
							<a href="${ADMIN_PATH}/entry/apply/list" class="btn btn-level1 btn-register">수강신청 회원 리스트</a>
							<button type="submit" class="btn btn-level1 btn-register">완료하기</button>
						</div>
						
						<input type="hidden" name="class_ok" value=""/>
						<input type="hidden" name="class_re" value=""/>
						</c:if>
						</form>
						<c:if test="${not empty list }">
						<%@ include file="../common/paging.jsp"%>
						</c:if>
					</article>
				</div>
			</div>
		</div>

		
		<form id="modForm1" method="post" action="${ADMIN_PATH}/entry/apply/vip"  enctype="multipart/form-data" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
		<div class="modal-basic js-modal " id="modal-add-vip"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">우선선정자 등록하기</div>
							<div class="modal-basic-desc">우선선정자 엑셀 파일을 업로드 해 주십시오.</div>
						</div>
						<input type="file" name="file" class="text" style="width:80%;" placeholder="" />
						<div class="btn-group">
							<button type="submit" class="by-2 btn btn-level1 btn-register">등록완료</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		</form>
		
		<div class="modal-basic js-modal " id="modal-lecture-member-vip"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-wide__body">
					<div class="modal-wide__contents">
						<p class="modal-wide-title">수동 선정자(VIP) 정보 입력</p>
						<div class="modal-wide__scroll">
							<div class="modal-wide__subject">회원정보 입력</div>

							<div class="rent-tabs">
								<a href="lecture-member.html" class="by-2 is-selected"><span>기존회원</span></a>
								<a href="lecture-regular.html" class="by-2"><span>신규회원</span></a>
							</div>
							<div class="member-type-input member-type-regular">
								<label for="member-name">아이디 입력</label>
								<input type="text" class="text" id="member-name" placeholder="직원명 입력">
							</div>
							<div class="member-type-input member-type-regular">
								<label for="member-name">직번</label>
								<input type="text" class="text" id="member-name" placeholder="직번 입력">
							</div>
							<div class="member-type-input member-type-regular">
								<label for="member-name">이용자명</label>
								<input type="text" class="text" id="member-name" placeholder="이용자명 입력">
							</div>
							<div class="btn-group">
								<a href="#" class="btn btn-level1 btn-register">회원확인</a>
							</div>
							<hr />
							<div class="modal-wide__subject">강좌검색 (정회원)</div>
							<div class="member-type-select">
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input1" checked="">
									<label for="input1">휘트니스</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input2" checked="">
									<label for="input2">국선도</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input3" checked="">
									<label for="input3">다이어트댄스</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input4" checked="">
									<label for="input4">방송댄스</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input5" checked="">
									<label for="input5">밸리댄스</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input6" checked="">
									<label for="input6">스쿼시</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input7" checked="">
									<label for="input7">스크린승마</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input8" checked="">
									<label for="input8">스피닝</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input9" checked="">
									<label for="input9">에어로빅</label>
								</span>
								<span class="radio radio--type1">
									<input type="radio" name="select-scale" id="input9" checked="">
									<label for="input9">요가</label>
								</span>
							</div>
							<div class="search-box">
								<label for="">강좌명 검색</label>
								<input type="text" class="text" id="search-lecture" placeholder="검색어 입력" />
								<a href="#" class="btn btn-block btn-default btn-level">검색</a>
							</div>

							<div class="modal-wide__subject">강좌선택</div>
							<div class="table-basic">
								<table class="table-basic-type2">
									<colgroup>
										<col width="*">
										<col width="200px">
										<col width="150px">
										<col width="180px">
										<col width="120px">
									</colgroup>
									<thead>
										<tr>
											<th>강좌명</th>
											<th>수강료</th>
											<th>요일</th>
											<th>시간</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="col-left">[정회원] 휘트니스 -3개월 </td>
											<td>60,000원</td>
											<td>월~일</td>
											<td>06:00 ~ 13:00</td>
											<td><a href="#" class="btn btn-point btn-level">선택</a></td>
										</tr>
										<tr>
											<td class="col-left">[정회원] 휘트니스(오전반) -3개월 </td>
											<td>60,000원</td>
											<td>월~일</td>
											<td>06:00 ~ 13:00</td>
											<td><a href="#" class="btn btn-default btn-level">신청</a></td>
										</tr>
										<tr>
											<td class="col-left">[정회원] 휘트니스(오후반) -3개월 </td>
											<td>60,000원</td>
											<td>월~일</td>
											<td>06:00 ~ 13:00</td>
											<td><a href="#" class="btn btn-default btn-level">신청</a></td>
										</tr>
									</tbody>
								</table>
							</div>


							<div class="btn-group">
								<a href="#" class="btn btn-level1 btn-register">수강신청 완료</a>
							</div>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">

$(function(){
	$(".select-class-cate").on("click", function(){
		
		$('.select-class-cate').each(function(index) { 
			$(this).removeClass("is-selected")
		});
		$(this).addClass("is-selected")
		
		var value = $(this).data("value");
		$("#class_search").find('input[name="b_cate"]').val(value);
	});

	$(".select-class-member").on("click", function(){
		
		$('.select-class-member').each(function(index) { 
			$(this).removeClass("is-selected")
		});
		$(this).addClass("is-selected")
		
		var value = $(this).data("value");
		$("#class_search").find('input[name="em_type"]').val(value);
	});
	
	$(".select-class-result").on("click", function(){
		
		$('.select-class-result').each(function(index) { 
			$(this).removeClass("is-selected")
		});
		$(this).addClass("is-selected")
		
		var value = $(this).data("value");
		$("#class_search").find('input[name="class_yn"]').val(value);
	});
	
	$(".btn-rental").on("click", function(){
		var idx = $(this).data("value");
		var mode = $(this).data("mode");
		
		var class_ok = $("#listForm").find('input[name="class_ok"]').val();
		var class_re = $("#listForm").find('input[name="class_re"]').val();
		
		class_ok = class_ok.replace(idx, '');
		class_re = class_re.replace(idx, '');
		
		if($(this).hasClass('is-selected')){
			$(this).removeClass("is-selected")
		}else{
			$(this).parent().find('.btn-rental').each(function(index) { 
				$(this).removeClass("is-selected")
			});
			$(this).addClass("is-selected")
			
			if(mode == 'Y')
				class_ok += idx;
			else if(mode == 'D')
				class_re += idx;
		}
		
		$("#listForm").find('input[name="class_ok"]').val(class_ok);
		$("#listForm").find('input[name="class_re"]').val(class_re);
		
		/* alert(class_ok + " _ " + class_re); */
		/* console.log(class_ok);
		console.log(class_re); */
	});
	
	$('#listForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	
            //validation체크 
            if(form.find('input[name="class_ok"]').val() == '' && 
            		form.find('input[name="class_re"]').val() == ''){
            	alert("선정자 또는 대기자를 선택해주세요.");
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
            	alert("반영되었습니다.");
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