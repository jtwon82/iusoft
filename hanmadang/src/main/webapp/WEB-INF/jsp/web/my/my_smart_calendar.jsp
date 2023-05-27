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
				<div class="contents-title cl-my">나의 건강 캘린더</div>
				<div class="my-calendar">
					<div class="my-calendar-head">
						<div class="my-calendar-month">11 <span class="my-calendar-year">(2017)</span></div>
						<div class="my-calendar-chart">
							<span class="text-icon text-body"><em>신</em>신체 측정기록</span>
							<span class="text-icon text-athlete"><em>운</em>운동기록</span>
							<!-- <span class="text-icon text-meal"><em>식</em>식사일기</span> -->
						</div>
					</div>
					<div class="my-calendar-body">
						<table class="my-calendar-week">
							<colgroup><col width="14.2%" /><col width="14.2%" /><col width="14.2%" /><col width="14.2%" /><col width="14.2%" /><col width="14.2%" /><col width="14.2%" /></colgroup>
							<thead>
								<tr>
									<th><strong>일</strong>SUN</th>
									<th><strong>월</strong>MON</th>
									<th><strong>화</strong>TUE</th>
									<th><strong>수</strong>WED</th>
									<th><strong>목</strong>THU</th>
									<th><strong>금</strong>FRI</th>
									<th><strong>토</strong>SAT</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td><p class="day">1</p></td>
									<td><p class="day">2</p></td>
									<td><p class="day">3</p><!-- <span class="text-icon text-meal"><em>식</em></span> --></td>
									<td><p class="day">4</p></td>
								</tr>
								<tr>
									<td><p class="day">5</p></td>
									<td><p class="day">6</p></td>
									<td><p class="day">7</p><!-- <span class="text-icon text-athlete"><em>운</em></span><span class="text-icon text-body"><em>신</em></span> --></td>
									<td><p class="day">8</p></td>
									<td><p class="day">9</p><!-- <span class="text-icon text-body"><em>신</em></span> --></td>
									<td><p class="day">10</p></td>
									<td><p class="day">11</p></td>
								</tr>
								<tr>
									<td><p class="day">12</p></td>
									<td><p class="day">13</p></td>
									<td><p class="day">14</p></td>
									<td><p class="day">15</p></td>
									<td><p class="day">16</p></td>
									<td><p class="day">17</p></td>
									<td><p class="day">18</p></td>
								</tr>
								<tr>
									<td><p class="day">19</p></td>
									<td><p class="day">20</p></td>
									<td><p class="day">21</p></td>
									<td><p class="day">22</p></td>
									<td><p class="day">23</p></td>
									<td><p class="day">24</p></td>
									<td><p class="day">25</p></td>
								</tr>
								<tr>
									<td><p class="day">26</p></td>
									<td><p class="day">27</p></td>
									<td><p class="day">28</p></td>
									<td><p class="day">29</p></td>
									<td><p class="day">30</p></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
						<div class="btn-prev"><a href="#"><img src="/web/assets/img/btn-arr-prev.png" alt="이전달" /></a></div>
						<div class="btn-next"><a href="#"><img src="/web/assets/img/btn-arr-next.png" alt="다음달" /></a></div>
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