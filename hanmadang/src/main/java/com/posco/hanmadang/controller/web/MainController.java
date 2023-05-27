package com.posco.hanmadang.controller.web;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.Banner;
import com.posco.hanmadang.model.NoticePagedList;
import com.posco.hanmadang.model.Popup;
import com.posco.hanmadang.service.BannerService;
import com.posco.hanmadang.service.NoticeService;
import com.posco.hanmadang.service.PopupService;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.Util;

@Controller
public class MainController extends CommonController{

	@Autowired
	private BannerService bannerService;
	
	@Autowired
	private PopupService popupService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	/**
	 * @return
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main(Model model){
		List<Banner> list = bannerService.getList();
		model.addAttribute("list", list);
		
		List<Popup> pop_list = popupService.getList(true);
		model.addAttribute("pop_list", pop_list);
		
		NoticePagedList pagedList = noticeService.getPagedList(1);
		if(pagedList != null){
			model.addAttribute("notice_list", pagedList.getList());
		}
		
		logger.info(String.format("61:%s", "MAIN"));

		return "web/main";
	}
	
	/**
	 * @return
	 */
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main2(Model model){
		return "redirect:/";
	}
	
	/**
	 * @return
	 */
	@RequestMapping(value="/policy/{ver}", method=RequestMethod.GET)
	public String policy(Model model, @PathVariable("ver") String ver){
		return "web/terms/term_ver_" + ver;
	}

	@RequestMapping(value="/web/{fileName}")
	public ResponseEntity<Resource> resouceFileDownload(@PathVariable String fileName) {

		logger.info("fileName {}", fileName);
		
		if("201802_program_timetable".equals(fileName)) {
			fileName+= ".xlsx";
		}
		else if("hanmadangteam".equals(fileName)) {
			fileName = "hanmadangteam.docx";
		}
		else if("hanmadanggymnasium".equals(fileName)) {
			fileName+= ".pptx";
		}
		else {
			fileName= "empty.txt";
		}
		
		logger.info("fileName {}", fileName);

		try {
			Resource resource = resourceLoader.getResource("classpath:static/web/" + fileName);
			File file = resource.getFile(); // 파일이 없는 경우 fileNotFoundException error가 난다.
			
			logger.info("file {}", file);

			return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, file.getName()) // 다운 받아지는 파일 명 설정
					.header(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length())) // 파일 사이즈 설정
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM.toString()) // 바이너리 데이터로 받아오기
																										// 설정
					.body(resource); // 파일 넘기기
		} catch (Exception e) {
			logger.info("err {}", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
//	@RequestMapping(value = {"/robots", "/robot", "/robot.txt", "/robots.txt", "/null"})
//	public void robot(HttpServletResponse response) throws IOException {
//	 
//	    InputStream resourceAsStream = null;
//	    try {
//	 
//	        ClassLoader classLoader = getClass().getClassLoader();
//	        resourceAsStream = classLoader.getResourceAsStream("robots.txt");
//	 
//	        response.addHeader("Content-disposition", "filename=robots.txt");
//	        response.setContentType("text/plain");
//	        IOUtils.copy(resourceAsStream, response.getOutputStream());
//	        response.flushBuffer();
//	    } catch (Exception e) {
//	    } finally {
//	    	resourceAsStream.close();
//	    }
//	}
//	
//	@RequestMapping(value = {"/sitemap.xml"})
//	public void sitemap(HttpServletResponse response) throws IOException {
//	 
//	    InputStream resourceAsStream = null;
//	    try {
//	 
//	        ClassLoader classLoader = getClass().getClassLoader();
//	        resourceAsStream = classLoader.getResourceAsStream("sitemap.xml");
//	 
//	        response.addHeader("Content-disposition", "filename=sitemap.xml");
//	        response.setContentType("text/xml");
//	        IOUtils.copy(resourceAsStream, response.getOutputStream());
//	        response.flushBuffer();
//	    } catch (Exception e) {
//	    } finally {
//	    	resourceAsStream.close();
//	    }
//	}
	
}
