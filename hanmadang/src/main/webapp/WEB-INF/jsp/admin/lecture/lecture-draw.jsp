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
						<h2>수강신청 관리</h2>
					</article>
					<div class="container-tabs">
						<%@ include file="tab_menu.jsp"%>
					</div>
					<article class="container-body">
						<h3 class="h3-title">추첨 (<c:out value="${date }"/> 현재 상황)</h3>
						<div class="h3-btn"><a href="#modal-draw-change" class="btn btn-change btn-level js-modal__btn-open">종목별 추첨 조건 변경</a></div>
						<div class="h3-desc">신청기간 중 종목별 신청현황을 파악하고, 신청기간 종료 후 추첨을 진행하며, 선정자를 홈페이지게 게시합니다</div>

						<span class="h3-desc cl-blue">* 상태 : 
						<c:if test="${end_cnt == 0 }"> 미추첨 ( 추첨이 가능합니다. ) </c:if>
						<c:if test="${end_cnt > 0 and  view_cnt == 0}"> 추첨완료 ( 추첨이 완료되었습니다. 게재하여주십시요. ) </c:if>
						<c:if test="${end_cnt > 0 and  view_cnt > 0}"> 게제완료 ( 게재가 완료 되었습니다. 초기화 버튼을 누르면 미추첨 상태로 돌아갑니다. ) </c:if>
						</span>
							
						<div class="lecture-advice">
							<a href="#none" class="btn btn-draw btn-level act-draw">추첨하기</a> 
							<a href="#none" class="btn btn-draw btn-level act-reset">초기화하기</a><br>
							<span class="h3-sub cl-blue">* 추첨하기 버튼을 선택하여, 추첨해 주십시오.</span><br>
							<span class="h3-sub cl-blue">* 초기화 하기 버튼을 선택하면 미추첨 상태로 돌아갑니다</span>
						</div>
						<div class="lecture-advice">
							<a href="#none" class="btn btn-start btn-level act-open">게제하기</a> 
							<a href="#none" class="btn btn-start btn-level act-end">게제종료</a><br>
							<span class="h3-sub cl-blue">* 게재하기 버튼을 선택하면, 홈페이지에 선정자 리스트가 게재됩니다.</span><br>
							<span class="h3-sub cl-blue">* 게재종료 버튼을 선택하면, 홈페이지에 선정자 리스트를 게재하지 않습니다.</span>
						</div>

						<div class="lecture-date">
							<div class="day-title">응모기간 </div>
							<div class="day-day"><c:out value="${fn:substring(classDate.startdate, 0, 4)}"/>년 <c:out value="${fn:substring(classDate.startdate, 5, 7)}"/>월 <c:out value="${fn:substring(classDate.startdate, 8, 10)}"/>일 ~ 
							<c:out value="${fn:substring(classDate.enddate, 0, 4)}"/>년 <c:out value="${fn:substring(classDate.enddate, 5, 7)}"/>월 <c:out value="${fn:substring(classDate.enddate, 8, 10)}"/>일</div>
						</div>

						<h3 class="h3-title">종목별 신청현황</h3>
						<div class="h3-btn"><div class="bul-regular">정회원</div> <div class="bul-associate">준회원</div> <div class="bul-general">일반회원</div></div>
						<div class="table-basic">
							<table class="table-basic-type2 top-box">
								<colgroup>
									<col width="150px">
									<col width="200px">
									<col width="*">
									<col width="120px">
									<col width="130px">
								</colgroup>
								<tbody>
									<c:forEach items="${subClass }" var="item" varStatus="status">	
									<c:set var="allper" value="${(item.cnt_regular + item.cnt_associate + item.cnt_general) >= (item.class_a_count + item.class_b_count + item.class_c_count) ? 100 : (item.cnt_regular + item.cnt_associate + item.cnt_general) / (item.class_a_count + item.class_b_count + item.class_c_count) * 100}"/>
									<c:set var="re_per" value="${item.cnt_regular / (item.cnt_regular + item.cnt_associate + item.cnt_general) * allper}"/>
									<c:set var="asso_per" value="${item.cnt_associate / (item.cnt_regular + item.cnt_associate + item.cnt_general) * allper}"/>
									<c:set var="gen_per" value="${item.cnt_general / (item.cnt_regular + item.cnt_associate + item.cnt_general) * allper}"/>
									
									<c:if test="${re_per == 'NaN' }"><c:set var="re_per" value="0"/></c:if>
									<c:if test="${asso_per == 'NaN' }"><c:set var="asso_per" value="0"/></c:if>
									<c:if test="${gen_per == 'NaN' }"><c:set var="gen_per" value="0"/></c:if>
									
									<tr>
										<td class="col-left"><c:out value="${item.b_cate_name }"/></td>
										<td><c:out value="${item.class_name }"/> <c:out value="${item.class_time }"/></td>
										<td>
											<div class="graph-bar">
											<fmt:parseNumber var="re_per1" value="${re_per+((re_per%1>0.5)?(1-(re_per%1))%1:-(re_per%1))}" integerOnly="true" />
											<fmt:parseNumber var="asso_per1" value="${asso_per+((asso_per%1>0.5)?(1-(asso_per%1))%1:-(asso_per%1))}" integerOnly="true" />
											<fmt:parseNumber var="gen_per1" value="${gen_per+((gen_per%1>0.5)?(1-(gen_per%1))%1:-(gen_per%1))}" integerOnly="true" />
											
											<c:if test="${ allper >= 100}">
											<c:set var="gen_per1" value="${100 - re_per1 - asso_per1 }"/>
											
											</c:if>
												<span class="bar-regular" style="width:${re_per1}%">정회원</span><span class="bar-associate" style="width:${asso_per1}%">준회원</span><span class="bar-general" style="width:${gen_per1}%">일반회원</span>
											</div>
										</td>
										<td><span><c:out value="${item.cnt_regular + item.cnt_associate + item.cnt_general}"/>명 / <c:out value="${item.class_a_count + item.class_b_count + item.class_c_count}"/>명</span></td>
										<!-- <td> -->
										<%-- <c:choose>
										<c:when test="${(item.cnt_regular + item.cnt_associate + item.cnt_general) > (item.class_b_count + item.class_a_count)}">
										<a href="javascript:alert('준비중입니다.');" class="btn btn-level btn-default">추첨하기</a>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
										</c:choose> --%>
										<!-- </td> -->
									</tr>
									</c:forEach>
									<!-- <tr>
										<td class="col-left" rowspan="2">휘트니스</td>
										<td>오후 10:00 ~ 18:00</td>
										<td>
											<div class="graph-bar">
												<span class="bar-regular" style="width:23%">정회원</span><span class="bar-associate" style="width:19%">준회원</span><span class="bar-general" style="width:6%">일반회원</span>
											</div>
										</td>
										<td>
											<span>70명 / 150명</span>
										</td>
										<td><a href="#" class="btn btn-level btn-default">추첨하기</a></td>
									</tr>
									<tr>
										<td>종일</td>
										<td>
											<div class="graph-bar">
												<span class="bar-regular" style="width:34%">정회원</span><span class="bar-associate" style="width:25%">준회원</span><span class="bar-general" style="width:10%">일반회원</span>
											</div>
										</td>
										<td><span>540명 / 700명</span></td>
										<td><a href="#" class="btn btn-level btn-default">추첨하기</a></td>
									</tr>
									<tr>
										<td class="col-left">휘트니스</td>
										<td>종일 06:00~23:00</td>
										<td>
											<div class="graph-bar">
												<span class="bar-regular" style="width:11%">정회원</span><span class="bar-associate" style="width:40%">준회원</span><span class="bar-general" style="width:15%">일반회원</span>
											</div>
										</td>
										<td><span>32명 / 40명</span></td>
										<td><a href="#" class="btn btn-level btn-default">추첨하기</a></td>
									</tr>
									<tr>
										<td class="col-left">휘트니스+승마</td>
										<td>종일 06:00~23:00</td>
										<td>
											<div class="graph-bar">
												<span class="bar-regular" style="width:20%">정회원</span><span class="bar-associate" style="width:60%">준회원</span><span class="bar-general" style="width:20%">일반회원</span>
											</div>
										</td>
										<td><span>40명 / 40명</span></td>
										<td>추첨완료 / 게재중</td>
									</tr>
									<tr>
										<td class="col-left">스쿼시</td>
										<td>종일 06:00~23:00</td>
										<td>
											<div class="graph-bar">
												<span class="bar-regular" style="width:10%">정회원</span><span class="bar-associate" style="width:15%">준회원</span><span class="bar-general" style="width:22%">일반회원</span>
											</div>
										</td>
										<td><span>40명 / 100명</span></td>
										<td>추첨완료 / 게재중</td>
									</tr> -->
								</tbody>
							</table>
						</div>

					</article>
				</div>
			</div>
		</div>


		<div class="modal-basic js-modal " id="modal-draw-change"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">종목별 추첨 조건 변경</div>
							<div class="modal-basic-desc">종목명을 입력해주십시오.</div>
						</div>
						
						<form id="factorForm" method="post" action="${ADMIN_PATH}/entry/draw/factor">
						<div class="line-form">
							<div class="line-form-admin">
								<div class="line-timeset">
									<span class="selectbox selectbox--type1">
										<select name="idx_no" id="factor_select">
										<c:forEach items="${subClass }" var="item" varStatus="status">	
										<c:set var="regular" value="${item.class_a_count / (item.class_a_count + item.class_b_count + item.class_c_count) * 100 }"/>
											<fmt:parseNumber var="regular1" value="${regular+((regular%1>0.5)?(1-(regular%1))%1:-(regular%1))}" integerOnly="true" />
											
											<c:set var="associate" value="${item.class_b_count / (item.class_a_count + item.class_b_count + item.class_c_count) * 100 }"/>
											<fmt:parseNumber var="associate1" value="${associate+((associate%1>0.5)?(1-(associate%1))%1:-(associate%1))}" integerOnly="true" />
											
											<c:set var="general" value="${item.class_c_count / (item.class_a_count + item.class_b_count + item.class_c_count) * 100 }"/>
											<fmt:parseNumber var="general1" value="${general+((general%1>0.5)?(1-(general%1))%1:-(general%1))}" integerOnly="true" />
											
											<option value="<c:out value="${item.idx_no}"/>"
												data-total="<c:out value="${item.class_a_count + item.class_b_count + item.class_c_count}"/>"
												data-regular="<c:out value="${regular1}"/>"
												data-associate="<c:out value="${associate1}"/>"
												data-general="<c:out value="${general1}"/>"
												data-man="<c:out value="${item.class_man_per}"/>"
												data-women="<c:out value="${item.class_women_per}"/>"><c:out value="${item.b_cate_name}"/> (<c:out value="${item.class_name}"/>)</option>
										</c:forEach>
											<!-- <option value="">휘트니스</option>
											<option value="">휘트니스+승마</option>
											<option value="">휘트니스+스쿼시</option>
											<option value="">스쿼시</option>
											<option value="">스피닝</option>
											<option value="">에어로빅</option>
											<option value="">요가</option>
											<option value="">다이어트댄스</option>
											<option value="">밸리댄스</option>
											<option value="">스크린승마</option>
											<option value="">다이어트발레</option> -->
										</select>
									</span>
								</div>
								<!-- <div class="line-time"><a href="#" class="btn btn-default btn-level ">조회하기</a></div> -->
							</div>
						</div>
						
						<c:set var="regular" value="${subClass[0].class_a_count / (subClass[0].class_a_count + subClass[0].class_b_count + subClass[0].class_c_count) * 100 }"/>
						<fmt:parseNumber var="regular1" value="${regular+((regular%1>0.5)?(1-(regular%1))%1:-(regular%1))}" integerOnly="true" />
						
						<c:set var="associate" value="${subClass[0].class_b_count / (subClass[0].class_a_count + subClass[0].class_b_count + subClass[0].class_c_count) * 100 }"/>
						<fmt:parseNumber var="associate1" value="${associate+((associate%1>0.5)?(1-(associate%1))%1:-(associate%1))}" integerOnly="true" />
						
						<c:set var="general" value="${subClass[0].class_c_count / (subClass[0].class_a_count + subClass[0].class_b_count + subClass[0].class_c_count) * 100 }"/>
						<fmt:parseNumber var="general1" value="${general+((general%1>0.5)?(1-(general%1))%1:-(general%1))}" integerOnly="true" />
						
						<div class="line-form">
							<div class="line-form-admin">
								<p class="line-title cl-blue">회원별 비율을 설정해주십시오.</p>
								<div class="line-time">정회원</div>
								<div class="line-timeset"><input type="text" name="regular" value="<c:out value="${regular1}"/>" class="text" style="width:200px" /><span class="words">%</span></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">준회원</div>
								<div class="line-timeset"><input type="text" name="associate" value="<c:out value="${associate1}"/>" class="text" style="width:200px" /><span class="words">%</span></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">일반회원</div>
								<div class="line-timeset"><input type="text" name="general" value="<c:out value="${general1}"/>" class="text" style="width:200px" /><span class="words">%</span></div>
							</div>

							<div class="line-form-admin">
								<p class="line-title cl-blue">전체 남녀 비율을 설정해 주십시오.</p>
								<div class="line-time">남자</div>
								<div class="line-timeset"><input type="text" name="man" value="<c:out value="${subClass[0].class_man_per}"/>" class="text" style="width:200px" /><span class="words">%</span></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">여자</div>
								<div class="line-timeset"><input type="text" name="women" value="<c:out value="${subClass[0].class_women_per}"/>" class="text" style="width:200px" /><span class="words">%</span></div>
							</div>
						</div>
						<div class="btn-group">
							<button type="submit" class="by-2 btn btn-level1 btn-register">변경하기</button>
						</div>
						<input type="hidden" name="total" value="<c:out value="${subClass[0].class_a_count + subClass[0].class_b_count + subClass[0].class_c_count }"/>"/>
						</form>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">

$(function(){
	$('#factor_select').change(function(){
	       var selected = $(this).find('option:selected');
	       var regular = selected.data('regular'); 
	       var associate = selected.data('associate'); 
	       var general = selected.data('general'); 
	       var man = selected.data('man'); 
	       var women = selected.data('women');
	       var total = selected.data('total');
	       
	       $('#factorForm').find('input[name="regular"]').val(regular);
	       $('#factorForm').find('input[name="associate"]').val(associate);
	       $('#factorForm').find('input[name="general"]').val(general);
	       $('#factorForm').find('input[name="man"]').val(man);
	       $('#factorForm').find('input[name="women"]').val(women);
	       $('#factorForm').find('input[name="total"]').val(total);
    });
	
	$('#factorForm').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	
            //validation체크 
            input_value = form.find('input[name="regular"]').val();
            if(input_value == ''){
            	alert("정회원 비율을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="associate"]').val();
            if(input_value == ''){
            	alert("준회원 비율을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="general"]').val();
            if(input_value == ''){
            	alert("일반회원 비율을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="man"]').val();
            if(input_value == ''){
            	alert("남자 비율을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="women"]').val();
            if(input_value == ''){
            	alert("여자 비율을 입력해주세요.");
            	return false;
            }
            
            if(!confirm("변경하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("변경되었습니다.");
    			location.reload(true);
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	
	$('.act-draw').on("click", function(){
		if(!confirm("추첨을 진행하시겠습니다. 진행후에는 취소가 불가능합니다."))
			return;
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/draw/proc',
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		        	 alert("추첨이 완료 되었습니다.");
		        	 location.reload(true);
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	 });
	
	$(".act-reset").on("click", function(){
		if(!confirm("추첨내역을 초기화 하시겠습니까?"))
			return;
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/draw/reset',
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		        	 alert("초기화되었습니다.");
		        	 location.reload(true);
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
	$(".act-open").on("click", function(){
		if(!confirm("사용자화면에 게제 하시겠습니까?"))
			return;
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/draw/open',
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		        	 alert("게제되었습니다.");
		        	 location.reload(true);
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
	$(".act-end").on("click", function(){
		if(!confirm("게제종료 하시면 지난데이타 검색에서 확인하실수 있습니다.게제종료 하시겠습니까?"))
			return;
		
		$.ajax({
		     url:'${ADMIN_PATH}/entry/draw/end',
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		         if(res=='SUCCESS'){
		        	 alert("종료처리되었습니다.");
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