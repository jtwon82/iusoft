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
			<div class="container-tabs cl-my">
				<%@ include file="tab_menu.jsp"%>
			</div>
			<article class="container-notice bg-my">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			<article class="container">
				<div class="contents-title">포스코 한마당의 다양한 건강관리 기능을 활용해 보세요.</div>
				<div class="smart-type">
					<div class="smart-type-item by-4">
						<div class="smart-type-box">
							<strong>나의 건강 캘린더</strong>
							<figure><img src="/web/assets/img/img-smart-01.png" alt="" /></figure>
							<span>다양한 건강활동 일정을<br>캘린더로 한눈에 관리하세요.</span>
						</div>
						<!-- <a href="/my/smart/calendar" class="btn btn-my btn-level2">선택</a> -->
						<a href="javascript:alert('준비중입니다.');" class="btn btn-my btn-level2">선택</a>
					</div>
					<div class="smart-type-item by-4">
						<div class="smart-type-box">
							<strong>신체측정 기록</strong>
							<figure><img src="/web/assets/img/img-smart-02.png" alt="" /></figure>
							<span>나의 체성분 평가기록을<br>살펴보세요.</span>
						</div>
						<!-- <a href="/my/smart/body" class="btn btn-my btn-level2">선택</a> -->
						<a href="javascript:alert('준비중입니다.');" class="btn btn-my btn-level2">선택</a>
					</div>
					<div class="smart-type-item by-4">
						<div class="smart-type-box">
							<strong>맞춤 운동 처방</strong>
							<figure><img src="/web/assets/img/img-smart-03.png" alt="" /></figure>
							<span>나에게 맞는 운동과 <br>운동량을 추천해드려요.</span>
						</div>
						<!-- <a href="/my/smart/recipe" class="btn btn-my btn-level2">선택</a> -->
						<a href="javascript:alert('준비중입니다.');" class="btn btn-my btn-level2">선택</a>
					</div>
					<div class="smart-type-item by-4">
						<div class="smart-type-box">
							<strong>운동기록</strong>
							<figure><img src="/web/assets/img/img-smart-04.png" alt="" /></figure>
							<span>매일 나의 운동내용을 <br>기록하여 건강을 관리하세요.</span>
						</div>
						<!-- <a href="/my/smart/athlete" class="btn btn-my btn-level2">선택</a> -->
						<a href="javascript:alert('준비중입니다.');" class="btn btn-my btn-level2">선택</a>
					</div>
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