<%@ page contentType = "text/html;charset=utf-8" %>
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
			<div class="container-tabs cl-lecture">
					<%@ include file="tab_menu.jsp"%>
			</div>
			<article class="container-notice bg-lecture">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			<article class="container">
			
				<form id="modForm" method="post" action="/lecture/result">
				<p class="heading-title">선정자 조회를 위한 정보입력</p>
				<div class="member-form">
					<div class="member-type-input member-type-list">
						<label for="member-name">휴대폰 번호</label>
						<input type="text" name="hp" id="hp_input" class="text" value="<c:out value="${hp }"/>" style="width:380px;" placeholder="- 없이 입력해주십시오" maxLength=11>
					</div>
					<div class="member-type-input member-type-list">
						<label for="add-password">비밀번호</label>
						<input type="password" autocomplete="off" name="pass" class="text" value="<c:out value="${pass }"/>" id="add-password"  style="width:380px;" placeholder="비밀번호 입력">
						<a href="#none" class="btn btn-block btn-search btn-level1 act-search">검색</a>
					</div>
				</div>
				<!-- 수강신청 검색//end -->
				</form>
				
				<p class="heading-title">선정자 리스트</p>
				<div class="table-basic">
					<table class="table-basic-type2">
						<caption>선정자 대한 정보제공</caption>
						<colgroup>
							<col width="7%">
							<col width="*">
							<col width="30%">
							<col width="250px">
							<col width="12%">
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th class="col-left">강좌명</th>
								<th>요일 및 시간</th>
								<th>참여인원/정원</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty list }">
							<c:forEach items="${list }" var="item" varStatus="status">
							<tr>
								<td><c:out value="${item.o_name }"/></td>
								<td class="col-left"><c:out value="${item.classInfo.b_cate_name }"/>(<c:out value="${item.classInfo.class_name }"/>)</td>
								<td><c:out value="${item.classInfo.class_time }"/></td>
								<td>
								<c:set var="allper" value="${(item.classInfo.cur_count >= (item.classInfo.class_a_count + item.classInfo.class_b_count + item.classInfo.class_c_count)) ? 100 : (item.classInfo.cur_count * 100 / (item.classInfo.class_a_count + item.classInfo.class_b_count + item.classInfo.class_c_count))}"/>
									<div class="party-state"><span class="value" style="width:<c:out value="${allper}"/>%"></span></div>
									<span class="party-state-per"><c:out value="${item.classInfo.cur_count }"/> / <c:out value="${item.classInfo.class_a_count + item.classInfo.class_b_count + item.classInfo.class_c_count}"/></span>
								</td>
								<td>
								<c:choose>
								<c:when test="${item.class_yn == 'Y' }">
								<a href="/my/lecture" class="btn btn-block btn-default btn-level0">선정 (등록/결제하기)</a>
								<!--	<a href="javascript:;" onclick="alert('22년 3분기(7~9월) 선정된 회원분들께서는 현장 결제(등록)만 가능하오니 불편하시더라도 양해 부탁드립니다.');" class="btn btn-block btn-default btn-level0">선정 (등록/결제하기)</a> -->
								</c:when>
								<c:when test="${item.class_yn == 'D' }">
								대기자
								</c:when>
								<c:otherwise>
								미선정
								</c:otherwise>
								</c:choose>
								
								</td>
							</tr>
							</c:forEach>
							</c:if>
							<c:if test="${!empty hp && fn:length(list) == 0}">
							<tr>
							<td colspan="5">수강신청 내역이 없습니다.</td>
							</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div style="color:red;">※ 신규 회원은 서류 지참 후 현장등록 바랍니다.(온라인 결제 불가)</div>
				
				<!-- 수강신청 검색 리스트//end -->

			<!-- 	팝업 확인 링크 >> <a href="#modal-lecture-pay" class="js-modal__btn-open">결제페이지로 이동</a>
				<br> -->
			</article>
		</div>

		<div class="modal-basic js-modal" id="modal-lecture-pay"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">등록 결제페이지로 이동하시겠습니까?</p>
						<span class="modal-basic-desc">※이동 버튼 선택시, 결제페이지로 이동합니다.<br>결제를 원치 않으시면 닫기 버튼을 선택해주십시오.</span>
						<div class="btn-group">
							<a href="#none" class="btn by-2 btn-level1 btn-select js-modal__btn-close act-pop-close">닫기</a>
							<a href="#none" class="btn by-2 btn-level1 btn-noti">이동</a>
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
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	<c:if test="${!empty result && result == 'NOT_MATCHE'}">
	alert('비밀번호가 일치하지 않습니다.');
	</c:if>
	$('#hp_input').keyup(function() {
        if (this.value.match(/[^0-9]/g)) {
            this.value = this.value.replace(/[^0-9]/g, '');
        }
    });
	
	$(".act-pop-close").on("click", function(){
		$(this).parents(".js-modal").removeClass('is-expanded');
	});
	
	$(".act-search").on("click", function(){
		if($('input[name="hp"]').val() == ''){
			alert("전화번호를 입력해주세요.");
			return;
		}
		if($('input[name="pass"]').val() == ''){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		$("#modForm").submit();
	});
	
	$(".act-pay").on("click", function(){
		var idx = $(this).data("value");
		$("#modal-lecture-pay").find('input[name="idx_no"]').val(idx);
		$("#modal-lecture-pay").find('p').html($(this).parents('tr').find(".col-left").text() + "<br>결제페이지로 이동하시겠습니까?");
		$("#modal-lecture-pay").addClass("is-expanded");
	});
});

</script>
</body>
</html>