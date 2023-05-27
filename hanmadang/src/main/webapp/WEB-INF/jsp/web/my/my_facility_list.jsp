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
				<p class="heading">검색</p>
				<div class="my-facility-search">
					<dl>
						<dt>예약일자</dt>
						<dd><a href="#" class="by-3 is-selected">최신순</a><a href="#" class="by-3 ">오래된 순</a></dd>
					</dl>
					<dl>
						<dt>예약일자</dt>
						<dd><a href="#" class="by-3 is-selected">배드민턴장</a><a href="#" class="by-3 ">탁구장</a><a href="#" class="by-3 ">당구장</a></dd>
						<dt>예약상태</dt>
						<dd><a href="#" class="by-3 is-selected">신청완료</a><a href="#" class="by-3 ">예약완료</a><a href="#" class="by-3 ">예약취소</a></dd>
					</dl>
				</div>
				<div class="btn-group">
					<a href="#" class="btn btn-level2 btn-search">검색</a>
				</div>

				<div class="table-caption">
					<div class="table-title">검색결과</div>
				</div>
				<div class="table-basic">
					<table class="table-basic-type2">
						<caption>시설예약 검색에 대한 예약일,예약자명, 시설, 시간, 예약상태 등 정보제공</caption>
						<colgroup>
							<col width="*">
							<col width="15%">
							<col width="18%">
							<col width="18%">
							<col width="17%">
							<col width="18%">
						</colgroup>
						<thead>
							<tr>
								<th>예약일자</th>
								<th>예약자명</th>
								<th>시설</th>
								<th>시간</th>
								<th>코트</th>
								<th>예약상태</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>2017.10.16</td>
								<td>홍길동</td>
								<td>배드민턴장</td>
								<td>06:00 ~ 08:00</td>
								<td>3코트</td>
								<td class="col-left">신청완료</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td>08:00 ~ 10:00</td>
								<td>3코트</td>
								<td class="col-left">신청완료</td>
								<td></td>
							</tr>
							<tr>
								<td>2017.10.16</td>
								<td>홍길동</td>
								<td>배드민턴장</td>
								<td>12:00 ~ 13:00</td>
								<td>3코트</td>
								<td class="col-left">예약완료 <a href="#modal-my-facility-cancel" class="btn btn-block btn-point btn-level0 js-modal__btn-open">예약취소</a></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="contents-header under-cnt">
					<p class="heading">예약안내 및 취소</p>
					<span class="header-desc">동호회 예약은 3일 전까지 취소 가능합니다.<br>직원(일반) 예약은 2시간 전까지 취소 가능합니다.</span>
					<div class="header-btn"><a href="#" class="btn btn-level2 btn-smart">시설예약 바로가기</a></div>
				</div>
			</article>
		</div>

		<div class="modal-basic js-modal " id="modal-my-facility-cancel"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-smart__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<div class="noti-box">
							<strong>배드민턴장 제 3코트</strong>
							<span class="date">예약일자 : 2017 .10.15<br>
							예약시간 : 07:00 ~ 08:00</span>
						</div>
						<p class="modal-basic-title">예약 내용을 취소하시겠습니까?</p>
						<span class="modal-basic-desc">※예약 후 무단으로 이용하지 않을 시, <br>페널티가 부여됩니다.</span>
						<div class="btn-group">
							<a href="#" class="js-modal__btn-close btn by-2 btn-level1 btn-select">닫기</a>
							<a href="#" class="btn by-2 btn-level1 btn-smart">취소하기</a>
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