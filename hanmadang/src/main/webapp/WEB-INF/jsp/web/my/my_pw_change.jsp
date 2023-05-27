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
			<form id="modForm" method="post" action="/my/pw/change/save">
			<article class="container">
				<div class="my-contents">
					<p class="my-change-title">비밀번호 변경을 위해 기존 비밀번호를<br>입력해 주십시오.</p>
					<div class="input-group input-smart">
						<input type="password" autocomplete="off" name="pwd" placeholder="기존 비밀번호 입력">
					</div>
					<p class="my-change-title">새 비밀번호를 입력해 주십시오.</p>
					<div class="input-group input-smart">
						<input type="password" autocomplete="off" name="new-pwd" placeholder="새 비밀번호 입력">
						<input type="password" autocomplete="off" name="new-pwd1" placeholder="새 비밀번호 확인">
					</div>
					<div class="btn-group">
						<button type="submit" class="btn btn-level2 btn-smart">비밀번호 변경</button>
					</div>
					<!-- <div class="link-group">
						<a href="#" class="link link-pure by-2">비밀번호 변경</a>
						<a href="#" class="link link-pure by-2">아이디·비밀번호 찾기</a>
					</div> -->
				</div>
			</article>
			</form>
		</div>


	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

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
            	alert("기존 비밀번호를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="new-pwd"]').val();
            if(input_value == ''){
            	alert("새 비밀번호를 입력해주세요.");
            	return false;
            }
          
            input_value = form.find('input[name="new-pwd1"]').val();
            if(input_value == ''){
            	alert("새 비밀번호 확인을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="new-pwd"]').val() != form.find('input[name="new-pwd1"]').val()){
            	alert("비밀번호 확인이 일치하지 않습니다.");
            	return false;
            }
            
            input_value = form.find('input[name="new-pwd"]').val();
            if(!passwordCheck(form.find('input[name="pwd"]').val(), input_value))
            		return false;
            
            /* input_value = form.find('input[name="new-pwd"]').val();
            var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,10}$/
            if(!passwordRules.test(input_value)){
            	alert('숫자, 영문자, 특수문자 조합으로 6~10자리를 사용해야 합니다.');
            	return false;
            } */
            
            if(!confirm("변경하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	/* alert("성공적으로 처리되었습니다."); */
    			location.replace("/my/pw/result");
            }else if(response =='NOT_MATCHE'){
            	alert("기존 비밀번호가 올바르지 않습니다.");
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