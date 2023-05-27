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
				<div class="contents-title cl-my">신체측정 기록</div>
				<div class="table-basic table-basic-type3">
					<table>
						<caption>신체 측정기록 - 구분, 최초측정일, 전회측정값, 금회측정값에 대한 정보제공</caption>
						<colgroup>
							<col width="220px">
							<col width="140px">
							<col width="140px">
							<col width="140px">
							<col width="200px">
							<col width="*">
						</colgroup>
						<thead>
							<tr class="no-head">
								<th>구분</th>
								<th>최초 측정</th>
								<th>전회 측정</th>
								<th>금회 측정</th>
								<th>변화량<br>(금회 측정 - 전회 측정)</th>
								<th>표준범위</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col-left">측정일</td>
								<td class="cl-g">2011.07.05</td>
								<td class="cl-b">2017.12.02</td>
								<td class="cl-c">2017.12.05</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="col-left">신장</td>
								<td class="cl-g">174</td>
								<td class="cl-b">173.9</td>
								<td class="cl-c">174</td>
								<td class="cl-r">0.10</td>
								<td></td>
							</tr>
							<tr>
								<td class="col-left">체중(㎏)</td>
								<td class="cl-g">75.7</td>
								<td class="cl-b">81.7</td>
								<td class="cl-c">81.7</td>
								<td class="cl-r">0.0</td>
								<td>개인별 상이</td>
							</tr>
							<tr>
								<td class="col-left">근육량(㎏)</td>
								<td class="cl-g">61</td>
								<td class="cl-b">61</td>
								<td class="cl-c">61</td>
								<td class="cl-r">0</td>
								<td></td>
							</tr>
							<tr>
								<td class="col-left">체지방량(㎏)</td>
								<td class="cl-g">10.60</td>
								<td class="cl-b">15.70</td>
								<td class="cl-c">15.80</td>
								<td class="cl-r">0.10</td>
								<td></td>
							</tr>
							<tr>
								<td class="col-left">체지방률(㎏)</td>
								<td class="cl-g">15.7</td>
								<td class="cl-b">19.2</td>
								<td class="cl-c">19.3</td>
								<td class="cl-r">0.1</td>
								<td>남 15 ~ 20 ｜ 여 20 ~ 28</td>
							</tr>
							<tr>
								<td class="col-left">체질량지수(비만도)</td>
								<td class="cl-g">25.3</td>
								<td class="cl-b">27</td>
								<td class="cl-c">27</td>
								<td class="cl-r">0.0</td>
								<td>18.5 ~ 23.0</td>
							</tr>
							<tr>
								<td class="col-left">복구지방률(％)</td>
								<td class="cl-g">0.79</td>
								<td class="cl-b">0.82</td>
								<td class="cl-c">0.87</td>
								<td class="cl-r">0.05</td>
								<td>남 0.75 ~ 0.85 ｜ 여 0.70 ~ 0.80</td>
							</tr>
							<tr>
								<td class="col-left">기초대사량(BMR)</td>
								<td class="cl-g">1605</td>
								<td class="cl-b">1670</td>
								<td class="cl-c">1601</td>
								<td class="cl-r">-69</td>
								<td>개인별 상이</td>
							</tr>
						</tbody>
					</table>
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