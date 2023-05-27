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
			<div class="container-tabs cl-program">
				<ul>
					<li class="by-4 is-selected"><a href="/program/time/all">운영시간</a></li>
					<li class="by-4"><a href="/program/amount">분기 회원제 금액</a></li>
					<li class="by-4"><a href="/program/stadium">경기장 이용 안내</a></li>
					<li class="by-4"><a href="/program/rule">이용수칙 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-program">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="program-tabs">
					<a href="/program/time/all" class="by-3"><span>전체 운영시간</span></a>
					<a href="/program/time/item/1" class="by-3"><span>수강 프로그램 시간</span></a>
					<a href="/program/time/one" class="by-3 is-selected"><span>1:1 강습 시간</span></a>
				</div>

				<div class="table-basic table-basic-type5">
					${info.content}
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