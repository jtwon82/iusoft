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
								<a href="${ADMIN_PATH}/rent/reserve/lecture/15?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 15}"> is-selected </c:if>"><span>주경기장(배드민턴)</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/lecture/16?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 16}"> is-selected </c:if>"><span>탁구장</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/lecture/17?date=<c:out value="${date}"/>" class="by-3 <c:if test="${part_cd == 17}"> is-selected </c:if>"><span>당구장</span></a>
							</div>
						</div>
						<div class="calendar-by-3">
							<h3 class="tab-title">모드 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/reserve/time/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>예약현황</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/go/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>예약하기</span></a>
								<a href="${ADMIN_PATH}/rent/reserve/cancel/<c:out value="${part_cd}"/>?date=<c:out value="${date}"/>" class="by-4"><span>취소하기</span></a>
								<a href="#none" class="by-4 is-selected"><span>고정강좌 취소</span></a>
							</div>
						</div>

						<div class="calendar-body">
							<div class="calendar-info">취소할 예약을 선택해 주십시오.</div>
							<div class="calendar-week">
								<div class="table-basic table-basic-type3" style="width:100%">
									<table>
										<colgroup><col width="20%"><col width="20%"><col width="20%"><col width="40%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>강좌교육명</th>
												<th>시간</th>
												<th>코트 / 중대 / 포켓</th>
												<th>취소기능</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${list }" var="item" varStatus="status">
											<tr>
												<td><c:out value="${item.re_title}"/></td>
												<td><c:out value="${fn:substring(item.rt_stime, 0, 2) }"/>:<c:out value="${fn:substring(item.rt_stime, 2, 4) }"/> ~ <c:out value="${fn:substring(item.rt_etime, 0, 2) }"/>:<c:out value="${fn:substring(item.rt_etime, 2, 4) }"/></td>
												<td><c:out value="${item.rt_court}"/></td>
												<td><a href="#none" data-value="<c:out value="${item.rt_num}"/>" data-mode="1" class="btn-cancel">현재일자 취소</a><a href="#none" data-value="<c:out value="${item.rt_num}"/>" data-mode="0" class="btn-cancel">전체취소</a>
												<input type ="hidden" value="<c:out value="${fn:substring(item.rt_stime, 0, 2) }"/>:<c:out value="${fn:substring(item.rt_stime, 2, 4) }"/> ~ <c:out value="${fn:substring(item.rt_etime, 0, 2) }"/>:<c:out value="${fn:substring(item.rt_etime, 2, 4) }"/>#<c:out value="${item.rt_court}"/>#<c:out value="${date}"/>" name="tmp_value"/>
												</td>
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


		<div class="modal-basic js-modal " id="modal-reserve-cancel"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">고정강좌 예약취소 내역(해당일) 확인</div>
							<div class="modal-basic-desc">아래 취소 내용을 확인하시고 강좌 취소 버튼을 선택해 주십시오.</div>
						</div>
						<div class="pay-result">
							<dl>
								<dt>시설</dt>
								<dd>주경기장(배드민턴)</dd>
								<!-- 해당일이 아닐경우 (전체일경우)노출//
								<dt>강좌요일</dt>
								<dd>매주 월,수,금</dd>
								-->
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
	        location.replace("${ADMIN_PATH}/rent/reserve/lecture/<c:out value='${part_cd}'/>?date=" + date );

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
	
	$(".btn-cancel").on("click", function(){
		var rt_num = $(this).data("value");
		var mode = $(this).data("mode");
		var opt = $(this).parents("tr").find('input[name="tmp_value"]').val();
		var opts = opt.split('#');
		var date = opts[2];
		
		
		if(mode == 0){
			if(!confirm(opts[0] + " " + opts[1] + " 전체 취소하시겠습니까?\n취소된 내역은 복구할수 없습니다."))
				return;
		}else{
			if(!confirm(opts[0] + " " + opts[1] + " 현재일자에서만 취소하시겠습니까?\n취소된 내역은 복구할수 없습니다."))
				return;
		}
		
		$.ajax({
		     url:'${ADMIN_PATH}/rent/reserve/lecture/cancel',
		  	data:"rt_num="+rt_num + "&date=" + date + "&mode=" + mode,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		    	/*  console.log(res); */
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