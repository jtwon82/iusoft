<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>포스코 한마당 - 관리자</title>
<script src="/admin/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>
				<div class="modal-wide__body">
					<div class="modal-wide__contents">
						<p class="modal-wide-title">시간대별 상세 내역 보기</p>
						<div class="modal-wide__scroll">

							<div class="table-basic">
								<table class="table-basic-type2">
									<colgroup>
										<col width="*">
										<col width="150px">
										<col width="150px">
										<col width="150px">
									</colgroup>
									<thead>
										<tr>
											<th>동호회명</th>
											<th>신청수</th>
											<th>선정수</th>
											<th>30일 누적 선정수</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${list }" var="item" varStatus="status">
										<tr>
											<td class="col-left"><c:out value="${item.cl_name }"/> </td>
											<td><c:out value="${item.rt_court_cnt }"/></td>
											<td><c:out value="${empty item.rt_court ? 0 : fn:length(fn:split(item.rt_court,','))}"/></td>
											<td><c:out value="${item.court_cnt }"/></td>
										</tr>
									</c:forEach>	
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
</body>
</html>