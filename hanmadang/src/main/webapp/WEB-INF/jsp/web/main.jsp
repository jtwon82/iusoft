<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=0.3, minimum-scale=0.3, maximum-scale=2, user-scalable=no" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<meta name="naver-site-verification" content="07223d4fb7937853d905107caf1212bcadb8481d"/>
<meta property="og:type" content="website">
<meta property="og:title" content="포스코 한마당">
<meta property="og:description" content="포스코 한마당 체육관의 홈페이지입니다.">
<meta name="description" content="포스코 한마당 체육관의 홈페이지입니다.">
<title>포스코 한마당</title>
<link rel="stylesheet" type="text/css" href="/web/assets/css/style.css">
<!--[if lt IE 9]>
<script src="/web/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/web/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery-ui.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/sly.js" type="text/javascript"></script>
<script src="/web/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- skip -->
<div id="skip" class="sr-only">
	<ul>
		<li><a href="#skip">메뉴 바로가기</a></li>
		<li><a href="#posco-main">본문 바로가기</a></li>
		<li><a href="#footer">하단 바로가기</a></li>
	</ul>
</div>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- contents -->
	<main id="posco-main" role="main">
	
		<div class="posco-wrap">
			<div class="main-bg">
				<!-- bg swiper -->
				<div class="slide-wrap">
					<div class="slide-frame" id="slide-frame" style="background-color: black;">
						<ul class="clearfix">
						
						<c:choose>
						<c:when test="${empty list }">
						<li>
							<img src="/web/assets/img/bg-main.jpg" alt="한마당" />
						</li>
						</c:when>
						<c:otherwise>
						<c:forEach items="${list }" var="item" varStatus="status">
						<li>
							<c:choose>
							<c:when test="${empty item.b_link }">
							<img src='/upload/<c:out value="${item.b_img}"/>' alt="포스코한마당" />
							</c:when>
							<c:otherwise>
							<a href="<c:out value="${item.b_link }"/>"><img src="/upload/<c:out value="${item.b_img}"/>" alt="한마당" /></a>
							</c:otherwise>
							</c:choose>
							<div class="main-text"><c:out value="${item.b_name}"/></div>
						</li>
						</c:forEach>
						</c:otherwise>
						</c:choose>
						</ul>
					</div>
				</div>
				<!-- <div class="contents-text"><img src="./assets/img/contents-text-lecture.png" alt="" /></div> -->
			</div>
			
			<h1><a href="/"><img src="/web/assets/img/h1-logo-main.png" alt="포스코한마당" /></a></h1>
			<div class="quick-link">
				<a href="/hanmadang/info">포스코 한마당 소개</a>
				<a href="/hanmadang/map">찾아오시는 길</a>
			</div>

			<!-- <div class="main-title sr-only">
				포스코 한마당과 함께 건강을 관리해 보세요
			</div> -->

			<div class="main-menu">
				<div class="main-cell bg-program">
					<a href="/program/time/all">
						<p class="menu-name">프로그램 소개</p>
						<figure><img src="/web/assets/img/main-p1.png" alt="포스코한마당" /></figure>
						<span class="menu-desc">포스코 한마당의 다양한 <br>강좌 정보 보기</span>
					</a>
				</div>
				<div class="main-cell bg-lecture">
					<a href="/lecture/info">
						<p class="menu-name">수강신청</p>
						<figure><img src="/web/assets/img/main-p2.png" alt="포스코한마당" /></figure>
						<span class="menu-desc">별도의 로그인 없이 신청 가능</span>
					</a>
				</div>
				<div class="main-cell bg-rent">
					<a href="/rent/main">
						<p class="menu-name">대관현황 및 예약</p>
						<figure><img src="/web/assets/img/main-p3.png" alt="포스코한마당" /></figure>
						<span class="menu-desc">배드민턴 / 탁구 / 당구 / 구기종목<br>대관 현황 보기</span>
					</a>
				</div>
				<div class="main-cell bg-smart">
					<c:choose>
					<c:when test="${!empty member_session }">
					<a href="/my/smart">
						<p class="menu-name">마이페이지</p>
						<figure><img src="/web/assets/img/main-p4.png" alt="포스코한마당" /></figure>
						<span class="menu-desc">스마트 짐 데이터 및<br>나의 모든 등록 정보 보기</span>
					</a>
					</c:when>
					<c:otherwise>
					<a href="/my/login">
						<p class="menu-name">마이페이지</p>
						<figure><img src="/web/assets/img/main-p4.png" alt="포스코한마당" /></figure>
						<span class="menu-desc">스마트 짐 데이터 및<br>나의 모든 등록 정보 보기</span>
					</a>
					</c:otherwise>
					</c:choose>
				</div>
				<div class="main-cell bg-new">
					<a href="/notice">
						<p class="menu-name">한마당 새소식</p>
						<figure><img src="/web/assets/img/main-p5.png" alt="포스코한마당" /></figure>
<!-- 						<span class="menu-desc ">한마당체육관 3분기 생활체육<br>특화 프로그램 운영 결과</span> -->
					</a>
				</div>
				<div class="main-cell-last bg-new">
					<div class="menu-desc-more">
						<ul>
						<c:forEach items="${notice_list }" var="item" varStatus="status">
						<c:if test="${status.index <= 2 }">
							<li><a href="/notice"><c:out value="${item.title}"/> <c:if test="${item.reg_diff < 10}"><span class="blinkcss new">New</span></c:if></a></li>
						</c:if>
						</c:forEach>
						</ul>
						<a href="/notice" class="btn" title="공지사항 더보기">더보기</a>
						<div class="menu-desc-common">
							<a href="#cctv-layer" class="footer-common js-modal__btn-open">영상정보처리기기 운영관리 방침</a>
							<a href="#policy-layer" class="footer-common js-modal__btn-open"><b style="color:blue;">개인정보 처리 방침</b></a>
							<a href="#terms-layer" class="footer-common js-modal__btn-open">이용약관</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<c:if test="${fn:length(pop_list) > 0 }">
		<c:set var="popno_x" value="100"/>
		<c:set var="popno_y" value="50"/>
		<c:forEach items="${pop_list }" var="item" varStatus="status">
		<c:set var="popno" value="${item.idx_no}"/>
		
		<div class="modal-main js-modal draggable" id="modal-main<c:out value='${popno }'/>" style="left:<c:out value='${popno_x }'/>px; top:<c:out value='${popno_y }'/>px;"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents modal-basic__main">
							<c:choose>
							<c:when test="${empty item.b_link }">
							<img src='/upload/<c:out value="${item.b_img}"/>' alt="한마당" />
							</c:when>
							<c:otherwise>
							<a href="<c:out value="${item.b_link }"/>"><img src='/upload/<c:out value="${item.b_img}"/>' alt="한마당" /></a>
							</c:otherwise>
							</c:choose>
					</div>
				</div>
				<div class="midal-basic__footer">
					<div class="checkbox">
						<input type="checkbox" class="checkbox" id="agree-terms<c:out value='${popno }'/>"><label for="agree-terms<c:out value='${popno }'/>">오늘하루 보지 않기</label>
					</div>
				</div>
				<a href="#none" data-value="<c:out value="${item.idx_no}"/>" title="닫기" class="modal-basic__btn-close act-pop-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		
		<c:set var="popno_x" value="${popno_x + 200}"/>
		<c:set var="popno_y" value="${popno_y + 100}"/>
		</c:forEach>
		
		</c:if>
<footer id="footer">
	<!-- footer -->
	<%@ include file="./common/footer-layerpop.jsp"%>
	<!-- //footer -->
</footer>
</div>
<!-- //wrapper -->
<script>  
// 쿠키 가져오기  
function getCookie( name ) {  
   var nameOfCookie = name + "=";  
   var x = 0;  
   while ( x <= document.cookie.length )  
   {  
       var y = (x+nameOfCookie.length);  
       if ( document.cookie.substring( x, y ) == nameOfCookie ) {  
           if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )  
               endOfCookie = document.cookie.length;  
           return unescape( document.cookie.substring( y, endOfCookie ) );  
       }  
       x = document.cookie.indexOf( " ", x ) + 1;  
       if ( x == 0 )  
           break;  
   }  
   return "";  
}  
  
// 24시간 기준 쿠키 설정하기  
// expiredays 후의 클릭한 시간까지 쿠키 설정  
function setCookie( name, value, expiredays ) {   
   var todayDate = new Date();   
   todayDate.setDate( todayDate.getDate() + expiredays );   
   document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"   
}  
  
// 00:00 시 기준 쿠키 설정하기  
// expiredays 의 새벽  00:00:00 까지 쿠키 설정  
function setCookieAt00( name, value, expiredays ) {   
    var todayDate = new Date();   
    todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);  
    if ( todayDate > new Date() )  
    {  
    expiredays = expiredays - 1;  
    }  
    todayDate.setDate( todayDate.getDate() + expiredays );   
     document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"   
  }  
   
 function checkPop(){
	 <c:if test="${fn:length(pop_list) > 0 }">
	 <c:forEach items="${pop_list }" var="item" varStatus="status">
	 var blnCookie = getCookie(<c:out value="${item.idx_no}"/>);
	 if( !blnCookie ) { 
		 $("#modal-main<c:out value='${item.idx_no}'/>").addClass("is-expanded");
	  }else{
		  $("#modal-main<c:out value='${item.idx_no}'/>").removeClass("is-expanded");
	  }
	 </c:forEach>
	 </c:if>
 }
 
$(function(){
	checkPop();
	
	$( ".draggable" ).draggable();
	
	$(".act-pop-close").on("click", function(){
		var idx = $(this).data("value");
		$(this).parents(".js-modal").removeClass('is-expanded');
		
		if($(this).parent().find('.checkbox').is(":checked"))
			setCookieAt00(idx, "done", 1);
	});
});
</script>  
</body>
</html>