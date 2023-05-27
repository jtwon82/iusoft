<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="sms test" />
<title>test</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script>
	$(document).ready(function() {
		$('form').submit(function(e){
			e.preventDefault();
			var thiss= $("form");

			if( thiss.find("input[name='title']").val()=='' ){
        		alert("title x");		return;
        	}
        	if( thiss.find("input[name='msg']").val()=='' ){
        		alert("msg x");		return ;
        	}
        	
			$.ajax({empty:1
				, type: thiss.attr("method")
				, url: thiss.attr("action")
// 				, data: new FormData(thiss)
				, data: thiss.serialize()
// 				, dataType:"json"
		        , success: function(res,stats){
		        	console.log(res);
		        	if( res=='SUCCESS' ){
		        		alert("succ");
		        	}
		        	else{
		        		alert('fail')
		        	}
		        },
		        error: function(){
		        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
		        }
		    });
		});
	});
</script>
</head>
<body>
	<form name="form1" method="GET" action="/ajax/sendSms" >
		<input type="text" name="title" value="">
		<input type="text" name="msg" value="">
		<input type="text" name="pno" value="">
		<input type="submit" value="전송">
	</form>
</body>
</html>