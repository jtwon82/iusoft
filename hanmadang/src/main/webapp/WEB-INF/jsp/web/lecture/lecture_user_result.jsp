<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<div class="container-tabs cl-lecture">
				<ul>
					<li class="by-5 "><a href="/lecture/info">수강신청안내</a></li>
					<li class="by-5 is-selected"><a href="/lecture/status">수강신청</a></li>
					<li class="by-5"><a href="/lecture/list">수강신청내역조회</a></li>
					<li class="by-5"><a href="/lecture/result">선정자발표</a></li>
					<li class="by-5"><a href="/lecture/pay">온라인 결제 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-lecture">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			<article class="container">
				<div class="member-step step6">
					<div class="step-item is-passed">약관 동의</div>
					<div class="step-item is-passed">회원타입 선택</div>
					<div class="step-item is-passed">회원 정보 입력</div>
					<div class="step-item is-passed">강좌 선택</div>
					<div class="step-item is-passed">비밀번호 설정</div>
					<div class="step-item is-current">수강신청 완료</div>
				</div>
				<!-- <div class="info-type info-type-right">
					<p class="info-noti">이전페이지(회색버튼)로 이동 가능합니다.</p>
				</div> -->

				<p class="heading">6. 수강신청 완료</p>
				<span class="heading-desc">수강신청이 완료되었습니다.<br>
				신규회원의 경우, 수강신청 이후의 절차(수강 확인 · 취소 · 선정 · 결제 · 등록)는 아래를 참고해 주십시요</span>

				<figure class="info-thumbnail-single"><img src="/web/assets/img/lecture-result-user.png" alt="" /></figure>

				<div class="btn-group">
					<a href="/lecture/list" class="btn btn-level2 btn-noti">수강신청 내역 조회페이지 바로가기</a>
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
</body>
</html>