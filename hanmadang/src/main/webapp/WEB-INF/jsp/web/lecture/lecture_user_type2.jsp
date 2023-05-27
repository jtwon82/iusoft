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
				<ul>
					<li class="by-5 "><a href="/lecture/info">수강신청안내</a></li>
					<li class="by-5 is-selected"><a href="/lecture/status">수강신청</a></li>
					<li class="by-5"><a href="/lecture/list">수강신청내역조회</a></li>
					<li class="by-5"><a href="/lecture/result">선정자발표</a></li>
					<li class="by-5"><a href="/lecture/pay">온라인 결제 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-lecture">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			
			<article class="container">
				<div class="member-step step2">
					<div class="step-item is-passed"><a href="/lecture/user/terms">약관 동의</a></div>
					<div class="step-item is-current">회원타입 선택</div>
					<div class="step-item">회원 정보 입력</div>
					<div class="step-item">강좌 선택</div>
					<div class="step-item">비밀번호 설정</div>
					<div class="step-item">수강신청 완료</div>
				</div>

				<div class="info-type info-type-right">
					<p class="info-noti">이전페이지(회색버튼)로 이동 가능합니다.</p>
				</div>
				
				<p class="heading">2. 회원 타입 선택</p>
				<span class="heading-desc">해당하는 회원 타입(번호)을 선택해 주십시오.</span>

				<div class="member-type">
					<div class="member-type-item-wrapper" style="margin: 0 auto;width: 1030px;">
					<c:choose>
					<c:when test="${em_type=='03' }">
						<div class="member-type-item by-3">
							<div class="member-type-box">
								<strong style="color:#bcbdbb">4 일반회원</strong> 입니다.<br><br>
								<span>일반회원은<br>지곡동 주민입니다.</span>
							</div>
							<a href="input?em_type=03" class="btn btn-select btn-level3">선택</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="member-type-item by-3">
							<div class="member-type-box">
								<strong style="color:#00578a;">① 포스코 직원 및 가족</strong><br><br>
								<span>포스코 직원 및 가족 입니다.</span>
							</div>
							<a href="input?em_type=01" class="btn btn-select btn-level3">선택</a>
						</div>
						<div class="member-type-item by-3">
							<div class="member-type-box">
								<strong style="color:#00578a;">② 그룹/ 협력사</strong><br><br>
								<span>그룹 / 협력사<br> 직원 및 배우자 입니다.</span>
							</div>
							<a href="input?em_type=02" onclick="alert('‘허위로 작성’ 또는 ‘자격사항이 되지 않는 경우’ 종목 미달시에도 선정에서 제외 될 수 있습니다.')" class="btn btn-select btn-level3">선택</a>
						</div>
						<div class="member-type-item by-3">
							<div class="member-type-box">
								<strong style="color:#00578a;">③ 포스코 / 그룹사 / 협력사</strong><br><br>
								<span>포스코 / 그룹사 / 협력사<br> OB 입니다.</span>
							</div>
							<a href="input?em_type=02&em_type2=01" onclick="alert('‘허위로 작성’ 또는 ‘자격사항이 되지 않는 경우’ 종목 미달시에도 선정에서 제외 될 수 있습니다.')" class="btn btn-select btn-level3">선택</a>
<!-- 							<a href="javascript:;" onclick="alert('`단계적 개관 운영`으로 이번달은 신청 대상이 아니오니 양해 부탁드립니다.')" class="btn btn-select btn-level3">선택</a> -->
						</div>
					</c:otherwise>
					</c:choose>
					</div>
				</div>

				<div class="info-list" style="padding:4% 20% 0 20%;margin:0 auto;font-size: 18px;color:red;">
					<p><strong>※ 휘트니스(종일, 패키지)프로그램은 직원 및 배우자만 신청 가능</strong></p>
					<p><strong>※ 휘트니스 주간반(오전 <span style="font-size:11px;">●</span> 후반)은 직원만 신청 가능</strong></p>
					<p><strong>※ 선정자 발표 후, 선정된 회원에 한해 별도의 회원가입 절차를 통해 실회원이 되실 수 있습니다</strong></p>					
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