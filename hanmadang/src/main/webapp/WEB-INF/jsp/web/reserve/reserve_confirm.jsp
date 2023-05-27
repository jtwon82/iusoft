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
			<div class="container-tabs cl-rent">
				<ul>
					<li class="by-3 "><a href="/rent/main">예약하기</a></li>
					<li class="by-3 is-selected"><a href="/rent/confirm">예약 확인 및 취소</a></li>
					<li class="by-3"><a href="/rent/rule">이용규정</a></li>
				</ul>
			</div>
			<article class="container-notice bg-rent">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<p class="heading">예약안내 및 취소</p>
				<span class="heading-desc">동호회 예약은 3일 전까지 취소 가능합니다.<br>
				직원(일반) 예약은 2시간 전까지 취소 가능합니다.</span>

				<p class="heading">검색</p>
				
				<form id="modForm" method="post" action="/rent/confirm">
				<div class="reserve-tabs">
					<a href="#none" class="by-2 member_tab <c:if test="${empty reserve.re_type or reserve.re_type == 1 }">is-selected</c:if> "><span>직원 예약</span></a>
					<a href="#none" class="team_tab by-2 <c:if test="${reserve.re_type == 2 }">is-selected</c:if> "><span>동호회 예약</span></a>
				</div>
				<div class="member-form by-2 member_tab1 <c:if test="${empty reserve.re_type or reserve.re_type == 1 }">is-selected</c:if>"><!-- 직원예약일경우 선택시 .is-selected -->
					<div class="member-type-input member-type-reserve">
						<label for="member-name">이용자명</label>
						<input type="text" class="text" name="re_name" id="member-name" placeholder="이용자명 입력" value="<c:out value="${reserve.re_name }"/>" <c:if test="${reserve.re_type == 2 }">readonly</c:if>>
						<label for="member-number">직번</label>
						<input type="text" class="text" autocomplete="off" name="employee_no" id="member-number" placeholder="직번 입력" value="<c:out value="${reserve.employee_no }"/>" <c:if test="${reserve.re_type == 2 }">readonly</c:if>>
					</div>
				</div>
				<div class="member-form team_tab1 by-2 <c:if test="${reserve.re_type == 2 }">is-selected</c:if>"><!-- 동호회예약일경우 선택시 .is-selected -->
					<div class="member-type-input member-type-team">
						<label for="member-id">아이디</label>
						<input type="text" class="text" name="team_id" id="member-id" placeholder="아이디 입력" value="<c:out value="${reserve.team_id }"/>" <c:if test="${empty reserve.re_type or reserve.re_type == 1 }">readonly</c:if>>
						<label for="member-pw">패스워드</label>
						<input type="password" autocomplete="off" class="text" name="team_pwd" id="member-pw" placeholder="패스워드 입력" style="margin-right:5px;" value="<c:out value="${reserve.team_pwd }"/>" <c:if test="${empty reserve.re_type or reserve.re_type == 1 }">readonly</c:if>>
						<c:if test="${!empty team_login_session}">
						<a href="#modal-password-change" class="btn btn-level1 btn-default js-modal__btn-open" style="float:left;">비밀번호 변경</a>
						</c:if>
					</div>
				</div>
				
				<input type="hidden" name="re_type" value="<c:out value="${reserve.re_type }"/>"/>
				</form>
				
				<div class="btn-group">
					<a href="#none" class="btn btn-level2 btn-rent act-search">검색</a>
				</div>
				
				
				<div class="table-caption">
					<div class="table-title">검색 결과</div>
				</div>
				<div class="table-basic">
					<table class="table-basic-type2">
						<caption>검색 결과에 대한 정보제공</caption>
						<colgroup>
							<col width="*">
							<col width="15%">
							<col width="18%">
							<col width="18%">
							<col width="15%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th>예약일자</th>
								<th>예약자명</th>
								<th>시설</th>
								<th>시간</th>
								<th>코트</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${not empty list }">
						<c:forEach items="${list }" var="item" varStatus="status">
							<tr>
							<td><c:out value="${fn:substring(item.re_date, 0, 4)}"/>.<c:out value="${fn:substring(item.re_date, 4, 6)}"/>.<c:out value="${fn:substring(item.re_date, 6, 8)}"/></td>
							<td>
							<c:choose>
							<c:when test="${item.cl_num > 0 }"><c:out value="${item.cl_name}"/></c:when>
							<c:when test="${not empty item.re_name}"><c:out value="${item.re_name}"/></c:when>
							</c:choose>
							
							</td>
							<td>
							<c:choose>
							<c:when test="${item.re_part == 15 }">배드민턴</c:when>
							<c:when test="${item.re_part == 16 }">탁구장</c:when>
							<c:when test="${item.re_part == 17 }">당구장</c:when>
							</c:choose>
							</td>
							<td><c:out value="${fn:substring(item.rt_stime, 0, 2)}"/>:<c:out value="${fn:substring(item.rt_stime, 2, 4)}"/> ~ <c:out value="${fn:substring(item.rt_etime, 0, 2)}"/>:<c:out value="${fn:substring(item.rt_etime, 2, 4)}"/></td>
							
							<c:choose>
							<c:when test="${item.rt_stat == 'Y' }">
							<td><c:out value="${item.rt_court}"/></td>
							<td>예약완료 
							<c:choose>
							<c:when test="${ item.cl_num == 0 and (curday != item.re_date or fn:replace(item.rt_stime, ':', '') > after2hourTime)}"> 
							<a href="#none" data-value="<c:out value="${item.rt_num}"/>" class="btn btn-block btn-point btn-level0 act-cancel">예약취소</a>
							</c:when>
							<c:when test="${ item.cl_num > 0 and fn:replace(item.re_date, '.', '') >= after3day}"> 
							<a href="#none" data-value="<c:out value="${item.rt_num}"/>" class="btn btn-block btn-point btn-level0 act-cancel">예약취소</a>
							</c:when>
							</c:choose>						
							</td>
							</c:when>
							<c:when test="${item.rt_stat == 'C' }">
							<td><c:out value="${item.rt_court}"/></td>
							<td>예약취소 </td>
							</c:when>
							<c:when test="${item.rt_stat == 'F' }">
							<td>코트 개수(<c:out value="${item.rt_court_cnt}"/>)</td>
							<td>추첨탈락 </td>
							</c:when>
							<c:when test="${item.rt_stat == 'N' }">
							<td>코트 개수(<c:out value="${item.rt_court_cnt}"/>)</td>
							<td>추점대기 <a href="#none" data-value="<c:out value="${item.rt_num}"/>" class="btn btn-block btn-point btn-level0 act-cancel">예약취소</a></td>
							</c:when>
							</c:choose>
							
							</tr>
						</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
			</article>


		</div>
		<c:if test="${!empty team_login_session}">
		<form id="modForm1" method="post" action="/rent/confirm/team/pass">
		<div class="modal-basic js-modal" id="modal-password-change"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-team__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">비밀번호 변경을 위해 기존 비밀번호를<br>입력해 주십시오.</p>
						<div class="line-form">
							<input type="password" autocomplete="off" style="width:360px;" class="text" name="pwd" id="num-confirm" placeholder="기존 비밀번호 입력" />
						</div>
						<br>
						<p class="modal-basic-title">새 비밀번호를 입력해 주십시오.</p>
						<div class="line-form">
							<input type="password" autocomplete="off" style="width:360px;" class="text" name="new_pwd" id="num-confirm-new" placeholder="새 비밀번호 입력" />
						</div>
						<div class="line-form">
							<input type="password" autocomplete="off" style="width:360px;" class="text" name="new_pwd1" id="num-confirm-check" placeholder="새 비밀번호 확인" />
							<!-- alert message -->
							<!-- <p class="msg-alert cl-red">비밀번호가 일치하지 않습니다. 다시 입력해 주십시오.</p> -->
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-rent">확인</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		</form>
		</c:if>
		
	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
<c:if test="${not empty error_result}">
<c:choose>
<c:when test="${type == 1}">alert("이용자명 또는 직번이 올바르지 않습니다.")</c:when>
<c:when test="${type == 2}">alert("아이디 또는 패스워드가 올바르지 않습니다.")</c:when>
</c:choose>

</c:if>
$(function(){
	$( "#member-id, #member-pw" ).click(function() {
		if(!$(".team_tab").hasClass("is-selected")){
			$(".team_tab").addClass("is-selected")
			$("#team_tab1").addClass("is-selected")
			$("input[name=re_name]").attr("readonly",true);
			$("input[name=employee_no]").attr("readonly",true);
			
			$(".member_tab").removeClass("is-selected")
			$("#member_tab1").removeClass("is-selected")
			$("input[name=team_id]").attr("readonly",false);
			$("input[name=team_pwd]").attr("readonly",false);
			
			$("input[name=re_type]").val("2");
		}
	});
	
	$( "#member-name, #member-number" ).click(function() {
		if(!$(".member_tab").hasClass("is-selected")){
			$(".member_tab").addClass("is-selected")
			$("#member_tab1").addClass("is-selected")
			$("input[name=re_name]").attr("readonly",false);
			$("input[name=employee_no]").attr("readonly",false);
			
			$(".team_tab").removeClass("is-selected")
			$("#team_tab1").removeClass("is-selected")
			$("input[name=team_id]").attr("readonly",true);
			$("input[name=team_pwd]").attr("readonly",true);
			
			$("input[name=re_type]").val("1");
		}
	});
	
	$(".member_tab").on("click", function(){
		if(!$(this).hasClass("is-selected")){
			$(this).addClass("is-selected")
			$("#member_tab1").addClass("is-selected")
			$("input[name=re_name]").attr("readonly",false);
			$("input[name=employee_no]").attr("readonly",false);
			
			$(".team_tab").removeClass("is-selected")
			$("#team_tab1").removeClass("is-selected")
			$("input[name=team_id]").attr("readonly",true);
			$("input[name=team_pwd]").attr("readonly",true);
			
			$("input[name=re_type]").val("1");
		}
	});
	
	$(".team_tab").on("click", function(){
		if(!$(this).hasClass("is-selected")){
			$(this).addClass("is-selected")
			$("#team_tab1").addClass("is-selected")
			$("input[name=re_name]").attr("readonly",true);
			$("input[name=employee_no]").attr("readonly",true);
			
			$(".member_tab").removeClass("is-selected")
			$("#member_tab1").removeClass("is-selected")
			$("input[name=team_id]").attr("readonly",false);
			$("input[name=team_pwd]").attr("readonly",false);
			
			$("input[name=re_type]").val("2");
		}
	});
	
	$(".act-search").on("click", function(){
		var type = $("#modForm").find('input[name="re_type"]').val()
		
		if(type == 1){
	    	input_value = $("#modForm").find('input[name="re_name"]').val();
	        if(input_value == ''){
	        	alert("이용자명을 입력해주세요.");
	        	return;
	        }
	        
	        input_value = $("#modForm").find('input[name="employee_no"]').val();
	        if(input_value == ''){
	        	alert("직번을 입력해주세요.");
	        	return;
	        }
		}else if(type == 2){
	    	input_value = $("#modForm").find('input[name="team_id"]').val();
	        if(input_value == ''){
	        	alert("아이디를 입력해주세요.");
	        	return;
	        }
	        
	        input_value = $("#modForm").find('input[name="team_pwd"]').val();
	        if(input_value == ''){
	        	alert("패스워드를 입력해주세요.");
	        	return;
	        }
		}else{
			return;
		}
		
		$("#modForm").submit();
	});
	
	$(".act-cancel").on("click", function(){
		if(!confirm("예약취소 하시겠습니까?"))
			return;
		
		var rt_num = $(this).data("value");
		
		$.ajax({
		     url:'/rent/confirm/cancel',
		  	data:"type=<c:out value="${type}"/>&rt_num="+rt_num,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		    	/*  console.log(res); */
		         if(res=='SUCCESS'){
		             alert("정상적으로 처리되었습니다.")
		             location.reload(true);
		         }else if(res=='INVALID_ACCESS'){
		        	 alert("취소 가능 시간이 지났습니다.");
		         }else if(res=='UNAUTHORIZED'){
		        	 alert("비정상적인 접근입니다.");
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
	<c:if test="${!empty team_login_session}">
	$('#modForm1').ajaxForm({
        beforeSubmit: function (data,form,option) {
            input_value = form.find('input[name="pwd"]').val();
            if(input_value == ''){
	            	alert("기존 비밀번호를 입력해주세요.");
	            	return false;
            }
        
            input_value = form.find('input[name="new_pwd"]').val();
            if(input_value == ''){
	            	alert("새 비밀번호를 입력해주세요.");
	            	return false;
            }
            
            input_value = form.find('input[name="new_pwd1"]').val();
            if(input_value == ''){
	            	alert("새 비밀번호 확인을 입력해주세요.");
	            	return false;
            }
            
            if(form.find('input[name="new_pwd"]').val() != form.find('input[name="new_pwd1"]').val()){
	            	alert("새 비밀번호와 확인이 일치하지 않습니다.");
	            	return false;
            }
            
            if(!confirm("변경하시겠습니까?"))
    			return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
	            	alert("비밀번호가 변경완료되었습니다.\n예약 확인 및 취소 조회는 변경된 비밀번호로 다시 조회주세요.");
	    			location.reload(true);
            }else if(response == 'NOT_MATCHE'){
	            	alert("기존 비밀번호가 일치하지 않습니다.");
       		}else{
            		alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
	</c:if>
	
});

</script>

</body>
</html>