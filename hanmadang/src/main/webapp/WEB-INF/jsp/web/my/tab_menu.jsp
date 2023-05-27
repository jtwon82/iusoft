<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%String my_menu = request.getServletPath(); %>
<c:set value="<%=my_menu %>" var="my_menu"/>

			<ul>
				<li class="by-4 <c:if test="${fn:contains(my_menu,  'my/my_smart')}"> is-selected </c:if>"><a href="/my/smart">스마트짐</a></li>
				<li class="by-4 <c:if test="${fn:contains(my_menu,  'my/my_lecture_list')}"> is-selected </c:if>"><a href="/my/lecture">수강 등록 및 내역</a></li>
				<li class="by-4 <c:if test="${fn:contains(my_menu,  'my/my_pw')}"> is-selected </c:if>"><a href="/my/pw/change">비밀번호 변경</a></li>
				<li class="by-4 <c:if test="${fn:contains(my_menu,  'my/my_leave')}"> is-selected </c:if>"><a href="/my/leave">회원탈퇴</a></li>
			</ul>