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
<style type="text/css">
.table-basic thead th { text-align:center; }
.table-basic tbody td { text-align:center; }
</style>
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
					<li class="by-3 is-selected"><a href="/rent/main">예약하기</a></li>
					<li class="by-3"><a href="/rent/confirm">예약 확인 및 취소</a></li>
					<li class="by-3"><a href="/rent/rule">이용규정</a></li>
				</ul>
			</div>
			<article class="container-notice bg-rent">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="rent-tabs" id="menu-link">
					<a href="#none" class="by-3 is-selected"><span>배드민턴장</span></a>
					<a href="/rent/time/16?date=<c:out value="${date}"/>" class="by-3"><span>탁구장</span></a>
					<a href="/rent/time/17?date=<c:out value="${date}"/>" class="by-3"><span>당구장</span></a>
					<!-- <a href="reserve_time_all.html" class="by-4"><span>경기장 전체</span></a> -->
				</div>
				<div class="calendar-box">
					<div class="calendar-head">
						<p class="calendar-month cl-rent"><c:out value="${fn:substring(date, 0, 4)}"/>.<c:out value="${fn:substring(date, 4, 6)}"/>.<c:out value="${fn:substring(date, 6, 8)}"/></p>
						<p class="calendar-year">(<c:out value='${yoil}'/>)</p>
					</div>
					
					<c:if test="${teamAbleDay=='false' }">
						<div class="info-box" style="font-size:20px;font-weight: bold;padding: 0 0 0px 0;">현 화면은 예약현황만 표시되므로 실제 코트 상황과 다를 수 있으니 054)221-9280~1로 연락주시면 현황을 확인하실 수 있습니다.</div>
					</c:if>
					<c:if test="${personAbleDay=='true' }">
						<c:choose>
						<c:when test="${teamAbleDay=='true' }"></c:when>
						<c:otherwise>
						<div class="info-box" style="font-size:20px;font-weight: bold;padding: 0 0 0px 0;">※ 직원 예약은 <span style="color:#00adee;">최대 1코트 2시간</span> 가능</div>
						</c:otherwise>
						</c:choose>
					</c:if>
					
					<div class="calendar-info">원하는 예약(시간/코트)를 선택해 주십시오.<br><br>
						<span style="text-align: right;float: left;">- 운영시간 : 평일 07:00~22:30 / 주말(공휴일) 07:00~21:30</span>
					</div>
					
					<div class="calendar-body">
						<div class="calendar-week">
							<div class="table-basic table-basic-type3"  style="width:1100px">
								<table>
									<colgroup><col width="*" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /><col width="80" /></colgroup>
									<thead>
										<tr class="no-head">
											<th>시간</th>
											<th>1코트</th>
											<th>2코트</th>
											<th>3코트</th>
											<th>4코트</th>
											<th>5코트</th>
											<th>6코트</th>
											<th>7코트</th>
											<th>8코트</th>
											<th>9코트</th>
											<th>10코트</th>
											<th>11코트</th>
											<th>12코트</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${data }" var="item" varStatus="status">
										<tr>	
											<td><c:out value="${item.key }"/></td>
											<c:choose>
											<c:when test="${fn:contains(item.key, '18:00 ~') }">
											<td colspan="12"><span class="select-basic select-break">크리닝 타임</span></td>
											</c:when>
											<c:when test="${fn:length(item.value) > 0 and item.value[0].allCourt == true }">
											<td colspan="12"><span class="select-basic select-general"><c:out value="${item.value[0].re_title }"/><c:if test="${!empty item.value[0].re_kind }">(<c:out value="${item.value[0].re_kind }"/>)</c:if></span></td>
											</c:when>
											<c:otherwise>
												<c:choose>
												<c:when test="${not empty item.value }">
														<c:forEach var="i" begin="1" end="6" step="1">
															<td></td>
														</c:forEach>
													<c:forEach var="i" begin="7" end="12" step="1">
														<c:set var="usedcourt" value="" /> 
														<c:set var="exist_flag" value="0" /> 
														<c:set var="str_i" value="${i}코트" /> 
															<c:forEach items="${item.value }" var="item2" varStatus="status1">
																<c:if test="${!((i == 1 and fn:contains(item2.rt_court, '11')) or (i == 2 and fn:contains(item2.rt_court, '12')) ) }">
																<c:if test="${fn:contains(item2.rt_court, str_i) and !fn:contains(usedcourt, str_i)}">
																	<c:choose>
																	<c:when test="${item2.re_type == 'lecture' }">
																	<td><span class="select-basic select-general"><c:out value="${fn:length(item2.re_title) > 5 ? fn:substring(item2.re_title, 0, 5) : item2.re_title }"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'team' }">
																	<td><span class="select-basic select-general"><c:out value="${fn:length(item2.cl_name) > 5 ? fn:substring(item2.cl_name, 0, 5) : item2.cl_name}"/></span></td>
																	</c:when>
																	<c:when test="${item2.re_type == 'employee' }">
																	<td><span class="select-basic select-general"><c:out value="${item2.re_name }"/></span></td>
																	</c:when>
																	<c:otherwise>
																	<td><span class="select-basic select-general"><c:out value="${fn:length(item2.re_title) > 5 ? fn:substring(item2.re_title, 0, 5) : item2.re_title }"/><c:if test="${!empty item.value[0].re_kind }">(<c:out value="${item2.re_kind }"/>)</c:if></span></td>
																	</c:otherwise>
																	</c:choose>
																	<c:set var="exist_flag" value="1" /> 
																	
																	<c:set var="usedcourt" value="${usedcourt += str_i }" /> 
																</c:if>
																</c:if>
															</c:forEach>
															
															<c:if test="${exist_flag == 0}">
															<c:choose>
															<c:when test="${type == 1}">
																<c:choose>
																	<c:when test="${ fn:replace(fn:substring(item.key, 0, 5), ':', '') > after2hourTime}"> 
																	<td><button data-value="${item.key }|${str_i}#" class="select-basic select-regular">직원</button></td>
																	</c:when>
																	<c:otherwise>
																	<td></td>
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:when test="${type == 2 and yoil == '일요일' and fn:substring(item.key, 0, 5) >= '13:00'}">
															<td></td>
															</c:when>
															<c:when test="${type == 2 and i > 6 }">
															<td><button data-value="${item.key }|${str_i}#" class="select-basic select-team">동호회</button></td>
															</c:when>
															<c:otherwise>
															<td></td>
															</c:otherwise>
															</c:choose>
															</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:choose>
													<c:when test="${type == 2 and yoil == '수요일' and (fn:contains(item.key, '18:30 ~') or fn:contains(item.key, '20:30 ~'))}">
													<td colspan="12"><span class="select-basic select-general">구기종목의 날</span></td>
													</c:when>
													<c:when test="${type == 2 and yoil == '일요일' and (fn:contains(item.key, '07:00 ~') or fn:contains(item.key, '09:00 ~'))}">
													<td colspan="12"><span class="select-basic select-general">구기종목의 날</span></td>
													</c:when>
													<c:when test="${type == 2 and yoil == '일요일' and fn:substring(item.key, 0, 5) >= '13:00'}">
													<td colspan="12"></td>
													</c:when>
													<c:otherwise>
														<c:forEach var="i" begin="1" end="6" step="1">
															<td></td>
														</c:forEach>
														<c:forEach var="i" begin="7" end="12" step="1">
															<c:choose>
															<c:when test="${type == 1}">
																<c:choose>
																<c:when test="${ fn:replace(fn:substring(item.key, 0, 5), ':', '') > after2hourTime}"> 
																<td><button data-value="${item.key }|${i}코트#" class="select-basic select-regular">직원</button></td>
																</c:when>
																<c:otherwise>
																<td></td>
																</c:otherwise>
																</c:choose>
															</c:when>
															<c:when test="${type == 2 and i > 6 }">
															<td><button data-value="${item.key }|${i}코트#" class="select-basic select-team">동호회</button></td>
															</c:when>
															<c:otherwise>
															<td></td>
															</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:otherwise>
													</c:choose>	
												</c:otherwise>
												</c:choose>
											</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<br>
					<div class="noti-box bg-rent">
						※ 담당자 정보 : 행정섭외 그룹 TEL. 054) 220 - 1155 ｜ EMAIL. csh0319@posco.com
					</div>
				</div>

				<div class="btn-group">
					<a href="/rent/main?code=<c:out value="${code }"/>" class="btn btn-level2 btn-rent">이전으로</a>
					<c:if test="${type == 1 }">
					<a href="#modal-login-regular" class="btn btn-level2 btn-rent act-done">선택완료</a>
					</c:if>
					<c:if test="${type == 2 }">
					<a href="#modal-login-team" class="btn btn-level2 btn-rent act-done">선택완료</a>
					</c:if>
				</div>
			</article>
		</div>
		<form id="modForm" method="post" action="/rent/time/save">
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-login-team"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-team__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">동호회 로그인</p>
						<span class="modal-basic-desc">로그인 후, 예약이 완료됩니다.</span>
						<div class="input-group">
							<input type="text" name="team_id" placeholder="아이디" />
							<input type="password" name="team_pwd" autocomplete="off" placeholder="비밀번호" />
						</div>
						<c:if test="${type == 2 }">
						<div class="input-group">
							<img src="/rent/time/captcha" id="captchaImg" alt="captcha img">
							<button type="button" class="btn by-1 btn-level1 captcha_refresh">새로고침</button>
							<input type="text" placeholder="보안문자를 입력하세요" name="captcha">
						</div>
						</c:if>
						
						<div class="btn-group">
							<a href="#" class="btn by-2 btn-level1 btn-search js-modal__btn-close">취소</a>
							<button type="submit" class="btn by-2 btn-level1 btn-search">예약하기</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		
		
		<!-- layer popup//end -->
		<div class="modal-basic js-modal " id="modal-login-regular"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-reserve__wrapper">
			
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">직원 예약</p>
						<span class="modal-basic-desc">이용자명과 직번을 입력해 주십시오.</span>
						<div class="input-group">
							<input type="text" name="id" placeholder="이용자명" />
							<input type="text" name="employee_no" placeholder="직번" />
						</div>
						<c:if test="${type == 1 }">
						<div class="input-group">
							<img src="/rent/time/captcha" id="captchaImg" alt="captcha img">
							<a href="#none" class="btn by-1 btn-level1 captcha_refresh">새로고침</a>
							<input type="text" placeholder="보안문자를 입력하세요" name="captcha">
						</div>
						</c:if>
						<div class="btn-group">
							<a onclick="imgRefresh()" id="refreshBtn">새로고침</a>
							<button type="button" class="btn by-2 btn-level1 btn-search js-modal__btn-close">취소</button>
							<button type="submit" class="btn by-2 btn-level1 btn-search">예약하기</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			
			</div>
		</div>
		<!-- layer popup//end -->
		<input type="hidden" id="values" name="re_times" value=""/>
		<input type="hidden" name="re_date" value="<c:out value="${date}"/>"/>
		<input type="hidden" name="re_code" value="<c:out value="${code}"/>"/>
		<input type="hidden" name="re_type" value="<c:out value="${type}"/>"/>
	</form>
	
	<c:if test="${success == 1 }">
		<div class="modal-basic js-modal is-expanded" id="modal-login-regular-result"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-reserve__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">예약이 완료되었습니다.</p>
						<span class="modal-basic-desc">※ 예약내역은 (예약 확인 및 취소)페이지에서<br>확인하실 수 있습니다.</span>
						<div class="btn-group">
							<a href="/rent/confirm" class="btn btn-level2 btn-primary">예약 확인 및 취소 바로가기</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		</c:if>
		
		<c:if test="${success == 2 }">
		<div class="modal-basic js-modal is-expanded" id="modal-login-team-result"><!-- layer 제어는 .is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper modal-team__wrapper">
				<div class="modal-basic__body">
					<div class="modal-basic__contents">
						<p class="modal-basic-title">예약이 완료되었습니다.</p>
						<span class="modal-basic-desc">※ 예약내역은 (예약 확인 및 취소)페이지에서<br>확인하실 수 있습니다.</span>
						<div class="btn-group">
							<a href="/rent/confirm" class="btn btn-level2 btn-primary">예약 확인 및 취소 바로가기</a>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		
		</c:if>
	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->
	
	<!-- <script type="text/javascript">
		$("html, body").animate({scrollTop:625}, 'slow');
	</script> -->
	
</div>
<!-- //wrapper -->
<script type="text/javascript" src="/web/assets/js/lib/moment.js"></script>
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	
	$(".captcha_refresh").on("click", function(){
		$(this).parent().find("img").remove();
		$(this).parent().prepend( "<img src='/rent/time/captcha'/>" );
		/* $(#some-id).append('<img src="/rent/time/captcha"/>');
		 $("#captchaImg").attr("src", "/rent/time/captcha?id=" + Math.random()); */
	});
	
	$(".act-done").on("click", function(){
		var times = $('input[name="re_times"]').val();
		if(times == ''){
			alert("코트를 선택해주세요.");
			return;
		}
		
		var type = $('input[name="re_type"]').val();
		if(type == 1){
			var courts = times.split('#');
			if(courts.length > 3){
				alert('2시간 까지만 예약가능합니다.');
				return;
			}
			
			if(courts.length == 3){
				var court1 = courts[0].split('|');
				var court2 = courts[1].split('|');
				
				var tt1 = parseInt(court1[0].split(':')[0]) - parseInt(court2[0].split(':')[0])
				var tt2 = parseInt(court1[1].split('코트')[0]) - parseInt(court2[1].split('코트')[0])
				
				if(tt1 != 1 && tt1 != -1 ){
					alert('1개코트에 연속된 시간만 사용가능합니다.');
					return;
				}
				
				if(tt2 != 0){
					alert('1개코트만 사용가능합니다.');
					return;
				}
				
			}
		}
		
		var _$this = $(this),
	      _$modal = $(_$this.attr('href'));
	    if(_$modal.length > 0) _$modal.addClass('is-expanded').attr('tabindex', '0').focus();
	});
	
	$(".select-team, .select-regular").on("click", function(){
		var value = $(this).data("value");
		var values = $("#values").val();
		
		if($(this).hasClass("select-time")){
			$(this).removeClass("select-time")
			values = values.replace(value, "");
			if($(this).hasClass("select-regular_bak"))
				$(this).addClass("select-regular")
			if($(this).hasClass("select-team_bak"))
				$(this).addClass("select-team")
		}else{
			$(this).addClass("select-time")
			if($(this).hasClass("select-regular")){
				$(this).removeClass("select-regular")
				$(this).addClass("select-regular_bak")
			}
			if($(this).hasClass("select-team")){
				$(this).removeClass("select-team")
				$(this).addClass("select-team_bak")
			}
			
			values += value;
		}
		
		$("#values").val(values);
	});
	
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	var type = form.find('input[name="re_type"]').val()
        	
        	if(type == 1){
	        	input_value = form.find('input[name="id"]').val();
	            if(input_value == ''){
	            	alert("이용자명을 입력해주세요.");
	            	return false;
	            }
	            
	            input_value = form.find('input[name="employee_no"]').val();
	            if(input_value == ''){
	            	alert("직번을 입력해주세요.");
	            	return false;
	            }
	            
	            input_value = form.find('input[name="captcha"]').val();
	            if(input_value == ''){
	            	alert("보안문자를 입력해주세요.");
	            	return false;
	            }
	            
        	}else if(type == 2){
	        	input_value = form.find('input[name="team_id"]').val();
	            if(input_value == ''){
	            	alert("아이디를 입력해주세요.");
	            	return false;
	            }
	            
	            input_value = form.find('input[name="team_pwd"]').val();
	            if(input_value == ''){
	            	alert("비밀번호를 입력해주세요.");
	            	return false;
	            }
	            
	            input_value = form.find('input[name="captcha"]').val();
	            if(input_value == ''){
	            	alert("보안문자를 입력해주세요.");
	            	return false;
	            }
	            
        	}else{
        		return false;
        	}
        	
           	if(!confirm("신청하시겠습니까?"))
           		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	/* alert("성공적으로 처리되었습니다."); */
            	//location.reload(true);
    			location.replace("/rent/time/<c:out value="${code}"/>?date=<c:out value="${date}"/>&success=<c:out value="${type}"/>");
    			/* $("#modal-login-team-result").addClass("is-expanded"); */
            }else if(response == 'NOT_FOUND' || response == 'NOT_MATCHE'){
            		alert("ID 또는 패스워드가 올바르지 않습니다.");
				$(".captcha_refresh").parent().find("img").remove();
            		$(".captcha_refresh").parent().prepend( "<img src='/rent/time/captcha'/>" );
            }else if(response == 'INVALID_ACCESS'){
            	alert("예약 가능한 시간이 지났습니다.");
            }else if(response == 'UNAUTHORIZED'){
            	alert("확인 문자열이 일치하지 않습니다. \n화면에 보이는 문자열을 정확하게 입력해 주십시오.");
            }else if(response == 'DUPLICATE'){
            	alert("중복된 예약이 있습니다.\n1코트 1시간을 예약하신경우, 해당 예약을 취소후 다시 예약하세요.");
            }else{
            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
            }
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }                               
    });
});

</script>

</body>
</html>