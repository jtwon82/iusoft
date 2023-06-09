<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/admin/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
</head>
<body>

<form name="form" id="form" action="/deploy" method="post" enctype="multipart/form-data">
<input type="file" name="war" value="">
<input type="submit" name="submit" value="SEND">
</form>

<script>
	$('#form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            var start_value = form.find('input[name="war"]').val();
            if(start_value == ''){
            	alert("시작일을 선택해주세요.");
            	return false;
            }
            $('input[name="submit"]').val('...');
            return true;
        },
        success: function(response,status){
            $('input[name="submit"]').val('SEND');
            $('#form')[0].reset();
            console.log(response);
        },
        error: function(){
        	alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
        }
    });
</script>
</body>
</html>