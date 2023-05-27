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
					<form id="modForm" method="post" action="${ADMIN_PATH}/rent/reserve/cancel">
					<input type="hidden" id="values" name="rt_nums" value=""/>
					<input type="hidden" name="re_date" value="<c:out value="${date}"/>"/>
					<input type="hidden" name="re_part" value="<c:out value="${part_cd}"/>"/>
						<h3 class="h3-title">예약/ 취소 : 예약/ 취소 버튼을 눌러 각 모드로 진입하여 예약 취소 하실 수 있습니다.<br>
						관리자 페이지에서 예약한 내용은 관리자 페이지에서만 취소 가능합니다.</h3>

						<div class="datebox-big"><input type="text" name="" id="selectDate" class="date-day" value="<c:out value="${fn:substring(date, 0, 4)}"/>.<c:out value="${fn:substring(date, 4, 6)}"/>.<c:out value="${fn:substring(date, 6, 8)}"/>"></div>

						<div class="calendar-by-3">
							<h3 class="tab-title">시설 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/cancel/15?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 15}"> is-selected </c:if>"><span>주경기장(배드민턴)</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/cancel/16?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 16}"> is-selected </c:if>"><span>탁구장</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/cancel/17?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 17}"> is-selected </c:if>"><span>당구장</span></a>
							</div>
						</div>
						<div class="calendar-by-3">
							<h3 class="tab-title">모드 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/time/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>예약현황</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>예약하기</span></a>
								<a href="#none" class="by-4  is-selected"><span>취소하기</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/lecture/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>고정강좌 취소</span></a>
							</div>
						</div>

						<div class="calendar-body">
							<div class="calendar-info">취소할 예약을 선택해 주십시오.</div>
							<div class="calendar-week">
								<div class="table-basic table-basic-type3" style="width:100%">
								<c:choose>
								<c:when test="${part_cd == 16}">
								<table>
										<colgroup><col width="*"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"></colgroup>
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
																	<td><span class="select-basic select-general">강습</span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><a href="#none"data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.cl_name }"/></a></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.re_name }"/></a></td>
																	</c:when>
																	<c:otherwise>
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.re_title }"/></a></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<td></td>
															</c:if>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="12" step="1">
														<td></td>
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
										<colgroup><col width="*"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"><col width="8%"></colgroup>
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
																	<td><span class="select-basic select-general">강습</span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.cl_name }"/></a></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.re_name }"/></a></td>
																	</c:when>
																	<c:otherwise>
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.re_title }"/></a></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<td></td>
															</c:if>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="9" step="1">
														<td></td>
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
										<colgroup><col width="*"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"><col width="7%"></colgroup>
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
											<c:otherwise>
												<c:choose>
												<c:when test="${not empty item.value }">
													<c:forEach var="i" begin="1" end="12" step="1">
														<c:set var="exist_flag" value="0" /> 
														<c:set var="str_i" value="${i}코트" /> 
															<c:forEach items="${item.value }" var="item2" varStatus="status1">
																<c:if test="${!((i == 1 and fn:contains(item2.rt_court, '11')) or (i == 2 and fn:contains(item2.rt_court, '12')) ) }">
																<c:if test="${fn:contains(item2.rt_court, str_i) }">
																	<c:choose>
																	<c:when test="${item2.re_type == 'lecture' }">
																	<td><span class="btn-toggle">강습</span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.cl_name }"/></a></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.re_name }"/></a></td>
																	</c:when>
																	<c:otherwise>
																	<td><a href="#none" data-value="${item2.rt_num }#" class="btn-toggle btn-toggle-off"><c:out value="${item2.re_title }"/><c:if test="${!empty item.value[0].re_kind }">(<c:out value="${item2.re_kind }"/>)</c:if></a></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																</c:if>
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<td></td>
															</c:if>
													</c:forEach>
													<td><a href="#none" class="btn-all">전체선택</a></td>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="12" step="1">
														<td></td>
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
								<button type="submit" class="btn btn-level2 btn-register">취소하기</button>
							</div>
						</div>
						</form>
					</article>
				</div>
			</div>
		</div>


		<div class="modal-basic js-modal " id="modal-reserve-cancel"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">대관 예약취소 내역 확인</div>
							<div class="modal-basic-desc">아래 취소 내용을 확인하시고 예약 취소 버튼을 선택해 주십시오.</div>
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
							<a href="#" class="by-2 btn btn-level1 btn-register js-modal__btn-close">닫기</a>
							<a href="#" class="by-2 btn btn-level1 btn-register">예약취소</a>
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
	        location.replace("${ADMIN_PATH}/rent/reserve/cancel/<c:out value='${part_cd}'/>?date=" + date );

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
	
	$(".btn-toggle").on("click", function(){
		var value = $(this).data("value");
		var values = $('input[name="rt_nums"]').val();
		
		if($(this).hasClass("btn-toggle-on")){
			$(this).removeClass("btn-toggle-on")
			$(this).addClass("btn-toggle-off")
			values = values.replace(value, "");
			
			$(this).parents('tbody').find('.btn-toggle').each(function(index) { 
				if(value == $(this).data("value")){
					$(this).removeClass("btn-toggle-on");
					$(this).addClass("btn-toggle-off");
				}
			});
			
		}else{
			$(this).addClass("btn-toggle-on")
			$(this).removeClass("btn-toggle-off")
			
			$(this).parents('tbody').find('.btn-toggle').each(function(index) { 
				if(value == $(this).data("value")){
					$(this).addClass("btn-toggle-on");
					$(this).removeClass("btn-toggle-off");
				}
			});
			
			if(values.indexOf(value) <= 0)
				values += value;
		}
		
		$('input[name="rt_nums"]').val(values);
	});
	
	$(".btn-all").on("click", function(){
		var values = $('input[name="rt_nums"]').val();
		$(this).parents('tr').find('.btn-toggle').each(function(index) { 
			var value = $(this).data("value");
			values = values.replace(value, "");
			$(this).addClass("btn-toggle-on");
			$(this).removeClass("btn-toggle-off");
			if(values.indexOf(value) <= 0)
				values += value;
		});
		
		$('input[name="rt_nums"]').val(values);
		/* console.log(values); */
	});
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
    		if($('input[name="rt_nums"]').val() == ''){
    			alert("취소할 코트를 선택해주세요.");
    			return false;
    		}
        	
           	if(!confirm("취소하시겠습니까?"))
           		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("취소가 완료되었습니다.");
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