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
				<div class="contents-title cl-my">운동 기록</div>
				<div class="smart-caloly"><span class="cl-my">홍길동</span> 회원님의 오늘 유산소운동 소모 칼로리는 <strong class="cl-my">000 Kcal</strong>입니다.</div>

				<div class="smart-athlete-state">
					<div class="by-3 is-selected">
						<span class="title">Aerobic exercise</span>
						<p class="caloly">0 Kcal</p>
					</div>
					<div class="by-3">
						<span class="title">Aerobic exercise</span>
						<p class="caloly">0 Kcal</p>
					</div>
					<div class="by-3">
						<span class="title">Aerobic exercise</span>
						<p class="caloly">0 Kcal</p>
					</div>
				</div>

				<div class="smart-athlete-view">
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
							<caption>운동기록에 대한 운동일자, 종목, 시간, 운동거리, 처방강도, 최고속도, 심박수, 칼로리변화 등 정보제공</caption>
							<colgroup>
								<col width="*">
								<col width="90px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
								<col width="80px">
							</colgroup>
							<tbody>
								<tr>
									<th>운동일자</th>
									<th>종목</th>
									<th>시간</th>
									<th>운동거리</th>
									<th>처방강도</th>
									<th>수정강도</th>
									<th>최고속도</th>
									<th>평균속도</th>
									<th>목표심박수</th>
									<th>평균심박수</th>
									<th>vo2max</th>
									<th>목표칼로리</th>
									<th>소모칼로리</th>
								</tr>
								<tr>
									<td class="col-center">2017.11.03<br>오후 7:36:36</td>
									<td class="col-center">R/M</td>
									<td class="col-center">0분</td>
									<td class="col-center">0㎞</td>
									<td class="col-center">47%</td>
									<td class="col-center">47%</td>
									<td class="col-center">0㎞</td>
									<td class="col-center">0㎞</td>
									<td class="col-center">131회/분</td>
									<td class="col-center">59회/분</td>
									<td class="col-center">0</td>
									<td class="col-center">205.62<br>Kcal</td>
									<td class="cl-smart col-center">0.74<br>Kcal</td>
								</tr>
								<tr>
									<td class="col-center">2017.11.03<br>오후 7:36:36</td>
									<td class="col-center">R/M</td>
									<td class="col-center">0분</td>
									<td class="col-center">0㎞</td>
									<td class="col-center">47%</td>
									<td class="col-center">47%</td>
									<td class="col-center">0㎞</td>
									<td class="col-center">0㎞</td>
									<td class="col-center">131회/분</td>
									<td class="col-center">59회/분</td>
									<td class="col-center">0</td>
									<td class="col-center">205.62<br>Kcal</td>
									<td class="cl-smart col-center">0<br>Kcal</td>
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