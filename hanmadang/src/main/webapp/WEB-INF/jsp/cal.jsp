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
<script src='/web/assets/calendar/jquery.min.js'></script>
<script>

  $(document).ready(function() {
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

    	ajax_data_upload_callback("/test/cal1", '', '',function(data){
	   	$('#container').empty();
		$('#container').append(data);
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
	<div id='container'>
  </div>
</body>
</html>