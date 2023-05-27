<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>ADMIN</title>
<link rel="stylesheet" href="/css/style.css"/>
<script src="/admin/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>
		<!-- <div class="modal-basic__wrapper"> -->
		<form id="modForm" method="post" action="${ADMIN_PATH}/rent/team/save">
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">동호회 수정하기</div>
							<div class="modal-basic-desc">동호회 수정을 위해 아래 내용을 입력해 주십시오.</div>
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-1">동호회명</label> <input type="text" name="cl_name" value="<c:out value="${club.cl_name }"/>" style="width:200px;" class="text" id="num-1" placeholder="동호회명 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-2">아이디</label> <input type="text" name="cl_id" value="<c:out value="${club.cl_id }"/>" style="width:200px;" class="text" id="num-2" placeholder="아이디 입력" />
						</div>
						<div class="line-form">
							<label class="line-form-name" for="num-3">비밀번호</label> <input type="text" name="cl_passwd" value="<c:out value="${club.cl_passwd }"/>" style="width:200px;" class="text" id="num-3" placeholder="비밀번호 입력" />
						</div>
						<div class="note-text">모든 항목 필수 입력사항 입니다.</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">수정하기</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
				</div>
				<input type="hidden" name="cl_num" value="<c:out value="${club.cl_num }"/>"/>
				
</form>
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

$(function(){
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
            if(form.find('input[name="em_no"]').val() == ''){
            	alert("사원번호를 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="em_name"]').val() == ''){
            	alert("사원명을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="part_name"]').val() == ''){
            	alert("부서명을 입력해주세요.");
            	return false;
            }
            
            if(form.find('input[name="work_name"]').val() == ''){
            	alert("직무명 입력해주세요.");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("성공적으로 처리되었습니다.");
    			location.reload(true);
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