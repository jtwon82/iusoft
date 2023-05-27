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
				<div class="contents-title cl-my">식사 일기</div>
				<div class="smart-caloly"><span class="cl-my">홍길동</span> 회원님의 오늘 섭취 칼로리는 <strong class="cl-my">174 Kcal</strong>입니다.</div>

				<div class="smart-meal-state">
					<input type="text" class="text" placeholder="오늘 섭취한 음식을 입력하세요." style="width:380px;" /><input type="text" class="text" placeholder="1인분" /><a href="#none" class="btn btn-smart btn-level2">입력</a>
				</div>

				<div class="smart-meal-view">
					<div class="smart-caloly-month">
						<a href="#none"><img src="/web/assets/img/btn-arr-prev-my.png" alt="" /></a>
						<span class="cl-extra">2017년 11월</span>
						<a href="#none"><img src="/web/assets/img/btn-arr-next-my.png" alt="" /></a>
					</div>
					<div class="smart-caloly-day">
						<a href="#none"><img src="/web/assets/img/btn-arr-prev-my.png" alt="" /></a>
						<span class="cl-extra">21일</span>
						<a href="#none"><img src="/web/assets/img/btn-arr-next-my.png" alt="" /></a>
					</div>
					<div class="table-basic table-basic-type3 line-box">
						<table>
							<caption>식사 일기에 대한 정보제공</caption>
							<colgroup>
								<col width="*">
								<col width="100px">
								<col width="70px">
							</colgroup>
							<tbody>
								<tr>
									<td class="col-left">누룬밥</td>
									<td>1인분</td>
									<td><a href="#"><img src="/web/assets/img/btn_x.png" alt="" /></a></td>
								</tr>
								<tr>
									<td class="col-left">갈치조림</td>
									<td>1인분</td>
									<td><a href="#"><img src="/web/assets/img/btn_x.png" alt="" /></a></td>
								</tr>
								<tr>
									<td class="col-left">감자탕</td>
									<td>1인분</td>
									<td><a href="#"><img src="/web/assets/img/btn_x.png" alt="" /></a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="btn-group">
					<a href="javascript:history.back(-1);" class="btn btn-level2 btn-smart btn-prev-dark">이전으로</a>
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