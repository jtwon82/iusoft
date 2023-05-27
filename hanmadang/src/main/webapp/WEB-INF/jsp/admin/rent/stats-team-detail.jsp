<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script src="/admin/assets/js/lib/plugin.js" type="text/javascript"></script>
<style type="text/css">
.sticky-table {max-width: 100%; overflow: auto;}
.sticky-table table {}
.sticky-table table tr.sticky-row td, .sticky-table table tr.sticky-row th {position: relative;z-index: 5}
.sticky-table table td.sticky-cell, .sticky-table table th.sticky-cell {position: relative;z-index: 10}
.sticky-table table tr.sticky-row td.sticky-cell, .sticky-table table tr.sticky-row th.sticky-cell { z-index: 15 }
.sticky-table table th span{min-width:70px; display:inline-block; line-height:1.2em; padding:5px 5px; font-size:14px;}
.sticky-table table td{ padding:5px 5px 4px 5px;}
.sticky-table .table-basic-type2{margin:0;}
</style>
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
						<h3 class="h3-title"><strong>대관 이용 통계</strong><br>
						기간별 대관 이용 통계를 확인합니다.</h3>

						<div class="rent-tabs ">
							<a href="${ADMIN_PATH}/rent/stats/all" class="by-3"><span>전체 이용 통계</span></a>
							<a href="${ADMIN_PATH}/rent/stats/team" class="by-3"><span>동호회 이용 통계</span></a>
							<a href="#none" class="by-3 is-selected"><span>동호회 개별 통계</span></a>
						</div>

						<h3 class="tab-title">기간 설정</h3>
						<div class="calendar-by-1">
							<span class="radio radio--type1">
								<input type="radio" value="0" name="select-day" id="input-day" <c:if test="${type == 0 }">checked</c:if>>
								<label for="input-day">일별검색</label>
							</span>
							<div class="datebox-basic"><input type="text" name="sdate" id="startInput2" <c:if test="${type == 0 }">value="<c:out value="${sdate }"/>"</c:if> class="date-day"></div><span class="bar">~</span><div class="datebox-basic"><input type="text" name="edate" <c:if test="${type == 0 }">value="<c:out value="${edate }"/>" </c:if>id="endInput2" class="date-day"></div>
						</div>
						<div class="calendar-by-1">
							<span class="radio radio--type1">
								<input type="radio" value="1" name="select-day" id="input-month" <c:if test="${type == 1 }">checked</c:if>>
								<label for="input-month">월별검색</label>
							</span>
							<a href="javascript:dateInput(30, 0);" class="btn-cancel">최근1개월</a>
							<a href="javascript:dateInput(180, 0);" class="btn-cancel">최근6개월</a>
							<a href="javascript:dateInput(365, 0);" class="btn-cancel">최근12개월</a>
							<div class="datebox-basic"><input type="text" name="sdate" id="startInput3" <c:if test="${type == 1 }">value="<c:out value="${sdate }"/>" </c:if>class="date-day"></div><span class="bar">~</span><div class="datebox-basic"><input type="text" name="edate" <c:if test="${type == 1 }">value="<c:out value="${edate }"/>" </c:if> id="endInput4" class="date-day"></div>
						</div>
						<div class="btn-group">
							<a href="#" class="btn btn-register btn-level3 act-search">검색하기</a>
						</div>

						<form name="frm" method="post">
							<input type="hidden" name="excel_data" />
							<input type="hidden" name="file_name" />
						</form>
						
						<h3 class="h3-title">대관 이용 리스트</h3>
						<div class="h3-btn"><a href="#none" class="btn btn-line act-excel">엑셀 출력하기</a></div>
						<div class="table-basic" style="display:none;">
							<div class="">
								<table class="table-basic-type2" id="excel_body">
									<colgroup>
										<col width="100"><col width="100">
										<c:forEach items="${clubList }" var="item" varStatus="status">
											<col width="80">
										</c:forEach>
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2" style="height: 84px;">날짜</th>
											<th rowspan="2" style="height: 84px;" >구분</th>
											<th colspan="${fn:length(clubList) }">동호회</th>
										</tr>
										<tr>
											<c:forEach items="${clubList }" var="item" varStatus="status">
												<th><span class="cl-gray"><c:out value="${item.cl_name }"/></span></th>
											</c:forEach>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list }" var="item" varStatus="status">
										<tr>
											<td rowspan="4" style="height:142px;"><c:out value="${fn:substring(item.key, 0, 4)}"/><c:out value="${fn:substring(item.key, 4, 6)}"/><c:out value="${fn:substring(item.key, 6, 8)}"/></td>
											<th class="bg-dim">전체</th>
											<c:forEach items="${item.value }" var="item1" varStatus="status1">
												<td><c:out value="${item1.team_ok + item1.team_cancel + item1.team_fail}"/></td>
											</c:forEach>
										</tr>
										<tr>
											<th class="bg-dark">예약</th>
											
											<c:forEach items="${item.value }" var="item1" varStatus="status1">
												<td><span class="cl-blue"><c:out value="${item1.team_ok }"/></span></td>
											</c:forEach>
										</tr>
										<tr>
											<th class="bg-gray">취소</th>
											
											<c:forEach items="${item.value }" var="item1" varStatus="status1">
											<td><c:out value="${item1.team_cancel}"/></td>
											</c:forEach>
										</tr>
										<tr>
											<th class="bg-light">탈락</th>
											<c:forEach items="${item.value }" var="item1" varStatus="status1">
											<td><span class="cl-gray"><c:out value="${item1.team_fail }"/></span></td>
											</c:forEach>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
						
						<div class="table-basic">
							<div class="col-9-1">
								<table class="table-basic-type2">
									<colgroup>
										<col width="100%">
									</colgroup>
									<thead>
										<tr>
											<th style="height: 84px;">날짜</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr>
											<td style="height:140px;"><c:out value="${fn:substring(item.key, 0, 4)}"/>-<c:out value="${fn:substring(item.key, 4, 6)}"/>-<c:out value="${fn:substring(item.key, 6, 8)}"/></td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="col-9-2">
								<table class="table-basic-type2">
									<colgroup>
										<col width="100%">
									</colgroup>
									<thead>
										<tr>
											<th style="height: 84px;" >구분</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr>
											<th class="bg-dim">전체</th>
										</tr>
										<tr>
											<th class="bg-dark">예약</th>
										</tr>
										<tr>
											<th class="bg-gray">취소</th>
										</tr>
										<tr>
											<th class="bg-light">탈락</th>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="col-9-rest">

								<table class="table-basic-type2">
									<colgroup>
										<col width="100%">
									</colgroup>
									<thead>
										<tr>
											<th>동호회</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td style="max-width:800px; padding:0;">
													<div class="sticky-table sticky-headers sticky-ltr-cells">
														<table class="table table-striped table-striped table-basic-type2">
															<thead>
																<tr class="sticky-row" style="height:46px;" >
																<c:forEach items="${clubList }" var="item" varStatus="status">
																	<th><span class="cl-gray"><c:out value="${item.cl_name }"/></span></th>
																</c:forEach>
																</tr>
															</thead>
															<tbody>
															<c:forEach items="${list }" var="item" varStatus="status">
																<tr>
																<c:forEach items="${item.value }" var="item1" varStatus="status1">
																	<td><c:out value="${item1.team_ok + item1.team_cancel + item1.team_fail}"/></td>
																</c:forEach>
																</tr>
																<tr>
																<c:forEach items="${item.value }" var="item1" varStatus="status1">
																	<td><span class="cl-blue"><c:out value="${item1.team_ok }"/></span></td>
																</c:forEach>
																</tr>
																<tr>
																	<c:forEach items="${item.value }" var="item1" varStatus="status1">
																	<td><c:out value="${item1.team_cancel}"/></td>
																	</c:forEach>
																</tr>
																<tr>
																	<c:forEach items="${item.value }" var="item1" varStatus="status1">
																	<td><span class="cl-gray"><c:out value="${item1.team_fail }"/></span></td>
																	</c:forEach>
																</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
											</td>
										</tr>
									</tbody>
								</table>
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

function dateInput(n,m){
	  var date = new Date();
	  var start = new Date(Date.parse(date) - n * 1000 * 60 * 60 * 24);
	  var today = new Date(Date.parse(date) - m * 1000 * 60 * 60 * 24);
	  
	  var yyyy = start.getFullYear();
	  var mm = start.getMonth()+1;
	  var dd = start.getDate();
	  
	  if(mm<10){
	   mm = "0" + mm;
	  }if(dd<10){
	   dd = "0" + dd;
	  }
	  
	  var t_yyyy = today.getFullYear();
	  var t_mm = today.getMonth()+1;
	  var t_dd = today.getDate();
	  
	  if(t_mm<10){
	   t_mm = "0" + t_mm;
	  }if(t_dd<10){
	   t_dd = "0" + t_dd;
	  }
	  
	  $('input[id="startInput3"]').val(yyyy + mm + dd);
	  $('input[id="endInput4"]').val(t_yyyy + t_mm + t_dd);
}
	 
$(function(){
	$(".date-day").datepicker({
	    buttonImageOnly: true,
		prevText: '이전달',
		nextText: '다음달',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:["일","월","화","수","목","금","토"],
		dateFormat:"yymmdd",
		changeMonth: true,
		changeYear: true
	});
	
	$(".act-search").on("click", function(){
		
		var type = $("input:radio[name='select-day']:checked").val();
		
		if(type == 0){
			var sdate = $('input[id="startInput2"]').val();
			var edate = $('input[id="endInput2"]').val();
			if(sdate == '' || edate == ''){
				alert("기간을 선택해주세요.");
				return;
			}
			
			location.replace("${ADMIN_PATH}/rent/stats/detail?type=0&sdate=" + sdate + "&edate=" + edate);
		}else{
			var sdate = $('input[id="startInput3"]').val();
			var edate = $('input[id="endInput4"]').val();
			if(sdate == '' || edate == ''){
				alert("기간을 선택해주세요.");
				return;
			}
			
			location.replace("${ADMIN_PATH}/rent/stats/detail?type=1&sdate=" + sdate + "&edate=" + edate);
		}
		
	});
	
	$(".act-excel").on("click", function(){
		document.frm.action = "${ADMIN_PATH}/rent/stats/excel";
		document.frm.excel_data.value = document.getElementById("excel_body").outerHTML;
		document.frm.file_name.value = 'team_detail_stats';
		document.frm.submit();
	});
});
</script>
</body>
</html>