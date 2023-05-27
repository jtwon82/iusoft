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
		<form id="modForm" method="post" action="${ADMIN_PATH}/entry/class/sub/add">
			<div class="modal-basic__wrapper">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">강좌 정보 수정</div>
						</div>
						<div class="line-form">
							<div class="line-form-admin">
								<div class="line-time">운동종목</div>
								<div class="line-timeset">
									<span class="selectbox selectbox--type1">
										<select name="b_cate" id="select-main-class">
										<c:forEach items="${mainClass }" var="item" varStatus="status">	
											<option value="<c:out value="${item.b_cate}"/>" <c:if test="${item.b_cate == classInfo.b_cate }">selected</c:if>><c:out value="${item.class_name}"/></option>
										</c:forEach>	
										</select>
									</span>
								</div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">강좌명</div>
								<div class="line-timeset"><input type="text" value="<c:out value="${classInfo.m_cate_name }"/>" name="m_cate_name" class="text" placeholder="" /></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">수강시간</div>
								<div class="line-timeset"><input type="text" value="<c:out value="${classInfo.class_time }"/>" name="class_time" class="text" placeholder="" /></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">정회원 정원</div>
								<div class="line-timeset"><input type="text" value="<c:out value="${classInfo.class_a_count }"/>" name="class_a_count" class="text" placeholder="" style="width:100px;" /><span class="words">명</span></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">준회원 정원</div>
								<div class="line-timeset"><input type="text" value="<c:out value="${classInfo.class_b_count }"/>" name="class_b_count" class="text" placeholder="" style="width:100px;" /><span class="words">명</span></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">일반회원 정원</div>
								<div class="line-timeset"><input type="text" value="<c:out value="${classInfo.class_c_count }"/>" name="class_c_count" class="text" placeholder="" style="width:100px;" /><span class="words">명</span></div>
							</div>
							<div class="line-form-admin">
								<div class="line-time">대기자 정원</div>
								<div class="line-timeset"><input type="text" value="<c:out value="${classInfo.class_standby_count }"/>" name="class_standby_count" class="text" placeholder="" style="width:100px;" /><span class="words">명</span></div>
							</div>
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-level1 btn-default">수정완료</button>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
			<input type="hidden" name="idx_no" value="<c:out value="${classInfo.idx_no }"/>"/>
			<input type="hidden" name="b_cate_name" value="<c:out value="${classInfo.b_cate_name }"/>"/>
				
</form>
<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

$(function(){
	$( "#select-main-class" ).change(function() {
		$('input[name="b_cate_name"]').val($( "#select-main-class option:selected" ).text());
	});
	
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
        	input_value = form.find('input[name="m_cate_name"]').val();
            if(input_value == ''){
            	alert("강좌명을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_time"]').val();
            if(input_value == ''){
            	alert("수강시간을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_a_count"]').val();
            if(input_value == ''){
            	alert("정회원 정원을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_b_count"]').val();
            if(input_value == ''){
            	alert("준회원 정원을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_c_count"]').val();
            if(input_value == ''){
            	alert("일반회원 정원을 입력해주세요.");
            	return false;
            }
            input_value = form.find('input[name="class_standby_count"]').val();
            if(input_value == ''){
            	alert("대기자 정원을 입력해주세요. ");
            	return false;
            }
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("수정완료하였습니다.");
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