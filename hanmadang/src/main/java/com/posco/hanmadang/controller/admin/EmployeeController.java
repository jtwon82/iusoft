package com.posco.hanmadang.controller.admin;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.ClassInfo;
import com.posco.hanmadang.model.ClassInfo1;
import com.posco.hanmadang.model.Employee;
import com.posco.hanmadang.model.EmployeePagedList;
import com.posco.hanmadang.service.EmployeeService;
import com.posco.hanmadang.service.admin.AdminService;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.Util;

@Controller
@RequestMapping("/rhksfl/vhtmzh/employee")
public class EmployeeController extends CommonController{

	private final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private AdminService adminService;
	
	/**
	 * 직원 리스트
	 * @return
	 */
	@RequestMapping(value="/list")
	public String list(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber,
			@RequestParam(value="op", defaultValue="all") String op,
			@RequestParam(value="keyword", defaultValue="") String keyword){
		EmployeePagedList pagedList = employeeService.getPagedList(pageNumber, op, keyword);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("list", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		model.addAttribute("op", op);
		model.addAttribute("keyword", keyword);
		
		return "admin/employee/staff-add";
	}
	
	@RequestMapping(value="/item/{idx}", method=RequestMethod.GET)
	public String employee_get(Model model, HttpServletRequest request,
			@PathVariable(value="idx") long idx_no){
		Employee employee = employeeService.find(idx_no);
		model.addAttribute("employee", employee);
		
		return "admin/employee/mod-pop";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public @ResponseBody String save(@ModelAttribute(value="employee") Employee employee){
		try{
			ServiceResult result = employeeService.add(employee);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public @ResponseBody String delete(@RequestParam(value="idx_no", defaultValue="0") long idx_no){
		try{
			ServiceResult result = employeeService.remove(idx_no);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
//	@PostMapping("/save/file1") 
//    public @ResponseBody String fileUpload1(@RequestParam("file") MultipartFile file, HttpSession session) {
//    	
//        if (file == null || file.isEmpty())
//        	return ServiceResult.INVALID_PARAM.name();
//        
//        String ext = Util.getExtension(file.getOriginalFilename()).toLowerCase();
//        if(!"xlsx".equals(ext) && !"xls".equals(ext))
//			return ServiceResult.NOT_MATCHE.name();
//			
//        List<ClassInfo1> dataList = new ArrayList<ClassInfo1>();
//        Workbook workbook = null;
//		
//        try {
//        	if("xls".equals(ext))
//        		workbook = new HSSFWorkbook(file.getInputStream());
//        	else
//        		workbook = new XSSFWorkbook(file.getInputStream());
//        	//sheet수 취득
//			int sheetCn = workbook.getNumberOfSheets();
//			System.out.println("sheet수 : " + sheetCn);
//			
//			if(sheetCn < 1)
//				return ServiceResult.NOT_MATCHE.name();
//			
//			//0번째 sheet 정보 취득
//			Sheet sheet = workbook.getSheetAt(0);
//			int rows = sheet.getPhysicalNumberOfRows();
//			System.out.println(workbook.getSheetName(0) + " sheet의 row수 : " + rows);
//			
//			if(rows > 1){
//				//취득된 row에서 취득대상 cell수 취득
//				int cells = sheet.getRow(1).getPhysicalNumberOfCells(); //
//				System.out.println(workbook.getSheetName(0) + " sheet의 row에 취득대상 cell수 : " + cells);
//				
//				if(cells < 3)
//					return ServiceResult.NOT_MATCHE.name();
//				
//				for (int r = 1; r < rows; r++) {
//					Row row = sheet.getRow(r); // row 가져오기
//					if (row != null) {
//						ClassInfo1 employeeData = new ClassInfo1();
//						for (int c = 0; c < cells; c++) {
//							Cell cell = row.getCell(c);
//							if (cell != null) {
//								
//								cell.setCellType(Cell.CELL_TYPE_STRING);
//								String value = "" + cell.getStringCellValue();
//								
//								if(c == Constant.ClassXLSFile.item_name.ordinal())
//									employeeData.setB_cate_name(value);
//								else if(c == Constant.ClassXLSFile.class_name.ordinal())
//									employeeData.setClass_name(value);
//								else if(c == Constant.ClassXLSFile.class_time.ordinal())
//									employeeData.setClass_time(value);
//								else if(c == Constant.ClassXLSFile.em_type.ordinal())
//									employeeData.setEm_type(value);
//								else if(c == Constant.ClassXLSFile.o_name.ordinal())
//									employeeData.setO_name(value);
//								else if(c == Constant.ClassXLSFile.e_name.ordinal())
//									employeeData.setE_name(value);
//								else if(c == Constant.ClassXLSFile.ph.ordinal())
//									employeeData.setPh(value);
//								else if(c == Constant.ClassXLSFile.e_no.ordinal())
//									employeeData.setE_no(value);
//								else if(c == Constant.ClassXLSFile.em_part.ordinal())
//									employeeData.setEm_part(value);
//								else if(c == Constant.ClassXLSFile.mem_type.ordinal())
//									employeeData.setMem_type(value);
//								else if(c == Constant.ClassXLSFile.gender.ordinal())
//									employeeData.setGender(value);
////								System.out.print(value + "\t");
//							} else {
////								System.out.print("[null]\t");
//							}
//						} // for(c) 문
////						
////						System.out.print("\n");
//						if(!StringUtils.isEmpty(employeeData.getB_cate_name())){
//							try{
////								Integer.parseInt(employeeData.getEm_no());
//
//								if("정회원".equals(employeeData.getEm_type()))
//									employeeData.setEm_type("01");
//								else if("준회원".equals(employeeData.getEm_type()))
//									employeeData.setEm_type("02");
//								else
//									employeeData.setEm_type("03");
//								
//								if("여성".equals(employeeData.getGender()))
//									employeeData.setGender("1");
//								else
//									employeeData.setGender("0");
//								
//								dataList.add(employeeData);
////								log.info("added data :" + employeeData.toString());
//							}catch(NumberFormatException e){
//								log.info("error data :" + employeeData.toString());
//								System.out.println(e.getMessage());
//							}
//						}else {
//							log.info("error data1 :" + employeeData.toString());
//						}
//					}
//				} // for(r) 문
//			}
//
//        } catch (IOException e) {
//            System.out.println(e.getMessage());
//			return Constant.ServiceResult.FAIL.name();
//        }
//        
//        ServiceResult result = employeeService.addNewAll(dataList);
//        
//        return result.name();
//    }
	
	@PostMapping("/save/file") 
    public @ResponseBody String fileUpload(@RequestParam("file") MultipartFile file, HttpSession session) {
    	
        if (file == null || file.isEmpty())
        	return ServiceResult.INVALID_PARAM.name();
        
        String ext = Util.getExtension(file.getOriginalFilename()).toLowerCase();
        if(!"xlsx".equals(ext) && !"xls".equals(ext))
			return ServiceResult.NOT_MATCHE.name();
			
        List<Employee> dataList = new ArrayList<Employee>();
        Workbook workbook = null;
		
        try {
        	if("xls".equals(ext))
        		workbook = new HSSFWorkbook(file.getInputStream());
        	else
        		workbook = new XSSFWorkbook(file.getInputStream());
        	//sheet수 취득
			int sheetCn = workbook.getNumberOfSheets();
			logger.info("sheet수 : " + sheetCn);
			
			if(sheetCn < 1)
				return ServiceResult.NOT_MATCHE.name();
			
			//0번째 sheet 정보 취득
			Sheet sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			logger.info(workbook.getSheetName(0) + " sheet의 row수 : " + rows);
			
			if(rows > 1){
				//취득된 row에서 취득대상 cell수 취득
				int cells = sheet.getRow(1).getPhysicalNumberOfCells(); //
				logger.info(workbook.getSheetName(0) + " sheet의 row에 취득대상 cell수 : " + cells);
				
				if(cells < 3)
					return ServiceResult.NOT_MATCHE.name();
				
				for (int r = 1; r < rows; r++) {
					Row row = sheet.getRow(r); // row 가져오기
					if (row != null) {
						Employee employeeData = new Employee();
						for (int c = 0; c < cells; c++) {
							Cell cell = row.getCell(c);
							if (cell != null) {
								
								cell.setCellType(Cell.CELL_TYPE_STRING);
								String value = "" + cell.getStringCellValue();
								
								if(c == Constant.EmployeeXLSFile.part_name.ordinal())
									employeeData.setPart_name(value);
								else if(c == Constant.EmployeeXLSFile.em_no.ordinal())
									employeeData.setEm_no(value);
								else if(c == Constant.EmployeeXLSFile.em_name.ordinal())
									employeeData.setEm_name(value);
								else if(c == Constant.EmployeeXLSFile.work_name.ordinal())
									employeeData.setWork_name(value);
								
//								System.out.print(value + "\t");
							} else {
//								System.out.print("[null]\t");
							}
						} // for(c) 문
//						
//						System.out.print("\n");
						if(!StringUtils.isEmpty(employeeData.getPart_name()) &&
								!StringUtils.isEmpty(employeeData.getEm_no()) &&
								!StringUtils.isEmpty(employeeData.getEm_name())){
							try{
//								Integer.parseInt(employeeData.getEm_no());
								
								if(StringUtils.isEmpty(employeeData.getWork_name()))
									employeeData.setWork_name("정규직");
								
								dataList.add(employeeData);
//								log.info("added data :" + employeeData.toString());
							}catch(NumberFormatException e){
								logger.info("error data :" + employeeData.toString());
								logger.error(e.getMessage());
							}
						}else {
							logger.info("error data1 :" + employeeData.toString());
						}
					}
				} // for(r) 문
			}

        } catch (IOException e) {
        	logger.error(e.getMessage());
			return Constant.ServiceResult.FAIL.name();
        }
        
        ServiceResult result = employeeService.addNewAll(dataList);
        
        return result.name();
    }
	
	
}
