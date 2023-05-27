<%@ page contentType = "text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당</title>
<!-- 테스트용 -->
<script type="text/javascript" src="https://testpg.mainpay.co.kr/csStdPayment/resources/script/v1/c2StdPay.js"></script>
<!-- 운영환경용 -->
<!--<script type="text/javascript" src="https://pg.mainpay.co.kr/csStdPayment/resources/script/v1/c2StdPay.js" ></script>-->

</head>
<body>

<form name="mallForm"  id="mallForm"  method="POST">
<input type="hidden" name="version" value="3.1">
<input type="hidden" name="server" value='0'> 
<input type="hidden" name="payKind" value='1'>
<input type="hidden" name="BILLTYPE" value="00">
<input type="hidden" name="mbrId" value="100011">
<input type="hidden" name="mbrName" value="씨스퀘어소프트">

<input type="hidden" name="buyerName" value="<c:out value="${member_session.member_name }"/>">
<input type="hidden" name="buyerMobile" value="<c:out value="${member_session.cellular }"/>">
<input type="hidden" name="buyerEmail" value="">
<input type="hidden" name="oid" value="<c:out value="${orderNo.order_no }"/>">
<input type="hidden" name="productName" value="<c:out value="${program.program_name }"/>">
<input type="hidden" name="salesPrice" value="<c:out value="${program.unit_price }"/>">
<input type="hidden" name="productPrice" value="<c:out value="${program.unit_price }"/>">

<input type="hidden" name="productCount" value="1">
<input type="hidden" name="bizNo" value="1203483832">
<input type="hidden" name="viewType" value="self">
<input type="hidden" name="callbackUrl" value="http://52.231.29.52/my/lecture/pay/callback">
<input type="hidden" name="returnUrl" value="http://52.231.29.52/my/lecture/pay/return">
<input type="hidden" name="cancelUrl" value="http://52.231.29.52/my/lecture/pay/cancel">
<input type="hidden" name="returnType" value="payment">
<input type="hidden" name="hashValue" value="<c:out value="${orderNo.hash }"/>"/>">
<!--휴대폰 결제수단 사용시 -->
<input type="hidden" name="CPCODE" value="">
<input type="hidden" name="authType" value="auth">
<!-- <input type="button" value="__결제요청__" onclick="location.href='/my/lecture/pay/callback'" /> -->
</form>
<script>
C2StdPay.pay();
</script>
</body>
</html>