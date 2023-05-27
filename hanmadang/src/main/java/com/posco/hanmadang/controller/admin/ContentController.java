package com.posco.hanmadang.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.common.Constant.UploadDirType;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.Banner;
import com.posco.hanmadang.model.Notice;
import com.posco.hanmadang.model.NoticePagedList;
import com.posco.hanmadang.model.Popup;
import com.posco.hanmadang.model.ProgramTimeInfo;
import com.posco.hanmadang.service.BannerService;
import com.posco.hanmadang.service.NoticeService;
import com.posco.hanmadang.service.PopupService;
import com.posco.hanmadang.service.ProgramService;
import com.posco.hanmadang.util.FileUpload;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.Util;

@Controller
@RequestMapping("/rhksfl/vhtmzh/content")
public class ContentController extends CommonController{

	@Autowired
	private BannerService bannerService;
	@Autowired
	private PopupService popupService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private ProgramService programService;
	
	@Autowired
	private FileUpload fileUpload;
	
	/**
	 * 배너관리
	 * @return
	 */
	@RequestMapping(value="/banner", method=RequestMethod.GET)
	public String banner(Model model){
		List<Banner> list = bannerService.getList();
		model.addAttribute("list", list);
		return "admin/content/cnt-banner";
	}
	
	
	@RequestMapping(value="/banner/save", method=RequestMethod.POST)
	public @ResponseBody String banner_save(@ModelAttribute(value="banner") Banner banner,
			@RequestParam(value="img", required=false) MultipartFile img){
		try{
			String imgFile = fileUpload.uploadFile(img, UploadDirType.images);
			if(imgFile != null){
				banner.setB_img(imgFile);
			}
			
			ServiceResult result = bannerService.add(banner);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/banner/delete", method=RequestMethod.POST)
	public @ResponseBody String banner_delete(@RequestParam(value="idx_no", defaultValue="0") int idx_no){
		try{
			ServiceResult result = bannerService.remove(idx_no);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 팝업관리
	 * @return
	 */
	@RequestMapping(value="/popup", method=RequestMethod.GET)
	public String popup(Model model){
		List<Popup> list = popupService.getList(false);
		model.addAttribute("list", list);
		
		return "admin/content/cnt-popup";
	}
	
	@RequestMapping(value="/popup/save", method=RequestMethod.POST)
	public @ResponseBody String popup_save(@ModelAttribute(value="popup") Popup popup,
			@RequestParam(value="img", required=false) MultipartFile img){
		try{
			String imgFile = fileUpload.uploadFile(img, UploadDirType.images);
			if(imgFile != null){
				popup.setB_img(imgFile);
			}
			
			ServiceResult result = popupService.add(popup);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/popup/delete", method=RequestMethod.POST)
	public @ResponseBody String popup_delete(@RequestParam(value="idx_no", defaultValue="0") int idx_no){
		try{
			ServiceResult result = popupService.remove(idx_no);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/popup/onoff", method=RequestMethod.POST)
	public @ResponseBody String popup_onoff(@RequestParam(value="idx_no", defaultValue="0") int idx_no,
			@RequestParam(value="open_yn", defaultValue="Y") String open_yn){
		try{
			Popup popup = popupService.get(idx_no);
			if(popup == null)
				return ServiceResult.NOT_FOUND.name();
			
			popup.setB_open_yn(open_yn);
			
			ServiceResult result = popupService.onOffPopup(popup.getIdx_no(), open_yn);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 공지사항 관리
	 * @return
	 */
	@RequestMapping(value="/notice", method=RequestMethod.GET)
	public String notice(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber){
		NoticePagedList pagedList = noticeService.getPagedList(pageNumber);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("list", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		return "admin/content/cnt-notice1";
	}
	
	@RequestMapping(value="/notice/item/{idx}", method=RequestMethod.GET)
	public String notice_get(Model model, HttpServletRequest request,
			@PathVariable(value="idx") int idx){
		Notice notice = noticeService.find(idx);
		model.addAttribute("notice", notice);
		
		return "admin/content/cnt-notice-pop";
	}
	
	@RequestMapping(value="/notice/save", method=RequestMethod.POST)
	public @ResponseBody String notice_save(@ModelAttribute(value="notice") Notice notice,
			@RequestParam(value="img", required=false) MultipartFile img){
		try{
			String imgFile = fileUpload.uploadFile(img, UploadDirType.images);
			if(imgFile != null){
				notice.setImgfile(imgFile);
			}
			
			ServiceResult result = noticeService.add(notice);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/notice/delete", method=RequestMethod.POST)
	public @ResponseBody String notice_delete(@RequestParam(value="idx", defaultValue="0") int idx){
		try{
			ServiceResult result = noticeService.remove(idx);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 프로그램 관리
	 * @return
	 */
	@RequestMapping(value="/program", method=RequestMethod.GET)
	public String program(Model model, @RequestParam(value="type", defaultValue="1") int type){
		ProgramTimeInfo info = programService.get(type);
		model.addAttribute("info", info);
		model.addAttribute("type", type);
		
		return "admin/content/cnt-program";
	}
	
	@RequestMapping(value="/program/save", method=RequestMethod.POST)
	public @ResponseBody String program_save(@ModelAttribute(value="program") ProgramTimeInfo program){
		try{
			ServiceResult result = programService.update(program);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
}
