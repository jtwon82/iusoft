<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<link href='/web/assets/calendar/fullcalendar.min.css' rel='stylesheet' />
<link href='/web/assets/calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='/web/assets/calendar/moment.min.js'></script>
<script src='/web/assets/calendar/jquery.min.js'></script>
<script src='/web/assets/calendar/fullcalendar.min.js'></script>
<script>

  $(document).ready(function() {
	  	// 마감 날짜 배열 생성
	  var arrayRed = [
			<c:forEach items="${list }" var="item" varStatus="status">
				<c:if test="${item.lock_yn}">'<c:out value = "${item.time_date}" />',</c:if>
			</c:forEach>
			];
	  	
	  	// 팀장 승인 날짜 배열 생성
	  var arrayYellow = [
			<c:forEach items="${list }" var="item" varStatus="status">
				<c:if test="${!item.lock_yn and item.confirm_yn}">'<c:out value = "${item.time_date}" />',</c:if>
			</c:forEach>
			];
	  	
	  	//입력 가능 날짜 배열 생성
	  var arrayGreen = [
			<c:forEach items="${list }" var="item" varStatus="status">
				<c:if test="${!item.lock_yn and !item.confirm_yn}">'<c:out value = "${item.time_date}" />',</c:if>
			</c:forEach>
			];
	  
    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next',
        center: 'title',
        right: ''
      },

      dayRender: function (date, cell) {
    	  
    	  // 백그라운드로 표시할 경우
          /* var rendDate = moment(date).format("YYYYMMDD");
			for( var i = 0; i < arrayRed.length; ++i ) {
			 if( arrayRed[i] === rendDate ){
				 cell.css("background-color", "red");
			   	break;
			 }
			}
			
			for( var i = 0; i < arrayYellow.length; ++i ) {
				 if( arrayYellow[i] === rendDate ){
					 cell.css("background-color", "yellow");
				   	break;
				 }
				}
			
			for( var i = 0; i < arrayGreen.length; ++i ) {
				 if( arrayGreen[i] === rendDate ){
					 cell.css("background-color", "green");
				   	break;
				 }
				}  */
			
      } ,
      
      // 기본 날짜 설정
      defaultDate: "<c:out value="${fn:substring(month, 0, 4)}"/>-<c:out value="${fn:substring(month, 4, 6)}"/>",
      dayClick: function(date, jsEvent, view) {
		 
    	  // 날짜 클릭시 입력 가능일 경우만 처리
		 var rendDate = moment(date).format("YYYYMMDD");
		 for( var i = 0; i < arrayGreen.length; ++i ) {
			 if( arrayGreen[i] === rendDate ){
				alert(moment(date).format("YYYYMMDD"));
			   	break;
			 }
			} 
		 
	    },
      
	    // 날짜별 마감, 팀장승인, 입력가능 표시를 위한 색상 처리
      events: [
		<c:forEach items="${list }" var="item" varStatus="status">
			<c:choose>
			<c:when test="${item.lock_yn}">
			{
				title: '',
				start: '<c:out value = "${fn:substring(item.time_date, 0, 4)}" />-<c:out value = "${fn:substring(item.time_date, 4, 6)}" />-<c:out value = "${fn:substring(item.time_date, 6, 8)}" />',
				color: '#ff0000'
			},
			</c:when>
			<c:when test="${!item.lock_yn and item.confirm_yn}">
			{
				title: '',
				start: '<c:out value = "${fn:substring(item.time_date, 0, 4)}" />-<c:out value = "${fn:substring(item.time_date, 4, 6)}" />-<c:out value = "${fn:substring(item.time_date, 6, 8)}" />',
				color: '#FFFF00'
			},
			</c:when>
			<c:when test="${!item.lock_yn and !item.confirm_yn}">
			{
				title: '',
				start: '<c:out value = "${fn:substring(item.time_date, 0, 4)}" />-<c:out value = "${fn:substring(item.time_date, 4, 6)}" />-<c:out value = "${fn:substring(item.time_date, 6, 8)}" />',
				color: '#00ff00'
			},
			</c:when>
			</c:choose>
		</c:forEach>
		]
    });
    
    var ajax_data_upload_callback = function(_url, _param, _dateType, callback){
	    	if(_dateType == ''){
	    		_dateType = 'json';
	    	}
	    	
	    	$.ajax ({
	    		url : _url,
	    		data : _param,
	    		dateType : _dateType,
	    		success : function(data){
	    			callback(data);
	    		}
	    	});
	}
    
    // 월 이동 이벤트 체크
    $('.fc-prev-button').click(function(){
		var moment = $('#calendar').fullCalendar('getDate');
	   alert(moment.format("YYYYMM"));
	   
	   ajax_data_upload_callback("/test/cal1", {"month":moment.format("YYYYMM")}, '',function(data){
		   $('#container').empty();
			$('#container').append(data);
		});
	   
	});

	$('.fc-next-button').click(function(){
		var moment = $('#calendar').fullCalendar('getDate');
	   alert(moment.format("YYYYMM"));
	   
	   ajax_data_upload_callback("/test/cal1", {"month":moment.format("YYYYMM")}, '',function(data){
		   $('#container').empty();
			$('#container').append(data);
		});
	});
  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>
</head>
<body>
  <div id='calendar'></div>
</body>
</html>