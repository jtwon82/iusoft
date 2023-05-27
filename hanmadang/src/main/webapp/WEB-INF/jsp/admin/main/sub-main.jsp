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
	<main id="admin-main" role="main">
		<div class="admin-wrap">
			<h1><a href="${ADMIN_PATH}/main"><img src="/admin/assets/img/h1-logo.png" alt="" /></a></h1>
			<div class="admin-submain">
				<p class="title ">관리할 항목을 선택해 주십시오.</p>
				<div class="submain-menu">
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',content')}">
					<div class="by-4 access-able">
						<p class="menu-title">컨텐츠 관리</p>
						<ul>
							<li><a href="${ADMIN_PATH}/content/popup">팝업관리</a></li>
							<li><a href="${ADMIN_PATH}/content/banner">배너관리</a></li>
							<li><a href="${ADMIN_PATH}/content/notice">공지사항관리</a></li>
							<li><a href="${ADMIN_PATH}/content/program">프로그램 관리</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',member')}">
					<div class="by-4 access-able">
						<p class="menu-title">직원 관리</p>
						<ul>
							<li><a href="${ADMIN_PATH}/employee/list">포스코 직원 관리</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',lecture')}">
					<div class="by-4 access-able">
						<p class="menu-title">수강신청 관리</p>
						<ul>
							<li><a href="${ADMIN_PATH}/entry/info">수강신청 내용 관리</a></li>
							<li><a href="${ADMIN_PATH}/entry/apply/list">수강신청회원 리스트</a></li>
							<li><a href="${ADMIN_PATH}/entry/draw/list">추첨관리</a></li>
							<li><a href="${ADMIN_PATH}/entry/result/list">선정/대기자 리스트</a></li>
							<li><a href="${ADMIN_PATH}/entry/before/list">지난 데이타</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',class')}">
					<div class="by-4 access-able">
						<p class="menu-title">수강신청 조회</p>
						<ul>
							<li><a href="${ADMIN_PATH}/class/list">수강신청회원 리스트</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',rent')}">
					<div class="by-4 access-able">
						<p class="menu-title">대관 관리</p>
						<ul>
							<li><a href="${ADMIN_PATH}/rent/reserve/time/15">예약현황</a></li>
							<li><a href="${ADMIN_PATH}/rent/state/15">현재 이용 현황</a></li>
							<li><a href="${ADMIN_PATH}/rent/draw">추첨관리</a></li>
							<li><a href="${ADMIN_PATH}/rent/off">휴관일 관리</a></li>
							<li><a href="${ADMIN_PATH}/rent/stats/all">통계</a></li>
							<li><a href="${ADMIN_PATH}/rent/team/list">동호회 관리</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<%-- <c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',stats')}">
					<div class="by-5 access-able">
						<p class="menu-title">통계</p>
						<ul>
							<li><a href="#">홈페이지 접속 통계</a></li>
							<li><a href="javascript:alert('준비중입니다.');">홈페이지 페이지별 조회수</a></li>
							<li><a href="javascript:alert('준비중입니다.');">한마당 방문자 통계</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose> --%>
					
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',gym')}">
					<div class="by-4 access-able">
						<p class="menu-title"><a href="#">스마트짐 분석</a></p>
						<ul>
							<li><a href="javascript:alert('준비중입니다.');">칼로리소모량 분석</a></li>
							<li><a href="javascript:alert('준비중입니다.');">운동 참여율 분석</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<c:choose>
					<c:when test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',admin')}">
					<div class="by-4 access-able">
						<p class="menu-title"><a href="#">관리자관리</a></p>
						<ul>
							<li><a href="${ADMIN_PATH}/role/list">관리자 계정 관리</a></li>
							<li><a href="${ADMIN_PATH}/role/log/list">관리자 활동 로그</a></li>
						</ul>
					</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
					
					<div class="by-4 access-able">
						<p class="menu-title only-title"><a href="${ADMIN_PATH}/login/pw">비밀번호 변경</a></p>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
</body>
</html>