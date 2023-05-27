package com.posco.hanmadang.controller.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.inicis.inipay.INIpay50;
import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.model.MainPay;
import com.posco.hanmadang.model.Member;
import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.ProgramDetail;
import com.posco.hanmadang.service.MemberService;
import com.posco.hanmadang.service.ProgramService;

@Controller
@RequestMapping("/inipay")
public class INIPayController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Value("${inipay.module.dir}")
	private String module_dir = "";
	
	@Value("${inipay.web.url}")
	private String web_url = "";
	
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
	
	@RequestMapping(value="/start", method=RequestMethod.GET)
	public String start(HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(value="code", defaultValue="") String program_code,
			HttpServletResponse response){
		Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
		if(member == null)
			return null;
		
		ProgramDetail program = programService.findProgram(program_code);
		if(program == null)
			return null;
		
		model.addAttribute("program", program);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal = Calendar.getInstance();
		String timestamp = formatter.format(cal.getTime());
		
		OrderNo orderNo = new OrderNo();
		orderNo.setMember_code(member.getMember_code());
		orderNo.setOrder_no(programService.getReceiptSeq());
		orderNo.setProgram_code(program_code);
		orderNo.setServer_yn(Constant.YesNoStatus.N.name());

		model.addAttribute("price", program.getUnit_price());
		
		logger.debug("INIPayController###########order_no : " + orderNo.getOrder_no());
		
		model.addAttribute("orderNo", orderNo);
		
		programService.updateOrderNo(orderNo);
		
		model.addAttribute("module_dir", module_dir);
		
//		
//	    /***************************************
//	     * 2. INIpay 인스턴스 생성             *
//	     ***************************************/
//	    INIpay50 inipay = new INIpay50();
//	    
//	    /***************************************
//	     * 3. 암호화 대상/값 설정              *
//	     ***************************************/
//	    inipay.SetField("inipayhome", "/Users/ksshin/Desktop/Project/posco/INIpay50"); // 이니페이 홈디렉터리(상점수정 필요)
//	    inipay.SetField("admin", "1111"); 							  // 키패스워드(상점아이디에 따라 변경)
//	    //***********************************************************************************************************
//	    //* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
//	    //* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
//	    //* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
//	    //* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
//	    //***********************************************************************************************************
//	    inipay.SetField("type", "chkfake");							  // 고정 (절대 수정 불가)
//	    
//	    inipay.SetField("enctype","asym"); 			                  // 고정 (절대 수정 불가) asym:비대칭, symm:대칭
//	    inipay.SetField("checkopt", "false"); 		                  // 고정 (절대 수정 불가) base64함:false, base64안함:true
//	    inipay.SetField("debug","false");                              // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//	    inipay.SetField("crypto", "execure");						  // Extrus 암호화모듈 사용(고정)
//	    
//	    //필수항목 : mid, price, nointerest, quotabase
//	    //추가가능 : INIregno, oid
//	    //*주의* : 	추가가능한 항목중 암호화 대상항목에 추가한 필드는 반드시 hidden 필드에선 제거하고 
//	    //          SESSION이나 DB를 이용해 다음페이지(INIsecureresult.jsp)로 전달/셋팅되어야 합니다.
//	    inipay.SetField("mid", "INIpayTest");                           //상점아이디
//	    inipay.SetField("price", "1000");                               // 가격
//	    inipay.SetField("nointerest", "no");                            //무이자여부
//	    inipay.SetField("quotabase", "선택:일시불:2개월:3개월:6개월");  //할부기간
//	    String[] parameters = {"price","nointerest", "quotabase"};
//	    inipay.SetField("parameters",parameters);
//	    
//	    /********************************
//	     * 4. 암호화 대상/값을 암호화함 *
//	     ********************************/
//
//	    
//	    inipay.startAction();
//
//	    /*********************
//	     * 5. 암호화 결과    *
//	     *********************/
//	    String rn_resultMsg = "";
//	 		if( inipay.GetResult("ResultCode") != "00" ) 
//			{
//			    rn_resultMsg = inipay.GetResult("ResultMsg");
//			}
//
//	    /*********************
//	     * 6. 세션정보 저장  *
//	     *********************/
//	    session.setAttribute("INI_MID"    , inipay.GetResult("mid"));
//	    session.setAttribute("INI_RN"     , inipay.GetResult("rn"));
//	    session.setAttribute("INI_ENCTYPE", inipay.GetResult("enctype"));
//	    session.setAttribute("INI_PRICE"  , inipay.GetResult("price") );
//	    session.setAttribute("admin"      , inipay.GetResult("admin"));
//
//	    /*******************************************
//	     * 7. 플러그인 전달 정보, hidden field 설정*
//	     *******************************************/
//	    String ini_encfield = inipay.GetResult("encfield");
//	    String ini_certid   = inipay.GetResult("certid");
//	   
//	    /*********************
//	     * 6. 인스턴스 해제  *
//	     *********************/
//	    inipay = null;
//	    
//	    model.addAttribute("rn_resultMsg", rn_resultMsg);
//	    model.addAttribute("ini_encfield", ini_encfield);
//	    model.addAttribute("ini_certid", ini_certid);
//	    
//		// 암호화정보 관련 에러발생 체크, 암호화 처리 정상 때만 결제 진행
//		if ( rn_resultMsg.trim().length() == 0 ){
//			
//			
//		}else {
////			response.setContentType("text/html; charset=UTF-8");
////	        PrintWriter out;
////			try { 
////				out = response.getWriter();
////				out.println("<script>alert('결제가 취소되었습니다.'); window.close();window.opener.location.reload(true);</script>");
////			    out.flush();
////			} catch (IOException e) {
////			}
//		}
		
		return "web/inipay/INIsecurestart";
	}
	
	@RequestMapping(value="/result", method=RequestMethod.POST)
	public String result(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response){
		
		/***************************************
		   * 2. INIpay 인스턴스 생성             *
		   ***************************************/
		  INIpay50 inipay = new INIpay50();
		 

		  /*********************
		   * 3. 지불 정보 설정 *
		   *********************/

		  inipay.SetField("inipayhome", module_dir);//"/Users/ksshin/Desktop/Project/posco/INIpay50");  // 이니페이 홈디렉터리(상점수정 필요)
		  inipay.SetField("type", "securepay");  // 고정 (절대 수정 불가)
		  inipay.SetField("admin", session.getAttribute("admin"));  // 키패스워드(상점아이디에 따라 변경)
		  //***********************************************************************************************************
		  //* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
		  //* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
		  //* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
		  //* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
		  //***********************************************************************************************************
		  inipay.SetField("debug", "false");  // 로그모드("true"로 설정하면 상세로그가 생성됨.)
		  inipay.SetField("crypto", "execure");	// Extrus 암호화모듈 사용(고정)
			
		  inipay.SetField("uid", request.getParameter("uid") );  // INIpay User ID (절대 수정 불가)
		  inipay.SetField("oid", request.getParameter("oid") );  // 상품명 
		  inipay.SetField("goodname", request.getParameter("goodname") );  // 상품명 
		  inipay.SetField("currency", request.getParameter("currency") );  // 화폐단위

		  inipay.SetField("mid", session.getAttribute("INI_MID") );  // 상점아이디
		  inipay.SetField("enctype", session.getAttribute("INI_ENCTYPE") );  //웹페이지 위변조용 암호화 정보
		  inipay.SetField("rn", session.getAttribute("INI_RN") );  //웹페이지 위변조용 RN값
		  inipay.SetField("price", session.getAttribute("INI_PRICE") );  //가격


		  /**---------------------------------------------------------------------------------------
		   * price 등의 중요데이터는
		   * 브라우저상의 위변조여부를 반드시 확인하셔야 합니다.
		   *
		   * 결제 요청페이지에서 요청된 금액과
		   * 실제 결제가 이루어질 금액을 반드시 비교하여 처리하십시오.
		   *
		   * 설치 메뉴얼 2장의 결제 처리페이지 작성부분의 보안경고 부분을 확인하시기 바랍니다.
		   * 적용참조문서: 이니시스홈페이지->가맹점기술지원자료실->기타자료실 의
		   *              '결제 처리 페이지 상에 결제 금액 변조 유무에 대한 체크' 문서를 참조하시기 바랍니다.
		   * 예제)
		   * 원 상품 가격 변수를 OriginalPrice 하고  원 가격 정보를 리턴하는 함수를 Return_OrgPrice()라 가정하면
		   * 다음 같이 적용하여 원가격과 웹브라우저에서 Post되어 넘어온 가격을 비교 한다.
		   *
				String originalPrice = merchant.getOriginalPrice();
				String postPrice = inipay.GetResult("price"); 
				if ( originalPrice != postPrice )
				{
					//결제 진행을 중단하고  금액 변경 가능성에 대한 메시지 출력 처리
					//처리 종료 
				}
		  ---------------------------------------------------------------------------------------**/

		  inipay.SetField("paymethod", request.getParameter("paymethod") );			          // 지불방법 (절대 수정 불가)
		  inipay.SetField("encrypted", request.getParameter("encrypted") );			          // 암호문
		  inipay.SetField("sessionkey",request.getParameter("sessionkey") );			        // 암호문
		  inipay.SetField("buyername", request.getParameter("buyername") );			          // 구매자 명
		  inipay.SetField("buyertel", request.getParameter("buyertel") );			            // 구매자 연락처(휴대폰 번호 또는 유선전화번호)
		  inipay.SetField("buyeremail",request.getParameter("buyeremail") );			        // 구매자 이메일 주소
		  inipay.SetField("url", web_url ); 	                      // 실제 서비스되는 상점 SITE URL로 변경할것
		  inipay.SetField("cardcode", request.getParameter("cardcode") ); 	          		// 카드코드 리턴
		  inipay.SetField("parentemail", request.getParameter("parentemail") ); 			    // 보호자 이메일 주소(핸드폰 , 전화결제시에 14세 미만의 고객이 결제하면  부모 이메일로 결제 내용통보 의무, 다른결제 수단 사용시에 삭제 가능)
			
		  /*-----------------------------------------------------------------*
		   * 수취인 정보 *                                                   *
		   *-----------------------------------------------------------------*
		   * 실물배송을 하는 상점의 경우에 사용되는 필드들이며               *
		   * 아래의 값들은 INIsecurestart.jsp 페이지에서 포스트 되도록        *
		   * 필드를 만들어 주도록 하십시요.                                  *
		   * 컨텐츠 제공업체의 경우 삭제하셔도 무방합니다.                   *
		   *-----------------------------------------------------------------*/
		  inipay.SetField("recvname",request.getParameter("recvname") );	// 수취인 명
		  inipay.SetField("recvtel",request.getParameter("recvtel") );		// 수취인 연락처
		  inipay.SetField("recvaddr",request.getParameter("recvaddr") );	// 수취인 주소
		  inipay.SetField("recvpostnum",request.getParameter("recvpostnum") );  // 수취인 우편번호
		  inipay.SetField("recvmsg",request.getParameter("recvmsg") );		// 전달 메세지
			
		  inipay.SetField("joincard",request.getParameter("joincard") );        // 제휴카드코드
		  inipay.SetField("joinexpire",request.getParameter("joinexpire") );    // 제휴카드유효기간
		  inipay.SetField("id_customer",request.getParameter("id_customer") );  // 일반적인 경우 사용하지 않음, user_id

		  OrderNo orderNo = programService.findOrderNo(inipay.GetResult("oid"));
		  if(orderNo == null) {
			  response.setContentType("text/html; charset=UTF-8");
		        PrintWriter out;
				try { 
					out = response.getWriter();
					out.println("<script>alert('잘못 된 접근입니다.'); window.close();window.opener.location.reload(true);</script>");
				    out.flush();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
				
				return null;
		  }
			
			
			ProgramDetail program = programService.findProgram(orderNo.getProgram_code());
			if(program == null) {
				response.setContentType("text/html; charset=UTF-8");
		        PrintWriter out;
				try { 
					out = response.getWriter();
					out.println("<script>alert('잘못 된 접근입니다.'); window.close();window.opener.location.reload(true);</script>");
				    out.flush();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
				
				return null;
			}

		  /****************
		   * 4. 지불 요청 *
		   ****************/ 
		  inipay.startAction();
			
		  boolean cancelFlag = false;
		  
		  //Get PG Added Entity Sample
		  if(inipay.GetResult("ResultCode").equals("00") )
		  {
			  if(Integer.parseInt(program.getUnit_price()) == Integer.parseInt(inipay.GetResult("TotPrice"))) {
				  MainPay payInfo = new MainPay();
				  payInfo.setSalesPrice(inipay.GetResult("price"));
				  
				  inipay.GetResult("tid");
				  payInfo.setOid(inipay.GetResult("tid"));
				  
				  inipay.GetResult("ResultCode"); //("00"이면 지불 성공)
				  inipay.GetResult("ResultMsg"); //(지불결과에 대한 설명)
				  inipay.GetResult("PayMethod"); // (거 래 번 호)
				  inipay.GetResult("MOID");    // (주 문 번 호)
				  inipay.GetResult("TotPrice");
				  inipay.GetResult("ApplDate"); // (YYYYMMDD)
				  payInfo.setCardApproveDate(inipay.GetResult("ApplDate"));
				  
				  inipay.GetResult("ApplTime"); //(HHMMSS)  
				  payInfo.setCardApproveTime(inipay.GetResult("ApplTime"));
				  
				  inipay.GetResult("ApplNum"); //승인번호
				  payInfo.setCardTradeNo(inipay.GetResult("ApplNum"));
				  
				  payInfo.setCardNum(inipay.GetResult("CARD_Num"));
				  
				  //3. 신용카드 결제 결과 데이터 (Card, VCard 공통)
				  inipay.GetResult("CARD_Quota"); // * 	할부기간 :
				  payInfo.setInstallNo(inipay.GetResult("CARD_Quota"));
				  
				  inipay.GetResult("CARD_Interest"); // ("1"이면 무이자할부)
				  inipay.GetResult("EventCode");// (무이자/할인 행사적용 여부, 값에 대한 설명은 메뉴얼 참조)
				  
				  inipay.GetResult("CARD_Code"); //(매뉴얼 참조)
//				  payInfo.setCardName(getCardName(inipay.GetResult("CARD_Code")));
				  payInfo.setCardName(inipay.GetResult("CARD_Code"));
				  payInfo.setCardCode(inipay.GetResult("CARD_Code"));
				  
				  inipay.GetResult("CARD_BankCode"); // * 	카드발급사 코드 : // (매뉴얼 참조)
				  inipay.GetResult("CARD_AuthType"); // * 	본인인증 수행여부 :  ("00"이면 수행)
				  inipay.GetResult("EventCode");  //*  각종 이벤트 적용 여부 : 
				  
				  /*******************************************************************
				   * 7. DB연동 실패 시 강제취소                                      *
				   *                                                                 *
				   * 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
				   * 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
				   * 작성합니다.                                                     *
				   *******************************************************************/
				  try {
					  		int totalPrice = Integer.parseInt(inipay.GetResult("TotPrice"));
					  		if(totalPrice <= 0) {
					  			payInfo.setSales_amount(0);
								payInfo.setVat_amount(0);
					  		}else {
					  			payInfo.setSales_amount((totalPrice * 10) / 11);
					  			
					  			int vatPrice = totalPrice - payInfo.getSales_amount();
					  			if(vatPrice < 0)
					  				payInfo.setVat_amount(0);
					  			else
					  				payInfo.setVat_amount(vatPrice);
					  		}
					  		
							orderNo.setPay(payInfo);
							
							programService.procPay(orderNo, program);
							programService.updateOrderNoStatus(orderNo.getOrder_no(), Constant.YesNoStatus.Y.name());
							
							logger.debug("INIPayController##########################################################1");
						
//							cancelFlag = true;
				  		}catch(Exception e) {
				  			cancelFlag = true;
				  		}
	
				}else {
					cancelFlag = true;
				}
				  		
		  		if(cancelFlag){
		  			String tmp_TID = inipay.GetResult("tid");
				    inipay.SetField("type", "cancel");         // 고정
				    inipay.SetField("tid", tmp_TID);              // 고정
				    inipay.SetField("cancelmsg", "DB FAIL");   // 취소사유
				    inipay.startAction();
				    
			  		response.setContentType("text/html; charset=UTF-8");
			        PrintWriter out;
					try { 
						out = response.getWriter();
						out.println("<script>alert('결제가 취소되었습니다.'); window.close();window.opener.location.reload(true);</script>");
					    out.flush();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						System.out.println(e.getMessage());
					}
						
		  		}else {
		  		
			  		response.setContentType("text/html; charset=UTF-8");
			        PrintWriter out;
					try { 
						out = response.getWriter();
						out.println("<script>alert('결제가 완료되었습니다.'); window.close();window.opener.location.reload(true);</script>");
					    out.flush();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						System.out.println(e.getMessage());
					}
		  		}
			  		
				return null;
				  		
		  	}
			  // cancelFlag를 "ture"로 변경하는 condition 판단은 개별적으로
			  // 수행하여 주십시오.

			  
		  
		  
		  model.addAttribute("result", inipay.GetResult("ResultCode"));
		  
		  logger.debug("INIPayController######################: " + inipay.GetResult("ResultCode"));
		  logger.debug("INIPayController######################: " + inipay.GetResult("ResultMsg"));
		  logger.debug("INIPayController######################: " + inipay.GetResult("tid"));
		  
		  response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out;
			try { 
				out = response.getWriter();
				out.println("<script>alert('결제가 정상적으로 처리되지 않았습니다.'); window.close();window.opener.location.reload(true);</script>");
			    out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println(e.getMessage());
			}
			
			return null;
			
//			
//		return "web/inipay/INIsecureresult";
	}
	
}
