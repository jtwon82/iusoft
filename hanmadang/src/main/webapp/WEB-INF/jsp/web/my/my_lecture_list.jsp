<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당</title>
<link rel="stylesheet" type="text/css" href="/web/assets/css/style.css">
<!--[if lt IE 9]>
<script src="/web/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/web/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/sly.js" type="text/javascript"></script>
<script src="/web/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- skip -->
<%@ include file="../common/skip.jsp"%>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->

	<%@ include file="../common/header.jsp"%>
	<!-- //header -->
	<!-- contents -->
	<main id="contents" role="main">
		<div id="contents-inner">
			<div class="container-tabs cl-my">
				<%@ include file="tab_menu.jsp"%>
			</div>
			<article class="container-notice bg-my">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			
			<article class="container">
				<div class="contents-title">수강결제/등록하기
					<div class="table-btn"><a href="#modal-my-lecture-cancel" class="btn btn-smart btn-level1 js-modal__btn-open">수강 취소 및 환불 규정 보기</a></div>
				</div>
				
				<p class="heading-desc">강좌검색</p>
				<div class="lecture-select">
					<span class="selectbox selectbox--type1">
						<select name="code" onchange="location.replace('/my/lecture?code=' + this.value)">
						<c:forEach items="${proList }" var="item" varStatus="status">
						<option value="<c:out value="${item.detail_code }"/>" <c:if test="${item.detail_code == code }"> selected </c:if>><c:out value="${item.detail_name }"/></option>
						</c:forEach>
						</select>
					</span>
				</div>
				
				<p class="heading-desc">강좌선택</p>
				<div class="table-basic">
					<table class="table-basic-type2 blad-box">
						<caption>강좌선택에 대한 정보제공</caption>
						<colgroup>
							<col width="*">
							<col width="12%">
							<!-- <col width="12%"> -->
							<col width="13%">
							<col width="22%">
						</colgroup>
						<thead>
							<tr>
								<th class="col-left">강좌명</th>
								<th>수강료</th>
								<!-- <th>요일</th> -->
								<th>시간</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list }" var="item" varStatus="status">
						<c:if test="${item.unit_price > 0 }">
							<tr>
								<td class="col-left"><c:out value="${item.program_name }"/></td>
								<td><fmt:formatNumber value="${item.unit_price }" pattern="#,###" /> 원</td>
							<!-- 	<td>-</td> -->
								<td><c:out value="${fn:substring(item.start_time, 0, 2) }"/>:<c:out value="${fn:substring(item.start_time, 2, 4) }"/> ~ <c:out value="${fn:substring(item.end_time, 0, 2) }"/>:<c:out value="${fn:substring(item.end_time, 2, 4) }"/></td>
								<td>
								<c:if test="${pay_active == 1 }">
								<a href="#none" data-value="<c:out value="${item.program_code }"/>" class="btn btn-block btn-smart btn-level0 act-pay">등록/결제하기</a>
								</c:if>
								</td>
							</tr>
						</c:if>
						</c:forEach>
						</tbody>
					</table>
				</div>

				<br><br>

				<div class="contents-title">수강 결제 내역</div>
				<div class="table-basic">
					<table class="table-basic-type2 blad-box">
						<caption>수강신청 내역에 대한 정보제공</caption>
						<colgroup>
							<col width="*">
							<col width="12%">
							<col width="12%">
							<col width="13%">
							<col width="12%">
							<col width="12%">
						</colgroup>
						<thead>
							<tr>
								<th class="col-left">강좌명</th>
								<th>시작일</th>
								<th>종료일</th>
								<th>수강료</th>
								<th>상태</th>
								<th>결제일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${receipt }" var="item" varStatus="status">
							<c:if test="${item.purchase_code == '99'}">
							<tr>
							
							<td class="col-left"><c:out value="${item.program_name }"/></td>
								<td><c:out value="${item.start_date }"/></td>
								<td><c:out value="${item.last_end_date }"/></td>
								<td><fmt:formatNumber value="${item.receive_amount }" pattern="#,###" /> 원</td>
								<c:choose>
								<c:when test="${item.deal_type == 'D2'}">
								<td>거래취소</td>
								</c:when>
								<c:otherwise>
								<%-- <td><a href="https://dev-biz.mainpay.co.kr/card/cardReceipt_popup.do?ref_no=<c:out value="${item.approval_no }"/>&tran_date=<c:out value="${item.approval_date }"/>" target="_blank" class="btn btn-block btn-default btn-level0">영수증 보기</a></td> --%>
								<td><a href="https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noTid=<c:out value="${item.deal_no }"/>&noMethod=1" target="_blank" class="btn btn-block btn-default btn-level0">영수증 보기</a></td>
								<!-- <td><a href="javascript:alert('준비중입니다.');" class="btn btn-block btn-default btn-level0">영수증 보기</a></td> -->
								</c:otherwise>
								</c:choose>
								
								<td><c:out value="${item.sales_date }"/></td>				
							</tr>
							</c:if>
						</c:forEach>
						
							<!-- <tr>
								<td class="col-left">휘트니스(오전반)-3개월[정회원]</td>
								<td>30,000 원</td>
								<td>월 ~ 금요일</td>
								<td>06:00 ~ 13:00</td>
								<td><a href="javascript:alert('준비중입니다.');" class="btn btn-block btn-default btn-level0">영수증 보기</a></td>
								<td>2018-01-31</td>
							</tr> -->
						</tbody>
					</table>
				</div>
			</article>
		</div>

		<div class="modal-basic js-modal" id="modal-my-lecture-cancel"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-smart__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">수강 취소 및 환불 규정 안내</p>
						이용전
						<div class="noti-box">포스코 한마당 체육관  054)221 - 9280 으로 연락 후 취소 처리 가능</div>
						<hr />
						이용후
						<div class="noti-box">포스코 한마당 체육관 현장 방문을 통해 환불신청서 작성 후 제출 온라인
						결제 취소 후 이용금액만큼 재결제 (위약금 10% + 이용일 수 × 일일금액)</div>
						<div class="btn-group">
							<a href="#" class="btn btn-level2 btn-primary js-modal__btn-close">닫기</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->

		<div class="modal-basic js-modal" id="modal-my-lecture-pay"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-smart__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">[정회원] 휘트니스 3개월에 대한<br>결제페이지로 이동하시겠습니까?</p>
						<span class="modal-basic-desc">※이동 버튼 선택시, 결제페이지로 이동합니다.<br>결제를 원치 않으시면 닫기 버튼을 선택해주십시오.</span>
						<div class="btn-group">
							<a href="#" class="js-modal__btn-close btn by-2 btn-level1 btn-select">닫기</a>
							<a href="#" class="btn by-2 btn-level1 btn-smart">이동</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->

	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->
</div>
<!-- //wrapper -->
<script>
function PopupCenter(url, title, w, h) {
    // Fixes dual-screen position                         Most browsers      Firefox
    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
    var top = ((height / 2) - (h / 2)) + dualScreenTop;
    var newWindow = window.open(url, title, 'status=yes,toolbar=no,menubar=no,location=no, scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

    // Puts focus on the newWindow
    if (window.focus) {
        newWindow.focus();
    }
}

$(function(){
	$(".act-pay").on("click", function(){
		/* alert('준비중입니다.'); */
		/* var code = $(this).data("value");
		PopupCenter("/my/lecture/pay/open?code=" + code, null, 740, 485); */
		var code = $(this).data("value");
		PopupCenter("/inipay2/start?code=" + code, null, 870, 740);

	});
});

</script>
</body>
</html>