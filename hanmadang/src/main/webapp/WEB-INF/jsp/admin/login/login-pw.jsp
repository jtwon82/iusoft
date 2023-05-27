<%@ page contentType = "text/html;charset=utf-8" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당 - 관리자</title>
<link rel="stylesheet" type="text/css" href="/admin/assets/css/style.css">
<link rel="stylesheet" type="text/css" href="/admin/assets/css/admin.css">
<!--[if lt IE 9]>
<script src="/admin/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/admin/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery-ui-datepicker-1.12.1.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- skip -->
<%@ include file="../common/skip.jsp"%>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- contents -->
	<main id="admin-main" role="main">
		<div class="admin-wrap">
			<h1><a href="#"><img src="/admin/assets/img/h1-logo.png" alt="" /></a></h1>
			<div class="admin-login">
				<p class="title">개인 정보 보호를 위한 비밀번호 변경</p>
				<div class="sub-title">
					<ul class="li-list">
						<li class="cl-pure">비밀번호는 주기적으로 (3개월에 한번씩) 변경하는 것이 좋습니다.<br><br></li>
						<li class="cl-pure">다른 사이트와 동일한 아이디 / 비밀번호를 사용할 경우,<br>개인정보 유출로 인한 피해를 입을 수 있습니다.<br><br></li>
						<li class="cl-pure">다른 사람이 예측할 수 없는 비밀번호로 변경하시어 <br>개인정보를 안전하게 보호하시기 바랍니다.</li>
					</ul>
				</div>
				<div class="div-confirm">
					<hr />
					<c:if test="${empty isforce or isforce != 1}">
					<a href="${ADMIN_PATH}/main" class="btn btn-primary btn-level0">다음에 변경하기</a>
					</c:if>
					<a href="#modal-password" class="btn btn-primary btn-level0 js-modal__btn-open">비밀번호 변경</a>
				</div>
			</div>
		</div>
	</main>
	<!-- contents//end -->

	<div class="modal-basic js-modal " id="modal-password"><!-- is-expanded -->
		<div class="modal-basic__bg"></div>
		<div class="modal-basic__wrapper">
		<form id="modForm" method="post" action="${ADMIN_PATH}/login/pw/change">
			<div class="modal-640__body">
				<div class="modal-basic__contents">
					<div class="modal-basic__header">
						<div class="modal-basic-title">비밀번호 변경</div>
						<div class="modal-basic-desc">비밀번호를 재설정 합니다.</div>
						<p class="note-text">비밀번호는 숫자, 문자, 특수문자를 1자 이상 포함하여 8자 이상이어야 합니다.</p>
					</div>
					<div class="line-form">
						<label class="line-form-name" for="num-confirm">기존 비밀번호</label> <input type="password" autocomplete="off" style="width:200px;" class="text" id="num-confirm" name="pwd" placeholder="기존 비밀번호 입력" />
					</div>
					<div class="line-form">
						<label class="line-form-name" for="num-confirm-new">새 비밀번호</label> <input type="password" autocomplete="off" style="width:200px;" class="text" id="num-confirm-new" name="new-pwd" placeholder="새 비밀번호 입력" />
					</div>
					<div class="line-form">
						<label class="line-form-name" for="num-confirm-check">비밀번호 확인</label> <input type="password" autocomplete="off" style="width:200px;" class="text" id="num-confirm-check" name="new-pwd1" placeholder="비밀번호 재입력" />
						<!-- alert message -->
						<p class="msg-alert cl-my"><!-- 비밀번호가 일치하지 않습니다. 다시 입력해 주십시오. --></p>
					</div>
					<div class="btn-group">
						<button type="submit" class="btn btn-level1 btn-register">변경하기</button>
					</div>
				</div>
			</div>
			<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
		</form>
		</div>
	</div>
	<!-- layer popup//end -->
		
</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
<c:if test="${!empty isforce and isforce == 1}">
	alert("최초 로그인입니다. 비밀번호를 변경해주세요.");
</c:if>

function passwordCheck(password, newPassword1) {

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
     
 	// 기존 비밀번호와 새 비밀번호 일치 여부
    if (password == newPassword1) {
        alert("기존 비밀번호와 새 비밀번호가 일치합니다.");
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

	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
        	input_value = form.find('input[name="pwd"]').val();
            if(input_value == ''){
            	$(".msg-alert").text("기존 비밀번호를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="new-pwd"]').val();
            if(input_value == ''){
            	$(".msg-alert").text("새 비밀번호를 입력해주세요.");
            	return false;
            }
          
            input_value = form.find('input[name="new-pwd1"]').val();
            if(input_value == ''){
            	$(".msg-alert").text("비밀번호 확인을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="new-pwd"]').val() != form.find('input[name="new-pwd1"]').val()){
            	$(".msg-alert").text("비밀번호 확인이 일치하지 않습니다.");
            	return false;
            }
            
            /* input_value = form.find('input[name="new-pwd"]').val();
            var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,10}$/
            if(!passwordRules.test(input_value)){
            	alert('숫자, 영문자, 특수문자 조합으로 6~10자리를 사용해야 합니다.');
            	return false;
            } */
            
            input_value = form.find('input[name="new-pwd"]').val();
            if(!passwordCheck(form.find('input[name="pwd"]').val(), input_value))
            		return false;
            
            if(!confirm("변경하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("성공적으로 처리되었습니다.");
    			location.replace("${ADMIN_PATH}/main");
            }else if(response =='NOT_MATCHE'){
            	$(".msg-alert").text("기존 비밀번호가 올바르지 않습니다.");
	        }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
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