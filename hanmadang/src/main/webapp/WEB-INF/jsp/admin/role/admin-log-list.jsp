<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
						<h2>관리자 관리</h2>
					</article>
					<div class="container-tabs">
						<a href="${ADMIN_PATH}/role/list" class="by-2">관리자 계정 관리</a>
						<a href="${ADMIN_PATH}/role/log/list" class="by-2 is-selected">관리자 활동 로그</a>
					</div>
					
					<article class="container-body">
						<h3 class="h3-title">관리자 활동 로그</h3>
						<div class="h3-desc">관리자 활동 로그를 확인할 수 있습니다.</div>

						<h3 class="h3-title">관리자  리스트 (<c:out value="${paging.totalEntryCount}"/>)</h3>

						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="120px">
									<col width="120px">
									<col width="150px">
									<%-- <col width="200px"> --%>
									<col width="*">
									<col width="150px">
								</colgroup>
								<thead>
									<tr>
										<th>아이디</th>
										<th>이름</th>
										<th>아이피</th>
										<!-- <th>접근URL</th> -->
										<th>활동내역</th>
										<th>일시</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.id}"/></td>
										<td><c:out value="${item.name}"/></td>
										<td><c:out value="${item.ip}"/></td>
										<td>
										<c:choose>
											<c:when test="${fn:contains(item.action, 'login') }">로그인</c:when>
											<c:when test="${fn:contains(item.action, 'logout') }">로그아웃</c:when>
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/main') }">메인</c:when>
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/login/pw') }">비밀번호 변경</c:when>
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/file/upload') }">이미지 업로드</c:when>
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/employee') }">
												<c:choose>
													<c:when test="${fn:contains(item.action, 'save/file') }">직원목록 업데이트</c:when>
													<c:when test="${fn:contains(item.action, '/save') }">직원정보 추가 및 수정</c:when>
													<c:when test="${fn:contains(item.action, '/delete') }">직원정보 삭제</c:when>
													<c:otherwise>직원 관리 조회</c:otherwise>
												</c:choose>
											</c:when>
											
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/class/list') }">수강신청 조회</c:when>
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/rent') }">
												<c:choose>
													<c:when test="${fn:contains(item.action, 'time/save') }">대관예약 추가</c:when>
													<c:when test="${fn:contains(item.action, 'reserve/cancel') }">대관예약 취소</c:when>
													<c:when test="${fn:contains(item.action, 'lecture/cancel') }">고정강좌 취소</c:when>
													<c:when test="${fn:contains(item.action, 'off/add') }">휴관일 추가</c:when>
													<c:when test="${fn:contains(item.action, 'team/save') }">동호회 추가 및 수정</c:when>
													<c:when test="${fn:contains(item.action, 'draw/go') }">대관 수동 추첨</c:when>
													<c:when test="${fn:contains(item.action, 'stats/excel') }">대관 통계 엑셀 다운로드</c:when>
													
													<c:when test="${fn:contains(item.action, '/reserve/time/') }">대관 예약현황 조회</c:when>
													<c:when test="${fn:contains(item.action, '/state/') }">대관 현재이용 현황 조회</c:when>
													<c:when test="${fn:contains(item.action, '/draw') }">대관 추첨관리 조회</c:when>
													<c:when test="${fn:contains(item.action, '/off') }">대관 휴관일 관리 조회</c:when>
													<c:when test="${fn:contains(item.action, '/stats/all') }">대관 통계 조회</c:when>
													<c:when test="${fn:contains(item.action, '/team/list') }">대관 동호회 관리 조회</c:when>
													
													<c:when test="${fn:contains(item.action, '/reserve/lecture') }">고정강좌 취소 조회</c:when>
													<c:when test="${fn:contains(item.action, '/reserve/cancel') }">대관 취소하기 조회</c:when>
													<c:when test="${fn:contains(item.action, '/reserve/go') }">대관 예약하기 조회</c:when>
													<c:otherwise>대관 관리</c:otherwise>
												</c:choose>
											</c:when>
											
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/content/') }">
												<c:choose>
													<c:when test="${fn:contains(item.action, 'notice/save') }">콘텐츠(공지사항) 추가 및 수정</c:when>
													<c:when test="${fn:contains(item.action, 'notice/delete') }">콘텐츠(공지사항) 삭제</c:when>
													<c:when test="${fn:contains(item.action, 'banner/delete') }">콘텐츠(배너) 삭제</c:when>
													<c:when test="${fn:contains(item.action, 'banner/save') }">콘텐츠(배너) 추가 및 수정</c:when>
													<c:when test="${fn:contains(item.action, 'popup/save') }">콘텐츠(팝업) 추가 및 수정</c:when>
													<c:when test="${fn:contains(item.action, 'popup/delete') }">콘텐츠(팝업) 삭제</c:when>
													<c:when test="${fn:contains(item.action, 'program/save') }">콘텐츠(프로그램) 수정</c:when>
													<c:when test="${fn:contains(item.action, '/banner') }">배너관리 조회</c:when>
													<c:when test="${fn:contains(item.action, '/notice') }">공지관리 조회</c:when>
													<c:when test="${fn:contains(item.action, '/popup') }">팝업관리 조회</c:when>
													<c:when test="${fn:contains(item.action, '/program') }">프로그램 관리 조회</c:when>
													<c:otherwise>콘텐츠 관리</c:otherwise>
												</c:choose>
											</c:when>
											
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/entry/') }">
												<c:choose>
													<c:when test="${fn:contains(item.action, 'class/date') }">수강신청 기간 추가</c:when>
													<c:when test="${fn:contains(item.action, 'draw/proc') }">수강신청 추첨</c:when>
													<c:when test="${fn:contains(item.action, 'draw/reset') }">수강신청 추첨 초기화</c:when>
													<c:when test="${fn:contains(item.action, 'draw/factor') }">수강신청 종목별 추첨 조건 변경</c:when>
													<c:when test="${fn:contains(item.action, 'before/list') }">수강신청 지난 선정자 조회</c:when>
													<c:when test="${fn:contains(item.action, 'draw/open') }">수강신청 추첨 선정자 게시</c:when>
													<c:when test="${fn:contains(item.action, 'result/list') }">수강신청 선정자 목록 조회</c:when>
													<c:when test="${fn:contains(item.action, 'apply/result/change') }">수강신청 회원 상태(선정 및 대기) 변경</c:when>
													<c:when test="${fn:contains(item.action, 'apply/result/cancel') }">수강신청 회원 취소처리</c:when>
													<c:when test="${fn:contains(item.action, 'apply/list') }">수강신청 회원 목록 조회</c:when>
													<c:when test="${fn:contains(item.action, 'apply/vip') }">수강신청 VIP 설정</c:when>
													<c:when test="${fn:contains(item.action, 'class/sub/add') }">수강신청 항목 추가</c:when>
													<c:when test="${fn:contains(item.action, 'class/sub/del') }">수강신청 항목 삭제</c:when>
													<c:when test="${fn:contains(item.action, 'class/main/add') }">수강신청 운동종목 추가</c:when>
													<c:when test="${fn:contains(item.action, 'class/main/del') }">수강신청 운동종목 삭제</c:when>
													<c:when test="${fn:contains(item.action, '/info') }">수강신청 내용 관리 조회</c:when>
													<c:when test="${fn:contains(item.action, '/draw/list') }">추첨 관리 조회</c:when>
													<c:otherwise>수강신청 관리</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${fn:contains(item.action, ' role ') }">
												<c:set var="role_split" value="${fn:split(item.action,' ')}" />
												아이디(<c:out value="${role_split[0] }"/>)
												<c:choose>
													<c:when test="${fn:contains(item.action, 'role chg :') }"> 권한 변경</c:when>
													<c:when test="${fn:contains(item.action, 'role add :') }"> 생성</c:when>
													<c:when test="${fn:contains(item.action, 'role del') }"> 삭제</c:when>
												</c:choose>
												
												<c:if test="${!fn:contains(item.action, 'role del') }">
												(<c:if test="${fn:contains(role_split[4], 'all')}">전체,</c:if>
												<c:if test="${fn:contains(role_split[4], ',content')}">컨텐츠관리,</c:if>
												<c:if test="${fn:contains(role_split[4], ',member')}">직원관리,</c:if>
												<c:if test="${fn:contains(role_split[4], ',lecture')}">수강신청 관리,</c:if>
												<c:if test="${fn:contains(role_split[4], ',class')}">수강신청 조회,</c:if>
												<c:if test="${fn:contains(role_split[4], ',rent')}">대관관리,</c:if>
												<c:if test="${fn:contains(role_split[4], ',stats')}">홈페이지분석,</c:if>
												<c:if test="${fn:contains(role_split[4], ',gym')}">스마트짐 분석,</c:if>
												<c:if test="${fn:contains(role_split[4], ',admin')}">관리자 관리,</c:if>)
												</c:if>		
											</c:when>
											<c:when test="${fn:contains(item.action, '${ADMIN_PATH}/role') }">
												<c:choose>
													<c:when test="${fn:contains(item.action, 'save') }">관리자 계정 추가 및 수정</c:when>
													<c:when test="${fn:contains(item.action, 'check') }">관리자 계정 아이디 중복체크</c:when>
													<c:when test="${fn:contains(item.action, 'delete') }">관리자 계정 삭제</c:when>
													<c:when test="${fn:contains(item.action, 'log/list') }">관리자 활동 로그 조회</c:when>
													<c:when test="${fn:contains(item.action, 'role/list') }">관리자 계정 관리 조회</c:when>
													<c:otherwise>관리자 관리</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
											<c:out value="${item.action}"/>
											</c:otherwise>
										</c:choose>
										
										</td>
										<td><c:out value="${fn:substring(item.regidate, 0, 16)}"/></td>
									</tr>
								</c:forEach>
								</c:if>	
								</tbody>
							</table>
						</div>
						<%@ include file="../common/paging.jsp"%>
						<div class="btn-group">
							<a href="${ADMIN_PATH}/role/log/excel" class="btn btn-register btn-level2">최근 1년 엑셀 다운로드</a>
						</div>
					</article>
				</div>
			</div>
		</div>

		<div class="modal-basic js-modal" id="modal-admin-mod"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
		
		</div>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

$(function(){

});

</script>

</body>
</html>