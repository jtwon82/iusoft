<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>ADMIN</title>
<script src="/admin/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>
		<!-- <div class="modal-basic__wrapper"> -->
			<form id="modForm1" method="post" action="${ADMIN_PATH}/role/save">
			<div class="modal-640__body">
				<div class="modal-basic__contents">
					<div class="modal-basic__header">
						<div class="modal-basic-title">관리자 등록</div>
						<div class="modal-basic-desc">관리자 등록을 위해 아래 내용을 입력해 주십시오.<br><br></div>
						<div class="line-form-admin">
							<label class="line-admin" for="num-1">담당</label>
							<div class="line-group"><input type="text" style="width:300px;" name="info" value="<c:out value="${admin.info}"/>" class="text" id="num-1" placeholder="담당 입력" /></div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="num-2">이름</label>
							<div class="line-group"><input type="text" style="width:200px;" name="name" value="<c:out value="${admin.name}"/>" class="text" id="num-2" placeholder="이름 입력" /></div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="num-3">내선번호</label>
							<div class="line-group"><input type="text" style="width:200px;" name="tel" value="<c:out value="${admin.tel}"/>" class="text" id="num-3" placeholder="" /></div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="num-4">전화번호</label>
							<div class="line-group"><input type="text" style="width:200px;" name="phone" value="<c:out value="${admin.phone}"/>" class="text" id="num-4" placeholder="" /></div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="">접근권한</label>
							<div class="line-group">
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, 'all')}">tag-selected</c:if>"" data-role=",all">전체</a>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',content')}">tag-selected</c:if>" data-role=",content">컨텐츠관리</a>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',member')}">tag-selected</c:if>"  data-role=",member">직원관리</a>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',lecture')}">tag-selected</c:if>"  data-role=",lecture">수강신청 관리</a>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',class')}">tag-selected</c:if>"  data-role=",class">수강신청 조회</a>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',rent')}">tag-selected</c:if>"  data-role=",rent">대관관리</a>
								<%-- <a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',stats')}">tag-selected</c:if>" data-role=",stats">홈페이지분석</a> --%>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',gym')}">tag-selected</c:if>" data-role=",gym">스마트짐 분석</a>
								<a href="#" class="tag role1 <c:if test="${fn:contains(admin.path_role, ',admin')}">tag-selected</c:if>" data-role=",admin">관리자 관리</a>
							</div>
							<input class="role-value" type="hidden" name="path_role" value="<c:out value="${admin.path_role}"/>">
						</div>
					</div>
					<div class="line-form-admin">
						<label class="line-admin" for="id">아이디</label>
						<div class="line-group"><input type="text" style="width:200px;" name="id" value="<c:out value="${admin.id}"/>"  class="text" id="id" placeholder="아이디 입력" /> <a href="#" class="btn btn-default btn-level btn-dup">중복확인</a></div>
					</div>
					<div class="line-form-admin">
						<label class="line-admin" for="password">비밀번호</label>
						<div class="line-group"><input type="password" autocomplete="off" style="width:200px;" name="pwd"  class="text" id="password" placeholder="비밀번호 입력" /></div>
					</div>
					<div class="line-form-admin">
						<label class="line-admin" for="password2">비밀번호 확인</label>
						<div class="line-group"><input type="password" autocomplete="off" style="width:200px;" name="pwd1" class="text" id="password2" placeholder="비밀번호 입력" /></div>
					</div>
					<!-- <div class="note-text">모든 항목 필수 입력사항 입니다.</div> -->
					<div class="btn-group">
						<button type="submit" href="#" class="btn btn-level1 btn-default">등록하기</button>
					</div>
					<!-- 수정인경우 //
					<div class="btn-group">
						<a href="#" class="by-2 btn btn-level1 btn-default">삭제하기</a>
						<a href="#" class="by-2 btn btn-level1 btn-default">수정완료</a>
					</div> -->
				</div>
			</div>
			<input type="hidden" name="idx" value="<c:out value="${admin.idx}"/>"/>
			<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
		</form>
	<!-- 	</div> -->

<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>
function passwordCheck(newPassword1) {

    // 길이
    if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{8,15}$/.test(newPassword1))
    { 
        alert("비밀번호는 숫자, 영문, 특수문자 조합으로 8~15자리를 사용해야 합니다."); 
        return false;
    }
     
    // 영문, 숫자, 특수문자 2종 이상 혼용
    var chk = 0;
    if(newPassword1.search(/[0-9]/g) != -1 ) chk ++;
    if(newPassword1.search(/[a-z]/ig)  != -1 ) chk ++;
    if(newPassword1.search(/[!@#$%^&*()?_~]/g)  != -1  ) chk ++;
    if(chk < 3)
    { 
        alert("비밀번호는 숫자, 영문, 특수문자를 혼용하여야 합니다."); 
        return false;
    }
     
    // 동일한 문자/숫자 4이상, 연속된 문자
    if(/(\w)\1\1\1/.test(newPassword1) || isContinuedValue(newPassword1))
    {
        alert("비밀번호에 4자 이상의 연속 또는 반복 문자 및 숫자를 사용하실 수 없습니다."); 
        return false;
    }
     
    return true;
     
}
 
function isContinuedValue(value) {
    /* console.log("value = " + value); */
    var intCnt1 = 0;
    var intCnt2 = 0;
    var temp0 = "";
    var temp1 = "";
    var temp2 = "";
    var temp3 = "";

    for (var i = 0; i < value.length-3; i++) {
        /* console.log("========================="); */
        temp0 = value.charAt(i);
        temp1 = value.charAt(i + 1);
        temp2 = value.charAt(i + 2);
        temp3 = value.charAt(i + 3);

       /*  console.log(temp0)
        console.log(temp1)
        console.log(temp2)
        console.log(temp3) */

        if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == 1
                && temp1.charCodeAt(0) - temp2.charCodeAt(0) == 1
                && temp2.charCodeAt(0) - temp3.charCodeAt(0) == 1) {
            intCnt1 = intCnt1 + 1;
        }

        if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == -1
                && temp1.charCodeAt(0) - temp2.charCodeAt(0) == -1
                && temp2.charCodeAt(0) - temp3.charCodeAt(0) == -1) {
            intCnt2 = intCnt2 + 1;
        }
        /* console.log("========================="); */
    }

    /* console.log(intCnt1 > 0 || intCnt2 > 0); */
    return (intCnt1 > 0 || intCnt2 > 0);
}

$(function(){
	$(".btn-dup").on("click", function(){
		var id = $(this).parent().find("input").val();
		if(id == ""){
			alert("아이디를 입력해주세요.");
			return;
		}
		
		$.ajax({
		     url:'${ADMIN_PATH}/role/check',
		  	data:"id="+id,
		     type: 'POST',
		     error: function(){
		    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
		     },
		     success: function(res){
		    	/*  console.log(res); */
		         if(res=='SUCCESS'){
		             alert("사용 가능한 아이디입니다.")
		         }else if(res=='DUPLICATE'){
		             alert("이미 사용중인 아이디입니다.")
		         }else{
		        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
		         }
		     }
		 });
	});
	
	$(".role1").on("click", function(){
		var role = $(this).data("role");
		var roles = $(this).parents('form').find(".role-value").val();
		
		if($(this).hasClass( "tag-selected" )){
			$(this).removeClass("tag-selected");
			roles = roles.replace(role, "");
		}else{
			$(this).addClass("tag-selected");
			roles += role;
		}
		
		$(this).parents('form').find(".role-value").val(roles);
});
	
	$('#modForm1').ajaxForm({
        beforeSubmit: function (data,form,option) {
        	
            //validation체크 
            input_value = form.find('input[name="info"]').val();
            if(input_value == ''){
            	alert("담당을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="name"]').val();
            if(input_value == ''){
            	alert("이름을 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="tel"]').val();
            if(input_value == ''){
            	alert("내선번호를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="phone"]').val();
            if(input_value == ''){
            	alert("전화번호를 입력해주세요.");
            	return false;
            }
            
            input_value = form.find('input[name="path_role"]').val();
            if(input_value == ''){
            	alert("권한을 선택해주세요.");
            	return false;
            }
            
            /* alert(input_value); */
            
            input_value = form.find('input[name="id"]').val();
            if(input_value == ''){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            
            var idx = form.find('input[name="idx"]').val()
            if(idx == '' || idx <= 0 || form.find('input[name="pwd"]').val() != ''){
	            input_value = form.find('input[name="pwd"]').val();
	            if(input_value == ''){
	            	alert("비밀번호를 입력해주세요.");
	            	return false;
	            }
            
	            input_value = form.find('input[name="pwd1"]').val();
	            if(input_value == ''){
	            	alert("비밀번호 확인을 입력해주세요.");
	            	return false;
	            }
	            
	            input_value = form.find('input[name="pwd1"]').val();
	            if(form.find('input[name="pwd"]').val() != form.find('input[name="pwd1"]').val()){
	            	alert("비밀번호가 일치하지 않습니다.");
	            	return false;
	            }
	            
	            input_value = form.find('input[name="pwd"]').val();
	            if(!passwordCheck(input_value))
	            		return false;
	            
	            /* input_value = form.find('input[name="pwd"]').val();
	            var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,10}$/
	            if(!passwordRules.test(input_value)){
	            	alert('숫자, 영문자, 특수문자 조합으로 6~10자리를 사용해야 합니다.');
	            	return false;
	            } */
            }
            
            if(!confirm("수정하시겠습니까?"))
        		return false;
            
            return true;
        },
        success: function(response,status){
            //성공후 서버에서 받은 데이터 처리
            if(response == 'SUCCESS'){
            	alert("성공적으로 처리되었습니다.");
    			location.reload(true);
            }else if(res=='DUPLICATE'){
	             alert("이미 사용중인 아이디입니다. 중복확인을 해주세요.")
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