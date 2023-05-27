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
		<div id="contents-inner" class="">
			<div class="container-tabs cl-my">
				<ul>
				</ul>
			</div>
			<article class="container-notice bg-my">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			
			<article class="container">
				<div class="my-contents">
				<form id="loginForm" method="post" action="/login/member/check">
					<p class="my-title">로그인</p>
					<span class="my-desc">포스코 한마당 이용을 위해 로그인해 주십시오.</span>
					<div class="input-group input-smart">
						<input type="text" name="id" placeholder="아이디">
						<input type="password" autocomplete="off" name="pwd" placeholder="비밀번호">
					</div>
					<div class="btn-group">
						<button type="submit" class="btn btn-level2 btn-smart">로그인</button>
					</div>
					<div class="link-group">
						<!-- <a href="#" class="link link-default by-2">비밀번호 변경</a> -->
						<a href="#none" class="link link-default by-2 act-find-id">아이디·비밀번호 찾기</a>
					</div>
				</form>
				</div>
			</article>
		</div>
	</main>
	<!-- contents//end -->

	<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-find"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<form id="idForm" method="post" action="/login/find/id">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">아이디 / 비밀번호 찾기</p>
						<span class="modal-basic-desc">이용자명과 휴대폰 번호를 입력 후 확인 버튼을<br>누르시면 인증번호가 발송됩니다.</span>
						<div class="input-group">
							<input type="text" name="name" placeholder="이용자명" />
							<input type="text" name="hp" placeholder="휴대폰 번호" />
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level2 btn-noti">인증번호 전송</button>
						</div>
					</div>
				</div>
				</form>
				<form id="authForm" method="post" action="/login/find/id/auth">
				<div class="modal-basic__body modal-double__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">SMS 로 전송된 인증번호를 입력하세요.</p>
						<div class="input-group">
							<input type="text" name="auth" placeholder="인증번호 입력" />
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level2 btn-search">확인</button>
						</div>
					</div>
				</div>
				</form>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-find-id"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">아이디 찾기</p>
						<span class="modal-basic-desc">고객님의 정보와 일치하는 아이디입니다.</span>
						<div class="find-id">
							<p class="user-info"></p>
							<span class="user-date"></span>
						</div>
						<div class="btn-group">
							<a href="#none" class="btn by-2 btn-level1 btn-select js-modal__btn-close">로그인하기</a>
							<a href="#none" class="btn by-2 btn-level1 btn-noti act-pw">비밀번호 찾기</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-change-pw"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<form id="pwForm" method="post" action="/login/find/pw/change">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">비밀번호 변경</p>
						<span class="modal-basic-desc">보안을 위해 새 비밀번호를 입력해 주십시오.</span>
						<div class="input-group">
							<input type="password" autocomplete="off" name="pwd" placeholder="새 비밀번호 입력" />
							<input type="password" autocomplete="off" name="pwd1" placeholder="새 비밀번호 재입력" />
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level2 btn-noti">비밀번호 변경</button>
						</div>
					</div>
				</div>
				</form>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-change-pw-ok"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">비밀번호가<br>성공적으로 변경되었습니다.</p>
						<div class="btn-group">
							<a href="#none" class="btn btn-level2 btn-noti js-modal__btn-close">확인</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		
	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
function passwordCheck(newPassword1) {

    // 길이
    if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{8,15}$/.test(newPassword1))
    { 
        alert("비밀번호는 숫자, 영문, 특수문자 조합으로 8~15자리를 사용해야 합니다."); 
        return false;
    }
     
    // 영문, 숫자, 특수문자 2종 이상 혼용
    var chk = 0;
    if(newPassword1.search(/[0-9]/g) != -1 ) chk ++;
    if(newPassword1.search(/[a-z]/ig)  != -1 ) chk ++;
    if(newPassword1.search(/[!@#$%^&*()?_~]/g)  != -1  ) chk ++;
    if(chk < 3)
    { 
        alert("비밀번호는 숫자, 영문, 특수문자를 혼용하여야 합니다."); 
        return false;
    }
     
    // 동일한 문자/숫자 4이상, 연속된 문자
    if(/(\w)\1\1\1/.test(newPassword1) || isContinuedValue(newPassword1))
    {
        alert("비밀번호에 4자 이상의 연속 또는 반복 문자 및 숫자를 사용하실 수 없습니다."); 
        return false;
    }

    return true;
     
}
 
function isContinuedValue(value) {
    /* console.log("value = " + value); */
    var intCnt1 = 0;
    var intCnt2 = 0;
    var temp0 = "";
    var temp1 = "";
    var temp2 = "";
    var temp3 = "";

    for (var i = 0; i < value.length-3; i++) {
        /* console.log("========================="); */
        temp0 = value.charAt(i);
        temp1 = value.charAt(i + 1);
        temp2 = value.charAt(i + 2);
        temp3 = value.charAt(i + 3);

       /*  console.log(temp0)
        console.log(temp1)
        console.log(temp2)
        console.log(temp3) */

        if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == 1
                && temp1.charCodeAt(0) - temp2.charCodeAt(0) == 1
                && temp2.charCodeAt(0) - temp3.charCodeAt(0) == 1) {
            intCnt1 = intCnt1 + 1;
        }

        if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == -1
                && temp1.charCodeAt(0) - temp2.charCodeAt(0) == -1
                && temp2.charCodeAt(0) - temp3.charCodeAt(0) == -1) {
            intCnt2 = intCnt2 + 1;
        }
        /* console.log("========================="); */
    }

    /* console.log(intCnt1 > 0 || intCnt2 > 0); */
    return (intCnt1 > 0 || intCnt2 > 0);
}

$(function(){
	$(".act-pw").on("click", function(){
		$("#modal-find-id").removeClass("is-expanded");
		$("#modal-change-pw").addClass("is-expanded");
	});
	
	$(".act-find-id").on("click", function(){
		$("#modal-find").find('input[name="name"]').val('');
		$("#modal-find").find('input[name="hp"]').val('');
		$("#modal-find").find('input[name="auth"]').val('');
		/* $("#modal-change-pw").find('input[name="pwd"]').val('');
		$("#modal-change-pw").find('input[name="pwd1"]').val(''); */
		$("#modal-find").addClass("is-expanded");
		isAuthSend = false;
	});
	
	
	$('#loginForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            input_value = form.find('input[name="id"]').val();
            if(input_value == ''){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="pwd"]').val();
            if(input_value == ''){
            	alert("비밀번호를 입력해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
    				location.replace("/my/lecture");
            }else if(response == 'SUCCESS_CHG'){
            		alert("3개월 주기로 비밀번호 변경을 안내해 드리고 있습니다.\n개인정보 보호를 위해 비밀번호를 변경해주세요.");
            		location.replace("/my/pw/change");
            }else if(response == 'SUCCESS_DOR'){
            		location.replace("/login/dormant");
            }else if(response == 'PWD_LOCK'){
            		alert("비밀번호 5회 실패로 5분간 로그인 접속 제한처리됩니다.");
            }else if(response == 'PWD_5MLOCK'){
            		alert("5분간 로그인 접속 제한중입니다.");
            }else{
            		alert("아이디 또는 비밀번호가 일치하지않습니다.\n다시 시도해주십시오.");
            }
        },
        error: function(){
        		alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
	var isAuthSend = false;
	
	$('#idForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            input_value = form.find('input[name="name"]').val();
            if(input_value == ''){
            	alert("이용자명을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="hp"]').val();
            if(input_value == ''){
            	alert("휴대폰 번호를 입력해주세요.");
            	return false;
            }
            
            isAuthSend = false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	isAuthSend = true;
            	alert("인증번호를 발송하였습니다.");
            }else if(response == 'NOT_FOUND'){
            	alert("등록된 정보가 없습니다.");
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요. : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
	$('#authForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            
            if(!isAuthSend){
            	alert("인증번호 발송 후 확인해주세요.");
            	return false;
            }
            	
            input_value = form.find('input[name="auth"]').val();
            if(input_value == ''){
            	alert("인증번호를 입력해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            var res = jQuery.parseJSON( response );
            if(res.result == 'SUCCESS'){
    			$("#modal-find").removeClass("is-expanded");
    			$("#modal-find-id").addClass("is-expanded");
    			$("#modal-find-id").find(".user-info").text(res.value);
    			$("#modal-find-id").find(".user-date").text("가입일 : " + res.value2);
            }else if(res.result == 'NOT_MATCHE'){
            	alert("인증번호가 일치하지 않습니다.");
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요. : " + res.result);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
	$('#pwForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            
            input_value = form.find('input[name="pwd"]').val();
            if(input_value == ''){
            	alert("새 비밀번호를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="pwd1"]').val();
            if(input_value == ''){
            	alert("새 비밀번호 확인을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="pwd"]').val() != form.find('input[name="pwd1"]').val()){
            	alert("새 비밀번호 확인과 일치하지 않습니다.");
            	return false;
            }
            
            input_value = form.find('input[name="pwd"]').val();
            if(!passwordCheck(input_value))
            		return false;
            
            /* input_value = form.find('input[name="pwd"]').val();
            var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,10}$/
            if(!passwordRules.test(input_value)){
            	alert('숫자, 영문자, 특수문자 조합으로 6~10자리를 사용해야 합니다.');
            	return false;
            } */
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
    			$("#modal-change-pw").removeClass("is-expanded");
    			$("#modal-change-pw-ok").addClass("is-expanded");
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요. : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
});

</script>
</body>
</html>