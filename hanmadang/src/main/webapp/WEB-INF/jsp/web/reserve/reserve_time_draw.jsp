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
				<div class="rent-tabs">
					<a href="#none" class="by-3 is-selected"><span>배드민턴장</span></a>
					<a href="/rent/time/16?date=<c:out value="${date}"/>" class="by-3"><span>탁구장</span></a>
					<a href="/rent/time/17?date=<c:out value="${date}"/>" class="by-3"><span>당구장</span></a>
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
					
					<div class="calendar-info">
<!-- 					현 화면은 예약현황만 표시되므로 실제 코트 상황과 다를 수 있으니 054)221 - 9280~1로 연락주시면 현황을 확인하실 수 있습니다.<br> -->
<!-- 					※ 직원 예약은 <span class="cl-rent">최대 1코트 2시간</span> 가능<br> -->
					※ 현재 시각 기준 신청가능한 예약은 <span class="cl-green">동호회 예약추첨</span>입니다</div>
					
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
										<c:choose>
											<c:when test="${yoil == '수요일' and (fn:contains(item.key, '18:30 ~') or fn:contains(item.key, '20:30 ~'))}">
											<tr>
												<td><c:out value="${item.key }"/></td>
												<td colspan="6"><span class="select-basic select-general">구기종목의 날</span></td>
											</tr>
											</c:when>
											<c:when test="${yoil == '일요일' and (fn:contains(item.key, '07:00 ~') or fn:contains(item.key, '09:00 ~'))}">
											<tr>
												<td><c:out value="${item.key }"/></td>
												<c:if test="${status.index == 0 }">
												<td colspan="6" rowspan="9">
													<div class="row-message" style="height:460px">
														회사행사 및 동호회, 직원 예약 후 이용은 포스코 및 패밀리사 직원(가족 포함) 가능
														직원예약은 1일전 13시부터 <span class="cl-rent">선착순</span> 예약 가능<br><br>
														<span style="color:blue;">당일 예약 현황은 포스코 배드민턴 동호회 추첨 신청일로 선정 완료(13시)후 확인이 가능합니다. <br><br>※문의 : 221-9283/4</span>
													</div>
												</td>
												</c:if>
												<td colspan="6"><span class="select-basic select-general">구기종목의 날</span></td>
											</tr>
											</c:when>
											<c:when test="${fn:contains(item.key, '18:00 ~') }">
											<tr>
												<td><c:out value="${item.key }"/></td>
												<td colspan="6"><span class="select-basic select-break">크리닝 타임</span></td>
											</tr>
											</c:when>
										<c:otherwise>
											<tr>
												<td><c:out value="${item.key }"/></td>
												<c:if test="${status.index == 0 }">
													<td colspan="6" rowspan="9">
														<div class="row-message" style="height:460px">
															회사행사 및 동호회, 직원 예약 후 이용은 포스코 및 패밀리사 직원(가족 포함) 가능
															직원예약은 1일전 13시부터 <span class="cl-rent">선착순</span> 예약 가능<br><br>
															<span style="color:blue;">당일 예약 현황은 포스코 배드민턴 동호회 추첨 신청일로 선정 완료(13시)후 확인이 가능합니다. <br><br>※문의 : 221-9283/4</span>
														</div>
													</td>
												</c:if>
												<td colspan="2">예약가능 코트수</td>
												<c:set var="usedcourt_cnt" value="6" /> 
												<c:if test="${not empty item.value }">
												<c:forEach var="i" begin="7" end="12" step="1">
													<c:set var="str_i" value="${i}코트" />
													<c:set var="usedcourt" value="" /> 
													<c:forEach items="${item.value }" var="item2" varStatus="status1">
													<c:if test="${fn:contains(item2.rt_court, str_i) and !fn:contains(usedcourt, str_i)}">
														<c:set var="usedcourt" value="${usedcourt += str_i }" /> 
														<c:set var="usedcourt_cnt" value="${usedcourt_cnt - 1}" /> 
													</c:if>
													</c:forEach>
												</c:forEach>
												</c:if>
												<td colspan="4">
													<c:if test="${usedcourt_cnt > 0 }"><a href="#none" data-value="${item.key }" class="check-btn">checked</a></c:if>
													<c:if test="${usedcourt_cnt > 1 }"><a href="#none" data-value="${item.key }" class="check-btn">checked</a></c:if>
													<c:if test="${usedcourt_cnt > 2 }"><a href="#none" data-value="${item.key }" class="check-btn">checked</a></c:if>
													<c:if test="${usedcourt_cnt > 3 }"><a href="#none" data-value="${item.key }" class="check-btn ">checked</a></c:if>
													<c:if test="${usedcourt_cnt > 4 }"><a href="#none" data-value="${item.key }" class="check-btn ">checked</a></c:if>
													<c:if test="${usedcourt_cnt > 5 }"><a href="#none" data-value="${item.key }" class="check-btn ">checked</a></c:if>
												</td>
											</tr>
										</c:otherwise>
										</c:choose>	
									</c:forEach>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="noti-box bg-rent">
						※ 담당자 정보 : 행정섭외 그룹 TEL. 054) 220 - 1155 ｜ EMAIL. csh0319@posco.com
					</div>
				</div>

				<div class="btn-group">
					<a href="/rent/main?code=<c:out value="${code }"/>" class="btn btn-level2 btn-rent">이전으로</a>
					<a href="#modal-login-team" class="btn btn-level2 btn-rent act-done">선택완료</a>
				</div>
			</article>
		</div>
		
		<form id="modForm" method="post" action="/rent/time/draw/save">
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
							<input type="password" name="team_pwd" placeholder="비밀번호" />
						</div>
						<div class="btn-group">
							<a href="#" class="btn by-2 btn-level1 btn-search js-modal__btn-close">취소</a>
							<button type="submit" class="btn by-2 btn-level1 btn-search">예약하기</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/web/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<input type="hidden" id="values" name="re_times" value=""/>
		<input type="hidden" name="re_date" value="<c:out value="${date}"/>"/>
		<input type="hidden" name="re_code" value="<c:out value="${code}"/>"/>
		<input type="hidden" name="re_type" value="<c:out value="${type}"/>"/>
		</form>
	
		<c:if test="${success == 5 }">
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

<!-- 	<script type="text/javascript">
		$("html, body").animate({scrollTop:625}, 'slow');
	</script> -->
	
</div>
<!-- //wrapper -->
<script src="/web/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">


$(function(){
	Map = function(){
		 this.map = new Object();
		};   
		Map.prototype = {   
			    put : function(key, value){   
			        this.map[key] = value;
			    },   
			    get : function(key){   
			        return this.map[key];
			    },
			    containsKey : function(key){    
			     return key in this.map;
			    },
			    containsValue : function(value){    
			     for(var prop in this.map){
			      if(this.map[prop] == value) return true;
			     }
			     return false;
			    },
			    isEmpty : function(key){    
			     return (this.size() == 0);
			    },
			    clear : function(){   
			     for(var prop in this.map){
			      delete this.map[prop];
			     }
			    },
			    remove : function(key){    
			     delete this.map[key];
			    },
			    keys : function(){   
			        var keys = new Array();   
			        for(var prop in this.map){   
			            keys.push(prop);
			        }   
			        return keys;
			    },
			    values : function(){   
			     var values = new Array();   
			        for(var prop in this.map){   
			         values.push(this.map[prop]);
			        }   
			        return values;
			    },
			    size : function(){
			      var count = 0;
			      for (var prop in this.map) {
			        count++;
			      }
			      return count;
			    }
			};
		var reMap = new Map();
		
	$(".act-done").on("click", function(){
		var times = $('input[name="re_times"]').val();
		if(times == ''){
			alert("코트를 선택해주세요.");
			return;
		}
		
		var _$this = $(this),
	      _$modal = $(_$this.attr('href'));
	    if(_$modal.length > 0) _$modal.addClass('is-expanded').attr('tabindex', '0').focus();
	});
	
	$(".check-btn").on("click", function(){
		var value = $(this).data("value");

		if($(this).hasClass("checked")){
			$(this).removeClass("checked")
			
			reMap.put(value, reMap.get(value) - 1);
			
		}else{
			$(this).addClass("checked")
			
			if(reMap.containsKey(value))
				reMap.put(value, reMap.get(value) + 1);
			else
				reMap.put(value, 1);
		}
		
		/* var tmp_value ="";
       	for (var [key, value] of reMap.entries()) {
		  if(value > 0){
			tmp_value += key + "|" + value + "#"
		  }
		} */
       	
		/* var tmp_value ="";
		$.each( reMap.entries(), function( key, value ) {
			if(value > 0){
				tmp_value += key + "|" + value + "#"
			  }
		}); */
		
		var tmp_value ="";
		/* reMap.forEach(function (item, key, mapObj) {  
			if(item > 0){
				tmp_value += key + "|" + item + "#"
			  }
		});  */
		
		for (var idx in reMap.keys()) {

			if(reMap.get(reMap.keys()[idx]) > 0){
				tmp_value += reMap.keys()[idx] + "|" + reMap.get(reMap.keys()[idx]) + "#"
			  }

	      }
		
       	/* alert("tmp_value = " + tmp_value); */
       	$("#values").val(tmp_value);
	});
	
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
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
        	
            input_value = form.find('input[name="re_times"]').val();
           	if(input_value == ''){
           		alert("사용할 코트수 만큼 체크하세요");
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
            }else if(response == 'NOT_FOUND'){
            	alert("등록되지 않은 정보입니다.");
            }else if(response == 'NOT_MATCHE'){
            	alert("비밀번호가 올바르지 않습니다.");
            }else if(response == 'DUPLICATE'){
            	alert("중복된 예약이 있습니다.");
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