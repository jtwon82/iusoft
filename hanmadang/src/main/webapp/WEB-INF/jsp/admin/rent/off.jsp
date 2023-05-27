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
						<h2>대관관리</h2>
					</article>
					<div class="container-tabs">
						<%@ include file="tab_menu.jsp"%>
					</div>
					<article class="container-body">
						<h3 class="h3-title"><strong>휴관일관리</strong><br>
						휴관일, 연휴 를 등록하세요.</h3>

						<div class="calendar-body" style="width:760px; margin:0 auto;">
							<div id='calendar'></div>
						</div>
					</article>
				</div>
			</div>
		</div>
		<!-- <center><a href="#modal-off-day" class="js-modal__btn-open">(P)휴관일입력</a></center> -->


		<form id="modForm" method="post" action="${ADMIN_PATH}/rent/off/add">
		<div class="modal-basic js-modal " id="modal-off-day"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">11월 23, 24일 휴관일 정보 입력</div>
							<div class="modal-basic-desc">휴관 사유를 입력해 주십시오.</div>
						</div>
						<input type="text" name = "bl_name" class="text" style="width:50%;" placeholder="휴관 사유 입력" />
						<div class="btn-group">
							<a href="#" class="by-2 btn btn-level1 btn-register js-modal__btn-close act-cancel">취소</a>
							<a href="#none" class="by-2 btn btn-level1 btn-register act-del">삭제</a>
							<button type="submit" class="by-2 btn btn-level1 btn-register">입력완료</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<input type="hidden" name="bl_date"/>
		<input type="hidden" name="bl_num" value="0"/>
		</form>
		<!-- layer popup//end -->
<script type="text/javascript" src="/admin/assets/js/lib/fullcalendar.min.js"></script>
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
function getleaf(size, num){
	var s = num+"";
    while (s.length < size) s = "0" + s;
    return s;
}

function onMod(num, name, date){
	$('input[name="bl_name"]').val(name);
	$('input[name="bl_num"]').val(num);
	$('input[name="bl_date"]').val(date);
	$("#modal-off-day .modal-basic-title").text(parseInt(date.substring(4,6)) + "월 " + parseInt(date.substring(6,8)) +"일 휴관일 정보 수정");
	$("#modal-off-day .act-del").show();
	$("#modal-off-day .act-cancel").hide();
	$("#modal-off-day").addClass("is-expanded");
}

	$(document).ready(function() {
		var isPageLoad = true;
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();

		$('#calendar').fullCalendar({
			header: {
				   right: 'today',
				   center: 'prev, title, next',
				   left: ''
				  },
			dayClick: function(date, jsEvent, view) {
				
				var array = [
				<c:forEach items="${list }" var="item" varStatus="status">
					'<c:out value = "${item.bl_date}" />',
				</c:forEach>
				];

				var clickeDate = date.getFullYear() + getleaf(2, date.getMonth() + 1) + getleaf(2, date.getDate());
				var isExist =false;
				for( var i = 0; i < array.length; ++i ) {
				 if( array[i] === clickeDate ){
				   isExist = true;
				 }
				}
				if(!isExist){
					$('input[name="bl_name"]').val('');
					$('input[name="bl_num"]').val(0);
					$('input[name="bl_date"]').val(clickeDate);
					$("#modal-off-day .modal-basic-title").text(date.getMonth() + 1 + "월 " + date.getDate() +"일 휴관일 정보 입력");
					$("#modal-off-day .act-del").hide();
					$("#modal-off-day .act-cancel").show();
					$("#modal-off-day").addClass("is-expanded");
				}
					
		    },
		    
			viewDisplay: function (element) {
				if(!isPageLoad){
					var moment = $('#calendar').fullCalendar('getDate');
				    location.href = "${ADMIN_PATH}/rent/off?year_month=" + moment.getFullYear() + getleaf(2, moment.getMonth() + 1);
				}
				isPageLoad = false;
		    },
		    year: <c:out value="${fn:substring(year_month, 0, 4)}"/>,
		    month: <c:out value="${fn:substring(year_month, 4, 6) - 1}"/>,
			editable: false,
			events: [
			         
			<c:forEach items="${list }" var="item" varStatus="status">
			{
				title: '<c:out value = "${item.bl_name}" />',
				start: new Date('<c:out value = "${fn:substring(item.bl_date, 0, 4)}" />', '<c:out value = "${fn:substring(item.bl_date, 4, 6) - 1}" />', '<c:out value = "${fn:substring(item.bl_date, 6, 8)}" />'),
				url: 'javascript:onMod(<c:out value = "${item.bl_num}" />, "<c:out value = "${item.bl_name}" />", "<c:out value = "${item.bl_date}" />")',
				color: '#f00b0b',
				textColor: '#ffffff'
			},
			</c:forEach>

			]
		});

	});

		$(function(){
			$('form').ajaxForm({
		        beforeSubmit: function (data,form,option) {
		    		if($('input[name="bl_name"]').val() == ''){
		    			alert("휴관 사유를 입력해주세요.");
		    			return false;
		    		}
		        	
		    		if($('input[name="bl_num"]').val() > 0){
			           	if(!confirm("수정하시겠습니까?"))
			           		return false;
		    		}else{
		    			if(!confirm("등록하시겠습니까?"))
			           		return false;
		    		}
		            
		            return true;
		        },
		        success: function(response,status){
		            //성공후 서버에서 받은 데이터 처리
		            if(response == 'SUCCESS'){
		            	alert("완료되었습니다.");
		            	location.reload(true);
		            }else{
		            	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " + response);
		            }
		        },
		        error: function(){
		        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
		        }                               
		    });
			
			$(".act-del").on("click", function(){
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				var bl_num = $('input[name="bl_num"]').val()
			
				$.ajax({
				     url:'${ADMIN_PATH}/rent/off/del',
				  	data:"bl_num="+bl_num,
				     type: 'POST',
				     error: function(){
				    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
				     },
				     success: function(res){
				    	/*  console.log(res); */
				         if(res=='SUCCESS'){
				             alert("삭제되었습니다.");
				             location.reload(true);
				         }else{
				        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
				         }
				     }
				 });
			});
		});
		
</script>
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
</body>
</html>