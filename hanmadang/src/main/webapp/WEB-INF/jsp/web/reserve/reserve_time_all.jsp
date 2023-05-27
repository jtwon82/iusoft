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
				<p>매월 첫째.셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="rent-tabs">
					<a href="reserve_time_badminton.html" class="by-4"><span>배드민턴장</span></a>
					<a href="reserve_time_pingpong.html" class="by-4"><span>탁구장</span></a>
					<a href="reserve_time_billiards.html" class="by-4"><span>당구장</span></a>
					<a href="reserve_time_all.html" class="by-4 is-selected"><span>경기장 전체</span></a>
				</div>

				<div class="heading-title">탁구장 · 당구장 · 경기장 전체 대관 예약 안내</div>

				<div class="noti-text no-top">★ 대관 신청서를 작성하시어, 체육관 담당자에게 메일로 전달해 주십시오 ★</div>

				<div class="noti-box bg-rent">※ 대관 담당자 : 행정섭외 그룹<br><br>TEL : 054 - 221 - 9216 ｜ email : csh0319@posco.com</div>

				<div class="btn-group">
					<a href="#" class="btn btn-level2 btn-rent">이전으로</a>
					<a href="#" class="btn btn-level2 btn-rent">대관 신청서 다운로드</a>
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