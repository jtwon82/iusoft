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
						<h3 class="h3-title">선정자 회원 리스트 검색 및 취소</h3>
						<div class="h3-desc">항목별로 수강신청 회원을 검색하며, 추첨전에 미리 선정할 수 있습니다.</div>
						<h3 class="h3-title">선정 회원 검색</h3>
						
						<form id="class_search" method="post" action="${ADMIN_PATH}/entry/result/list">
						<input type="hidden" name="b_cate" value="<c:out value="${param.b_cate }"/>"/>
						<input type="hidden" name="em_type" value="<c:out value="${param.em_type }"/>"/>
						<input type="hidden" name="class_yn" value="<c:out value="${param.class_yn }"/>"/>
						
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
						<!-- <div class="rent-tabs under-tabs">
							<a href="#none" class="by-3 is-selected"><span>전체</span></a>
							<a href="#none" class="by-3"><span>기존회원</span></a>
							<a href="#none" class="by-3"><span>신규회원</span></a>
						</div> -->
						<div class="by-2">
							<h3 class="tab-title">상태구분</h3>
							<div class="rent-tabs ">
								<a href="#none" data-value="YN" class="select-class-result by-4 <c:if test="${empty param.class_yn or param.class_yn == 'YN' }">is-selected</c:if>"><span>전체</span></a>
								<a href="#none" data-value="Y" class="select-class-result by-4 <c:if test="${param.class_yn == 'Y' }">is-selected</c:if>"><span>선정</span></a>
								<a href="#none" data-value="D" class="select-class-result by-4 <c:if test="${param.class_yn == 'D' }">is-selected</c:if>"><span>대기</span></a>
							<!-- 	<a href="#none" class="select-class-result by-4"><span>취소</span></a> -->
							</div>
						</div>

						<div class="by-2">
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
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-default btn-level2">검색하기</button>
						</div>
						</form>

						<h3 class="h3-title">선정자 회원 리스트</h3>
						<!-- <div class="h3-btn"><a href="#modal-add-member" class="btn btn-default btn-level js-modal__btn-open">직원 목록 보기</a></div> -->
						<!-- <div class="h3-desc">
							<span class="note-text cl-blue">버튼을 선택하면,  온라인 회원 신청서를 인쇄하실 수 있습니다.</span>
							<span class="note-text cl-blue">결제를 완료한 선정자는 수강 결제확인/등록 관리에서 내용을 확인할 수 있습니다.</span>
						</div> -->

						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="12%">
									<col width="6%">
									<col width="9%">
									<col width="7%">
									<col width="10%">
									<col width="9%">
									<col width="7%">
									<col width="7%">
									<col width="*">
									<col width="5%">
									<col width="5%">
									<col width="6%">
									<col width="6%">
								</colgroup>
								<thead>
									<tr>
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
										<th>상태</th>
										<th>취소</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.classInfo.b_cate_name}"/></td>
										<td><c:out value="${item.classInfo.class_name}"/></td>
										<td><c:out value="${item.classInfo.class_time}"/></td>
										<td>
										<c:choose>
										<c:when test="${item.em_type == '01' }">포스코패밀리</c:when>
										<c:when test="${item.em_type == '02' }">포스코패밀리</c:when>
										<c:otherwise>
										일반회원
										</c:otherwise>
										</c:choose>
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
										<c:when test="${item.class_yn == 'Y' }">
										<td>선정</td>
										</c:when>
										<c:otherwise>
										<td>대기 ${item.rankFormat }</td>
										</c:otherwise>
										</c:choose>
										<td><a href="#none" data-value="<c:out value="${item.idx_no}"/>" class="btn btn-level btn-rental">취소하기</a></td>
									</tr>
								</c:forEach>
								</c:if>
								</tbody>
							</table>
						</div>
						<c:if test="${not empty list }">
						<%@ include file="../common/paging.jsp"%>
						</c:if>
						<div class="btn-group">
							<a href="${ADMIN_PATH}/entry/result/excel" class="btn btn-register btn-level2 act-down">엑셀로 다운로드 받기</a>
						</div>

					</article>
				</div>
			</div>
		</div>



		<div class="modal-basic js-modal" id="modal-member-print"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-wide__body">
					<div class="modal-wide__contents">
						<p class="modal-wide-title">회원신청서</p>
						<div class="modal-wide__scroll">
							<div class="register-form">
								<div class="register-title">이용프로그램</div>

								<div class="register-type-input">
									<label for="">프로그램</label>
									<div class="member-type-select">
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input1">
											<label for="input1">휘트니스</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input2">
											<label for="input2">휘트니스+스크린승마</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input3">
											<label for="input3">스쿼시</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input4">
											<label for="input4">휘트니스+스쿼시</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input5">
											<label for="input5">스피닝</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input6">
											<label for="input6">에어로빅</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input7">
											<label for="input7">요가</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input8">
											<label for="input8">다이어트 댄스</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input9">
											<label for="input9">밸리댄스</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input9">
											<label for="input9">스크린승마</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-scale" id="input10">
											<label for="input10">다이어트발레</label>
										</span>
									</div>
								</div>
								<!-- select//end -->
								<div class="register-type-input">
									<label for="register-duedate">강습기간</label>
									<input type="text" class="text" id="register-duedate" style="width:85px" /><span class="words">월</span><input type="text" class="text" id="register-duedate2" style="width:85px" /><span class="words">일 ~ </span><input type="text" class="text" id="register-duedate3" style="width:85px" /><span class="words">월</span><input type="text" class="text" id="register-duedate4" style="width:85px" /><span class="words">일</span>
								</div>
								<div class="register-type-input">
									<label for="register-day">강습일시</label>
									<div class="register-day-tabs">
										<span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="check1" >
											<label for="check1">월</label>
										</span>
										<span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="check2" >
											<label for="check2">화</label>
										</span>
										<span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="check3" >
											<label for="check3">수</label>
										</span>
										<span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="check4" >
											<label for="check4">목</label>
										</span>
										<span class="checkbox checkbox--type1">
											<input type="checkbox" name="select-scale" id="check5" >
											<label for="check5">금</label>
										</span>
									</div>
									<div class="register-day-time">
										<input type="text" class="text" style="width:85px" /><span class="words">시</span><input type="text" class="text" style="width:85px" /><span class="words">분</span>
									</div>
								</div>

								<div class="register-title">회원 구분 및 인적사항 입력</div>
								<div class="register-type-input">
									<label for="">회원구분</label>
									<div class="register-type-tabs">
										<span class="radio radio--type1">
											<input type="radio" name="select-member" id="member1">
											<label for="member1">정회원<em>(포스코 직원 및 가족)</em></label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-member" id="member2">
											<label for="member2">준회원<em>(포스코 OB / 패밀리사 가족)</em></label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-member" id="member3">
											<label for="member3">일반회원<em>(지곡동 주민)</em></label>
										</span>
									</div>
								</div>
								<div class="register-type-input">
									<div class="fl by-2">
										<label for="register-company">회사명</label>
										<input type="text" class="text" id="register-company" style="width:180px" placeholder="회사명 입력" />
									</div>
									<div class="fr by-2">
										<label for="register-part">부서명</label>
										<input type="text" class="text" id="register-part" style="width:180px" placeholder="부서명 입력" />
									</div>
								</div>
								<div class="register-type-input">
									<div class="fl by-2">
										<label for="register-name">직원명</label>
										<input type="text" class="text" id="register-name" style="width:180px" placeholder="직원명 입력" />
									</div>
									<div class="fr by-2">
										<label for="register-number">직번(사번)<p class="info-noti">- 없이 입력해주십시요.</p></label>
										<input type="text" class="text" id="register-number" style="width:180px" placeholder="직번(사번) 입력" />
									</div>
								</div>
								<div class="register-type-input-bar"></div>
								<div class="register-type-input register-family">
									<label for="">회원과의 관계</label>
									<div class="register-family-tabs">
										<span class="radio radio--type1">
											<input type="radio" name="select-family" id="family1">
											<label for="family1">본인</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-family" id="family2">
											<label for="family2">배우자</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-family" id="family3">
											<label for="family3">부</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-family" id="family4">
											<label for="family4">모</label>
										</span>
										<span class="radio radio--type1">
											<input type="radio" name="select-family" id="family5">
											<label for="family5">자녀</label>
										</span>
									</div>
								</div>

								<div class="register-type-input register-family">
									<label for="register-family-name">신청자명</label>
										<input type="text" class="text" id="register-family-name" style="width:180px" placeholder="신청자명 입력" />
								</div>
								<div class="register-type-input register-family">
									<label for="register-family-birth">신청자 생년월일</label>
										<input type="text" class="text" id="register-family-birth" style="width:80px" /><span class="words">년</span><input type="text" class="text" id="register-family-birth2" style="width:80px" /><span class="words">월</span><input type="text" class="text" id="register-family-birth3" style="width:80px" /><span class="words">일</span>
								</div>
								<div class="register-type-input register-family">
									<label for="register-family-tel">신청자 전화번호</label>
										<input type="text" class="text" id="register-family-tel" style="width:80px" /><span class="bar">-</span><input type="text" class="text" id="register-family-tel2" style="width:80px" /><span class="bar">-</span><input type="text" class="text" id="register-family-tel3" style="width:80px" />
								</div>
								<div class="register-type-input register-family">
									<label for="register-family-phone">신청자 휴대폰번호</label>
										<input type="text" class="text" id="register-family-phone" style="width:80px" /><span class="bar">-</span><input type="text" class="text" id="register-family-phone2" style="width:80px" /><span class="bar">-</span><input type="text" class="text" id="register-family-phone3" style="width:80px" />
								</div>
								<div class="register-type-input register-family">
									<label for="register-family-address">신청자 주소</label>
										<input type="text" class="text" id="register-type-input" style="width:545px" />
								</div>
							</div>
							<div class="register-form">
								<div class="btn-group">
									<a href="#" class="btn by-2 btn-agree">개인 정보 취급방침 보기</a>
									<a href="#" class="btn by-2 btn-agree">이용약관 보기</a>
								</div>
								<div class="checkbox">
									<input type="checkbox" class="checkbox" id="agree-terms"><label for="agree-terms">상기 본인은 포스코 한마당 체육관 이용안내 및 이용규정을 확인하였고, <br>제공한 개인정보(인적사항)을 포스코 한마당에서 수집/이용하는 것에 대해 동의함</label>
								</div>
								<div class="checkbox">
									<input type="checkbox" class="checkbox" id="agree-service"><label for="agree-service">문자 메시지 (회원 공지사항 안내 서비스 제공) 수신에 동의합니다</label>
								</div>
							</div>
							<div class="register-date">2017년 12월 31일</div>
							<div class="register-btn">
								<div class="btn-group">
									<a href="javascript:print();" class="btn btn-register btn-level2">인쇄하기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-add-member"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-wide__body">
					<div class="modal-wide__contents">
						<div class="modal-wide-title">직원 목록 보기</div>
						<div class="modal-wide__scroll">
							<div class="modal-wide__subject">직원 검색</div>

							<div class="search-box">
								<span class="selectbox selectbox--type1">
									<select name="select">
										<option value="">검색 조건 (직번/이름)</option>
										<option value="">직번</option>
										<option value="">이름</option>
									</select>
								</span>

								<input type="text" class="text" id="search-lecture" placeholder="검색어 입력" />
								<a href="#" class="btn btn-block btn-default btn-level">검색하기</a>
							</div>

							<div class="modal-wide__subject">직원 리스트<span class="h3-sub">총 1000명의 직원이 있습니다.</span></div>

							<div class="table-basic">
								<table class="table-basic-type2">
									<colgroup>
										<col width="25%">
										<col width="25%">
										<col width="25%">
										<col width="25%">
									</colgroup>
									<thead>
										<tr>
											<th>직번 (사원번호)</th>
											<th>사원명</th>
											<th>부서명</th>
											<th>직무명</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>00000000</td>
											<td>홍길동</td>
											<td>부서명</td>
											<td>직무명</td>
										</tr>
										<tr>
											<td>00000000</td>
											<td>홍길동</td>
											<td>부서명</td>
											<td>직무명</td>
										</tr>
										<tr>
											<td>00000000</td>
											<td>홍길동</td>
											<td>부서명</td>
											<td>직무명</td>
										</tr>
										<tr>
											<td>00000000</td>
											<td>홍길동</td>
											<td>부서명</td>
											<td>직무명</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="btn-group">
								<a href="#" class="btn btn-level1 btn-default js-modal__btn-close">닫기</a>
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
		if(!confirm("취소하시겠습니까?"))
    		return;
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/apply/result/cancel',
		  	data:"idx="+idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		             alert("취소되었습니다.");
		             location.reload(true);
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
		
	});	
});

</script>
</body>
</html>