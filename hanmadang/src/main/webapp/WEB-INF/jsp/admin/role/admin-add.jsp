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
						<h2>관리자 관리</h2>
					</article>
					<div class="container-tabs">
						<a href="${ADMIN_PATH}/role/list" class="by-2 is-selected">관리자 계정 관리</a>
						<a href="${ADMIN_PATH}/role/log/list" class="by-2">관리자 활동 로그</a>
					</div>
					<article class="container-body">
						<h3 class="h3-title">관리자 계정 관리</h3>
						<div class="h3-desc">관리자 등록, 정보 수정, 삭제 및  관리자가 접근할 수 있는 항목을 지정합니다.</div>

						<h3 class="h3-title">관리자  리스트 <span class="h3-sub">총 <c:out value="${paging.totalEntryCount}"/>명의 관리자가 있습니다.</span></h3>
						<div class="h3-btn"><a href="#modal-admin-add" class="btn btn-default btn-level act-add">관리자 등록하기</a></div>

						<div class="table-basic">
							<table class="table-basic-type2">
								<colgroup>
									<col width="100px">
									<col width="100px">
									<col width="100px">
									<col width="150px">
									<col width="150px">
									<col width="*">
									<col width="150px">
								</colgroup>
								<thead>
									<tr>
										<th>담당</th>
										<th>이름</th>
										<th>아이디</th>
										<th>전화번호(내선)</th>
										<th>휴대폰 번호</th>
										<th>권한</th>
										<th>수정/삭제</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${not empty list }">
								<c:forEach items="${list }" var="item" varStatus="status">
									<tr>
										<td><c:out value="${item.info}"/></td>
										<td><c:out value="${item.name}"/></td>
										<td><c:out value="${item.id}"/></td>
										<td><c:out value="${item.tel}"/></td>
										<td><c:out value="${item.phone}"/></td>
										<td><span class="tag <c:if test="${fn:contains(item.path_role, 'all')}">tag-selected</c:if>">전체</span>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',content')}">tag-selected</c:if>">컨텐츠관리</span>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',member')}">tag-selected</c:if>">직원관리</span>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',lecture')}">tag-selected</c:if>">수강신청 관리</span>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',class')}">tag-selected</c:if>">수강신청 조회</span>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',rent')}">tag-selected</c:if>">대관관리</span>
										<%-- <span class="tag <c:if test="${fn:contains(item.path_role, ',stats')}">tag-selected</c:if>">홈페이지분석</span> --%>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',gym')}">tag-selected</c:if>">스마트짐 분석</span>
										<span class="tag <c:if test="${fn:contains(item.path_role, ',admin')}">tag-selected</c:if>">관리자 관리</span>
										</td>
										<td><a href="#" data-id="<c:out value="${item.id}"/>" class="btn btn-level btn-rental act-mod">수정</a> <a href="#" data-idx="<c:out value="${item.idx}"/>" class="btn btn-level btn-copy act-del">삭제</a></td>
									</tr>
								</c:forEach>
								</c:if>	
								</tbody>
							</table>
						</div>
						<%@ include file="../common/paging.jsp"%>

					</article>
				</div>
			</div>
		</div>

		<div class="modal-basic js-modal" id="modal-admin-add"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
			<div class="modal-basic__wrapper">
				<form id="modForm" method="post" action="${ADMIN_PATH}/role/save">
				<div class="modal-640__body">
					<div class="modal-basic__contents">
						<div class="modal-basic__header">
							<div class="modal-basic-title">관리자 등록</div>
							<div class="modal-basic-desc">관리자 등록을 위해 아래 내용을 입력해 주십시오.<br><br></div>
							<div class="line-form-admin">
								<label class="line-admin" for="num-1">담당</label>
								<div class="line-group"><input type="text" style="width:300px;" name="info" class="text" id="num-1" placeholder="담당 입력" /></div>
							</div>
							<div class="line-form-admin">
								<label class="line-admin" for="num-2">이름</label>
								<div class="line-group"><input type="text" style="width:200px;" name="name" class="text" id="num-2" placeholder="이름 입력" /></div>
							</div>
							<div class="line-form-admin">
								<label class="line-admin" for="num-3">내선번호</label>
								<div class="line-group"><input type="text" style="width:200px;" name="tel" class="text" id="num-3" placeholder="" /></div>
							</div>
							<div class="line-form-admin">
								<label class="line-admin" for="num-4">전화번호</label>
								<div class="line-group"><input type="text" style="width:200px;" name="phone" class="text" id="num-4" placeholder="" /></div>
							</div>
							<div class="line-form-admin">
								<label class="line-admin" for="">접근권한</label>
								<div class="line-group">
									<a href="#" class="tag role" data-role=",all">전체</a>
									<a href="#" class="tag role" data-role=",content">컨텐츠관리</a>
									<a href="#" class="tag role"  data-role=",member">회원관리</a>
									<a href="#" class="tag role"  data-role=",lecture">수강신청 관리</a>
									<a href="#" class="tag role"  data-role=",class">수강신청 조회</a>
									<a href="#" class="tag role"  data-role=",rent">대관관리</a>
									<!-- <a href="#" class="tag role" data-role=",stats">홈페이지분석</a> -->
									<a href="#" class="tag role" data-role=",gym">스마트짐 분석</a>
									<a href="#" class="tag role" data-role=",admin">관리자 관리</a>
								</div>
								<input class="role-value" type="hidden" name="path_role">
							</div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="id">아이디</label>
							<div class="line-group"><input type="text" style="width:200px;" name="id" class="text" id="id" placeholder="아이디 입력" /> <a href="#" class="btn btn-default btn-level btn-dup">중복확인</a></div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="password">비밀번호</label>
							<div class="line-group"><input type="password" autocomplete="off" style="width:200px;" name="pwd" class="text" id="password" placeholder="비밀번호 입력" /></div>
						</div>
						<div class="line-form-admin">
							<label class="line-admin" for="password2">비밀번호 확인</label>
							<div class="line-group"><input type="password" autocomplete="off" style="width:200px;" name="pwd1" class="text" id="password2" placeholder="비밀번호 입력" /></div>
						</div>
						<div class="note-text">모든 항목 필수 입력사항 입니다.</div>
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
				<input type="hidden" name="idx" value="0"/>
				</form>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
		</div>
		<!-- layer popup//end -->
		
		<div class="modal-basic js-modal" id="modal-admin-mod"><!-- is-expanded -->
			<div class="modal-basic__bg"></div>
		
		</div>
		<!-- layer popup//end -->
	</main>
	<!-- contents//end -->

</div>
<!-- //wrapper -->
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

      /*   console.log(temp0)
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

	$(".act-add").on("click", function(){
		$('#modal-admin-mod .modal-basic__wrapper').remove();
		$('#modal-admin-add').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".act-mod").on("click", function(){
		var id = $(this).data("id");
		$('#modal-admin-mod .modal-basic__wrapper').remove();
		var url = "${ADMIN_PATH}/role/mod?id=" + id;
		$('#modal-admin-mod').append($('<div class="modal-basic__wrapper">').load(url));
		$('#modal-admin-mod').addClass("is-expanded").attr('tabindex', '0').focus();
	});
	
	$(".act-del").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var idx = $(this).data("idx");
			$.ajax({
			     url:'${ADMIN_PATH}${ADMIN_PATH}/role/delete',
			  	data:"idx="+idx,
			     type: 'POST',
			     error: function(){
			    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
			     },
			     success: function(res){
			    	/*  console.log(res); */
			         if(res=='SUCCESS'){
			             alert("성공적으로 처리되었습니다.")
			             location.reload(true);
			         }else{
			        	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res);
			         }
			     }
			 });
		}
	});

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
	
	$(".role").on("click", function(){
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
		
		/* alert(roles); */
});
	
	$('#modForm').ajaxForm({
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
            
            input_value = form.find('input[name="id"]').val();
            if(input_value == ''){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            
            var idx = form.find('input[name="idx"]').val()
            if(idx == '' || idx <= 0){
            	
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
	            
	            /* var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,10}$/
	            if(!passwordRules.test(input_value)){
	            	alert('숫자, 영문자, 특수문자 조합으로 6~10자리를 사용해야 합니다.');
	            		return false;
	            } */
            }
            
            if(!confirm("등록하시겠습니까?"))
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