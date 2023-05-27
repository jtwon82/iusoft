<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당 - 관리자</title>
<link rel="stylesheet" type="text/css" href="/admin/assets/css/style.css">
<link rel="stylesheet" type="text/css" href="/admin/assets/css/admin.css">
<!--[if lt IE 9]>
<script src="/admin/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/admin/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/lib/jquery-ui-datepicker-1.12.1.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- contents -->
	<main id="admin-sub" role="main">
		<div class="admin-page">
			<%@ include file="../common/menu.jsp"%>
			<div class="page-wrap">
				<div id="page-inner">
					<article class="container-header">
						<h2>대관관리</h2>
					</article>
					<div class="container-tabs">
						<%@ include file="tab_menu.jsp"%>
					</div>
					<article class="container-body">

						<div class="timebox-big"><c:out value="${date }"/></div>
						<p class="noti-text no-top">현 시각 이용자 현황입니다.</p>

						<div class="calendar-by-1">
							<h3 class="tab-title">시설 선택</h3>
							<div class="rent-tabs ">
								<a href="${ADMIN_PATH}/rent/state/15" class="by-3 <c:if test="${part_cd == 15}"> is-selected </c:if>"><span>주경기장(배드민턴)</span></a>
								<a href="${ADMIN_PATH}/rent/state/16" class="by-3 <c:if test="${part_cd == 16}"> is-selected </c:if>"><span>탁구장</span></a>
								<a href="${ADMIN_PATH}/rent/state/17" class="by-3 <c:if test="${part_cd == 17}"> is-selected </c:if>"><span>당구장</span></a>
							</div>
						</div>

						<div class="calendar-body">
							<div class="calendar-week">
							<c:if test="${part_cd == 15 }"> 
								<div class="table-basic table-basic-type3" style="width:100%">
									<p class="table-state">총 <c:out value="${fn:length(list) }"/>코트 이용중입니다.</p>
									<table>
										<colgroup><col width="*"><col width="14%"><col width="14%"><col width="14%"><col width="14%"><col width="14%"><col width="14%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>위치</th>
												<th class="bg-title">1코트</th>
												<th class="bg-title">2코트</th>
												<th class="bg-title">3코트</th>
												<th class="bg-title">4코트</th>
												<th class="bg-title">5코트</th>
												<th class="bg-title">6코트</th>
											</tr>
										</thead>
										<tbody>
											<tr>
											<td>예약날짜</td>
											<c:forEach var="i" begin="1" end="6" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${!((i == 1 and fn:contains(item.rt_court, '11')) or (i == 2 and fn:contains(item.rt_court, '12')) ) }">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
													<td><c:out value="${item.re_wdate }"/></td>
														<%-- <td><fmt:formatDate value="${item.re_wdate}" pattern="yyyy-MM-dd"/></td> --%>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>			
											<tr>
											<td>회원 구분</td>
											<c:forEach var="i" begin="1" end="6" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${!((i == 1 and fn:contains(item.rt_court, '11')) or (i == 2 and fn:contains(item.rt_court, '12')) ) }">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td>강습</td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td>동호회</td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td>직원</td>
														</c:when>
														<c:otherwise>
														<td>회사행사</td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
											<tr>
											<td>이용자명/동호회명</td>
											<c:forEach var="i" begin="1" end="6" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${!((i == 1 and fn:contains(item.rt_court, '11')) or (i == 2 and fn:contains(item.rt_court, '12')) ) }">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td><c:out value="${item.re_title}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td><c:out value="${item.cl_name}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td><c:out value="${item.re_name}"/></td>
														</c:when>
														<c:otherwise>
														<td><c:out value="${item.re_title}"/></td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
										</tbody>
									</table>
								</div>

								<div class="table-basic table-basic-type3" style="width:100%">
									<table>
										<colgroup><col width="*"><col width="14%"><col width="14%"><col width="14%"><col width="14%"><col width="14%"><col width="14%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>위치</th>
												<th class="bg-title">7코트</th>
												<th class="bg-title">8코트</th>
												<th class="bg-title">9코트</th>
												<th class="bg-title">10코트</th>
												<th class="bg-title">11코트</th>
												<th class="bg-title">12코트</th>
											</tr>
										</thead>
										<tbody>
											<tr>
											<td>예약날짜</td>
											<c:forEach var="i" begin="7" end="12" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<td><c:out value="${item.re_wdate }"/></td>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
												<tr>
											<td>회원 구분</td>
											<c:forEach var="i" begin="7" end="12" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td>강습</td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td>동호회</td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td>직원</td>
														</c:when>
														<c:otherwise>
														<td>회사행사</td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
											<tr>
											<td>이용자명/동호회명</td>
											<c:forEach var="i" begin="7" end="12" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td><c:out value="${item.re_title}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td><c:out value="${item.cl_name}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td><c:out value="${item.re_name}"/></td>
														</c:when>
														<c:otherwise>
														<td><c:out value="${item.re_title}"/></td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
											
										</tbody>
									</table>
								</div>
								</c:if>
								
							<c:if test="${part_cd == 16 }"> 
								<div class="table-basic table-basic-type3" style="width:100%">
									<p class="table-state">총 <c:out value="${fn:length(list) }"/>코트 이용중입니다.</p>
									<table>
										<colgroup><col width="*"><col width="13%"><col width="13%"><col width="13%"><col width="13%"><col width="13%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>위치</th>
												<th class="bg-title">신발장</th>
												<th class="bg-title">2코트</th>
												<th class="bg-title">3코트</th>
												<th class="bg-title">4코트</th>
												<th class="bg-title">5코트</th>
												<th class="bg-title">6코트</th>
											</tr>
										</thead>
										<tbody>
											<tr>
											<td>예약날짜</td>
											<c:forEach var="i" begin="1" end="6" step="1">
												<c:set var="exist_flag" value="0" /> 
												<c:choose>
												<c:when test="${i == 11 }">
												<c:set var="str_i" value="A코트" /> 
												</c:when>
												<c:when test="${i == 12 }">
												<c:set var="str_i" value="B코트" /> 
												</c:when>
												<c:otherwise>
												<c:set var="str_i" value="${i}코트" /> 
												</c:otherwise>
												</c:choose>
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
													<td><c:out value="${item.re_wdate }"/></td>
														<%-- <td><fmt:formatDate value="${item.re_wdate}" pattern="yyyy-MM-dd"/></td> --%>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>			
											<tr>
											<td>회원 구분</td>
											<c:forEach var="i" begin="1" end="6" step="1">
												<c:set var="exist_flag" value="0" /> 
												<c:choose>
												<c:when test="${i == 11 }">
												<c:set var="str_i" value="A코트" /> 
												</c:when>
												<c:when test="${i == 12 }">
												<c:set var="str_i" value="B코트" /> 
												</c:when>
												<c:otherwise>
												<c:set var="str_i" value="${i}코트" /> 
												</c:otherwise>
												</c:choose>
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td>강습</td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td>동호회</td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td>직원</td>
														</c:when>
														<c:otherwise>
														<td>회사행사</td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
											<tr>
											<td>이용자명/동호회명</td>
											<c:forEach var="i" begin="1" end="6" step="1">
												<c:set var="exist_flag" value="0" /> 
												<c:choose>
												<c:when test="${i == 11 }">
												<c:set var="str_i" value="A코트" /> 
												</c:when>
												<c:when test="${i == 12 }">
												<c:set var="str_i" value="B코트" /> 
												</c:when>
												<c:otherwise>
												<c:set var="str_i" value="${i}코트" /> 
												</c:otherwise>
												</c:choose>
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td><c:out value="${item.re_title}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td><c:out value="${item.cl_name}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td><c:out value="${item.re_name}"/></td>
														</c:when>
														<c:otherwise>
														<td><c:out value="${item.re_title}"/></td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
										</tbody>
									</table>
								</div>

								<div class="table-basic table-basic-type3" style="width:100%">
									<table>
										<colgroup><col width="*"><col width="13%"><col width="13%"><col width="13%"><col width="13%"><col width="13%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>위치</th>
												<th class="bg-title">7코트</th>
												<th class="bg-title">8코트</th>
												<th class="bg-title">9코트</th>
												<th class="bg-title">10코트</th>
												<th class="bg-title">11코트</th>
												<th class="bg-title">12코트</th>
											</tr>
										</thead>
										<tbody>
											<tr>
											<td>예약날짜</td>
											<c:forEach var="i" begin="7" end="12" step="1">
												<c:set var="exist_flag" value="0" /> 
												<c:choose>
												<c:when test="${i == 11 }">
												<c:set var="str_i" value="A코트" /> 
												</c:when>
												<c:when test="${i == 12 }">
												<c:set var="str_i" value="B코트" /> 
												</c:when>
												<c:otherwise>
												<c:set var="str_i" value="${i}코트" /> 
												</c:otherwise>
												</c:choose>
												
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<td><c:out value="${item.re_wdate }"/></td>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
												<tr>
											<td>회원 구분</td>
											<c:forEach var="i" begin="7" end="12" step="1">
												<c:set var="exist_flag" value="0" /> 
												<c:choose>
												<c:when test="${i == 11 }">
												<c:set var="str_i" value="A코트" /> 
												</c:when>
												<c:when test="${i == 12 }">
												<c:set var="str_i" value="B코트" /> 
												</c:when>
												<c:otherwise>
												<c:set var="str_i" value="${i}코트" /> 
												</c:otherwise>
												</c:choose>
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td>강습</td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td>동호회</td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td>직원</td>
														</c:when>
														<c:otherwise>
														<td>회사행사</td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
											<tr>
											<td>이용자명/동호회명</td>
											<c:forEach var="i" begin="7" end="12" step="1">
												<c:set var="exist_flag" value="0" /> 
												<c:choose>
												<c:when test="${i == 11 }">
												<c:set var="str_i" value="A코트" /> 
												</c:when>
												<c:when test="${i == 12 }">
												<c:set var="str_i" value="B코트" /> 
												</c:when>
												<c:otherwise>
												<c:set var="str_i" value="${i}코트" /> 
												</c:otherwise>
												</c:choose>
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td><c:out value="${item.re_title}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td><c:out value="${item.cl_name}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td><c:out value="${item.re_name}"/></td>
														</c:when>
														<c:otherwise>
														<td><c:out value="${item.re_title}"/></td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
											
										</tbody>
									</table>
								</div>
								</c:if>
								
								<c:if test="${part_cd == 17 }"> 
								<div class="table-basic table-basic-type3" style="width:100%">
									<p class="table-state">총 <c:out value="${fn:length(list) }"/>코트 이용중입니다.</p>
									<table>
										<colgroup><col width="*"><col width="15%"><col width="15%"><col width="15%"><col width="15%"><col width="15%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>위치</th>
												<th class="bg-title">1특대</th>
												<th class="bg-title">2중대</th>
												<th class="bg-title">3중대</th>
												<th class="bg-title">4중대</th>
												<th class="bg-title">5중대</th>
											</tr>
										</thead>
										<tbody>
											<tr>
											<td>예약날짜</td>
											<c:forEach var="i" begin="1" end="5" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
													<td><c:out value="${item.re_wdate }"/></td>
														<%-- <td><fmt:formatDate value="${item.re_wdate}" pattern="yyyy-MM-dd"/></td> --%>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>			
											<tr>
											<td>회원 구분</td>
											<c:forEach var="i" begin="1" end="5" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td>강습</td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td>동호회</td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td>직원</td>
														</c:when>
														<c:otherwise>
														<td>회사행사</td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
											<tr>
											<td>이용자명/동호회명</td>
											<c:forEach var="i" begin="1" end="5" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td><c:out value="${item.re_title}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td><c:out value="${item.cl_name}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td><c:out value="${item.re_name}"/></td>
														</c:when>
														<c:otherwise>
														<td><c:out value="${item.re_title}"/></td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
										</tbody>
									</table>
								</div>

								<div class="table-basic table-basic-type3" style="width:100%">
									<table>
										<colgroup><col width="*"><col width="15%"><col width="15%"><col width="15%"><col width="15%"><col width="15%"></colgroup>
										<thead>
											<tr class="no-head">
												<th>위치</th>
												<th class="bg-title">6중대</th>
												<th class="bg-title">7중대</th>
												<th class="bg-title">8중대</th>
												<th class="bg-title">9포켓</th>
												<th class="bg-title"></th>
											</tr>
										</thead>
										<tbody>
											<tr>
											<td>예약날짜</td>
											<c:forEach var="i" begin="6" end="10" step="1">
													<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<td><c:out value="${item.re_wdate }"/></td>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
												<tr>
											<td>회원 구분</td>
											<c:forEach var="i" begin="6" end="10" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td>강습</td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td>동호회</td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td>직원</td>
														</c:when>
														<c:otherwise>
														<td>회사행사</td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
												
											<tr>
											<td>이용자명/동호회명</td>
											<c:forEach var="i" begin="6" end="10" step="1">
											<c:set var="exist_flag" value="0" />
													<c:set var="str_i" value="${i}코트" /> 
												<c:forEach items="${list }" var="item" varStatus="status">
													<c:if test="${fn:contains(item.rt_court, str_i) }">
														<c:choose>
														<c:when test="${item.re_type == 'lecture' }">
														<td><c:out value="${item.re_title}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'team' }">
														<td><c:out value="${item.cl_name}"/></td>
														</c:when>
														<c:when test="${item.re_type == 'employee' }">
														<td><c:out value="${item.re_name}"/></td>
														</c:when>
														<c:otherwise>
														<td><c:out value="${item.re_title}"/></td>
														</c:otherwise>
														</c:choose>
														<c:set var="exist_flag" value="1" /> 
													</c:if>
												</c:forEach>
												<c:if test="${exist_flag == 0}">
												<td></td>
												</c:if>
											</c:forEach>
												</tr>
											
										</tbody>
									</table>
								</div>
								</c:if>
								
									
							</div>
						</div>
					</article>
				</div>
			</div>
		</div>

	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
</body>
</html>