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
				<div class="member-step step5">
					<div class="step-item is-passed"><a href="/lecture/user/terms">약관 동의</a></div>
					<div class="step-item is-passed"><a href="/lecture/user/type">회원타입 선택</a></div>
					<div class="step-item is-passed"><a href="/lecture/user/input">회원 정보 입력</a></div>
					<div class="step-item is-passed"><a href="/lecture/user/select">강좌 선택</a></div>
					<div class="step-item is-current">비밀번호 설정</div>
					<div class="step-item">수강신청 완료</div>
				</div>
				<div class="info-type info-type-right">
					<p class="info-noti">이전페이지(회색버튼)로 이동 가능합니다.</p>
				</div>

				<p class="heading">5. 비밀번호 설정</p>
				<span class="heading-desc">설정하신 비밀번호는 신청내역 삭제시 필요합니다.<br>신청내용수정은 불가하오니, 신청을 취소하시고 재신청해주십시오.</span>

				<form id="modForm" method="post" action="/lecture/user/save">
				<div class="member-form">
					<div class="member-type-input">
						<label for="member-password">비밀번호 입력</label>
						<input type="password" class="text" autocomplete="off" name="pass" id="member-password" placeholder="비밀번호 입력">
					</div>
					<div class="member-type-input">
						<label for="member-password-re">비밀번호 재입력</label>
						<input type="password" class="text" autocomplete="off" name="pass1" id="member-password-re" placeholder="비밀번호 재입력">
					</div>
				</div>
			
				<div class="btn-group">
					<button type="submit" class="btn btn-level2 btn-noti">다음</button>
				</div>
				</form>
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
var isIng = false;
$(function(){
	$('#modForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
        		if(isIng){
        			alert("처리중입니다.");
        			return false;
        		}
        			
            if(form.find('input[name="pass"]').val() == ''){
	    			alert("비밀번호를 입력해주세요.");
	    			return fasle;
	    		}
	    		if(form.find('input[name="pass1"]').val() == ''){
	    			alert("비밀번호 재입력해주세요.");
	    			return fasle;
	    		}
	    		if(form.find('input[name="pass"]').val() != $('input[name="pass1"]').val()){
	    			alert("비밀번호 재입려과 일치하지 않습니다.");
	    			return fasle;
	    		}
            
	    		isIng = true;
	    		
            return true;
        },
        success: function(res,status){
            //성공후 서버에서 받은 데이터 처리
            if(res=='SUCCESS'){
            		location.replace("/lecture/user/result");
	         }else if(res=='INVALID_TYPE'){
	        	 	location.replace("/lecture/user/type");
	         }else if(res=='INVALID_PARAM'){
	        	 	alert("비밀번호를 입력해주세요.");
	        	 	location.reload(true);
	         }else if(res=='INVALID_ACCESS'){
	        	 	location.replace("/lecture/user/terms");
	         }else{
	        	 	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
	        	 	isIng = false;
	         } 
            
            
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        	isIng = false;
        }                               
    });
});

</script>
</body>
</html>