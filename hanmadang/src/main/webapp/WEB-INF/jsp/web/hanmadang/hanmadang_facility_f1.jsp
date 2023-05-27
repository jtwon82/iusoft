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
			<div class="container-tabs cl-intro">
				<ul>
					<li class="by-2"><a href="/hanmadang/info">포스코 한마당 개요</a></li>
					<li class="by-2 is-selected"><a href="/hanmadang/facility/f1">포스코 한마당 시설안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-home">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			
			<article class="container">

				<div class="floor-tabs">
					<a href="#none" class="by-4 is-selected"><span>1F</span></a>
					<a href="/hanmadang/facility/f2" class="by-4"><span>2F</span></a>
					<a href="/hanmadang/facility/f3" class="by-4"><span>3F</span></a>
					<a href="/hanmadang/facility/b1" class="by-4"><span>B1</span></a>
				</div>

				<div class="floor-cnt">
					<div class="floor-state">
						<strong>1F</strong>
						<span class="eng">First floor</span>
						<ul class="floor-list">
							<li>체육관존</li>
							<li>생활체육존</li>
							<li>공용존</li>
						</ul>
						<a href="#floor-f1" class="btn btn-floor btn-level2 js-modal__btn-open">이미지보기</a>
					</div>
					<div class="floor-img"><img src="/web/assets/img/floor-1f.jpg" alt="한마당" /></div>
				</div>
			</article>
		</div>


		<div class="modal-basic js-modal " id="floor-f1"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-middle__body">
					<div class="modal-middle__contents">
						<div class="floor-cnt">
							<div class="floor-state">
								<strong>1F</strong>
								<span class="eng">First floor</span>
								<ul class="floor-list">
									<li>체육관존</li>
									<li>생활체육존</li>
									<li>공용존</li>
								</ul>
							</div>
							<div class="floor-img">
								<div class="slide-wrap">
									<div class="slide-frame" id="slide-floor">
										<ul class="clearfix">
											<li><img src="/web/assets/img/floor-1f-01.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-02.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-03.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-04.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-05.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-06.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-07.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-08.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-09.jpg" alt="한마당" /></li>
											<li><img src="/web/assets/img/floor-1f-10.jpg" alt="한마당" /></li>
										</ul>
									</div>
									<div class="slide-controls center">
										<button class="btn prev"><i class="icon-chevron-left"></i> prev</button>
										<button class="btn next">next <i class="icon-chevron-right"></i></button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
</body>
</html>