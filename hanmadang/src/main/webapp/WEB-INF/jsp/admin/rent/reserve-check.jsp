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
						<h2>대관관리</h2>
					</article>
					<div class="container-tabs">
						<%@ include file="tab_menu.jsp"%>
					</div>
					<article class="container-body">
						<form id="modForm" method="post" action="${ADMIN_PATH}/rent/time/save">
						<h3 class="h3-title">예약/ 취소 : 예약/ 취소 버튼을 눌러 각 모드로 진입하여 예약 취소 하실 수 있습니다.<br>
						관리자 페이지에서 예약한 내용은 관리자 페이지에서만 취소 가능합니다.</h3>

						<div class="datebox-big"><input type="text" name="" id="selectDate" class="date-day" value="<c:out value="${fn:substring(date, 0, 4)}"/>.<c:out value="${fn:substring(date, 4, 6)}"/>.<c:out value="${fn:substring(date, 6, 8)}"/>"></div>

						<div class="calendar-by-3">
							<h3 class="tab-title">시설 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/go/15?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 15}"> is-selected </c:if>"><span>주경기장(배드민턴)</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/16?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 16}"> is-selected </c:if>"><span>탁구장</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/17?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 17}"> is-selected </c:if>"><span>당구장</span></a>
							</div>
						</div>
						<div class="calendar-by-3">
							<h3 class="tab-title">모드 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/time/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>예약현황</span></a>
								<a href="#none" class="by-4 is-selected"><span>예약하기</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/cancel/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>취소하기</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/lecture/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>고정강좌 취소</span></a>
							</div>
						</div>
						<div class="calendar-by-1">
							<h3 class="tab-title">구분</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>&type=4" class="by-4 <c:if test="${type == 4}"> is-selected </c:if>"><span>회사행사 ( 구기종목 예약 ) </span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>&type=2" class="by-4 <c:if test="${type == 2}"> is-selected </c:if>"><span>동호회예약</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>&type=1" class="by-4 <c:if test="${type == 1}"> is-selected </c:if>"><span>직원예약</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>&type=3" class="by-4 <c:if test="${type == 3}"> is-selected </c:if>"><span>고정강좌/교육 예약</span></a>
							</div>
						</div>


						<h3 class="tab-title">정보 입력 <span class="h3-sub cl-blue">* 필수 입력사항 입니다.</span></h3>
						
						
						<input type="hidden" id="values" name="re_times" value=""/>
						<input type="hidden" name="re_date" value="<c:out value="${date}"/>"/>
						<input type="hidden" name="re_part" value="<c:out value="${part_cd}"/>"/>
						<input type="hidden" name="re_type" value="<c:out value="${type}"/>"/>
						<c:if test="${type == 4 }">
						<!-- 회사행사 ( 구기종목 예약 )  선택시 -->
						<div class="calendar-by-select">
							<div class="member-type-input reserve-subject">
								<div class="calendar-by-3 ">
									<label for="member-name">행사(부서)명</label>
									<input type="text" class="text" id="member-name" name="re_title" placeholder="행사(부서)명 입력">
								</div>
								<div class="calendar-by-3">
									<label for="member-number">담당자명</label>
									<input type="text" class="text" id="member-number" name="re_name" placeholder="담당자명">
								</div>
							</div>
							<div class="member-type-input reserve-subject">
								<div class="calendar-by-3">
									<div class="member-type-input reserve-subject">
										<label for="member-name">연락처</label>
										<input type="text" class="text" style="width:270px;" name="re_tel" placeholder="-없이 입력">
									</div>
								</div>
								<div class="calendar-by-3">
									<div class="member-type-input reserve-subject">
										<label for="member-name"> 구기종목</label>
											<div class="rent-tabs ">
											<a href="#none" data-value="농구" class="by-3 is-selected select-ball"><span>농구</span></a>
											<a href="#none" data-value="배구" class="by-3 select-ball"><span>배구</span></a>
											<a href="#none" data-value="족구" class="by-3 select-ball"><span>족구</span></a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" name="re_kind" value="농구"/>
						</c:if>
						<c:if test="${type == 2}">
						<!-- 동호회예약 선택시 -->
						<div class="calendar-by-select">
							<div class="calendar-by-3">
								<label for="" class="tab-label">동호회 선택</label>
								<span class="selectbox selectbox--type1">
									<select name="cl_num">
									<c:forEach items="${clubList }" var="club" varStatus="status">
									<option value="<c:out value="${club.cl_num }"/>"><c:out value="${club.cl_name }"/></option>
									</c:forEach>
									</select>
								</span>
							</div>
							<div class="calendar-by-3">
								<div><a href="#" class="btn btn-line btn-right">동호회 등록하기</a></div>
							</div>
						</div>
						</c:if>
						<c:if test="${type == 1 }">
						<!-- 직원 예약 선택시 -->
						<div class="calendar-by-select">
							<div class="member-type-input reserve-subject">
								<div class="calendar-by-3 ">
									<label for="member-name">직번 입력</label>
									<input type="text" class="text" id="member-name" name="re_code" placeholder="직번 입력">
								</div>
								<div class="calendar-by-3">
									<label for="member-number">이용자명</label>
									<input type="text" class="text" id="member-number" name="re_name" placeholder="이용자명 입력">
								</div>
							</div>
						</div>
						</c:if>
						<c:if test="${type == 3 }">
						<!-- 고정강좌/ 교육 예약 선택시 -->
						<div class="calendar-by-select">
							<div class="member-type-input reserve-subject">
								<div class="calendar-by-1 ">
									<label for="member-name">강좌/교육명</label>
									<input type="text" class="text" name="re_title" id="member-name" placeholder="강좌/교육명 입력">
								</div>
								<div class="calendar-by-1">
									<label for="member-number">요일</label>
									<div class="rent-tabs ">
										<a href="#none" data-value=",1" class="by-10 is-selected select-yoil"><span>월</span></a>
										<a href="#none" data-value=",2" class="by-10 select-yoil"><span>화</span></a>
										<a href="#none" data-value=",3" class="by-10 select-yoil"><span>수</span></a>
										<a href="#none" data-value=",4" class="by-10 select-yoil"><span>목</span></a>
										<a href="#none" data-value=",5" class="by-10 select-yoil"><span>금</span></a>
										<a href="#none" data-value=",6" class="by-10 select-yoil"><span>토</span></a>
										<a href="#none" data-value=",7" class="by-10 select-yoil"><span>일</span></a>
										<span class="h3-sub cl-blue">* 매주 해당 요일에 고정으로 예약됩니다</span>
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" name="re_yoil" value=",1"/>
						</c:if>
						<div class="calendar-body">
							<div class="calendar-info">예약할 시간과 코트를 선택해 주십시오.</div>
							<div class="calendar-week">
								<div class="table-basic table-basic-type3" style="width:100%">
								<c:choose>
								<c:when test="${part_cd == 16}">
								<table>
										<colgroup><col width="*"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>시간</th>
												<th>신발장</th>
												<th>2코트</th>
												<th>3코트</th>
												<th>4코트</th>
												<th>5코트</th>
												<th>6코트</th>
												<th>7코트</th>
												<th>8코트</th>
												<th>9코트</th>
												<th>10코트</th>
												<th>11코트</th>
												<th>12코트</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${data }" var="item" varStatus="status">
										<tr>	
											<td><c:out value="${item.key }"/></td>
												<c:choose>
												<c:when test="${not empty item.value }">
													<c:forEach var="i" begin="1" end="12" step="1">
														<c:set var="exist_flag" value="0" /> 
														<c:choose>
														<c:when test="${i == 11 }">
														<c:set var="str_i" value="A코트" /> 
														</c:when>
														<c:when test="${i == 12 }">
														<c:set var="str_i" value="B코트" /> 
														</c:when>
														<c:otherwise>
														<c:set var="str_i" value="${i}코트" /> 
														</c:otherwise>
														</c:choose>
															<c:forEach items="${item.value }" var="item2" varStatus="status1">
																<c:if test="${fn:contains(item2.rt_court, str_i) }">
																	<c:choose>
																	<c:when test="${item2.re_type == 'lecture' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_title }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.cl_name }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_name }"/></span></td>
																	</c:when>
																	<c:otherwise>
																	<td><span class="select-basic select-general"><c:out value="${item2.re_title }"/></span></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<td><a href="#none" data-value="${item.key }|${str_i}#" class="select-basic select-able">예약가능</a></td>
															</c:if>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="12" step="1">
														<c:choose>
														<c:when test="${i == 11 }">
														<c:set var="str_i1" value="A코트" /> 
														</c:when>
														<c:when test="${i == 12 }">
														<c:set var="str_i1" value="B코트" /> 
														</c:when>
														<c:otherwise>
														<c:set var="str_i1" value="${i}코트" /> 
														</c:otherwise>
														</c:choose>
														<td><a href="#none" data-value="${item.key }|${str_i1}#" class="select-basic select-able">예약가능</a></td>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:otherwise>
												</c:choose>
										</tr>
									</c:forEach>
										</tbody>
									</table>
								</c:when>
								<c:when test="${part_cd == 17}">
								<table>
										<colgroup><col width="*"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>시간</th>
												<th>1(특대)</th>
												<th>1(중대)</th>
												<th>3(중대)</th>
												<th>4(중대)</th>
												<th>5(중대)</th>
												<th>6(중대)</th>
												<th>7(중대)</th>
												<th>8(중대)</th>
												<th>9(포켓)</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${data }" var="item" varStatus="status">
										<tr>	
											<td><c:out value="${item.key }"/></td>
												<c:choose>
												<c:when test="${not empty item.value }">
													<c:forEach var="i" begin="1" end="9" step="1">
														<c:set var="exist_flag" value="0" /> 
														<c:set var="str_i" value="${i}코트" /> 
															<c:forEach items="${item.value }" var="item2" varStatus="status1">
																<c:if test="${fn:contains(item2.rt_court, str_i) }">
																	<c:choose>
																	<c:when test="${item2.re_type == 'lecture' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_title }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.cl_name }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_name }"/></span></td>
																	</c:when>
																	<c:otherwise>
																	<td><span class="select-basic select-general"><c:out value="${item2.re_title }"/></span></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<td><a href="#none" data-value="${item.key }|${i}코트#" class="select-basic select-able">예약가능</a></td>
															</c:if>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="9" step="1">
														<td><a href="#none" data-value="${item.key }|${i}코트#" class="select-basic select-able">예약가능</a></td>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:otherwise>
												</c:choose>
										</tr>
									</c:forEach>
										</tbody>
									</table>
								</c:when>
								<c:otherwise>
								<table>
										<colgroup><col width="*"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>시간</th>
												<th>1코트</th>
												<th>2코트</th>
												<th>3코트</th>
												<th>4코트</th>
												<th>5코트</th>
												<th>6코트</th>
												<th>7코트</th>
												<th>8코트</th>
												<th>9코트</th>
												<th>10코트</th>
												<th>11코트</th>
												<th>12코트</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${data }" var="item" varStatus="status">
											<tr>
												<td><c:out value="${item.key }"/></td>
												<c:choose>
											<c:when test="${fn:contains(item.key, '18:00 ~') }">
											<td colspan="12"><span class="select-basic select-break">크리닝 타임</span></td>
											</c:when>
											<c:when test="${fn:length(item.value) > 0 and item.value[0].allCourt == true }">
											<td colspan="12"><span class="select-basic select-general"><c:out value="${item.value[0].re_title }"/><c:if test="${!empty item.value[0].re_kind }">(<c:out value="${item.value[0].re_kind }"/>)</c:if></span></td>
											</c:when>
											<c:otherwise>
											<c:choose>
												<c:when test="${not empty item.value }">
													<c:forEach var="i" begin="1" end="12" step="1">
														<c:set var="usedcourt" value="" /> 
														<c:set var="exist_flag" value="0" /> 
														<c:set var="str_i" value="${i}코트" /> 
															<c:forEach items="${item.value }" var="item2" varStatus="status1">
																<c:if test="${!((i == 1 and fn:contains(item2.rt_court, '11')) or (i == 2 and fn:contains(item2.rt_court, '12')) ) }">
																<c:if test="${fn:contains(item2.rt_court, str_i) and !fn:contains(usedcourt, str_i) }">
																	<c:choose>
																	<c:when test="${item2.re_type == 'lecture' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_title }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.cl_name }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_name }"/></span></td>
																	</c:when>
																	<c:otherwise>
																	<td><span class="select-basic select-general"><c:out value="${item2.re_title }"/></span></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																	<c:set var="usedcourt" value="${usedcourt += str_i }" /> 
																</c:if>
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<td><a href="#none" data-value="${item.key }|${i}코트#" class="select-basic select-able">예약가능</a></td>
															</c:if>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="12" step="1">
														<td><a href="#none" data-value="${item.key }|${i}코트#" class="select-basic select-able">예약가능</a></td>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:otherwise>
												</c:choose>
											</c:otherwise>
											</c:choose>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:otherwise>
								</c:choose>
								
								</div>
							</div>
							<div class="btn-group">
						<!-- 		<a href="#" class="btn btn-level2 btn-register btn-prev">이전으로</a> -->
								<button type="submit" class="btn btn-level2 btn-register">예약하기</button>
							</div>
						</div>
						</form>
					</article>
				</div>
			</div>
		</div>


		<div class="modal-basic js-modal " id="modal-reserve-select"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">대관 예약 내역 확인</div>
							<div class="modal-basic-desc">아래 예약 내용을 확인하시고 확인 버튼을 선택해 주십시오.</div>
						</div>
						<div class="pay-result">
							<dl>
								<dt>시설</dt>
								<dd>주경기장(배드민턴)</dd>
								<dt>구분</dt>
								<dd>회사행사 예약</dd>
								<dt>일시</dt>
								<dd>10:00 ~ 11:00 3코트<br>11:00 ~ 12:00 3코트</dd>
							</dl>
						</div>
						<div class="btn-group">
							<a href="#" class="btn btn-level1 btn-register">확인</a>
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
	
	$(".date-day").datepicker({
		onSelect: function(dateText, inst) {
	        var date = $(this).val().replace(".", "");
	        location.replace("${ADMIN_PATH}/rent/reserve/go/<c:out value='${part_cd}'/>?date=" + date );

	    },
	    buttonImageOnly: true,
		prevText: '이전달',
		nextText: '다음달',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:["일","월","화","수","목","금","토"],
		dateFormat:"yy.mm.dd",
		changeMonth: true,
		changeYear: true
	});
	
	$(".select-able, .select-time").on("click", function(){
		var value = $(this).data("value");
		var values = $('input[name="re_times"]').val();
		
		if($(this).hasClass("select-time")){
			$(this).removeClass("select-time")
			$(this).addClass("select-able")
			values = values.replace(value, "");
		}else{
			$(this).addClass("select-time")
			$(this).removeClass("select-able")
			values += value;
		}
		
		$('input[name="re_times"]').val(values);
	});
	
	$(".btn-all").on("click", function(){
		var values = $('input[name="re_times"]').val();
		$(this).parents('tr').find('.select-able').each(function(index) { 
			var value = $(this).data("value");
			values = values.replace(value, "");
			$(this).addClass("select-time")
			$(this).removeClass("select-able")
			if(values.indexOf(value) <= 0)
				values += value;
		});
		
		$('input[name="re_times"]').val(values);
/* 		alert(values); */
	});
	
	$(".select-ball").on("click", function(){
		var value = $(this).data("value");
		$('input[name="re_kinde"]').val("");
		
		if($(this).hasClass("is-selected")){
			$(this).removeClass("is-selected")
		}else{
			$('.select-ball').each(function(index) { 
				$(this).removeClass("is-selected")
			});
			$(this).addClass("is-selected")
			$('input[name="re_kinde"]').val(value);
		}
	});
	
	$(".select-yoil").on("click", function(){
		var value = $(this).data("value");
		var values = $('input[name="re_yoil"]').val();
		
		if($(this).hasClass("is-selected")){
			$(this).removeClass("is-selected")
			
			values = values.replace(value, '');
		}else{
			$(this).addClass("is-selected")
			$('input[name="re_kinde"]').val(value);
			
			values += value;
		}
		
/* 		alert(values); */
		$('input[name="re_yoil"]').val(values);
	});
	
/* 	$(".act-reserve").on("click", function(){
		
		
		$('#modForm').submit();
	}); */
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	var type = form.find('input[name="re_type"]').val()
    		if(type == 1){
    			if($('input[name="re_code"]').val() == ''){
    				alert("직번을 입력해주세요.");
    				return false;
    			}
    			if($('input[name="re_name"]').val() == ''){
    				alert("직원명을 입력해주세요.");
    				return false;
    			}
    			
    		}else if(type == 2){
    		}else if(type == 3){
    			if($('input[name="re_title"]').val() == ''){
    				alert("강좌/교육명을 입력해주세요.");
    				return false;
    			}
    			if($('input[name="re_yoil"]').val() == ''){
    				alert("고정 요일을 선택해주세요.");
    				return false;
    			}
    		}else if(type == 4){
    			if($('input[name="re_title"]').val() == ''){
    				alert("행사(부서)명을 입력해주세요.");
    				return false;
    			}
    			if($('input[name="re_name"]').val() == ''){
    				alert("담당자명을 입력해주세요.");
    				return false;
    			}
    			if($('input[name="re_tel"]').val() == ''){
    				alert("연락처를 입력해주세요.");
    				return false;
    			}
    		}else{
    			return false;
    		}
    		
    		if($('input[name="re_times"]').val() == ''){
    			alert("예약할 시간과 코트를 선택해주세요.");
    			return false;
    		}
        	
           	if(!confirm("예약하시겠습니까?"))
           		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	location.reload(true);
            }else if(response == 'NOT_FOUND'){
            	alert("등록되지 않은 정보입니다.");
            }else if(response == 'NOT_MATCHE'){
            	alert("비밀번호가 올바르지 않습니다.");
            }else if(response == 'DUPLICATE'){
            	alert("중복된 예약이 있습니다.");
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