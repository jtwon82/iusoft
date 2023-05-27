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
				
				<form id="modForm" method="post" action="/lecture/list">
				<p class="heading-title">수강신청 내역 조회를 위한 정보입력</p>
				<div class="member-form">
					<div class="member-type-input member-type-list">
						<label for="hp_input">휴대폰 번호</label>
						<input type="text" name="hp" id="hp_input" value="<c:out value="${hp }"/>" class="text" style="width:380px;" placeholder="- 없이 입력해주십시오" maxLength=11>
					</div>
					<div class="member-type-input member-type-list">
						<label for="add-password">비밀번호</label>
						<input type="password" autocomplete="off" value="<c:out value="${pass }"/>" name="pass" class="text" id="add-password"  style="width:380px;" placeholder="비밀번호 입력">
						<a href="#none" class="btn btn-block btn-search btn-level1 act-search">검색</a>
					</div>
				</div>
				<!-- 수강신청 검색//end -->
				</form>
				
				<p class="heading-title">수강신청 내역</p>
				<div class="table-basic">
					<table class="table-basic-type2">
						<caption>수강신청내역 대한 정보제공</caption>
						<colgroup>
							<col width="7%">
							<col width="*">
							<col width="30%">
							<col width="230px">
							<col width="17%">
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
									<span class="party-state-per"><c:out value="${item.classInfo.cur_count }"/>/<c:out value="${item.classInfo.class_a_count + item.classInfo.class_b_count + item.classInfo.class_c_count}"/></span>
								</td>
								<td>수강신청 완료 
								<c:if test="${!empty classDate}">
								<a href="#none" data-value="<c:out value="${item.idx_no}"/>" class="btn btn-block btn-default btn-level0 act-cancel">신청취소</a>
								</c:if>
								</td>
							</tr>
							</c:forEach>
							</c:if>
							<c:if test="${!empty hp and fn:length(list) == 0}">
							<tr>
							<td colspan="5">수강신청 내역이 없습니다.</td>
							</tr>
							</c:if>
							<!-- <tr>
								<td>홍길동</td>
								<td class="col-left">[정회원] 휘트니스 - 3개월</td>
								<td>60,000 원</td>
								<td>월 ~ 일요일</td>
								<td>06:00 ~ 13:00</td>
								<td>
									<div class="party-state"><span class="value" style="width:70%"></span></div>
									<span class="party-state-per">350/500</span>
								</td>
								<td>수강신청 완료 <a href="#modal-lecture-cancel-check" class="btn btn-block btn-default btn-level0 js-modal__btn-open">신청취소</a></td>
							</tr>
							<tr>
								<td>김길동</td>
								<td class="col-left">[정회원] 휘트니스(오전반) - 3개월</td>
								<td>60,000 원</td>
								<td>월 ~ 일요일</td>
								<td>06:00 ~ 13:00</td>
								<td>
									<div class="party-state"><span class="value" style="width:50%"></span></div>
									<span class="party-state-per">250/500</span>
								</td>
								<td>수강신청 완료 <a href="#modal-lecture-cancel-check" class="btn btn-block btn-default btn-level0 js-modal__btn-open">신청취소</a></td>
							</tr>
							<tr>
								<td>소길동</td>
								<td class="col-left">[정회원] 휘트니스(오후반) - 3개월</td>
								<td>60,000 원</td>
								<td>월 ~ 일요일</td>
								<td>06:00 ~ 13:00</td>
								<td>
									<div class="party-state"><span class="value" style="width:25%"></span></div>
									<span class="party-state-per">125/500</span>
								</td>
								<td>수강신청 완료 <a href="#modal-lecture-cancel-check" class="btn btn-block btn-default btn-level0 js-modal__btn-open">신청취소</a></td>
							</tr> -->
						</tbody>
					</table>
				</div>
				<!-- 수강신청 검색 리스트//end -->

				<!-- 팝업 확인 링크 >> <a href="#modal-lecture-cancel-check" class="js-modal__btn-open">수강신청 취소</a>
				<br>
				팝업 확인 링크 >> <a href="#modal-lecture-cancel" class="js-modal__btn-open">수강신청 취소완료</a>
				<br> -->
			</article>
		</div>

		<div class="modal-basic js-modal" id="modal-lecture-cancel-check"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">[정회원] 휘트니스 3개월<br>수강신청을 취소하시겠습니까?</p>
						<span class="modal-basic-desc">※ 한번 취소한 내용은 되돌릴 수 없습니다.</span>
						<div class="btn-group">
							<a href="#none" class="btn by-2 btn-level1 btn-select act-pop-close">닫기</a>
							<a href="#" class="btn by-2 btn-level1 btn-noti act-cancel-done">수강신청 취소</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
			<input type="hidden" name="idx_no"/>
		</div>
		
		<c:if test="${success == 1}">
		<!-- layer popup//end -->
		<div class="modal-basic js-modal is-expanded" id="modal-lecture-cancel"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">수강신청이 취소되었습니다.</p>
						<span class="modal-basic-desc">※ 수강신청 취소 내역은<br>(수강신청내역조회)페이지에서 확인하실 수 있습니다.</span>
						<div class="btn-group">
							<a href="#none" class="btn btn-level1 btn-noti act-pop-close">확인</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		</c:if>
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
	
	$(".act-cancel").on("click", function(){
		var idx = $(this).data("value");
		$("#modal-lecture-cancel-check").find('input[name="idx_no"]').val(idx);
		$("#modal-lecture-cancel-check").find('p').html($(this).parents('tr').find(".col-left").text() + "<br>수강신청을 취소하시겠습니까?");
		$("#modal-lecture-cancel-check").addClass("is-expanded");
	});
	
	$(".act-cancel-done").on("click", function(){
		var idx = $("#modal-lecture-cancel-check").find('input[name="idx_no"]').val();
		
		$.ajax({
		     url:'/lecture/user/delete',
		     data: "idx_no=" + idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		    	/*  console.log(res); */
		         if(res=='SUCCESS'){
		             location.replace("/lecture/list?success=1");
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
});

</script>
</body>
</html>