package com.posco.hanmadang.controller.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.NoticePagedList;
import com.posco.hanmadang.service.NoticeService;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.Util;

@Controller
@RequestMapping("/notice")
public class NoticeController extends CommonController{

	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 뉴스(공지사항) 리스트 가져오기
	 * @param model
	 * @param request
	 * @param pageNumber
	 * @return
	 */
	@RequestMapping(value="", method=RequestMethod.GET)
	public String info(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber){
		NoticePagedList pagedList = noticeService.getPagedList(pageNumber);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("notice", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		return "web/news/hanmadang_news";
	}
	
	/**
	 * hit 증가
	 * @param idx
	 * @return
	 */
	@RequestMapping(value="/hit", method=RequestMethod.POST)
	public @ResponseBody String hit(@RequestParam(value="idx", defaultValue="0") int idx){
		try{
			ServiceResult result = noticeService.incHit(idx);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
}
