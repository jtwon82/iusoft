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
				<div class="member-step step1">
					<div class="step-item is-current">약관 동의</div>
					<div class="step-item">회원타입 선택</div>
					<div class="step-item">회원 정보 입력</div>
					<div class="step-item">강좌 선택</div>
					<div class="step-item">비밀번호 설정</div>
					<div class="step-item">수강신청 완료</div>
				</div>

				<p class="heading">1. 이용약관 및 개인정보제공 동의</p>
				<span class="heading-desc">아래 내용을 확인하시고 동의를 선택해 주십시오.</span>

				<div class="member-terms">
					<div class="member-terms-box">
<pre>
※ 개인 정보의 처리 목적 및 보유현황
  - 회사는 다음의 목적을 위하여 개인 정보를 처리합니다. 처리하고 있는 개인 정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호헙 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

1. 수집 항목
   &lt;필수&gt;
   - 포스코패밀리 – 회원정보(직원명, 직번, 회사명, 부서명), 회원과의 관계, 성별, 신청자명, 연락처
   - 일반회원 – 성별, 신청자명, 연락처
   
2. 수집 목적
   - 수강추첨 및 회원제 서비스 제공에 따른 본인 확인
   - 체육관 운영 및 고지사항 발송
   
3. 수집 및 보유기간
   - 추첨발표 15일 후 일괄삭제
   
4. 동의 거부의 권리 및 불이익
   - 위의 개인정보 수집•이용에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우 수강신청 및 체육관시설 이용에 일부 제한을 받을 수 있습니다.
</pre>
					</div>
					
					<p class="heading-desc">위와 같이 개인정보를 수집하는데 동의하십니까?</p>
					<br>
					<div class="checkbox">
						<input type="checkbox" class="checkbox" id="agree-terms-ok" /><label for="agree-terms-ok">동의</label>
						<input type="checkbox" class="checkbox" id="agree-terms-no" /><label for="agree-terms-no">미동의</label>
					</div>
</div>
				<div class="btn-group">
					<a href="#none" class="btn btn-level2 btn-noti act-next">다음</a>
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
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$("#agree-terms-ok").change(function(){
		if($(this).is(":checked"))
			$("input:checkbox[id='agree-terms-no']").prop("checked", false);
    });
	
	$("#agree-terms-no").change(function(){
		if($(this).is(":checked"))
			$("input:checkbox[id='agree-terms-ok']").prop("checked", false);
    });
	
	$(".act-next").on("click", function(){
		if(!$('input:checkbox[id="agree-terms-ok"]').is(":checked")){
			alert("이용약관 및 개인정보제공 동의를 하지 않으시면, 본 서비스이용이 제한됩니다.");
			return;
		}
		
		location.replace("/lecture/user/type");
	});
	
});

</script>
</body>
</html>