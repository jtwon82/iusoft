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
					<li class="by-4"><a href="/program/time/all">운영시간</a></li>
					<li class="by-4"><a href="/program/amount">분기 회원제 금액</a></li>
					<li class="by-4 is-selected"><a href="/program/stadium">경기장 이용안내</a></li>
					<li class="by-4"><a href="/program/rule">이용수칙 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-program">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="contents-header">
					<h3 class="cl-program">주 경기장 단체 이용 신청 및 이용 방법 안내</h3><br>
					<span class="header-desc">회사공식행사, 부(공장) 단위 체육행사, 직원동호회, 일반직원(배드민턴)</span>
					<div class="header-btn"><a href="/rent/main" class="btn btn-rental btn-level2 btn-block">대관 신청하기</a></div>
				</div>

				<div class="contents-body">
					<div class="inner-body">
						<p class="noti-title">이용방법</p>

						<div class="noti-block">
							<div class="noti-box-giude bg-program by-3">
								<img src="/web/assets/img/program-use-01.png" alt="한마당" />
								대관(예약) 신청 및 예약 등록이 완료된 이용객은 개인 실내 운동화 필히 지참 후 이용가능.
							</div>
							<div class="noti-box-giude bg-program by-3">
								<img src="/web/assets/img/program-use-02.png" alt="한마당" />
								주 경기장(배드민턴) 마룻바닥은 여러 이용객이 사용하는 시설로 실내운동화를 필히 착용 후 이용하여 주시기 바랍니다.
							</div>
							<div class="noti-box-giude bg-program by-3">
								<img src="/web/assets/img/program-use-03.png" alt="한마당" />
								구두, 운동화 바닥이 검은색일 경우 출입 시 바닥에 흠집이 발생하여, 많은 보수비용과 더불어 보수 기간 동안 휴관이 불가피하게 됩니다.
							</div>
						</div>

						<p class="noti-title">신청방법</p>
						<div class="noti-block">
							<div class="noti-box bg-program by-3">
								<strong><span class="cl-red">회사공식행사, 부(공장) <br>체육행사</span><br>
								이용일 포함 30일 전 <br>선착순 신청 / 무료이용</strong><br><br>
								부서장 결재(대관 신청서 첨부) 후 담당자에게 메일 전송<br>
								<span class="ic-down-default">↓</span><br>
								담당자 확인 후 예약 등록
							</div>
							<div class="noti-box bg-program by-3">
								<strong><span class="cl-green">동호회</span><br><br>
								이용일 포함 15일 전 13시부터 <br>예약(선착순&추첨)등록</strong><br><br>
								대관스케줄 현황 확인<br><br>
								<span class="ic-down-default">↓</span><br>
								로그인 후 예약 등록<br>
							</div>
							<div class="noti-box bg-program by-3">
								<strong><span class="cl-blue">직원(일반)</span><br><br>
								1일 전 13시부터 선착순 예약<br> 등록(이용일 포함 2일 전)</strong><br><br>
								대관스케줄 현황 확인<br><br>
								<span class="ic-down-default">↓</span><br>
								로그인 후 예약 등록
							</div>
							<p class="info-noti cl-default">탁구 / 당구 예약신청은 대관신청서 작성 후 담당자에게 신청 바랍니다.</p>
						</div>

							<div class="program-noti"><strong>-  당일 현장 방문 시 빈 코트는 직원 및 가족, 일반(지역주민) 선착순 이용</strong><br>
								* 문의 054-221-9280~1
							</div>
							<div class="noti-box bg-program">
								새롭게 변경된 대관(예약) 프로세스로 신청 및 등록 바랍니다.<br>
								대관스케줄<span class="ic-next-default">-></span>[예약방법] / [등록(예약)매뉴얼]참고
							</div>
					</div>
				</div>

				<div class="contents-header">
					<h3 class="cl-program">구기종목의 날 운영</h3>
				</div>

				<div class="contents-body">
					<div class="program-text"><strong>매주 수, 일요일</strong><br>
					구기종목<strong>(농구, 배구, 족구)</strong> 운영</div>
					<div class="program-text"><strong>운영시간</strong><br>
					매주 수요일 <strong>(18:30 ~ 22:30)</strong><br>
					일요일 <strong>(07:00 ~ 11:00)</strong></div>

					<div class="info-inner-day bg-program">
						<ul class="dl-list">
							<li>포스코 담당부서<strong>(행정지원그룹)</strong> 사전예약 후 이용</li>
							<li>구기종목 사전예약이 이용일 포함 3일 전까지 없을 시 배드민턴 이용 가능</li>
							<li>구기종목의 날 운영 시간 내에는 이용 고객의 운동공간 확보와 안전사고 예방을 위해 다른 종목의 주 경기장 사용을 제한합니다.</li>
						</ul>
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