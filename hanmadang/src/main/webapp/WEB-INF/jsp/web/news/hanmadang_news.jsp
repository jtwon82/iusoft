<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당</title>
<link rel="stylesheet" type="text/css" href="/web/assets/css/style.css">
<!--[if lt IE 9]>
<script src="/web/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/web/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/sly.js" type="text/javascript"></script>
<script src="/web/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- skip -->
<%@ include file="../common/skip.jsp"%>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->

	<%@ include file="../common/header.jsp"%>
	<!-- //header -->
	<!-- contents -->
	<main id="contents" role="main">
		<div id="contents-inner">
			<div class="container-tabs cl-new">
			</div>
			<article class="container-notice bg-new">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>
			
			<article class="container">
				<div class="noti-title">포스코 한마당 체육관의 <span class="cl-new">새로운 소식</span>입니다.</div>
				<div class="news-list">
					<div class="table-basic table-basic-type3">
					<table>
						<caption>새로운 소식에 대한 정보제공</caption>
						<colgroup>
							<col width="110px">
							<col width="*">
							<col width="220px">
							<col width="110px">
							<col width="110px">
						</colgroup>
						<thead>
							<tr>
								<th class="col-center">번호</th>
								<th class="col-center">제목</th>
								<th class="col-center">작성일</th>
								<th class="col-center">조회수</th>
								<th class="col-center"></th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${not empty list }">
						<c:forEach items="${list }" var="item" varStatus="status">
							<tr class="">
								<td class="col-center"><c:out value="${item.rownum}"/></td>
								<td class="col-left normal"><a href="#" class="btn-toggle" data-seq="<c:out value="${item.idx}"/>">
									<c:choose>
										<c:when test="${item.reg_diff < 10}">
											<span style="font-weight:bold"><c:out value="${item.title}"/></span><span class="blinkcss new">New</span>
										</c:when>
										<c:otherwise>
											<span style="font-weight:normal"><c:out value="${item.title}"/></span>
										</c:otherwise>
									</c:choose>
								</a></td>
								<td class="col-center"><c:out value="${fn:substring(item.regidate, 0, 10)}"/></td>
								<td class="col-center"><c:out value="${item.hit}"/></td>
								<td></td>
							</tr>
							<tr class="is-close">
								<td colspan="5">
									<div class="news-body">
										${item.context}
									</div>
								</td>
							</tr>
						</c:forEach>
						</c:if>
							<!-- <tr class="">
								<td>59</td>
								<td class="col-left">포스코 한마당 회원님들의 건강 호전 사례</td>
								<td>2017.11.10</td>
								<td>108</td>
								<td><a href="#" class="btn btn-toggle"><img src="/web/assets/img/btn-door.png" alt="한마당" /></a></td>
							</tr>
							<tr class="is-close">
								<td colspan="5">
									<div class="news-body">
										<img src="http://via.placeholder.com/950x550">
									</div>
								</td>
							</tr>
							<tr class="">
								<td>59</td>
								<td class="col-left">포스코 한마당 회원님들의 건강 호전 사례</td>
								<td>2017.11.10</td>
								<td>108</td>
								<td><a href="#" class="btn btn-toggle"><img src="/web/assets/img/btn-door.png" alt="한마당" /></a></td>
							</tr>
							<tr class="is-close">
								<td colspan="5">
									<div class="news-body">
										<img src="http://via.placeholder.com/800x150">
									</div>
								</td>
							</tr>
							<tr class="">
								<td>59</td>
								<td class="col-left">포스코 한마당 회원님들의 건강 호전 사례</td>
								<td>2017.11.10</td>
								<td>108</td>
								<td><a href="#" class="btn btn-toggle"><img src="/web/assets/img/btn-door.png" alt="한마당" /></a></td>
							</tr>
							<tr class="is-close">
								<td colspan="5">
									<div class="news-body">
										<img src="http://via.placeholder.com/750x250">
									</div>
								</td>
							</tr>
							<tr class="">
								<td>59</td>
								<td class="col-left">포스코 한마당 회원님들의 건강 호전 사례</td>
								<td>2017.11.10</td>
								<td>108</td>
								<td><a href="#" class="btn btn-toggle"><img src="/web/assets/img/btn-door.png" alt="한마당" /></a></td>
							</tr>
							<tr class="is-close">
								<td colspan="5">
									<div class="news-body">
										<img src="http://via.placeholder.com/950x350">
									</div>
								</td>
							</tr> -->
						</tbody>
					</table>
					</div>
					<%@ include file="../common/paging.jsp"%>
					<!-- <div class="paging">
						<a href="#none" class="paging__btn-prev">이전</a>
						<a href="#none" class="paging__num is-selected">1</a>
						<span class="paging__bar">/</span>
						<a href="#none" class="paging__num">5</a>
						<a href="#none" class="paging__btn-next">다음</a>
					</div> -->
					<!--paging//end-->
				</div>
			</article>
		</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$(document).on("click", ".btn-toggle", function(e){
				e.preventDefault();
				var nextCell = $(this).parent().parent().next();
				if(nextCell.hasClass("is-close")){
					//닫힌상태 alert("s");
					$(".news-list tr:nth-child(2n)").addClass("is-close");
					$(".news-list tr.is-open").removeClass("is-open");
					$(".news-list tr.is-selected").removeClass("is-selected");
					$(this).parent().parent().addClass("is-selected");
					nextCell.removeClass("is-close");
					nextCell.addClass("is-open");
					
					var seq = $(this).data("seq");
					$.ajax({
					     url:'/notice/hit',
					  	data:"idx="+seq,
					     type: 'POST',
					     error: function(){
					    	 alert("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요");
					     },
					     success: function(res){
					    	/*  console.log(res); */
					         if(res=='SUCCESS'){
					        	/*  console.log("성공적으로 처리되었습니다.") */
					         }else{
					        	/*  console.log("정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요 : " +  res); */
					         }
					     }
					 });
					
				}else{
					//열린상태 alert("is-open");
					$(".news-list tr.is-selected").removeClass("is-selected");
					nextCell.addClass("is-close");
					$(".news-list tr.is-open").removeClass("is-open");
					nextCell.addClass("is-close");
				}
			})
		})
	</script>

	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
<script>
$(function(){

});

</script>

</body>
</html>