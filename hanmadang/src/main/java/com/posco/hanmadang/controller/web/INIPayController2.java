package com.posco.hanmadang.controller.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.SignatureException;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.MainPay;
import com.posco.hanmadang.model.Member;
import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.ProgramDetail;
import com.posco.hanmadang.service.MemberService;
import com.posco.hanmadang.service.ProgramService;
import com.posco.hanmadang.util.DateUtil;
import com.posco.hanmadang.util.HttpUtil;
import com.posco.hanmadang.util.ParseUtil;

@Controller
@RequestMapping("/inipay2")
public class INIPayController2 extends CommonController{

	@Value("${inipay.module.dir}")
	private String module_dir = "";
	
	@Value("${inipay.web.url}")
	private String web_url = "";

	@Value("${dev.mode}")
	private boolean dev_mode = false;
	
	@Autowired
	private ProgramService programService;
	@Autowired
	private MemberService memberService;
	
	private String getCardName(String code) {
		String[] names = {"", "하나(외환)", "", "롯데", "현대", "", "국민", "", "", "", 
				"", "BC", "삼성", "", "신한", "한미", "NH", "하나카드", "", "", 
				"", "해외비자", "해외마스터", "JCB", "해외아멕스", "해외다이너스"};
		
		if("56".equals(code))
			return "카카오뱅크";
		
		int idx = Integer.parseInt(code);
		if(idx >= names.length || StringUtils.isEmpty(names[idx]))
			return code;
		
		return names[idx];
	}

	private String getTimestamp() {
		Calendar cal = Calendar.getInstance();
		return new StringBuilder().append(cal.getTimeInMillis()).append("").toString();
	}

	private String hash(String data, String algorithm) throws Exception {
		MessageDigest md = MessageDigest.getInstance(algorithm);

		md.update(data.getBytes("UTF-8"));

		byte[] hashbytes = md.digest();

		StringBuilder sbuilder = new StringBuilder();
		for (int i = 0; i < hashbytes.length; i++) {
			sbuilder.append(String.format("%02x", new Object[] { Integer.valueOf(hashbytes[i] & 0xFF) }));
		}

		return sbuilder.toString();
	}
	
	private String makeSignature(Map<String, String> parameters) throws Exception {
		if ((parameters == null) || (parameters.isEmpty())) {
			throw new RuntimeException("Parameters can not be empty.");
		}

		String parametersString = calculateString(parameters);

		String signature = hash(parametersString, "SHA-256");

		return signature;
	}

	private String calculateString(Map<String, String> parameters) throws SignatureException {
		StringBuffer stringToSign = new StringBuffer("");

		Map sortedParamMap = new TreeMap();
		sortedParamMap.putAll(parameters);
		Iterator pairs = sortedParamMap.entrySet().iterator();
		while (pairs.hasNext()) {
			Map.Entry pair = (Map.Entry) pairs.next();

			stringToSign.append(((String) pair.getKey()).trim());
			stringToSign.append("=");
			stringToSign.append(((String) pair.getValue()).trim());

			if (pairs.hasNext())
				stringToSign.append("&");
		}

		logger.info(
				new StringBuilder().append("stringToSign.toString()=").append(stringToSign.toString()).toString());
		return stringToSign.toString();
	}

	private String makeSignatureAuth(Map<String, String> parameters) throws Exception {
		if ((parameters == null) || (parameters.isEmpty())) {
			throw new RuntimeException("Parameters can not be empty.");
		}

		String stringToSign = "";
		String mid = (String) parameters.get("mid");
		String tstamp = (String) parameters.get("tstamp");
		String MOID = (String) parameters.get("MOID");
		String TotPrice = (String) parameters.get("TotPrice");
		String tstampKey = ((String) parameters.get("tstamp"))
				.substring(((String) parameters.get("tstamp")).length() - 1);

		switch (Integer.parseInt(tstampKey)) {
		case 1:
			stringToSign = new StringBuilder().append("MOID=").append(MOID).append("&mid=").append(mid)
					.append("&tstamp=").append(tstamp).toString();
			break;
		case 2:
			stringToSign = new StringBuilder().append("MOID=").append(MOID).append("&tstamp=").append(tstamp)
					.append("&mid=").append(mid).toString();
			break;
		case 3:
			stringToSign = new StringBuilder().append("mid=").append(mid).append("&MOID=").append(MOID)
					.append("&tstamp=").append(tstamp).toString();
			break;
		case 4:
			stringToSign = new StringBuilder().append("mid=").append(mid).append("&tstamp=").append(tstamp)
					.append("&MOID=").append(MOID).toString();
			break;
		case 5:
			stringToSign = new StringBuilder().append("tstamp=").append(tstamp).append("&mid=").append(mid)
					.append("&MOID=").append(MOID).toString();
			break;
		case 6:
			stringToSign = new StringBuilder().append("tstamp=").append(tstamp).append("&MOID=").append(MOID)
					.append("&mid=").append(mid).toString();
			break;
		case 7:
			stringToSign = new StringBuilder().append("TotPrice=").append(TotPrice).append("&mid=").append(mid)
					.append("&tstamp=").append(tstamp).toString();
			break;
		case 8:
			stringToSign = new StringBuilder().append("TotPrice=").append(TotPrice).append("&tstamp=").append(tstamp)
					.append("&mid=").append(mid).toString();
			break;
		case 9:
			stringToSign = new StringBuilder().append("TotPrice=").append(TotPrice).append("&MOID=").append(MOID)
					.append("&tstamp=").append(tstamp).toString();
			break;
		case 0:
			stringToSign = new StringBuilder().append("TotPrice=").append(TotPrice).append("&tstamp=").append(tstamp)
					.append("&MOID=").append(MOID).toString();
		}

		logger.info(new StringBuilder().append("stringToSign=").append(stringToSign.toString()).toString());
		logger.info(new StringBuilder().append("tstampKey,tstamp=").append(tstampKey).append(",").append(tstamp)
				.toString());

		String signature = hash(stringToSign, "SHA-256");

		return signature;
	}
	
	@RequestMapping(value="/popup", method=RequestMethod.GET)
	public String popup(HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(value="code", defaultValue="") String program_code,
			HttpServletResponse response) throws Exception{

		return "web/inipay2/popup";
	}
	@RequestMapping(value="/close", method=RequestMethod.GET)
	public String close(HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(value="code", defaultValue="") String program_code,
			HttpServletResponse response) throws Exception{

		return "web/inipay2/close";
	}

	@RequestMapping(value="/start", method=RequestMethod.GET)
	public String start(HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(value="code", defaultValue="") String program_code,
			HttpServletResponse response) throws Exception{
		
		//############################################
		// 1.전문 필드 값 설정(***가맹점 개발수정***)
		//############################################

		// 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
//		String mid					= "poscowel00";		// 가맹점 ID(가맹점 수정후 고정)					
		
		//인증
//		String signKey			    = "S2xZcUxUS3lMZ1JNekptNHpCZkZmdz09";	// 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
		

		String mid					= "poscohan01";		// 가맹점 ID(가맹점 수정후 고정)					
		String signKey			    = "MVl5VVMzcFZlLzN2Tk1LbGV3MU9vQT09";	// 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
		String timestamp			= getTimestamp();			// util에 의해서 자동생성

		String oid					= mid +"_"+ getTimestamp();	// 가맹점 주문번호(가맹점에서 직접 설정)
		String price				= "1000";													// 상품가격(특수기호 제외, 가맹점에서 직접 설정)

		String cardNoInterestQuota	= "11-2:3:,34-5:12,14-6:12:24,12-12:36,06-9:12,01-3:4";		// 카드 무이자 여부 설정(가맹점에서 직접 설정)
		String cardQuotaBase		= "2:3:6";		// 가맹점에서 사용할 할부 개월수 설정

		if(1==1) {
			Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
			if(member == null)
				return null;
			
			ProgramDetail program = programService.findProgram(program_code);
			if(program == null)
				return null;
			
			model.addAttribute("member", member);
			model.addAttribute("program", program);
			
			OrderNo orderNo = new OrderNo();
			orderNo.setMember_code(member.getMember_code());
			orderNo.setOrder_no(programService.getReceiptSeq());
			orderNo.setProgram_code(program_code);
			orderNo.setServer_yn(Constant.YesNoStatus.N.name());

			price = program.getUnit_price();
			logger.debug("INIPayController###########order_no : " + orderNo.getOrder_no());
			oid = orderNo.getOrder_no();
			
			session.setAttribute("oid", oid);
			session.setAttribute("price", price);
			
			programService.updateOrderNo(orderNo);
			
		}
		
		
		//###############################################
		// 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
		//###############################################
		String mKey = hash(signKey, "SHA-256");
		
		//###############################################
		// 2.signature 생성
		//###############################################
		Map<String, String> signParam = new HashMap<String, String>();
		signParam.put("oid", oid); 					// 필수
		signParam.put("price", price);				// 필수
		signParam.put("timestamp", timestamp);		// 필수

		// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
		String signature = makeSignature(signParam);
		
		/* 기타 */
		String siteDomain= web_url +"/inipay2"; //가맹점 도메인 입력
		if(dev_mode) {
			siteDomain= "http://weespk.iptime.org:8088/inipay2";
		}
		// 페이지 URL에서 고정된 부분을 적는다. 
		// Ex) returnURL이 http://localhost:8080INIpayStdSample/INIStdPayReturn.jsp 라면
		// http://localhost:8080/INIpayStdSample 까지만 기입한다.

		model.addAttribute("oid", oid);
		model.addAttribute("price", price);
		model.addAttribute("mid", mid);
		model.addAttribute("timestamp", timestamp);
		model.addAttribute("signature", signature);
		model.addAttribute("siteDomain", siteDomain);
		model.addAttribute("mKey", mKey);
		model.addAttribute("cardQuotaBase", cardQuotaBase);
		model.addAttribute("offerPeriod", String.format("%s-%s", DateUtil.getDateToStr("yyyyMMdd", new Date())
				, DateUtil.getDateToStr("yyyyMMdd", new Date())));
		
		logger.info(String.format("model:%s", model.toString()));
		
		return "web/inipay2/INIStdPayRequest";
	}

	@RequestMapping(value="/result", method=RequestMethod.POST)
	public String result(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response){

		try{
			StringBuffer outPrintln= new StringBuffer();

			//#############################
			// 인증결과 파라미터 일괄 수신
			//#############################
			request.setCharacterEncoding("UTF-8");

			Map<String,String> paramMap = new Hashtable<String,String>();

			Enumeration elems = request.getParameterNames();

			String temp = "";

			while(elems.hasMoreElements())
			{
				temp = (String) elems.nextElement();
				paramMap.put(temp, request.getParameter(temp));
			}
			logger.info(String.format("325 paramMap:%s", paramMap.toString()));
			
			//System.outPrintln.append("paramMap : "+ paramMap.toString());
			
			//#####################
			// 인증이 성공일 경우만
			//#####################
			if("0000".equals(paramMap.get("resultCode"))){

				String oid="";
				String price="";
				try {
					//oid= session.getAttribute("oid").toString();
					oid= paramMap.get("orderNumber").toString();
//					OrderNo orderNo = programService.findOrderNo(oid);
//					
//					ProgramDetail program = programService.findProgram(orderNo.getProgram_code());
//					price= program.getUnit_price(); //session.getAttribute("price").toString();
					
				}catch(Exception ee) {
					logger.info(String.format("347 none orderNumber %s", session.toString()));
				}
				
				OrderNo orderNo = programService.findOrderNo(oid);
				if(orderNo!=null) {
					logger.info(String.format("358 findOrderNo:%s", orderNo));
				}else if(orderNo == null) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out;
					try { 
						out = response.getWriter();
						out.println("<script>alert('잘못 된 접근입니다.'); window.close();window.opener.location.reload(true);</script>");
						out.flush();
					} catch (IOException e) {
						logger.error(String.format("345 err %s", e.getMessage()));
					}
					return null;
				}
				
				ProgramDetail program = programService.findProgram(orderNo.getProgram_code());
				if(program!=null) {
					logger.info(String.format("374 findProgram:%s", program.toString()));
				}else if(program == null) {
					response.setContentType("text/html; charset=UTF-8");
			        PrintWriter out;
					try { 
						out = response.getWriter();
						out.println("<script>alert('잘못 된 접근입니다 .'); window.close();window.opener.location.reload(true);</script>");
					    out.flush();
					} catch (IOException e) {
						logger.error(String.format("358 err %s", e.getMessage()));
					}
					
					return null;
				}
				price= program.getUnit_price();
				
				outPrintln.append("####인증성공/승인요청####");
				outPrintln.append("<br/>");
				
				logger.info(String.format("367 outPrintln:%s", outPrintln.toString()));

				//############################################
				// 1.전문 필드 값 설정(***가맹점 개발수정***)
				//############################################
				
				String mid 		= paramMap.get("mid");						// 가맹점 ID 수신 받은 데이터로 설정
				String signKey	= "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";		// 가맹점에 제공된 키(이니라이트키) (가맹점 수정후 고정) !!!절대!! 전문 데이터로 설정금지
				String timestamp= getTimestamp();				// util에 의해서 자동생성
				String charset 	= "UTF-8";								    // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
				String format 	= "JSON";								    // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)
				String authToken= paramMap.get("authToken");			    // 취소 요청 tid에 따라서 유동적(가맹점 수정후 고정)
				String authUrl	= paramMap.get("authUrl");				    // 승인요청 API url(수신 받은 값으로 설정, 임의 세팅 금지)
				String netCancel= paramMap.get("netCancelUrl");			 	// 망취소 API url(수신 받은 값으로 설정, 임의 세팅 금지)
//				String ackUrl 	= paramMap.get("checkAckUrl");			    // 가맹점 내부 로직 처리후 최종 확인 API URL(수신 받은 값으로 설정, 임의 세팅 금지)		
				String merchantData = paramMap.get("merchantData");			// 가맹점 관리데이터 수신
				String orderNumber=		paramMap.get("orderNumber");
				
				//#####################
				// 2.signature 생성
				//#####################
				Map<String, String> signParam = new HashMap<String, String>();
				signParam.put("authToken",	authToken);		// 필수
				signParam.put("timestamp",	timestamp);		// 필수

				// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
				String signature = makeSignature(signParam);

//	      		String price = "";  // 가맹점에서 최종 결제 가격 표기 (필수입력아님)
	      		
			    // 1. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.  
			    // String oid = "";             
	      
				//#####################
				// 3.API 요청 전문 생성
				//#####################
				Map<String, String> authMap = new Hashtable<String, String>();
				authMap.put("mid"			    ,mid);			  // 필수
				authMap.put("authToken"		,authToken);	// 필수
				authMap.put("signature"		,signature);	// 필수
				authMap.put("timestamp"		,timestamp);	// 필수
				authMap.put("charset"		  ,charset);		// default=UTF-8
				authMap.put("format"		  ,format);		  // default=XML
	      		//authMap.put("price" 		,price);		    // 가격위변조체크기능 (선택사용)
	      
				//System.outPrintln.append("##승인요청 API 요청##");
				
				logger.info(String.format("413 authMap:%s", authMap.toString()));

				HttpUtil httpUtil = new HttpUtil();

				try{
					//#####################
					// 4.API 통신 시작
					//#####################

					String authResultString = "";

					logger.info(String.format("424 authMap:%s", authMap.toString()));
					
					authResultString = httpUtil.processHTTP(authMap, authUrl);
					
					//############################################################
					//5.API 통신결과 처리(***가맹점 개발수정***)
					//############################################################
					outPrintln.append("## 승인 API 결과 ##");
					
					String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");

					logger.info(String.format("435 test:%s",  test.toString()));
					
					//outPrintln.append("<pre>"+authResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</pre>");
					
					Map<String, String> resultMap = new HashMap<String, String>();
					
					resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱
					
					logger.info(String.format("443 resultMap:%s",  resultMap.toString()));
					
					
					//System.outPrintln.append("resultMap == " + resultMap);
					outPrintln.append("<pre>");
					outPrintln.append("<table width='565' border='0' cellspacing='0' cellpadding='0'>");
					
					/*************************  결제보안 강화 2016-05-18 START ****************************/ 
					Map<String , String> secureMap = new HashMap<String, String>();
					secureMap.put("mid"			, mid);								//mid
					secureMap.put("tstamp"		, timestamp);						//timestemp
					secureMap.put("MOID"		, resultMap.get("MOID"));			//MOID
					secureMap.put("TotPrice"	, resultMap.get("TotPrice"));		//TotPrice
					
					// signature 데이터 생성 
					String secureSignature = makeSignatureAuth(secureMap);
					/*************************  결제보안 강화 2016-05-18 END ****************************/

					logger.info(String.format("459 secureMap:%s", secureMap.toString()));
					
					if ("0000".equals(resultMap.get("resultCode"))
							&& secureSignature.equals(resultMap.get("authSignature"))) { // 결제보안 강화 2016-05-18
						/*****************************************************************************
						 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.
						 * 
						 * [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함 처리중 에러 발생시 망취소를 한다.
						 ******************************************************************************/

						{
							boolean cancelFlag = false;
							if (Integer.parseInt(program.getUnit_price()) == Integer.parseInt(resultMap.get("TotPrice"))) {
								MainPay payInfo = new MainPay();
								payInfo.setSalesPrice(price);
								payInfo.setOid(resultMap.get("tid"));
								payInfo.setCardApproveDate(resultMap.get("applDate"));
								payInfo.setCardApproveTime(resultMap.get("applTime"));
								payInfo.setCardTradeNo(resultMap.get("applNum"));
								payInfo.setCardNum(resultMap.get("CARD_Num"));
								payInfo.setInstallNo(resultMap.get("CARD_Quota"));
								payInfo.setCardName(resultMap.get("CARD_Code"));
								payInfo.setCardCode(resultMap.get("CARD_Code"));

								/*******************************************************************
								 * 7. DB연동 실패 시 강제취소 * * 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는 * 경우, 아래의 코드를 참조하여
								 * 이미 지불된 거래를 취소하는 코드를 * 작성합니다. *
								 *******************************************************************/
								try {
									int totalPrice = Integer.parseInt(resultMap.get("TotPrice"));
									if (totalPrice <= 0) {
										payInfo.setSales_amount(0);
										payInfo.setVat_amount(0);
									} else {
										payInfo.setSales_amount((totalPrice * 10) / 11);

										int vatPrice = totalPrice - payInfo.getSales_amount();
										if (vatPrice < 0)
											payInfo.setVat_amount(0);
										else
											payInfo.setVat_amount(vatPrice);
									}

									logger.info(String.format("504 payInfo:%s", payInfo.toString()));

									orderNo.setPay(payInfo);

									programService.procPay(orderNo, program);
									programService.updateOrderNoStatus(orderNo.getOrder_no(),
											Constant.YesNoStatus.Y.name());

									logger.debug(
											"INIPayController##########################################################1");

									// cancelFlag = true;
								} catch (Exception e) {
									cancelFlag = true;
								}

							} else {
								cancelFlag = true;
							}

							if (cancelFlag) {
								// String tmp_TID = resultMap.get("tid");
								// inipay.SetField("type", "cancel"); // 고정
								// inipay.SetField("tid", tmp_TID); // 고정
								// inipay.SetField("cancelmsg", "DB FAIL"); // 취소사유
								// inipay.startAction();

								// Map<String, String> cancelMap= new Hashtable<String, String>();
								// cancelMap.put("", "");
								// authResultString = httpUtil.processHTTP(authMap, netCancel);
								
								httpUtil.processHTTP(authMap, netCancel);

								response.setContentType("text/html; charset=UTF-8");
								PrintWriter out;
								try {
									out = response.getWriter();
									out.println(
											"<script>alert('결제가 취소되었습니다.'); window.close();window.opener.location.reload(true);</script>");
									out.flush();
								} catch (IOException e) {
									logger.error(String.format("545 err %s", e.getMessage()));
								}

							} else {

								response.setContentType("text/html; charset=UTF-8");
								PrintWriter out;
								try {
									out = response.getWriter();
									out.println(
											"<script>alert('결제가 완료되었습니다.');window.close();window.opener.location.reload(true);</script>");
									out.flush();
								} catch (IOException e) {
									logger.error(String.format("558 err %s", e.getMessage()));
								}
							}

							return null;
						}
					}
					else {
						outPrintln.append("<tr><th><p>거래 성공 여부</p></th>");
						outPrintln.append("<td><p>실패</p></td></tr>");
						outPrintln.append("<tr><th><p>결과 코드</p></th>");
						outPrintln.append("<td><p>" +resultMap.get("resultCode")+"</p></td></tr>");
						outPrintln.append("<tr><th><p>결과 내용</p></th>");
						outPrintln.append("<td><p>" +resultMap.get("resultMsg")+"</p></td></tr>");
						
						//결제보안키가 다른 경우
						if (!secureSignature.equals(resultMap.get("authSignature")) && "0000".equals(resultMap.get("resultCode"))) {
							//결과정보
							outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
							outPrintln.append("<tr><th><p>결과 내용</p></th>");
							outPrintln.append("<td><p>* 데이터 위변조 체크 실패</p></td></tr>");	
							
							//망취소
							if ("0000".equals(resultMap.get("resultCode"))) {
								throw new Exception("데이터 위변조 체크 실패");
							}
						}
					}
						
					// output
					
				} catch (Exception ex) {

					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################

					//---- db 저장 실패시 등 예외처리----//
//					System.outPrintln.append(ex);

					//#####################
					// 망취소 API
					//#####################
					String netcancelResultString = httpUtil.processHTTP(authMap, netCancel);	// 망취소 요청 API url(고정, 임의 세팅 금지)

					outPrintln.append("## 망취소 API 결과 ##");

					// 취소 결과 확인
					outPrintln.append("<p>"+netcancelResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</p>");
					

					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out;
					try {
						out = response.getWriter();
						out.println(
								"<script>alert('결제가 취소되었습니다.'); window.close();window.opener.location.reload(true);</script>");
						out.flush();
					} catch (IOException e) {
						logger.error(String.format("617 err %s", e.getMessage()));
					}
					return null;
				}

			}else{

				//#############
				// 인증 실패시
				//#############
				outPrintln.append("<br/>");
				outPrintln.append("####인증실패####");

				outPrintln.append("<p>"+paramMap.toString()+"</p>");

			}
			
			model.addAttribute("output", outPrintln.toString());

		}catch(Exception e){
			logger.error(String.format("637 err %s", e.getMessage()));
		}		
		
		return "web/inipay2/INIStdPayReturn";
	}

	
	private String getOutputHtml(Map<String, String> resultMap) {
		StringBuffer outPrintln = new StringBuffer();
		//공통 부분만
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		outPrintln.append("<tr><th><p>거래 번호</p></th>");
		outPrintln.append("<td><p>" +resultMap.get("tid")+"</p></td></tr>");
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		outPrintln.append("<tr><th><p>결제방법(지불수단)</p></th>");
		outPrintln.append("<td><p>" +resultMap.get("payMethod")+"</p></td></tr>");
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		outPrintln.append("<tr><th><p>결제완료금액</p></th>");
		outPrintln.append("<td><p>" +resultMap.get("TotPrice")+"원</p></td></tr>");
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		outPrintln.append("<tr><th><p>주문 번호</p></th>");
		outPrintln.append("<td><p>" +resultMap.get("MOID")+"</p></td></tr>");
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		outPrintln.append("<tr><th><p>승인날짜</p></th>");
		outPrintln.append("<td><p>" +resultMap.get("applDate")+"</p></td></tr>");
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		outPrintln.append("<tr><th><p>승인시간</p></th>");
		outPrintln.append("<td><p>" +resultMap.get("applTime")+"</p></td></tr>");
		outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
		
		if("VBank".equals(resultMap.get("payMethod"))){ //가상계좌
			
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>입금 계좌번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("VACT_Num")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>입금 은행코드</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("VACT_BankCode")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>입금 은행명</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("vactBankName")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>예금주 명</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("VACT_Name")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>송금자 명</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("VACT_InputName")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>송금 일자</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("VACT_Date")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>송금 시간</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("VACT_Time")+"</p></td></tr>");
			
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");	
			
		}else if("DirectBank".equals(resultMap.get("payMethod"))){ //실시간계좌이체
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>은행코드</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("ACCT_BankCode")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>현금영수증 발급결과코드</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CSHR_ResultCode")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>현금영수증 발급구분코드</p> <font color=red><b>(0 - 소득공제용, 1 - 지출증빙용)</b></font></th>");
			outPrintln.append("<td><p>" +resultMap.get("CSHR_Type")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			 
		}else if("iDirectBank".equals(resultMap.get("payMethod"))){ //실시간계좌이체
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>은행코드</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("ACCT_BankCode")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>현금영수증 발급결과코드</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CSHRResultCode")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>현금영수증 발급구분코드</p> <font color=red><b>(0 - 소득공제용, 1 - 지출증빙용)</b></font></th>");
			outPrintln.append("<td><p>" +resultMap.get("CSHR_Type")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			 
		}else if("HPP".equals(resultMap.get("payMethod"))){ //휴대폰
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>통신사</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("HPP_Corp")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>결제장치</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("payDevice")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>휴대폰번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("HPP_Num")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}else if("DGCL".equals(resultMap.get("payMethod"))){//게임문화상품권
			String sum="0",sum2="0",sum3="0",sum4="0",sum5="0",sum6="0";
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>게임문화상품권승인금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GAMG_ApplPrice")+"원</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>사용한 카드수</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GAMG_Cnt")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>사용한 카드번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GAMG_Num1")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>카드잔액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GAMG_Price1")+"원</p></td></tr>");
			
			if(!"".equals(resultMap.get("GAMG_Num2"))){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>사용한 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Num2")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>카드잔액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Price2")+"원</p></td></tr>");
			}
			if(!"".equals(resultMap.get("GAMG_Num3"))){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>사용한 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Num3")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>카드잔액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Price3")+"원</p></td></tr>");
			}
			if(!"".equals(resultMap.get("GAMG_Num4"))){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>사용한 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Num4")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>카드잔액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Price4")+"원</p></td></tr>");
			}
			if(!"".equals(resultMap.get("GAMG_Num5"))){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>사용한 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Num5")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>카드잔액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Price5")+"원</p></td></tr>");
			}
			if(!"".equals(resultMap.get("GAMG_Num6"))){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>사용한 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Num6")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>카드잔액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GAMG_Price6")+"원</p></td></tr>");
			}
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}else if("OCBPoint".equals(resultMap.get("payMethod"))){ //오케이 캐쉬백
		
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>지불구분</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("PayOption")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
//				outPrintln.append("<tr><th><p>결제완료금액</p></th>");
//				outPrintln.append("<td><p>" +resultMap.get("applPrice")+"원</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>OCB 카드번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("OCB_Num")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>적립 승인번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("OCB_SaveApplNum")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>사용 승인번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("OCB_PayApplNum")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");					
			outPrintln.append("<tr><th><p>OCB 지불 금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("OCB_PayPrice")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}else if("GSPT".equals(resultMap.get("payMethod"))){ //GSPoint
		
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>지불구분</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("PayOption")+"</p></td></tr>");					
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>GS 포인트 승인금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GSPT_ApplPrice")+"원</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>GS 포인트 적립금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GSPT_SavePrice")+"원</p></td></tr>");					
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>GS 포인트 지불금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("GSPT_PayPrice")+"원</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}else if("UPNT".equals(resultMap.get("payMethod"))){ //U-포인트
			
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>U포인트 카드번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("UPoint_Num")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>가용포인트</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("UPoint_usablePoint")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");			
			outPrintln.append("<tr><th><p>포인트지불금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("UPoint_ApplPrice")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}
		else if("KWPY".equals(resultMap.get("payMethod"))){ //뱅크월렛 카카오
			outPrintln.append("<tr><th><p>결제방법</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("payMethod")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>결과 코드</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("resultCode")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>결과 내용</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("resultMsg")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>거래 번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("tid")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>주문 번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("MOID")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>결제완료금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("price")+"원</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>사용일자</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("applDate")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>사용시간</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("applTime")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}else if("Culture".equals(resultMap.get("payMethod"))){//문화 상품권
		  outPrintln.append("<tr><th><p>컬처랜드 아이디</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CULT_UserID")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			
		}else if("TEEN".equals(resultMap.get("payMethod"))){//틴캐시
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>틴캐시 승인번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("TEEN_ApplNum")+"</p></td></tr>");									
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>틴캐시아이디</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("TEEN_UserID")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>틴캐시승인금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("TEEN_ApplPrice")+"원</p></td></tr>");	
								
		}else if("Bookcash".equals(resultMap.get("payMethod"))){//도서문화상품권
			
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>도서상품권 승인번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("BCSH_ApplNum")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>도서상품권 사용자ID</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("BCSH_UserID")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>도서상품권 승인금액</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("BCSH_ApplPrice")+"원</p></td></tr>");
			
		}else if("PhoneBill".equals(resultMap.get("payMethod"))){//폰빌전화결제
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>승인전화번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("PHNB_Num")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			

		}else if("Bill".equals(resultMap.get("payMethod"))){//빌링결제
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>빌링키</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CARD_BillKey")+"</p></td></tr>");
		}else if("Auth".equals(resultMap.get("payMethod"))){//빌링결제
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>빌링키</p></th>");
			if ("BILL_CARD".equalsIgnoreCase(resultMap.get("payMethodDetail"))) {
				outPrintln.append("<td><p>" +resultMap.get("CARD_BillKey")+"</p></td></tr>");
			} else  if ("BILL_HPP".equalsIgnoreCase(resultMap.get("payMethodDetail"))) {
				outPrintln.append("<td><p>" +resultMap.get("HPP_BillKey")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>통신사</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("HPP_Corp")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>결제장치</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("payDevice")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>휴대폰번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("HPP_Num")+"</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>상품명</p></th>");			//상품명
				outPrintln.append("<td><p>" +resultMap.get("goodName")+"</p></td></tr>");

			} else {
				//
			}		
		}else if("HPMN".equals(resultMap.get("payMethod"))){//해피머니
			
		}else{//카드
			int  quota=Integer.parseInt(resultMap.get("CARD_Quota"));
			if(resultMap.get("EventCode")!=null){				
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>이벤트 코드</p></th>");					
				outPrintln.append("<td><p>" +resultMap.get("EventCode")+"</p></td></tr>");
			}
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>카드번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CARD_Num")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>승인번호</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("applNum")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>할부기간</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CARD_Quota")+"</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			if("1".equals(resultMap.get("CARD_Interest")) || "1".equals(resultMap.get("EventCode"))){					
				outPrintln.append("<tr><th><p>할부 유형</p></th>");
				outPrintln.append("<td><p>무이자</p></td></tr>");	
			}else if(quota > 0 && !"1".equals(resultMap.get("CARD_Interest"))){
				outPrintln.append("<tr><th><p>할부 유형</p></th>");
				outPrintln.append("<td><p>유이자 <font color='red'> *유이자로 표시되더라도 EventCode 및 EDI에 따라 무이자 처리가 될 수 있습니다.</font></p></td></tr>");
			}
				
			if("1".equals(resultMap.get("point"))){
				outPrintln.append("<td><p></p></td></tr>");
				outPrintln.append("<tr><th><p>포인트 사용 여부</p></th>");
				outPrintln.append("<td><p>사용</p></td></tr>");
			}else{
				outPrintln.append("<td><p></p></td></tr>");
				outPrintln.append("<tr><th><p>포인트 사용 여부</p></th>");
				outPrintln.append("<td><p>미사용</p></td></tr>");
			}
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>카드 종류</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CARD_Code")+ "</p></td></tr>");
			outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
			outPrintln.append("<tr><th><p>카드 발급사</p></th>");
			outPrintln.append("<td><p>" +resultMap.get("CARD_BankCode")+ "</p></td></tr>");
			
			if(resultMap.get("OCB_Num")!=null && resultMap.get("OCB_Num") != ""){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>OK CASHBAG 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("OCB_Num")+ "</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>OK CASHBAG 적립 승인번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("OCB_SaveApplNum")+ "</p></td></tr>");
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>OK CASHBAG 포인트지불금액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("OCB_PayPrice")+ "</p></td></tr>");
			}
			if(resultMap.get("GSPT_Num")!=null && resultMap.get("GSPT_Num") != ""){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>GS&Point 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GSPT_Num")+ "</p></td></tr>");
				
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>GS&Point 잔여한도</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GSPT_Remains")+ "</p></td></tr>");
				
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>GS&Point 승인금액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("GSPT_ApplPrice")+ "</p></td></tr>");
			}
			
			if(resultMap.get("UNPT_CardNum")!=null && resultMap.get("UNPT_CardNum") != ""){
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>U-Point 카드번호</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("UNPT_CardNum")+ "</p></td></tr>");
				
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>U-Point 가용포인트</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("UPNT_UsablePoint")+ "</p></td></tr>");
				
				outPrintln.append("<tr><th colspan='2'><p></p></th></tr>");
				outPrintln.append("<tr><th><p>U-Point 포인트지불금액</p></th>");
				outPrintln.append("<td><p>" +resultMap.get("UPNT_PayPrice")+ "</p></td></tr>");
			}
	    }
		outPrintln.append("</table>");
		outPrintln.append("<span style='padding-left : 100px;'>");
		outPrintln.append("</span>");
		outPrintln.append("<form name='frm' method='post'>"); 
		outPrintln.append("<input type='hidden' name='tid' value='"+resultMap.get("tid")+"'/>");
		outPrintln.append("</form>");
		
		outPrintln.append("</pre>");
		
		// 수신결과를 파싱후 resultCode가 "0000"이면 승인성공 이외 실패
		// 가맹점에서 스스로 파싱후 내부 DB 처리 후 화면에 결과 표시

		// payViewType을 popup으로 해서 결제를 하셨을 경우
		// 내부처리후 스크립트를 이용해 opener의 화면 전환처리를 하세요

		//throw new Exception("강제 Exception");
		
		return outPrintln.toString();
	}
}
