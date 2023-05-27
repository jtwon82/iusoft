<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>    
<head>
<title>포스코 한마당 수강등록 결제</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />
<link rel="stylesheet" type="text/css" href="/web/assets/css/style.css">
	<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<!-- 	<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script> -->

</head>

<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0 >
			<div id="wrapper">
				<div class="modal-basic__body" style="width:900px;">
					<div class="modal-basic__contents">
						<!-- <p class="modal-basic-title">[정회원] 휘트니스 3개월에 대한<br>결제페이지로 이동하시겠습니까?</p> -->
						<span class="modal-basic-desc">※결제 버튼 선택시, 결제페이지로 이동합니다.<br>결제를 원치 않으시면 닫기 버튼을 선택해주십시오.</span>
						<div class="btn-group">
							<a href="#" class="js-modal__btn-close btn by-2 btn-level1 btn-select" onclick="window.close();">닫기</a>
							<button type="button" class="btn by-2 btn-level1 btn-smart" onclick="INIStdPay.pay('SendPayForm_id')">결제</button>
						</div>
					</div>
				</div>
				<!-- <a href="#none" title="닫기" class="modal-basic__btn-close js-modal__btn-close"><img src="./assets/img/btn-close.png" alt="레이어 닫기" /></a> -->
			</div>
			
<form id="SendPayForm_id" name="" method="POST" style="display:none;">
<input type="hidden" name="version" value="1.0" >
<input type="hidden" name="mid" value="${mid }" >
<input type="hidden" name="goodname" value="${program.program_name }" >
<input type="hidden" name="oid" value="${oid }" >
<input type="hidden" name="price" value="${price }" >
<input type="hidden" name="currency" value="WON" >
<input type="hidden" name="buyername" value="${member.member_name }" >
<input type="hidden" name="buyertel" value="${member.cellular }" >
<input type="hidden" name="buyeremail" value="${member.email }" >
<input type="hidden" name="timestamp" value="${timestamp }" >
<input type="hidden" name="signature" value="${signature }" >
<input type="hidden" name="returnUrl" value="${siteDomain }/result" >
<input type="hidden" name="mKey" value="${mKey }" >
<input type="hidden" name="gopaymethod" value="Card" >
<input type="hidden" name="offerPeriod" value="${offerPeriod }" >
<input type="hidden" name="acceptmethod" value="CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000" >
<input type="hidden" name="closeUrl" value="${siteDomain }/close" >
<input type="hidden" name="popupUrl" value="${siteDomain }/popup" >
<input type="hidden" name="quotabase" value="${cardQuotaBase }" >
<input type="hidden" name="ini_onlycardcode" value="" >
<input type="hidden" name="ini_cardcode" value="" >
<input type="hidden" name="ansim_quota" value="" >
<input type="hidden" name="INIregno" value="" >
<input type="hidden" name="merchantData" value="" >
</form>

</form>
</body>
</html>