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
			<div class="container-tabs cl-map">
				<!-- <ul>
					<li class="by-1 is-selected"><a href="#none">찾아오시는길&nbsp;</a></li>
				</ul> -->
			</div>
			<article class="container-notice bg-map">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="map-info">
					<dl class="by-2">
						<dt>주소</dt>
						<dd><span>지번주소 : </span>경상북도 포항시 남구 지곡동 482번지<!--  <a href="#" class="btn btn-copy btn-level0">주소복사</a> --><br>
							<span>도로명주소 : </span>경상북도 포항시 남구 지곡로 212번길 33
						</dd>
					</dl>
					<dl class="by-2">
						<dt>연락처</dt>
						<dd>054 - 221 - 9280~1</dd>
					</dl>
				</div>
				<div class="map-box">
					<!-- <img src="/web/assets/img/map-img01.png" alt="한마당" /> -->
					<iframe title="지도" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6453.32703311611!2d129.32122049371912!3d36.02850939579128!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x356701e0cda3087f%3A0x4c54cafa31adc8ff!2z6rK97IOB67aB64-EIO2PrO2VreyLnCDrgqjqtawg7KeA6rOh66GcMjEy67KI6ri4IDMz!5e0!3m2!1sko!2skr!4v1520916076144" width="720" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
				</div>
				<div class="btn-group">
					<a href="javascript:print();" class="btn btn-copy btn-level2">인쇄하기</a>
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
</body>
</html>