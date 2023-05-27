<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<div class="container-tabs cl-lecture">
				<%@ include file="tab_menu.jsp"%>
			</div>
			<article class="container-notice bg-lecture">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="contents-header">
					<h3>포스코 한마당 체육관 수강신청 안내</h3><br>
					<span class="header-desc">포스코 한마당체육관은 분기별(3개월) 회원제로 운영 됩니다.<br>
					수강신청 > 추첨(선정) > 등록(접수)을 실시하며, 분기 내 결원 발생 시에는 대기자 순으로 <br>
					개별 안내(대기자 없을 시 선착순) 후 접수를 실시하오니 많은 참여 부탁 드립니다.
					<!-- 포스코 한마당 체육관은 분기별(3개월) 회원제로 운영되며, 수강신청 응모, 추첨, 등록을 실시합니다. --></span>
				</div>

				<div class="contents-body">
					<div class="inner-body">
						<p class="noti-title">신청 및 추첨</p>
						<ul class="noti-list">
							<li><strong>수강신청 : </strong>분기별 신청(한마당 홈페이지) > 추첨(선정) > 등록 실시</li>
							<li><strong>신청기간 : </strong>매 분기 3, 6, 9, 12월 18 ~ 21일까지(4일간)</li>
							<li><strong>선정발표 : </strong>22일 오전 11시 홈페이지를 통해 발표<br>※ 홈페이지 : www.poscohanmadang.co.kr</li>
							<!-- <li><strong>분기회원 수강신청 : </strong>3, 6, 9, 12월 신청응모, 추첨, 접수를 실시</li>
							<li><strong>수강신청 응모기간 : </strong><span class="cl-lecture">매 분기 18~21일(4일간)</span></li>
							<li><strong>추첨 및 공지 : </strong><span class="cl-lecture">매 분기 22일 오전 11:00</span> (포스코 한마당 홈페이지 공지)</li>
							<li><strong>수강신청 응모처 : </strong>포스코 한마당 홈페이지 공지 (www.poscohanmadang.co.kr)</li> -->
						</ul>
						<p class="noti-title">신청 대상 및 이용 자격 기준</p>
						<ul class="noti-list">
							<li><strong class="cl-blue">포스코 패밀리 회원</strong> <br>
								① 포스코 직원 및 가족<br>
								&nbsp;&nbsp;- 휘트니스(오전, 오후) : 직원 본인<br>
								&nbsp;&nbsp;- 휘트니스(종일) / 휘트니스(종일) + 스쿼시 : 직원 본인 및 배우자<br>
								&nbsp;&nbsp;- 휘트니스 외 기타 프로그램 : 직원 본인, 배우자, 부, 모, 자녀 1, 2, 3<br><br>
								② 포스코 그룹사 / 협력사 직원 및 배우자<br>
								&nbsp;&nbsp;- 휘트니스(오전,오후) : 직원 본인<br>
								&nbsp;&nbsp;- 휘트니스(오전,오후) 외 기타 프로그램 : 직원 본인 및 배우자<br>
								&nbsp;&nbsp;* <strong>그룹사 및 협력사 리스트는 한마당 새소식(공지사항) 확인</strong><br><br>
								③ 포스코 / 그룹사 / 협력사 OB : 퇴직자<br>
								&nbsp;&nbsp;- 전 프로그램 : 직원 본인 및 배우자<strong>(단, 휘트니스 오전/오후반 제외)</strong><br><br>
							</li>
							<li><strong class="cl-blue">일반회원</strong><br>
								④ 일반회원 : 지곡동 거주(일반주민)<br>
								&nbsp;&nbsp;- 전 프로그램 : 본인<br><br>
							</li>
						</ul>
						<p class="noti-title">등록기간</p>
						<ul class="noti-list">
							<li>수강 등록<br>
								- <strong>22~26일(5일간)</strong> 현장 등록(포스코 한마당 체육관 1층 안내 데스크) / 신규 및 재등록 회원<br>
								- <strong>22~26일(5일간)</strong> 온라인등록(포스코한마당 홈페이지)/단, 재등록 회원(ID를 부여 받은 회원)에 한함<br>
								<p class="info-noti cl-default">기간 내 등록하지 않을 경우, 대기 후보자에게 등록 기회가 부여됨</p><br>
							</li>
							<li>신규 등록 시 지참 서류<br>
								<div class="first-inner">
									<div class="note-list">
										<strong class="cl-blue">포스코 패밀리 회원</strong><br>
										① 포스코 직원 및 가족<br>
										&nbsp;&nbsp; 본인(사원증), 가족(직원 사원증 사본, 본인 신분증 사본, 의료보험증 사본 등 가족관계 증빙서류)<br><br>
										
										② 포스코 그룹사 / 협력사 직원 및 배우자<br>
										&nbsp;&nbsp; 본인(사원증), 배우자(직원 사원증 사본, 본인 신분증 사본, 의료보험증 사본 등 가족관계 증빙서류)<br><br>
										
										③ 포스코 / 그룹사 / 협력사 OB : 퇴직자<br>
										&nbsp;&nbsp; 본인 신분증 혹은 등본, 경력증명서(사본)<br>
									</div>
									<div class="note-list">
										<strong class="cl-blue">일반회원</strong><br>
										④ 일반회원 : 지곡동 거주(일반주민)<br>
										&nbsp;&nbsp; 본인 신분증 혹은 등본(지곡동 거주 확인용)<br>
									</div>
								</div>
								<p class="info-noti cl-default" style="margin-bottom: 0px;">준비 서류는 등록 시 확인을 위한 용도 이며, 제출 하지 않습니다. (미 지참 시 등록 불가)</p>
								<p class="info-noti cl-default">사원증 없을 시 출입카드(Ⅹ), 재직증명서 또는 경력증명서(○)</p>
							</li>
							<li>추가등록<br>
								<!-- - <span class="cl-lecture">28~말일 </span>: 대기 후보자 현장 및 온라인 등록(1차 등록 결원 시 후보자 개별 통보) <br> -->
								- <strong>28일 ~ 정원 마감 시 까지 </strong> * 현장 선착순 등록<br>
								<p class="info-noti cl-default">운동 프로그램의 종목 및 시간은 변동 될 수 있음</p><br><br>
							</li>
						</ul>
						<p class="noti-title">등록시간</p>
						<ul class="noti-list">
							<li><strong>월 ~ 금 : </strong>05:30 ~ 22:00 / 주말, 공휴일 : 07:00 ~ 21:00<br>
								<p class="info-noti cl-default"> 단, 온라인 결제는 22일 11시 추첨 발표 후, 26일 21시까지 결제 가능<!-- 단, 추첨발표 당일(22일)은 오전 11:00 이후 등록가능 --></p></li>
						</ul>

						<!-- <div class="noti-lecture">
							<span>수강신청 일정을 참조하여 등록에 차질이 없도록하시기 바랍니다</span>
						</div> -->
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