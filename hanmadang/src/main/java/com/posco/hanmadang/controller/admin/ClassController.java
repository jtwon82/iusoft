package com.posco.hanmadang.controller.admin;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.ClassInfo;
import com.posco.hanmadang.model.ClassUser;
import com.posco.hanmadang.model.ClassUserPagedList;
import com.posco.hanmadang.model.admin.SearchParam;
import com.posco.hanmadang.service.ClassService;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.Util;

@Controller
@RequestMapping("/rhksfl/vhtmzh/class")
public class ClassController extends CommonController{
	private final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	private ClassService classService;
	
	
	@RequestMapping(value="/excel", method=RequestMethod.GET)
	public void apply_excel(Model model, HttpServletResponse response,
			@ModelAttribute(value="param") SearchParam param) throws IOException {
		response.setHeader("Content-disposition", "attachment; filename=class_apply.xls"); //target명을 파일명으로 작성
		
		List<ClassUser> list = classService.getClassUserList(Constant.ClassUserListMode.class_all.name(), param);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("수강신청리스트") ;

		//iterating r number of rows
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("운동종목");
		row.createCell(1).setCellValue("강좌명");
		row.createCell(2).setCellValue("수강시간");
		row.createCell(3).setCellValue("회원구분");
		row.createCell(4).setCellValue("이용자명");
		row.createCell(5).setCellValue("전화번호");
		row.createCell(6).setCellValue("직번");
		row.createCell(7).setCellValue("직원명");
		row.createCell(8).setCellValue("부서");
		row.createCell(9).setCellValue("관계");
		row.createCell(10).setCellValue("성별");
		
		int idx = 1;
		for (ClassUser user : list)
		{
			row = sheet.createRow(idx++);
	
			//iterating c number of columns

				row.createCell(0).setCellValue(user.getClassInfo().getB_cate_name());
				row.createCell(1).setCellValue(user.getClassInfo().getClass_name());
				row.createCell(2).setCellValue(user.getClassInfo().getClass_time());
				if("01".equals(user.getEm_type()))
					row.createCell(3).setCellValue("정회원");
				else if("02".equals(user.getEm_type()))
					row.createCell(3).setCellValue("준회원");
				else if("03".equals(user.getEm_type()))
					row.createCell(3).setCellValue("일반회원");
				
				row.createCell(4).setCellValue(user.getO_name());
				row.createCell(5).setCellValue(user.getHp());
				row.createCell(6).setCellValue(user.getE_no());
				row.createCell(7).setCellValue(user.getE_name());
				row.createCell(8).setCellValue(user.getPartname());
				row.createCell(9).setCellValue(user.getMem_type());
				row.createCell(10).setCellValue("1".equals(user.getGender()) ? "여성" : "남성");
		}
		
		wb.write(response.getOutputStream());
//		new ExcelExporter().exportHtml(excel_data, response.getOutputStream());
		return;
	}
	
	/**
	 * 수강신청 회원 리스트
	 * @return
	 */
	@RequestMapping(value="/list")
	public String apply_list(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber,
			@RequestParam(value="mode", defaultValue="0") int mode,
			@ModelAttribute(value="param") SearchParam param){
		
		model.addAttribute("mode", mode);
		model.addAttribute("param", param);
		
		List<ClassInfo> mainClass = classService.getMainClass();
		model.addAttribute("mainClass", mainClass);
		
		String class_user_mode = Constant.ClassUserListMode.class_all.name();
		
//		if(mode == 1)
//			class_user_mode = Constant.ClassUserListMode.class_none.name();
		
		ClassUserPagedList pagedList = classService.getClassUserPagedList(pageNumber, class_user_mode, param);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("list", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		return "admin/class/list";
	}
	
}
