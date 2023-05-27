<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%String url1 = request.getServletPath(); %>
<c:set value="<%=url1 %>" var="url1"/>

<!-- header -->
	<header id="gnb" class="gnb" role="banner">
		<div class="gnb-nav">
			<ul>
				<li><a href="/"><span class="gnb-nav-home "></span>홈으로 가기</a></li>
				<li><a href="/hanmadang/info"><span class="gnb-nav-intro <c:if test="${fn:contains(url1,  'web/hanmadang')}"> is-selected </c:if>"></span>포스코 한마당 소개</a></li>
				<li><a href="/hanmadang/map"><span class="gnb-nav-map <c:if test="${fn:contains(url1,  'web/map')}"> is-selected </c:if>"></span>찾아오시는 길</a></li>
				<li><a href="/program/time/all"><span class="gnb-nav-program <c:if test="${fn:contains(url1,  'web/program')}"> is-selected </c:if>"></span>프로그램소개</a></li>
				<li><a href="/lecture/info"><span class="gnb-nav-lecture <c:if test="${fn:contains(url1,  'web/lecture')}"> is-selected </c:if>"></span>수강신청</a></li>
				<li><a href="/rent/main"><span class="gnb-nav-rent <c:if test="${fn:contains(url1,  'web/reserve')}"> is-selected </c:if>"></span>대관신청</a></li>
				<c:if test="${!empty member_session }">
				<li><a href="/my/smart"><span class="gnb-nav-mypage <c:if test="${fn:contains(url1,  'web/my')}"> is-selected </c:if>"></span>마이페이지</a></li>
				</c:if>
				<c:if test="${empty member_session }">
				<li><a href="/my/login"><span class="gnb-nav-mypage <c:if test="${fn:contains(url1,  'web/my')}"> is-selected </c:if>"></span>마이페이지</a></li>
				</c:if>
				<li><a href="/notice"><span class="gnb-nav-new <c:if test="${fn:contains(url1,  'web/news')}"> is-selected </c:if>"></span>한마당 새소식</a></li>
				<c:if test="${!empty member_session }">
				<li><a href="/login/member/logout"><span class="gnb-nav-logout"></span>로그아웃</a></li>
				</c:if>
			</ul>
		</div>
	</header>
	<!-- //header -->
	<div class="floating-header">
		<div class="top-nav">
			<h1><a href="/"><img src="/web/assets/img/h1-logo.png" alt="포스코한마당" /></a></h1>
			<ul>
				<li class="cl-home <c:if test="${fn:contains(url1,  'web/hanmadang')}"> is-selected </c:if>"><a href="/hanmadang/info">포스코 한마당 소개</a></li>
				<li class="cl-map <c:if test="${fn:contains(url1,  'web/map')}"> is-selected </c:if>"><a href="/hanmadang/map">찾아오시는 길</a></li>
				<li class="cl-program <c:if test="${fn:contains(url1,  'web/program')}"> is-selected </c:if>"><a href="/program/time/all">프로그램소개</a></li>
				<li class="cl-lecture <c:if test="${fn:contains(url1,  'web/lecture')}"> is-selected </c:if>"><a href="/lecture/info">수강신청</a></li>
				<li class="cl-rent <c:if test="${fn:contains(url1,  'web/reserve')}"> is-selected </c:if>"><a href="/rent/main">대관신청</a></li>
				<c:if test="${!empty member_session }">
				<li class="cl-my <c:if test="${fn:contains(url1,  'web/my')}"> is-selected </c:if>"><a href="/my/smart">마이페이지</a></li>
				</c:if>
				<c:if test="${empty member_session }">
				<li class="cl-my <c:if test="${fn:contains(url1,  'web/my')}"> is-selected </c:if>"><a href="/my/login">마이페이지</a></li>
				</c:if>
				<li class="cl-new <c:if test="${fn:contains(url1,  'web/news')}"> is-selected </c:if>"><a href="/notice">한마당 새소식</a></li>
			</ul>
			<c:if test="${!empty member_session }">
			<div class="global-link"><a href="/login/member/logout">로그아웃</a></div>
			</c:if>
		</div>
		<div class="nav-header">
			<h2>
			<c:choose>
			<c:when test="${fn:contains(url1,  'web/hanmadang')}">포스코 한마당 소개</c:when>
			<c:when test="${fn:contains(url1,  'web/map')}">찾아오시는길</c:when>
			<c:when test="${fn:contains(url1,  'web/program')}">프로그램소개</c:when>
			<c:when test="${fn:contains(url1,  'web/lecture')}">수강신청</c:when>
			<c:when test="${fn:contains(url1,  'web/reserve')}">대관신청</c:when>
			<c:when test="${fn:contains(url1,  'web/my')}">마이페이지</c:when>
			<c:when test="${fn:contains(url1,  'web/news')}">한마당 새소식</c:when>
			<c:otherwise>
			
			</c:otherwise>
			</c:choose>
			</h2>
			<c:if test="${!empty member_session }">
			<div class="global-user"><c:out value="${member_session.member_name }"/>님 반갑습니다.</div>
			</c:if>
			<div class="breadcrumbs"><span class="breadcrumbs__list">HOME</span><span class="breadcrumbs__list">
			<c:choose>
			<c:when test="${fn:contains(url1,  'web/hanmadang')}">포스코 한마당 소개</c:when>
			<c:when test="${fn:contains(url1,  'web/map')}">찾아오시는길</c:when>
			<c:when test="${fn:contains(url1,  'web/program')}">프로그램소개</c:when>
			<c:when test="${fn:contains(url1,  'web/lecture')}">수강신청</c:when>
			<c:when test="${fn:contains(url1,  'web/reserve')}">대관신청</c:when>
			<c:when test="${fn:contains(url1,  'web/my')}">마이페이지</c:when>
			<c:when test="${fn:contains(url1,  'web/news')}">한마당 새소식</c:when>
			<c:otherwise>
			
			</c:otherwise>
			</c:choose>
			</span></div>
		</div>
	</div>
	<!-- //header -->