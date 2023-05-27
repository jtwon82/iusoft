<%@ page contentType = "text/html;charset=utf-8" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당</title>
<link rel="stylesheet" type="text/css" href="/web/assets/css/style.css">
<!--[if lt IE 9]>
<script src="/web/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/web/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/sly.js" type="text/javascript"></script>
<script src="/web/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- skip -->
<%@ include file="../common/skip.jsp"%>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->

	<%@ include file="../common/header.jsp"%>
	<!-- //header -->
	<!-- contents -->
	<main id="contents" role="main">
		<div id="contents-inner">
			<div class="container-tabs cl-rent">
				<ul>
					<li class="by-3 is-selected"><a href="/rent/main">예약하기</a></li>
					<li class="by-3"><a href="/rent/confirm">예약 확인 및 취소</a></li>
					<li class="by-3"><a href="/rent/rule">이용규정</a></li>
				</ul>
			</div>
			<article class="container-notice bg-rent">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="rent-tabs">
					<a href="/rent/main?code=15" class="by-3 <c:if test="${code == '15'}">is-selected</c:if>"><span>배드민턴장</span></a>
					<a href="/rent/main?code=16" class="by-3 <c:if test="${code == '16'}">is-selected</c:if>"><span>탁구장</span></a>
					<a href="/rent/main?code=17" class="by-3 <c:if test="${code == '17'}">is-selected</c:if>"><span>당구장</span></a>
					<%-- <c:forEach items="${rentCodes }" var="item" varStatus="status">
					<a href="/rent/main?type=<c:out value="${item.detail_code }"/>" class="by-4 <c:if test="${type == item.detail_code}">is-selected</c:if>"><span><c:out value="${item.detail_name }"/></span></a>
					</c:forEach> --%>
					
					<%-- <a href="/rent/main?type=00" class="by-4 <c:if test="${empty type or type == '00'}">is-selected</c:if>"><span>경기장 전체</span></a> --%>
				</div>
				

				<div style="float:right;"><a href="/web/hanmadanggymnasium.pptx" class="btn btn-level1 btn-rent">대관 신청서</a></div>
				<p class="cl-basic cl-blue">※ 직원 예약 가능일은 <em><c:out value="${pdate[0]}"/></em>부터 <em><c:out value="${pdate[fn:length(pdate) - 1]}"/></em>까지 입니다.</p>
				<p class="cl-basic cl-green">※ 동호회  예약 가능일은 <em><c:out value="${tdate[0]}"/></em>부터 <em><c:out value="${tdate[fn:length(tdate) - 1]}"/></em>까지 입니다.</p>
				
					
				<div class="calendar-box">
					<!-- <div class="calendar-head">
						<p class="calendar-month cl-rent">11</p>
						<p class="calendar-year">(2017)</p>
						<a href="#none" class="link-prev"><img src="./assects/img/btn-prev.png" alt="이전달" /></a>
						<a href="#none" class="link-next"><img src="./assects/img/btn-next.png" alt="다음달" /></a>
					</div> -->
					<div class="calendar-body">
						<div id='calendar'></div>
					</div>
					<br>
				</div>
			</article>
		</div>
	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
<script type="text/javascript" src="/web/assets/js/lib/fullcalendar.min.js"></script>
<script type="text/javascript">
	
	
	function getleaf(size, num){
		var s = num+"";
	    while (s.length < size) s = "0" + s;
	    return s;
	}
	
	$(document).ready(function() {
		var isPageLoad = true;
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();

		 $('#calendar').fullCalendar({
			 header: {
				   right: 'today',
				   center: 'prev, title, next',
				   left: ''
				  },
				// *** use long day names by using 'dddd' ***
		            columnFormat: {
		                month: 'dddd',    // Monday, Wednesday, etc
		            },
/* 			views: {
					    month: { // name of view
					      titleFormat: 'YYYY.MM'
					      // other view-specific options here
					    }
					  }, */
					/*   viewRender: function (view, element) {
						  view.title = "aaaa";
					  }, */
			 dayClick: function(date, jsEvent, view) {
					
				 var array = [
				 <c:forEach items="${recounts }" var="item" varStatus="status">
					<c:set var="exist" value="0"/>
					<c:forEach items="${offList }" var="item1" varStatus="status1">
						<c:if test="${item.re_date == item1.bl_date}">
						<c:set var="exist" value="1"/>
						</c:if>
					</c:forEach>
					<c:choose>
					<c:when test="${exist == 1 or item.re_date == off1 or item.re_date == off2}">
					</c:when>
					<c:otherwise>
					'<c:out value = "${item.re_date}" />',
					</c:otherwise>
					</c:choose>
				</c:forEach>
					];

					var clickeDate = date.getFullYear() + getleaf(2, date.getMonth() + 1) + getleaf(2, date.getDate());
					var isExist =false;
					for( var i = 0; i < array.length; ++i ) {
					 if( array[i] === clickeDate ){
					   isExist = true;
					   break;
					 }
					}
					if(isExist)
						location.replace('/rent/time/<c:out value='${code}'/>?date=' + clickeDate);
						
			    },
			    
			viewDisplay: function (element) {
				if(!isPageLoad){
					var moment = $('#calendar').fullCalendar('getDate');
				    location.href = "/rent/main?code=<c:out value="${code }"/>&year_month=" + moment.getFullYear() + getleaf(2, moment.getMonth() + 1);
				}
				isPageLoad = false;
		    },
		    year: <c:out value="${fn:substring(year_month, 0, 4)}"/>,
		    month: <c:out value="${fn:substring(year_month, 4, 6) - 1}"/>,
			editable: false,
			events: [
				{
					title: '직원 예약 가능',
					start: new Date('<c:out value = "${fn:substring(pdate1[0], 0, 4)}" />', '<c:out value = "${fn:substring(pdate1[0], 5, 7) - 1}" />', '<c:out value = "${fn:substring(pdate1[0], 8, 10)}" />'),
					end : new Date('<c:out value = "${fn:substring(pdate1[fn:length(pdate1) - 1], 0, 4)}" />', '<c:out value = "${fn:substring(pdate1[fn:length(pdate1) - 1], 5, 7) - 1}" />', '<c:out value = "${fn:substring(pdate1[fn:length(pdate1) - 1], 8, 10)}" />'),
					color: '#0070c0',
					textColor: '#ffffff'
				},
				{
					title: '동호회예약가능',
					start: new Date('<c:out value = "${fn:substring(tdate1[0], 0, 4)}" />', '<c:out value = "${fn:substring(tdate1[0], 5, 7) - 1}" />', '<c:out value = "${fn:substring(tdate1[0], 8, 10)}" />'),
					end : new Date('<c:out value = "${fn:substring(tdate1[fn:length(tdate1) - 1], 0, 4)}" />', '<c:out value = "${fn:substring(tdate1[fn:length(tdate1) - 1], 5, 7) - 1}" />', '<c:out value = "${fn:substring(tdate1[fn:length(tdate1) - 1], 8, 10)}" />'),
					color: '#167431',
					textColor: '#ffffff'
				},
				
			<c:forEach items="${recounts }" var="item" varStatus="status">
				<c:set var="exist" value="0"/>
				<c:forEach items="${offList }" var="item1" varStatus="status1">
					<c:if test="${item.re_date == item1.bl_date}">
					<c:set var="exist" value="1"/>
					</c:if>
				</c:forEach>
				<c:choose>
				<c:when test="${exist == 1 or item.re_date == off1 or item.re_date == off2}">
				{
					title: '휴관일',
					start: new Date('<c:out value = "${fn:substring(item.re_date, 0, 4)}" />', '<c:out value = "${fn:substring(item.re_date, 4, 6) - 1}" />', '<c:out value = "${fn:substring(item.re_date, 6, 8)}" />'),
					color: '#f00b0b',
					textColor: '#ffffff'
				},
				</c:when>
				<c:otherwise>
				{
					title: '예약 (<c:out value = "${item.cnt}" />)',
					start: new Date('<c:out value = "${fn:substring(item.re_date, 0, 4)}" />', '<c:out value = "${fn:substring(item.re_date, 4, 6) - 1}" />', '<c:out value = "${fn:substring(item.re_date, 6, 8)}" />'),
					url: '/rent/time/<c:out value='${code}'/>?date=<c:out value = "${item.re_date}" />'
				},
				</c:otherwise>
				</c:choose>
			</c:forEach>
			]
		});
	});

</script>
</body>
</html>