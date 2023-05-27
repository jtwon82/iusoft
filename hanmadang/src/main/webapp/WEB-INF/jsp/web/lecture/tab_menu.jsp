<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%String my_menu = request.getServletPath(); 
%>
<c:set value="<%=my_menu %>" var="my_menu"/>
				<ul>
					<li class="by-5 <c:if test="${fn:contains(my_menu,  'lecture_info.jsp')}"> is-selected </c:if>"><a href="/lecture/info">수강신청 안내</a></li>
					<li class="by-5 <c:if test="${fn:contains(my_menu,  'lecture_user_')}"> is-selected </c:if>"><a href="/lecture/status">수강신청</a></li>
					<li class="by-5 <c:if test="${fn:contains(my_menu,  'lecture_class.jsp')}"> is-selected </c:if>"><a href="/lecture/list">수강신청내역조회</a></li>
					<li class="by-5 <c:if test="${fn:contains(my_menu,  'lecture_class_list.jsp')}"> is-selected </c:if>"><a href="/lecture/result">선정자발표</a></li>
					<li class="by-5 <c:if test="${fn:contains(my_menu,  'lecture_pay.jsp')}"> is-selected </c:if>"><a href="/lecture/pay">온라인 결제 안내</a></li>
				</ul>