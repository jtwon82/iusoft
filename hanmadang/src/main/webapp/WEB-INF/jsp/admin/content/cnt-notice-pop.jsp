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
			<form id="modForm" method="post" action="${ADMIN_PATH}/content/notice/save">
			<div class="modal-basic__wrapper">
				<div class="modal-wide__body">
					<div class="modal-wide__contents">
						<p class="modal-wide-title">공지사항 수정하기</p>
						<div class="modal-wide__scroll">
							<div class="modal-wide__subject">내용을 수정하고 수정완료 버튼을 선택해 주세요</div>

							<div class="table-basic">
								<table class="table-basic-type2">
									<colgroup>
										<col width="80px">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<td>제목</td>
											<td class="col-left">
												<input type="text" name="title" class="text" value="<c:out value="${notice.title }"/>" placeholder="제목입력" />
											</td>
										</tr>
										<tr>
											<td>내용</td>
											<td class="col-left">
												<textarea name="context1" id="editor2" rows="12" cols="80">${notice.context }</textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>


							<div class="btn-group">
								<button type="submit" class="btn btn-level1 btn-register">수정완료</button>
							</div>
						</div>
					</div>
				</div>
				<a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="/admin/assets/img/btn-close.png" alt="레이어 닫기" /></a>
			</div>
			<!-- <input type="hidden" name="context"/> -->
			<input type="hidden" name="idx" value="<c:out value="${notice.idx }"/>"/>
		</form>
	<!-- 	</div> -->

<script src="/admin/assets/js/jquery.form.js" type="text/javascript"></script>
<script>

CKEDITOR.config.language = 'en';
CKEDITOR.replace( 'editor2' );

$(function(){
	$('form').ajaxForm({
        beforeSubmit: function (data,form,option) {
            //validation체크 
        	input_value = form.find('input[name="title"]').val();
            if(input_value == ''){
            	alert("제목을 입력해주세요.");
            	return false;
            }
            
            var content = CKEDITOR.instances.editor2.getData();
            if(content.length === 0){
            	alert("내용을 입력해주세요.");
                return false;
            }
            
            data.push({name:'context', value:content});
            
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