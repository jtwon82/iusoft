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
					<a href="reserve_time_badminton.html" class="by-4 is-selected"><span>배드민턴장</span></a>
					<a href="reserve_time_pingpong.html" class="by-4"><span>탁구장</span></a>
					<a href="reserve_time_billiards.html" class="by-4"><span>당구장</span></a>
					<a href="reserve_time_all.html" class="by-4"><span>경기장 전체</span></a>
				</div>

				<center>
				<a href="#modal-login-team" class="js-modal__btn-open">(pop) 동호회예약</a><br><br>
				<a href="#modal-login-team-result" class="js-modal__btn-open">(pop) 동호회예약완료</a>
				</center>

				<div class="btn-group">
					<a href="#" class="btn btn-level2 btn-rent">이전으로</a>
					<a href="#" class="btn btn-level2 btn-rent">선택완료</a>
				</div>
			</article>
		</div>

		<div class="modal-basic js-modal " id="modal-login-team-result"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-team__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">예약이 완료되었습니다.</p>
						<span class="modal-basic-desc">※ 예약내역은 (예약 확인 및 취소)페이지에서<br>확인하실 수 있습니다.</span>
						<div class="btn-group">
							<a href="#" class="btn btn-level2 btn-primary">예약 확인 및 취소 바로가기</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-login-team"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-team__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">동호회 로그인</p>
						<span class="modal-basic-desc">로그인 후, 예약이 완료됩니다.</span>
						<div class="input-group">
							<input type="text" placeholder="아이디" />
							<input type="password" placeholder="비밀번호" />
						</div>
						<div class="btn-group">
							<a href="#" class="btn by-2 btn-level1 btn-search">취소</a>
							<a href="#" class="btn by-2 btn-level1 btn-search">예약하기</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->

	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
</body>
</html>