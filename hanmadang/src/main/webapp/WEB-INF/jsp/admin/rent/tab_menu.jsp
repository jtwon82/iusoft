<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%String my_menu = request.getServletPath(); 
%>
<c:set value="<%=my_menu %>" var="my_menu"/>
				<a href="${ADMIN_PATH}/rent/reserve/time/15" class="by-6 <c:if test="${fn:contains(my_menu,  'reserve-')}"> is-selected </c:if>">예약현황</a>
				<a href="${ADMIN_PATH}/rent/state/15" class="by-6 <c:if test="${fn:contains(my_menu,  'state')}"> is-selected </c:if>">현재 이용 현황</a>
				<a href="${ADMIN_PATH}/rent/draw" class="by-6 <c:if test="${fn:contains(my_menu,  'draw')}"> is-selected </c:if>">추첨관리</a>
				<a href="${ADMIN_PATH}/rent/off" class="by-6 <c:if test="${fn:contains(my_menu,  'off')}"> is-selected </c:if>">휴관일 관리</a>
				<a href="${ADMIN_PATH}/rent/stats/all" class="by-6 <c:if test="${fn:contains(my_menu,  'stats-')}"> is-selected </c:if>">통계</a>
				<a href="${ADMIN_PATH}/rent/team/list" class="by-6 <c:if test="${fn:contains(my_menu,  'team-list.jsp')}"> is-selected </c:if>">동호회 관리</a>