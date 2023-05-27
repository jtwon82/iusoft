<%@ page contentType = "text/html;charset=utf-8" %>
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
						<h2>컨텐츠 관리</h2>
					</article>
					<div class="container-tabs">
						<a href="${ADMIN_PATH}/content/banner" class="by-4">배너 관리</a>
						<a href="${ADMIN_PATH}/content/popup" class="by-4">팝업 관리</a>
						<a href="${ADMIN_PATH}/content/notice" class="by-4">공지사항 관리</a>
						<a href="${ADMIN_PATH}/content/program" class="by-4 is-selected">프로그램 관리</a>
					</div>
					<article class="container-body">
						<h3 class="h3-title">프로그램 지도강사 등록</h3>
						<div class="h3-desc">홈페이지 > 프로그램 안내 페이지 내 소개되는 지도강사를 지정합니다.</div>

						<h3 class="h3-title">종목 선택</h3>
						<div class="rent-tabs">
							<a href="program?type=1" class="by-8 <c:if test="${type == 1 }">is-selected</c:if>"><span>스쿼시</span></a>
							<a href="program?type=2" class="by-8 <c:if test="${type == 2 }">is-selected</c:if>"><span>에어로빅</span></a>
							<a href="program?type=3" class="by-8 <c:if test="${type == 3 }">is-selected</c:if>"><span>요가</span></a>
							<a href="program?type=4" class="by-8 <c:if test="${type == 4 }">is-selected</c:if>"><span>다이어트 댄스</span></a>
							<a href="program?type=5" class="by-8 <c:if test="${type == 5 }">is-selected</c:if>"><span>밸리댄스</span></a>
							<a href="program?type=6" class="by-8 <c:if test="${type == 6 }">is-selected</c:if>"><span>스피닝</span></a>
							<a href="program?type=7" class="by-8 <c:if test="${type == 7 }">is-selected</c:if>"><span>다이어트 발레</span></a>
							<a href="program?type=100" class="by-8 <c:if test="${type == 100 }">is-selected</c:if>"><span>1:1강습</span></a>
						</div>
						<!-- or ▼▼▼<br>
						<div class="rent-tabs">
							<a href="#" class="by-8 is-selected"><span>스쿼시</span></a>
							<a href="#" class="by-8"><span>에어로빅</span></a>
							<a href="#" class="by-8"><span>요가</span></a>
							<a href="#" class="by-8"><span>다이어트 댄스</span></a>
							<a href="#" class="by-8"><span>밸리댄스</span></a>
							<a href="#" class="by-8"><span>스피닝</span></a>
							<a href="#" class="by-8"><span>다이어트 발레</span></a>
							<a href="#" class="by-8"><span>1:1강습</span></a>
						</div>
						else ▼▼▼<br>
						<div class="rent-tabs">
							<a href="#" class="by-3 "><span>전체 운영시간</span></a>
							<a href="#" class="by-3 is-selected"><span>수강 프로그램 시간</span></a>
							<a href="#" class="by-3"><span>1:1 강습 시간</span></a>
						</div> -->

						<h3 class="h3-title">지도강사 리스트</h3>
						<p class="h3-btn"><a href="#" class="btn btn-level0 btn-default">수정하기</a>
							<!-- <a href="#" class="btn btn-level0 btn-complete">수정완료</a> -->
						</p>
						<div style="width:100%;min-height:300px; padding:0; background:#eee; border:4px double #ccc;">
							<div style="margin:30px; background:#fff;">

								<strong>!!EDIT AREA - front table PREVIEW</strong>
								<!-- front table 반영시// -->
								<div class="table-basic table-basic-type3">
									<table>
										<caption>스쿼시에 대한 정보제공</caption>
										<colgroup>
											<col width="190px">
											<col width="190px">
											<col width="*">
											<col width="200px">
											<col width="180px">
											<col width="200px">
										</colgroup>
										<thead>
											<tr class="no-head">
												<th>강습요일</th>
												<th>시간</th>
												<th>지도강사</th>
												<th>장소</th>
												<th>강습내용</th>
												<th>정원</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td rowspan="7">월 ~ 금<br>(강습시간)</td>
												<td>09 : 00</td>
												<td rowspan="3">박재혁</td>
												<td rowspan="7">스쿼시장 (1층)</td>
												<td><span class="cl-program">초급</span></td>
												<td rowspan="7">100 명<br><br>강습별인원<br>(각 10명)<br><br><span class="cl-program">분기에 따라 <br>오전 / 오후 강사변동</span></td>
											</tr>
											<tr>
												<td>10 : 00</td>
												<td><span class="cl-program">초급</span></td>
											</tr>
											<tr>
												<td>11 : 00</td>
												<td><span class="cl-program">중급</span></td>
											</tr>
											<tr>
												<td>15 : 30</td>
												<td rowspan="4">김영빈</td>
												<td><span class="cl-program">초급</span></td>
											</tr>
											<tr>
												<td>16 : 30</td>
												<td><span class="cl-program">증급</span></td>
											</tr>
											<tr>
												<td>19 : 30</td>
												<td><span class="cl-program">초급</span></td>
											</tr>
											<tr>
												<td>20 : 30</td>
												<td><span class="cl-program">중급</span></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- front table 반영시// -->

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