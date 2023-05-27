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
						<h3 class="h3-title"><strong>코트 사용 예약 신청 추첨</strong><br>
						추첨내역이 없는 경우는 자동 추첨이 완료된 경우입니다.<br>
						수동 추첨은 12시 이후부터 13시 사이에 가능합니다. 자동추첨은 표준시 12시 50분에 진행됩니다.</h3>

						<div class="datebox-big2"><c:out value="${fn:substring(date, 0, 4)}"/>.<c:out value="${fn:substring(date, 4, 6)}"/>.<c:out value="${fn:substring(date, 6, 8)}"/></div>
						<%-- <div class="datebox-big"><input type="text" name="" id="selectDate" class="date-day" value="<c:out value="${fn:substring(date, 0, 4)}"/>.<c:out value="${fn:substring(date, 4, 6)}"/>.<c:out value="${fn:substring(date, 6, 8)}"/>"></div> --%>

						<div class="calendar-body">
							<div class="calendar-week">
								<div class="table-basic table-basic-type3" style="width:100%">
									<table>
										<colgroup><col width="*"><col width="15%"><col width="18%"><col width="18%"><col width="18%"><col width="15%"></colgroup>
										<thead>
											<tr class="no-head">
												<th class="bg-title">시간</th>
												<th class="bg-title"><!-- 예약된 코트번호 --></th>
												<th class="bg-title">추첨 신청 수</th>
												<th class="bg-title">추첨신청 코트수</th>
												<th class="bg-title">남은 코트수</th>
												<th class="bg-title">추첨</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${cntList }" var="item" varStatus="status">
											<tr>
												<td><c:out value="${item.key }"/></td>
												<c:choose>
												<c:when test="${fn:contains(item.key, '18:00 ~') }">
												<td colspan="5"><span class="select-basic select-general">크리닝 타임</span></td>
												</c:when>
												<c:otherwise>
												<td><a href="#none" data-id="${status.index > 6 ? status.index - 1 : status.index}" class="btn-cancel act-detail">상세보기</a></td>
												<td><c:out value="${item.value.court_cnt }"/></td>
												<td><c:out value="${item.value.rt_court_cnt }"/></td>
												<td><c:out value="${(6 - item.value.rt_court_cnt) > 0 ? (6 - item.value.rt_court_cnt) : 0 }"/></td>
												<td><c:if test="${status.index == 0 }"><a href="#none" class="btn-cancel act-draw">추첨</a></c:if></td>
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
		
		<div class="modal-basic js-modal" id="modal-reserve-view"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
		</div>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
/* 	$(".date-day").datepicker({
		onSelect: function(dateText, inst) {
	        var date = $(this).val().replace(".", "");
	        location.replace("${ADMIN_PATH}/rent/draw?date=" + date );

	    },
	    buttonImageOnly: true,
		prevText: '이전달',
		nextText: '다음달',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:["일","월","화","수","목","금","토"],
		dateFormat:"yy.mm.dd",
		changeMonth: true,
		changeYear: true
	}); */
	
	$(".act-detail").on("click", function(){
		var id = $(this).data("id");
		$('#modal-reserve-view .modal-basic__wrapper').remove();
		var url = "${ADMIN_PATH}/rent/draw/detail/" + id + "?date=<c:out value='${date}'/>";
		$('#modal-reserve-view').append($('<div class="modal-basic__wrapper">').load(url));
		$('#modal-reserve-view').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".act-draw").on("click", function(){
		if(!confirm("추첨을 진행하시겠습니까?"))
			return;
		
		$.ajax({
		     url:'${ADMIN_PATH}/rent/draw/go',
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		    	/*  console.log(res); */
		         if(res=='SUCCESS'){
		             alert("완료되었습니다.");
		             location.reload(true);
		         }else if(res=='INVALID_ACCESS'){
		             alert("12시에서 13시 사이에 수동추첨가능 합니다.");
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