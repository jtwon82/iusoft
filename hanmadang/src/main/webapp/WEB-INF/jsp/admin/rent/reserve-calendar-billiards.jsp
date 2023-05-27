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
						<h3 class="h3-title">예약/ 취소 : 예약/ 취소 버튼을 눌러 각 모드로 진입하여 예약 취소 하실 수 있습니다.<br>
						관리자 페이지에서 예약한 내용은 관리자 페이지에서만 취소 가능합니다.</h3>

						<div class="datebox-big"><input type="text" name="" id="selectDate" class="date-day" value="<c:out value="${fn:substring(date, 0, 4)}"/>.<c:out value="${fn:substring(date, 4, 6)}"/>.<c:out value="${fn:substring(date, 6, 8)}"/>"></div>

						<div class="calendar-by-3">
							<h3 class="tab-title">시설 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/time/15?date=<c:out value="${date}"/>" class="by-3"><span>주경기장(배드민턴)</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/time/16?date=<c:out value="${date}"/>" class="by-3"><span>탁구장</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/time/17?date=<c:out value="${date}"/>" class="by-3 is-selected"><span>당구장</span></a>
							</div>
						</div>
						<div class="calendar-by-3">
							<h3 class="tab-title">모드 선택</h3>
							<div class="rent-tabs ">
								<a href="#none" class="by-4 is-selected"><span>예약현황</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>예약하기</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/cancel/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>취소하기</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/lecture" class="by-4"><span>고정강좌 취소</span></a>
							</div>
						</div>
						<div class="calendar-body">
							<div class="calendar-week">
								<div class="table-basic table-basic-type3" style="width:100%">
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
															<td></td>
															</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach var="i" begin="1" end="9" step="1">
														<td></td>
													</c:forEach>
												</c:otherwise>
												</c:choose>
										</tr>
									</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
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
<script type="text/javascript">
$(function(){
	$(".date-day").datepicker({
		onSelect: function(dateText, inst) {
	        var date = $(this).val().replace(".", "");
	        location.replace("${ADMIN_PATH}/rent/reserve/time/<c:out value='${part_cd}'/>?date=" + date );

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
});
</script>
</body>
</html>