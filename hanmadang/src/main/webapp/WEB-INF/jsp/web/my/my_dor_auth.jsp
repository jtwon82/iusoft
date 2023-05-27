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
				<ul></ul>
			</div>
			<article class="container-notice bg-my">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			<article class="container">
				<div class="my-contents1">
					<p class="my-change-title">'정보통신망 이용촉진 및 정보보호 등에 관한 법률'에 따라
					<br>최근 1년 이상 사이트에 접속한 기록이 없어 휴면계정 처리 전환되었습니다.
					</p>
					
					<p class="my-change-title">휴면 계정 복구를 위해 본인 인증 및 비밀번호 변경을 해주세요.
					</p>
					
					<div class="my-contents2">
						<form id="idForm" method="post" action="/login/dormant/id">
							<span class="modal-basic-desc">이용자명과 휴대폰 번호를 입력 후 확인 버튼을<br>누르시면 인증번호가 발송됩니다.</span>
							<div class="input-group input-smart">
								<input type="text" autocomplete="off" name="name" placeholder="이용자명" />
								<input type="text" autocomplete="off" name="hp" placeholder="휴대폰 번호" />
								<button type="submit" class="btn btn-level2 btn-noti">인증번호 전송</button>
							</div>
						</form>
					</div>
					<div class="my-contents2">
						<form id="authForm" method="post" action="/login/dormant/id/auth">
							<p class="modal-basic-desc">SMS 로 전송된 인증번호를 입력하세요.</p>
							<div class="input-group input-smart">
								<input type="text" autocomplete="off" name="auth" placeholder="인증번호 입력" />
								<button type="submit" class="btn btn-level2 btn-search">확인</button>
							</div>
						</form>
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
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

$(function(){
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
            if(response == 'SUCCESS'){
            		location.replace("/login/dormant/pwd");
            }else if(response == 'NOT_MATCHE'){
            		alert("인증번호가 일치하지 않습니다.");
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