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
			<h1><a href="${ADMIN_PATH}"><img src="/admin/assets/img/h1-logo.png" alt="" /></a></h1>
			<div class="admin-login">
				<p class="title">관리자 인증</p>
				<p class="sub-title">관리자 페이지 접근을 위해, 핸드폰 본인인증을 완료해주십시오.</p>
				<div class="div-confirm">
					<strong>관리자 휴대전화번호 <c:out value="${admin_session.phone}"/></strong> <a href="#" class="btn btn-primary btn-level0 act-send">인증번호 발송</a>
					<hr />
					<label for="num-confirm">인증번호 입력</label> <input type="text" style="width:150px;" class="text auth-value" id="num-confirm" /> <a href="#" class="btn btn-primary btn-level0 act-ok">인증확인</a>
				</div>
			</div>
		</div>
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
$(function(){
	var isSend = false;
	$(".act-send").on("click", function(){
		$.ajax({
		     url:'${ADMIN_PATH}/login/confirm/send',
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		        	 isSend = true;
		             alert("인증번호를 발송하였습니다.");
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
	$(".act-ok").on("click", function(){
		var auth = $(".auth-value").val();
		if(!isSend){
			alert("인증번호 발송 후 확인해주세요.");
			return;
		}
		
		if(auth == ''){
			alert("인증번호를 입력해주세요.");
			$(".auth-value").focus();
			return;
		}
		
		$.ajax({
		     url:'${ADMIN_PATH}/login/confirm/check',
		     data:"auth="+auth,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		             alert("인증을 성공하였습니다.");
		             location.replace("${ADMIN_PATH}/main");
		         }else if(res=='SUCCESS2'){
		             alert("인증을 성공하였습니다.");
		             location.replace("${ADMIN_PATH}/login/pw");
		         }else if(res=='NOT_MATCHE'){
		             alert("인증번호가 올바르지 않습니다.");
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
});

</script>
</body>
</html>