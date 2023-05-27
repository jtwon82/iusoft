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
					<li class="by-4"><a href="/program/stadium">경기장 이용안내</a></li>
					<li class="by-4"><a href="/program/rule">이용수칙 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-program">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="program-tabs">
					<a href="/program/time/all" class="by-3 is-selected"><span>전체 운영시간</span></a>
					<a href="/program/time/item/1" class="by-3"><span>수강 프로그램 시간</span></a>
					<a href="/program/time/one" class="by-3"><span>1:1 강습 시간</span></a>
				</div>

				<div class="table-basic-type4">
					<table>
						<caption>전체 운영시간에 대한 정보제공</caption>
						<colgroup>
							<col width="220px">
							<col width="210px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="220px">
												<col width="210px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="4">휘트니스</td>
													<td><span class="cl-program">휘트니스 (종일반)</span></td>
													<td class="col-text">월~금요일 (05:30~23:00) / 주말 및 공휴일 (07:00~22:00)</td>
												</tr>
												<tr>
													<td><span class="cl-program">휘트니스 (오전반)</span></td>
													<td class="col-text">평일 (운영 05:30 ~ 14:00 / 입장 가능 시간 05:30 ~ 13:00) / 주말 (공휴일) (07:00 ~ 22:00)</td>
												</tr>
												<tr>
													<td><span class="cl-program">휘트니스 (오후반)</span></td>
													<td class="col-text">평일 (운영 10:00 ~ 18:00 / 입장 가능 시간 10:00 ~ 17:00) / 주말 (공휴일) (07:00 ~ 22:00)</td>
												</tr>
												<tr>
													<td><span class="cl-program">휘트니스(일일 입장제)</span></td>
													<td class="col-text">월~금요일 (05:30~18:00 / 입장 가능 시간 17:00까지) / 주말(공휴일) (07:00~22:00) (3시간/1회)
													<br><br>동 시간대 입장인원 제한 / 안전사고 예방을 위한 신규 이용 제한(기존 휘트니스 등록된 회원에 한 함)
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>

							<tr>
								<td>GX 프로그램</td>
								<td><span class="cl-program">GX 강습</span></td>
								<td class="col-text">강습프로그램 시간표참고 / 휴강일 : 토, 일요일, 국경일, 임시공휴일, 근로자의 날</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="220px">
												<col width="210px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td>스쿼시</td>
													<td><span class="cl-program">스쿼시</span></td>
													<td class="col-text col-middle" rowspan="2">월~금요일 (05:30~23:00) / 주말 및 공휴일 (07:00~22:00)</td>
												</tr>
												<tr>
													<td>패키지 프로그램</td>
													<td><span class="cl-program">패키지 프로그램</span></td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="220px">
												<col width="210px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="2">일일 프로그램</td>
													<td><span class="cl-program">배드민턴</span></td>
													<td class="col-text">월~금요일 (07:00~22:30) / 주말 및 공휴일 (07:00~21:30)</td>
												</tr>
												<tr>
													<td><span class="cl-program">당구 / 탁구</span></td>
													<td class="col-text">월~금요일 (09:00~22:30) / 주말 및 공휴일 (09:00~21:30)</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td>구기종목</td>
								<td><span class="cl-program">농구 / 배구 / 족구</span></td>
								<td class="col-text">[수요일] 18:30 ~ 22:30 / [일요일] 07:00 ~ 11:00</td>
							</tr>
							<tr>
								<td>휴관일</td>
								<td></td>
								<td class="col-text">매월 첫째ㆍ셋째주 월요일 및 명절연휴</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="info-inner bg-program">
					<ul class="li-list">
						<li>운동 지참물 : 실내 운동화 및 전용화</li>
						<li>14세 미만의 어린이는 배드민턴, 탁구 프로그램만 이용 가능 (기타 이용수칙 안내 참고)</li>
						<!-- <li>스크린 승마 이용 자격 기준 : 14세 이상,  키 150cm 이상 이용 가능 / 체중 90kg 이상 등록 불가</li> -->
						<!-- <li>휘트니스 일일입장 : 동 시간대 입장인원 제한 / 안전사고 예방을 위해 신규 이용 제한 &nbsp;&nbsp;&nbsp;&nbsp;* 남/여 각 10명(총 20명)</li> -->
					</ul>
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