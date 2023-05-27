<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%String my_menu = request.getServletPath(); 
%>
<c:set value="<%=my_menu %>" var="my_menu"/>
				<a href="${ADMIN_PATH}/entry/info" class="by-5 <c:if test="${fn:contains(my_menu,  'lecture-list')}"> is-selected </c:if>">수강신청 내용 관리</a>
				<a href="${ADMIN_PATH}/entry/apply/list" class="by-5 <c:if test="${fn:contains(my_menu,  '-member-list')}"> is-selected </c:if>">수강신청회원 리스트</a>
				<a href="${ADMIN_PATH}/entry/draw/list" class="by-5 <c:if test="${fn:contains(my_menu,  'lecture-draw')}"> is-selected </c:if>">추첨관리</a>
				<a href="${ADMIN_PATH}/entry/result/list" class="by-5 <c:if test="${fn:contains(my_menu,  'lecture-standby')}"> is-selected </c:if>">선정/대기자 리스트</a>
				<a href="${ADMIN_PATH}/entry/before/list" class="by-5 <c:if test="${fn:contains(my_menu,  'lecture-before')}"> is-selected </c:if>">지난 데이타</a>
				<!-- <a href="lecture-pay.html" class="by-5 ">수강 결제확인/등록 관리</a> -->