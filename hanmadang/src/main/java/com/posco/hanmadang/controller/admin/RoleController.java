package com.posco.hanmadang.controller.admin;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.ClassUser;
import com.posco.hanmadang.model.admin.Admin;
import com.posco.hanmadang.model.admin.AdminLog;
import com.posco.hanmadang.model.admin.AdminLogPagedList;
import com.posco.hanmadang.model.admin.AdminPagedList;
import com.posco.hanmadang.model.admin.SearchParam;
import com.posco.hanmadang.security.PasswordEncoding;
import com.posco.hanmadang.service.admin.AdminService;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.Util;

@Controller
@RequestMapping("/rhksfl/vhtmzh/role")
public class RoleController extends CommonController{

	@Autowired
	private AdminService adminService;
	
	/**
	 * 직원 리스트
	 * @return
	 */
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber){
		AdminPagedList pagedList = adminService.getPagedList(pageNumber);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("list", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		return "admin/role/admin-add";
	}
	
	@RequestMapping(value="/mod", method=RequestMethod.GET)
	public String mod(Model model, @RequestParam(value="id", defaultValue="0") String id){
		Admin admin = adminService.find(id);
		model.addAttribute("admin", admin);
		
		return "admin/role/mod-pop";
	}
	
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public @ResponseBody String save(HttpSession session, @ModelAttribute(value="admin") Admin admin){
		try{
			
			Admin ssadmin = (Admin)session.getAttribute(Constant.ADMIN_SESSION);
			
			Admin exis = adminService.find(admin.getId());
			if(admin.getIdx() <= 0){
				if(exis != null)
					return ServiceResult.DUPLICATE.name();
				
				PasswordEncoder passwordEncoding = new PasswordEncoding();
			    String encodePass = passwordEncoding.encode(admin.getPwd());
			    admin.setPwd(encodePass);
			    
			    
				adminService.addLog(ssadmin, admin.getId() + " role add : " + admin.getPath_role());
				
			}else{
				if(!StringUtils.isEmpty(admin.getPwd())){
					PasswordEncoder passwordEncoding = new PasswordEncoding();
				    String encodePass = passwordEncoding.encode(admin.getPwd());
				    admin.setPwd(encodePass);
				}else{
//					admin.setPwd(exis.getPwd());
				}
				
				adminService.addLog(ssadmin, admin.getId() + " role chg : " + admin.getPath_role());
			}
			
			ServiceResult result = adminService.add(admin);
			
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/check", method=RequestMethod.POST)
	public @ResponseBody String check(@RequestParam(value="id", defaultValue="") String id){
		try{
			Admin admin = adminService.find(id);
			if(admin != null)
				return ServiceResult.DUPLICATE.name();
			
			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public @ResponseBody String delete(HttpSession session, @RequestParam(value="idx", defaultValue="0") int idx){
		try{
			Admin exis = adminService.find(idx);
			if(exis == null)
				return ServiceResult.NOT_FOUND.name();
			
			Admin ssadmin = (Admin)session.getAttribute(Constant.ADMIN_SESSION);
			adminService.addLog(ssadmin, exis.getId() + " role del");
			
			ServiceResult result = adminService.remove(idx);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 로그 리스트
	 * @return
	 */
	@RequestMapping(value="/log/list", method=RequestMethod.GET)
	public String log_list(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber){
		AdminLogPagedList pagedList = adminService.getLogPagedList(pageNumber);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("list", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		return "admin/role/admin-log-list";
	}
	
	@RequestMapping(value="/log/excel", method=RequestMethod.GET)
	public void apply_excel(Model model, HttpServletResponse response,
			@RequestParam(value="date", defaultValue="") String date) throws IOException {
		response.setHeader("Content-disposition", "attachment; filename=admin_log.xls"); //target명을 파일명으로 작성
		
		if(StringUtils.isEmpty(date)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, -1);
			date = dateFormat.format(cal.getTime());
		}
		
		
		List<AdminLog> list = adminService.getLogAllList(date);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("관리자로그리스트") ;

		//iterating r number of rows
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("아이디");
		row.createCell(1).setCellValue("이름");
		row.createCell(2).setCellValue("아이피");
		row.createCell(3).setCellValue("활동내역");
		row.createCell(4).setCellValue("일시");
		
		int idx = 1;
		for (AdminLog log : list)
		{
			row = sheet.createRow(idx++);
	
			row.createCell(0).setCellValue(log.getId());
			row.createCell(1).setCellValue(log.getName());
			row.createCell(2).setCellValue(log.getIp());
			
			if(log.getAction().contains("login")) {
				row.createCell(3).setCellValue("로그인");
			}else if(log.getAction().contains("logout")) {
				row.createCell(3).setCellValue("로그아웃");
			}else if(log.getAction().contains("/rhksfl/vhtmzh/main")) {
				row.createCell(3).setCellValue("메인");
			}else if(log.getAction().contains("/rhksfl/vhtmzh/login/pw")) {
				row.createCell(3).setCellValue("비밀번호 변경");
			}else if(log.getAction().contains("/rhksfl/vhtmzh/file/upload")) {
				row.createCell(3).setCellValue("이미지 업로드");
			}else if(log.getAction().contains("/rhksfl/vhtmzh/employee")) {
				if(log.getAction().contains("save/file")) {
					row.createCell(3).setCellValue("직원목록 업데이트");
				}else if(log.getAction().contains("/save")) {
					row.createCell(3).setCellValue("직원정보 추가 및 수정");
				}else if(log.getAction().contains("/delete")) {
					row.createCell(3).setCellValue("직원정보 삭제");
				}else {
					row.createCell(3).setCellValue("직원 관리 조회");
				}
			}else if(log.getAction().contains("/rhksfl/vhtmzh/class/list")) {
				row.createCell(3).setCellValue("수강신청 조회");
			}else if(log.getAction().contains("/rhksfl/vhtmzh/rent")) {
				if(log.getAction().contains("time/save")) {
					row.createCell(3).setCellValue("대관예약 추가");
				}else if(log.getAction().contains("reserve/cancel")) {
					row.createCell(3).setCellValue("대관예약 취소");
				}else if(log.getAction().contains("lecture/cancel")) {
					row.createCell(3).setCellValue("고정강좌 취소");
				}else if(log.getAction().contains("off/add")) {
					row.createCell(3).setCellValue("휴관일 추가");
				}else if(log.getAction().contains("team/save")) {
					row.createCell(3).setCellValue("동호회 추가 및 수정");
				}else if(log.getAction().contains("draw/go")) {
					row.createCell(3).setCellValue("대관 수동 추첨");
				}else if(log.getAction().contains("stats/excel")) {
					row.createCell(3).setCellValue("대관 통계 엑셀 다운로드");
				}
				
				else if(log.getAction().contains("/reserve/time/")) {
					row.createCell(3).setCellValue("대관 예약현황 조회");
				}else if(log.getAction().contains("/state/")) {
					row.createCell(3).setCellValue("대관 현재이용 현황 조회");
				}else if(log.getAction().contains("/draw")) {
					row.createCell(3).setCellValue("대관 추첨관리 조회");
				}else if(log.getAction().contains("/off")) {
					row.createCell(3).setCellValue("대관 휴관일 관리 조회");
				}else if(log.getAction().contains("/stats/all")) {
					row.createCell(3).setCellValue("대관 통계 조회");
				}else if(log.getAction().contains("/team/list")) {
					row.createCell(3).setCellValue("대관 동호회 관리 조회");
				}else if(log.getAction().contains("/reserve/lecture")) {
					row.createCell(3).setCellValue("고정강좌 취소 조회");
				}else if(log.getAction().contains("/reserve/cancel")) {
					row.createCell(3).setCellValue("대관 취소하기 조회");
				}else if(log.getAction().contains("/reserve/go")) {
					row.createCell(3).setCellValue("대관 예약하기 조회");
				}else {
					row.createCell(3).setCellValue("대관 관리");
				}
			}else if(log.getAction().contains("/rhksfl/vhtmzh/content/")) {
				if(log.getAction().contains("notice/save")) {
					row.createCell(3).setCellValue("콘텐츠(공지사항) 추가 및 수정");
				}else if(log.getAction().contains("notice/delete")) {
					row.createCell(3).setCellValue("콘텐츠(공지사항) 삭제");
				}else if(log.getAction().contains("banner/delete")) {
					row.createCell(3).setCellValue("콘텐츠(배너) 삭제");
				}else if(log.getAction().contains("banner/save")) {
					row.createCell(3).setCellValue("콘텐츠(배너) 추가 및 수정");
				}else if(log.getAction().contains("popup/save")) {
					row.createCell(3).setCellValue("콘텐츠(팝업) 추가 및 수정");
				}else if(log.getAction().contains("popup/delete")) {
					row.createCell(3).setCellValue("콘텐츠(팝업) 삭제");
				}else if(log.getAction().contains("program/save")) {
					row.createCell(3).setCellValue("콘텐츠(프로그램) 수정");
				}
				else if(log.getAction().contains("/banner")) {
					row.createCell(3).setCellValue("배너관리 조회");
				}else if(log.getAction().contains("/notice")) {
					row.createCell(3).setCellValue("공지관리 조회");
				}else if(log.getAction().contains("/popup")) {
					row.createCell(3).setCellValue("팝업관리 조회");
				}else if(log.getAction().contains("/program")) {
					row.createCell(3).setCellValue("프로그램 관리 조회");
				}else {
					row.createCell(3).setCellValue("콘텐츠 관리");
				}
			}else if(log.getAction().contains("/rhksfl/vhtmzh/entry/")) {
				if(log.getAction().contains("class/date")) {
					row.createCell(3).setCellValue("수강신청 기간 추가");
				}else if(log.getAction().contains("draw/proc")) {
					row.createCell(3).setCellValue("수강신청 추첨");
				}else if(log.getAction().contains("draw/reset")) {
					row.createCell(3).setCellValue("수강신청 추첨 초기화");
				}else if(log.getAction().contains("draw/factor")) {
					row.createCell(3).setCellValue("수강신청 종목별 추첨 조건 변경");
				}else if(log.getAction().contains("before/list")) {
					row.createCell(3).setCellValue("수강신청 지난 선정자 조회");
				}else if(log.getAction().contains("draw/open")) {
					row.createCell(3).setCellValue("수강신청 추첨 선정자 게시");
				}else if(log.getAction().contains("result/list")) {
					row.createCell(3).setCellValue("수강신청 선정자 목록 조회");
				}else if(log.getAction().contains("apply/result/change")) {
					row.createCell(3).setCellValue("수강신청 회원 상태(선정 및 대기) 변경");
				}else if(log.getAction().contains("apply/result/cancel")) {
					row.createCell(3).setCellValue("수강신청 회원 취소처리");
				}else if(log.getAction().contains("apply/list")) {
					row.createCell(3).setCellValue("수강신청 회원 목록 조회");
				}else if(log.getAction().contains("apply/vip")) {
					row.createCell(3).setCellValue("수강신청 VIP 설정");
				}else if(log.getAction().contains("class/sub/add")) {
					row.createCell(3).setCellValue("수강신청 항목 추가");
				}else if(log.getAction().contains("class/sub/del")) {
					row.createCell(3).setCellValue("수강신청 항목 삭제");
				}else if(log.getAction().contains("class/main/add")) {
					row.createCell(3).setCellValue("수강신청 운동종목 추가");
				}else if(log.getAction().contains("class/main/del")) {
					row.createCell(3).setCellValue("수강신청 운동종목 삭제");
				}else if(log.getAction().contains("/info")) {
					row.createCell(3).setCellValue("수강신청 내용 관리 조회");
				}else if(log.getAction().contains("/draw/list")) {
					row.createCell(3).setCellValue("추첨 관리 조회");
				}else {
					row.createCell(3).setCellValue("수강신청 관리");
				}
			}else if(log.getAction().contains(" role ")) {
				String[] role_split = log.getAction().split(" ");
				
				String tmp = "아이디(" + role_split[0] + ")";
				if(log.getAction().contains("role chg :")) {
					tmp += " 권한 변경";
				}else if(log.getAction().contains("role add :")) {
					tmp += " 생성";
				}else if(log.getAction().contains("role del")) {
					tmp += " 삭제";
				}
				
				if(!log.getAction().contains("role del")) {
					
					tmp += "(";
					if(role_split[4].contains("all")) {
						tmp += "전체,";
					}else if(role_split[4].contains(",content")) {
						tmp += "컨텐츠관리,";
					}else if(role_split[4].contains(",member")) {
						tmp += "직원관리,";
					}else if(role_split[4].contains(",lecture")) {
						tmp += "수강신청 관리,";
					}else if(role_split[4].contains(",class")) {
						tmp += "수강신청 조회,";
					}else if(role_split[4].contains(",rent")) {
						tmp += "대관관리,";
					}else if(role_split[4].contains(",stats")) {
						tmp += "홈페이지분석,";
					}else if(role_split[4].contains(",gym")) {
						tmp += "스마트짐 분석,";
					}else if(role_split[4].contains(",admin")) {
						tmp += "관리자 관리,";
					}
					
					tmp += ")";
				}
				
				row.createCell(3).setCellValue(tmp);
				
			}else if(log.getAction().contains("/rhksfl/vhtmzh/role")) {
				if(log.getAction().contains("save")) {
					row.createCell(3).setCellValue("관리자 계정 추가 및 수정");
				}else if(log.getAction().contains("check")) {
					row.createCell(3).setCellValue("관리자 계정 아이디 중복체크");
				}else if(log.getAction().contains("delete")) {
					row.createCell(3).setCellValue("관리자 계정 삭제");
				}else if(log.getAction().contains("log/list")) {
					row.createCell(3).setCellValue("관리자 활동 로그 조회");
				}else if(log.getAction().contains("role/list")) {
					row.createCell(3).setCellValue("관리자 계정 관리 조회");
				}else {
					row.createCell(3).setCellValue("관리자 관리");
				}
			}
				
			row.createCell(4).setCellValue(log.getRegidate().substring(0, 16));
		}
		
		wb.write(response.getOutputStream());
//		new ExcelExporter().exportHtml(excel_data, response.getOutputStream());
		return;
	}
	
}
