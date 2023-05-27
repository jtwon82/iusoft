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
						<h2>수강신청 조회</h2>
					</article>
					<div class="container-tabs">
						<%-- <%@ include file="tab_menu.jsp"%> --%>
					</div>
					<article class="container-body">
						<h3 class="h3-title">수강신청 회원 리스트 검색 </h3>
						<div class="h3-desc">항목별로 수강신청 회원을 검색할 수 있습니다.</div>

						<h3 class="h3-title">수강신청 회원 검색</h3>
						
						<form id="class_search" method="post" action="${ADMIN_PATH}/class/list">
						<input type="hidden" name="b_cate" value="<c:out value="${param.b_cate }"/>"/>
						<input type="hidden" name="em_type" value="<c:out value="${param.em_type }"/>"/>
						<input type="hidden" name="class_yn" value="<c:out value="${param.class_yn }"/>"/>
						
						<h3 class="tab-title">운동 종목</h3>
						<div class="rent-tabs sub-tabs">
							<a href="#none" data-value="00" class="select-class-cate by-6 <c:if test="${empty param.b_cate or param.b_cate == '00' }">is-selected</c:if>"><span>전체</span></a>
							<c:forEach items="${mainClass }" var="item" varStatus="status">	
							<a href="#none" data-value="<c:out value="${item.b_cate}"/>" class="select-class-cate by-6 <c:if test="${param.b_cate == item.b_cate }">is-selected</c:if>"><span><c:out value="${item.class_name}"/></span></a>
						</c:forEach>
						</div>
						<h3 class="tab-title">회원구분</h3>
						<div class="rent-tabs sub-tabs">
							<a href="#none" data-value="00" class="select-class-member by-4 <c:if test="${empty param.em_type or param.em_type == '00' }">is-selected</c:if>"><span>전체</span></a>
							<a href="#none" data-value="01" class="select-class-member by-4 <c:if test="${param.em_type == '01' }">is-selected</c:if>"><span>정회원</span></a>
							<a href="#none" data-value="02" class="select-class-member by-4 <c:if test="${param.em_type == '02' }">is-selected</c:if>"><span>준회원</span></a>
							<a href="#none" data-value="03" class="select-class-member by-4 <c:if test="${param.em_type == '03' }">is-selected</c:if>"><span>일반회원</span></a>
						</div>

						<h3 class="tab-title">상세검색</h3>
						<div class="search-box">
							<span class="selectbox selectbox--type1">
								<select name="op">
									<option value="all" <c:if test="${empty param.op or param.op == 'all' }">selected</c:if>>전체</option>
									<option value="e_name" <c:if test="${param.op == 'e_name' }">selected</c:if>>직원명</option>
									<option value="o_name" <c:if test="${param.op == 'o_name' }">selected</c:if>>이용자명</option>
									<option value="e_no" <c:if test="${param.op == 'e_no' }">selected</c:if>>사원번호</option>
									<option value="class_name" <c:if test="${param.op == 'class_name' }">selected</c:if>>클래스명</option>
								</select>
							</span>

							<input type="text" name="keyword" class="text" id="search-lecture" placeholder="검색어 입력" value="<c:out value="${param.keyword }"/>"/>
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-default btn-level2">검색하기</button>
						</div>
						</form>
						
						<form id="listForm" method="post" action="${ADMIN_PATH}/entry/apply/result/change">
						<!-- 우선선정자일경우// -->
						<h3 class="h3-title">수강신청 회원 리스트</h3>
						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="3%">
									<col width="*">
									<col width="6%">
									<col width="8%">
									<col width="7%">
									<col width="7%">
									<col width="11%">
									<col width="5%">
									<col width="6%">
									<col width="20%">
									<col width="5%">
									<col width="5%">
								</colgroup>
								<thead>
									<tr>
										<th>순번</th>
										<th>운동종목</th>
										<th>강좌명</th>
										<th>수강시간</th>
										<th>회원구분</th>
										<th>이용자명</th>
										<th>전화번호</th>
										<th>직번</th>
										<th>직원명</th>
										<th>부서명</th>
										<th>관계</th>
										<th>성별</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.rownum}"/></td>
										<td><c:out value="${item.classInfo.b_cate_name}"/></td>
										<td><c:out value="${item.classInfo.class_name}"/></td>
										<td><c:out value="${item.classInfo.class_time}"/></td>
										<td>
										<c:choose>
										<c:when test="${item.em_type == '01' }">정회원</c:when>
										<c:when test="${item.em_type == '02' }">준회원</c:when>
										<c:otherwise>
										일반회원
										</c:otherwise>
										</c:choose>
										</td>
										<td><c:out value="${item.o_name}"/></td>
										<td><c:out value="${item.hp}"/></td>
										<td><c:out value="${item.e_no}"/></td>
										<td><c:out value="${item.e_name}"/></td>
										<td><c:out value="${item.partname}"/></td>
										<td><c:out value="${item.mem_type}"/></td>
										
										<c:choose>
										<c:when test="${item.gender == 0 }">
										<td>남</td>
										</c:when>
										<c:when test="${item.gender == 1 }">
										<td>여</td>
										</c:when>
										<c:otherwise>
										<td></td>
										</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
								</c:if>
								</tbody>
							</table>
						</div>
						<div class="btn-group">
							<a href="${ADMIN_PATH}/class/excel" class="btn btn-level1 btn-register">엑셀로 다운로드받기</a>
						</div>
						</form>
						<c:if test="${not empty list }">
						<%@ include file="../common/paging.jsp"%>
						</c:if>
					</article>
				</div>
			</div>
		</div>
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script type="text/javascript">

$(function(){
	$(".select-class-cate").on("click", function(){
		
		$('.select-class-cate').each(function(index) { 
			$(this).removeClass("is-selected")
		});
		$(this).addClass("is-selected")
		
		var value = $(this).data("value");
		$("#class_search").find('input[name="b_cate"]').val(value);
	});

	$(".select-class-member").on("click", function(){
		
		$('.select-class-member').each(function(index) { 
			$(this).removeClass("is-selected")
		});
		$(this).addClass("is-selected")
		
		var value = $(this).data("value");
		$("#class_search").find('input[name="em_type"]').val(value);
	});
});
</script>
</body>
</html>