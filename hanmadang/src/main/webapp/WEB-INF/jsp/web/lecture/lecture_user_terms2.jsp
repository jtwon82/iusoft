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
				<span class="heading-desc">각 항목의 내용을 확인하시고 동의를 선택해 주십시오.</span>

				<div class="member-terms">
					<p class="heading-desc">포스코 한마당 체육관의 이용약관입니다.</p>
					<div class="member-terms-box">
<pre>
제1조(목적 등)

1 본 약관은 주식회사 포스코(이하 "회사"라 합니다)가 홈페이지(www.poscohanmadang.co.kr)를 (이하 "사이트"라 합니다) 통하여 제공하는 인터넷 관련 서비스(이하 "서비스"라 합니다)를 이용함에 있어 이용자와"회사"의 권리•의무 및 책임사항을 규정함을 목적으로 합니다.

2 본 약관에 정하는 이외의 "이용자"와 "회사"의 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.




제2조(이용자의 정의)

1 "이용자"란 "사이트"에 접속하여 "회사"가 제공하는 서비스를 받는 자를 말하며 이는 "회원"과 "비회원"으로 구분됩니다.

2 "회원"이란 "포스코 한마당 체육관" 현장에서 일정의 가입 절차를 거쳐 개인정보를 제공하고 등록을 마친 자로서 "사이트"를 통해 제공되는 모든 서비스를 이용할 수 있습니다.

3 "비회원"이란 회원 가입 없이 "회사"가 제공하는 서비스를 제한적으로 이용하는 자를 말합니다.




제3조(회원 가입)

1 "회원"이 되고자 하는 자는 "회사"가 정한 가입 양식에 따라 포스코한마당체육관 현장에서 개인 정보를 기입하고 회원 가입을 신청합니다.

2 "회사"는 제1항과 같이 회원으로 가입할 것을 신청한 자가 다음 각 호에 해당하지 않는 한 신청한 자를 회원으로 등록합니다.

① 가입신청자가 본 약관 제6조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우. 다만 제6조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서"회사"의 회원재가입 승낙을 얻은 경우에는 예외로 합니다.

② 등록 내용에 허위, 기재누락, 오기가 있는 경우

③ 기타 회원으로 등록하는 것이 "회사"의 기술상 현저히 지장이 있다고 판단되는 경우

3 회원가입계약의 성립시기는 "회사"의 승낙이 가입신청자에게 도달한 시점으로 합니다.

4 "회원"은 제1항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 합니다.

</pre>
					</div>
					<div class="checkbox">
						<input type="checkbox" class="checkbox" id="agree-terms" /><label for="agree-terms">이용약관에 동의합니다.</label>
					</div>
				</div>

				<div class="member-terms">
					<p class="heading-desc">포스코 한마당 체육관의 개인정보 취급방침입니다.</p>
					<div class="member-terms-box">
<pre>
1. 총칙

① 개인정보란 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.
② 포스코 한마당체육관은 고객의 개인정보보호를 매우 중요시하며, "개인정보보호법" 상의 개인정보보호규정을 준수하고 있습니다. 포스코 한마당체육관은 개인정보처리방침을 통하여 고객께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려 드립니다.
③ 포스코 한마당체육관은 개인정보처리방침의 지속적인 개선을 위하여 개인정보처리방침을 개정하는데 필요한 절차를 정하고 있습니다. 그리고 개인정보처리방침을 개정하는 경우 버전번호 등을 부여하여 개정된 사항을 고객께서 쉽게 알아볼 수 있도록 하고 있습니다.



2. 개인정보 수집 및 이용목적

가. 포스코 한마당체육관은 보다 더 향상된 양질의 회원 서비스 제공을 위해 필요한 최소한의 개인정보만을 수집합니다.
    포스코 한마당체육관 방문을 통해 회원가입 시 스마트짐 서비스(맞춤별 운동가이드 제공, 운동이력관리 웹사이트 제공 등) 이용이 가능합니다.

  [ 구분 이용목적 ]
    * 회원관리
        - 회원 서비스 이용에 따른 신원 확인, 개인식별
        - 불량회원의 부정이용 방지와 비인가 사용 방지
        - 고객상담, 고객불만 접수 및 처리, 분쟁조정을 위한 기록보존
        - 각 종 통계 및 맞춤 서비스 제공
        - 정보 제공, 고지사항 전달
    * 서비스 제공에 관한 계약의 이행 및 서비스 이용에 따른 요금정산
        - 추첨신청/선정에 따른 안내
        - 금융거래 관련 본인인증 및 금융서비스
        - 요금결제, 환불등
    * 스마트짐 서비스 제공
        - 맞춤형 운동 가이드 제공 및 운동이력 관리에 따른 정보 확보


</pre>
					</div>
					<div class="checkbox">
						<input type="checkbox" class="checkbox" id="agree-policy" /><label for="agree-policy">개인정보취급방침 및 개인정보 제공에 동의합니다.</label>
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
	$(".act-next").on("click", function(){
		if(!$('input:checkbox[id="agree-terms"]').is(":checked")){
			alert("이용약관 및 개인정보제공 동의를 하지 않으시면, 본 서비스이용이 제한됩니다.");
			return;
		}
		if(!$('input:checkbox[id="agree-policy"]').is(":checked")){
			alert("이용약관 및 개인정보제공 동의를 하지 않으시면, 본 서비스이용이 제한됩니다.");
			return;
		}
		
		location.replace("/lecture/user/type");
	});
	
});

</script>
</body>
</html>