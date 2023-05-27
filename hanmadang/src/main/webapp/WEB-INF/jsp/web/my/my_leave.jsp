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
			<form id="modForm" method="post" action="/my/leave/proc">
			<article class="container">
				<div class="my-contents">
					<p class="my-change-title">포스코한마당 회원을 탈퇴하시면,<br>저장된 모든 데이타가 삭제됩니다.<br>탈퇴하시겠습니까?</p>
					
					<div class="btn-group">
						<button type="submit" class="btn btn-level2 btn-smart">탈퇴하기</button>
					</div>
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
$(function(){
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            		alert("포스코한마당 회원에서 탈퇴처리 되었습니다.");
    				location.replace("/login/member/logout");
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