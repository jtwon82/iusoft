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
			<form id="modForm" method="post" action="${ADMIN_PATH}/login/check">
			<div class="admin-login">
				<p class="title">관리자 로그인</p>
				<p class="sub-title">포스코 한마당 관리자 페이지 접근을 위해, 로그인 해주십시오.</p>
				<div class="div-input">
					<input type="text" class="text" name="id" placeholder="아이디 입력" />
					<input type="password" autocomplete="off" class="text" name="pwd" placeholder="비밀번호 입력" />
				</div>
				<div class="div-btn">
					<button type="submit" class="btn btn-login">로그인</button>
				</div>
			</div>
			</form>
		</div>
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
$(function(){
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            input_value = form.find('input[name="id"]').val();
            if(input_value == ''){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="pwd"]').val();
            if(input_value == ''){
            	alert("비밀전호를 입력해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
    			location.replace("${ADMIN_PATH}/login/confirm");
            }else if("DUPLICATE" === response){
            	if(confirm("이미 접속중입니다. 기존의 접속을 종료하시겠습니까?"))
            		location.replace("${ADMIN_PATH}/login/disconnect");
            	else
            		location.replace("${ADMIN_PATH}");
            }else if(response == 'LOCK'){
            	alert("비밀번호 5회 실패로 계정이 잠겼습니다. 관리자에게 문의하세요.");
            }else{
            	alert("존재하지 않는 계정이거나 비밀번호가 올바르지 않습니다. 관리자에게 문의하세요.");
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	$('input[name="id"]').focus();
});

</script>
</body>
</html>