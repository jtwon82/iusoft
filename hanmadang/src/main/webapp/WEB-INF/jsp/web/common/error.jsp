<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<%@ include file="skip.jsp"%>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->

	<%@ include file="header.jsp"%>
	<!-- //header -->
	<!-- contents -->
	<main id="contents" role="main">
		<div id="contents-inner">
			<div class="container-tabs cl-new">
			</div>
			<article class="container-notice bg-new">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			
			<article class="container">
				<div class="noti-title">포스코 한마당 체육관의 <span class="cl-new">새로운 소식</span>입니다.</div>
			</article>
		</div>

	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>