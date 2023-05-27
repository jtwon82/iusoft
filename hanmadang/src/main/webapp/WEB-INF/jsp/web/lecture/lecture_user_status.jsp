<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<ul>
					<li class="by-5 "><a href="/lecture/info">수강신청안내</a></li>
					<li class="by-5 is-selected"><a href="/lecture/status">수강신청</a></li>
					<li class="by-5"><a href="/lecture/list">수강신청내역조회</a></li>
					<li class="by-5"><a href="/lecture/result">선정자발표</a></li>
					<li class="by-5"><a href="/lecture/pay">온라인 결제 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-lecture">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">

				<div class="btn-group" style="margin:-10px 0 0 0;">
					<a href="/lecture/user/terms" class="btn btn-level2 btn-noti">수강신청</a>
				</div>

				<div class="btn-group" style="margin: 34px 0 auto;font-size: 20px;font-weight: bold;">
					* 강습 프로그램은 모집정원 50% 미만 접수 시 폐강이 될 수 있습니다.
				</div>

				<div class="table-basic">
					<table class="table-basic-type2">
						<caption>강좌선택에 대한 정보제공</caption>
						<colgroup>
							<col width="*">
							<col width="36%">
							<col width="240px">
						</colgroup>
						<thead>
							<tr>
								<th class="col-left">강좌명</th>
								<th>요일 및 시간</th>
								<th>참여인원/정원</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty subList }">
							<c:forEach items="${subList }" var="item" varStatus="status">
							
							<tr>
								<td class="col-left"><c:out value="${item.b_cate_name}"/>(<c:out value="${item.class_name}"/>)</td>
								<td><c:out value="${item.class_time}"/></td>
								<td>
									<c:set var="allper" value="${(item.cur_count >= (item.class_a_count + item.class_b_count + item.class_c_count)) ? 100 : (item.cur_count * 100 / (item.class_a_count + item.class_b_count + item.class_c_count))}"/>
									
									<div class="party-state"><span class="value" style="width:<c:out value="${allper}"/>%"></span></div>
									<span class="party-state-per"><c:out value="${item.cur_count }"/>/<c:out value="${item.class_a_count + item.class_b_count + item.class_c_count}"/></span>
								</td>
							</tr>
							</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</article>
		</div>
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
	
	$(".select-cate").on("click", function(){
		var value = $(this).data("value");
		var values = $("#cates").val();
		
		if($(this).hasClass("is-selected")){
			$(this).removeClass("is-selected");
			values = values.replace(value, "");
		}else{
			$(this).addClass("is-selected");
			values += value;
		}
		
		$("#cates").val(values);
		
		alert(values);
	});
	
	$(".select-class").on("click", function(){
		$('.select-class').each(function(index) { 
			$(this).removeClass("btn-point");
			$(this).addClass("btn-default");
			$(this).text("신청");
		});
		
		var value = $(this).data("value");
		
		$(this).addClass("btn-point");
		$(this).removeClass("btn-default");
		$(this).text("선택");
	});
	
	$(".act-done").on("click", function(){
		var c_idx = 0;
		$('.select-class').each(function(index) { 
			if($(this).hasClass("btn-point"))
				c_idx = $(this).data("value");
		});
		
		if(c_idx <= 0){
			alert("강좌를 선택해주세요.");
			return;
		}
		
		$.ajax({
		     url:'/lecture/user/select/check',
		  	data:"c_idx=" + c_idx,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		    	/*  console.log(res); */
		         if(res=='SUCCESS'){
		             location.replace("/lecture/user/pw");
		         }else if(res=='NOT_FOUND'){
		        	 alert("등록되지 않은 직원이거나 사번이 잘못 되었습니다.");
		         }else if(res=='INVALID_TYPE'){
		        	 alert("회원구분을 다시 선택하여 주세요.");
		         }else if(res=='INVALID_PARAM'){
		        	 alert("재직자 입니다. 회원구분을 다시 선택하여 주세요.");
		         }else if(res=='DUPLICATE'){
		        	 alert("이미 등록된 정보입니다.");
		         }else if(res=='INVALID_ACCESS'){
		        	 alert("수강신청 기간이 아닙니다.");
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