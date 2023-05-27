<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%String url1 = request.getServletPath(); %>
<c:set value="<%=url1 %>" var="url1"/>

			<div class="float-menu">
				<h1><a href="${ADMIN_PATH}/main"><img src="/admin/assets/img/h1-logo.png" alt="" /></a></h1>
				<div class="login-user">안녕하세요. <strong><c:out value="${admin_session.name }"/></strong> 님
					<a href="${ADMIN_PATH}/logout">로그아웃</a><a href="${ADMIN_PATH}/login/pw">비밀번호 변경</a>
				</div>

				<div class="menu-link">
					<ul>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',content')}">
						<li <c:if test="${fn:contains(url1,  'admin/content')}"> class="is-selected" </c:if>><a href="${ADMIN_PATH}/content/banner">컨텐츠 관리</a></li>
						</c:if>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',member')}">
						<li <c:if test="${fn:contains(url1,  'admin/employee')}"> class="is-selected" </c:if>><a href="${ADMIN_PATH}/employee/list">직원 관리</a></li>
						</c:if>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',lecture')}">
						<li<c:if test="${fn:contains(url1,  'admin/lecture')}"> class="is-selected" </c:if>><a href="${ADMIN_PATH}/entry/info">수강신청 관리</a></li>
						</c:if>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',class')}">
						<li<c:if test="${fn:contains(url1,  'admin/class')}"> class="is-selected" </c:if>><a href="${ADMIN_PATH}/class/list">수강신청 조회</a></li>
						</c:if>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',rent')}">
						<li <c:if test="${fn:contains(url1,  'admin/rent')}"> class="is-selected" </c:if>><a href="${ADMIN_PATH}/rent/reserve/time/15">대관 관리</a></li>
						</c:if>
						<%-- <c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',stats')}">
						<li><a href="javascript:alert('준비중입니다.');">통계</a></li>
						</c:if> --%>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',gym')}">
						<li><a href="javascript:alert('준비중입니다.');">스마트짐 분석</a></li>
						</c:if>
						<c:if test="${fn:contains(admin_session.path_role, 'all') or fn:contains(admin_session.path_role, ',admin')}">
						<li <c:if test="${fn:contains(url1,  'admin/role')}"> class="is-selected" </c:if>><a href="${ADMIN_PATH}/role/list">관리자 관리</a></li>
						</c:if>
					</ul>
				</div>

			</div>
