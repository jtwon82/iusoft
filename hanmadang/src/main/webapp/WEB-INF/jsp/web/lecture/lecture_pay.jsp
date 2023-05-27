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
					<h3>온라인 결제 신청 안내</h3><br>
					<span class="header-desc">선정자 발표를 통해 선정된 회원 중 재등록 회원에 한해서만 수강등록 / 결제를 해주시기 바라며, <br>미선정자로 확인될 시 수강등록/결제가 무효 처리됨을 알려드립니다.
		 <!-- 선정된 회원에 한하여 수강 등록을 해주시기 바라며, <br>미선정자로 확인 될 시 수강등록이 무효 처리됨을 알려드립니다. --></span>
					<div class="header-btn"><a href="/upload/온라인결제메뉴얼_v0.1.pptm" class="btn btn-noti btn-level2 btn-block">온라인 결제 메뉴얼 다운로드</a></div>
				</div>

				<div class="contents-body">
					<div class="inner-body">
						<p class="noti-title">수강 결제 방법</p>
						<ul class="noti-list">
							<li>수강신청 버튼 클릭 후 원하시는 종목을 선택</li>
							<li>선정된 강좌명/회원 구분/강좌 요일을 확인하신 후 수강신청 클릭</li>
							<li>안내에 따라 결제(단, 신용카드만 결제 가능)</li>
							<li>마이페이지에서 수강신청현황 확인 가능하며 결제 또는 영수증 출력, 대기 취소 가능</li>
						</ul>
						<p class="noti-title">취소 및 환불</p>
						<dl class="noti-definition">
							<dt>이용 전 -</dt>
							<dd>현장 방문-> 환불신청서 작성 -> 위약금 10%공제 후 환불<!-- 포스코 한마당 체육관 현장 방문을 통해 환불신청서 작성 후 취소처리 가능 <br>(위약금 10% 공제 후 환불) --></dd>
							<dt>이용 후 -</dt>
							<dd>현장 방문 -> 환불신청서 작성 -> 위약금 10% + 이용일 수 × 사용료<!-- 포스코 한마당 체육관 현장 방문을 통해 환불신청서 작성 후 제출, <br>온라인 결제 취소 후 이용금액만큼 재결제<br>(위약금 10% + 이용일수 X 사용료) --></dd>
						</dl>
					</div>
					<div class="info-inner ">
						<p class="note-list">문의처 : 포스코 한마당 체육관 054) 221 - 9280~1</p>
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