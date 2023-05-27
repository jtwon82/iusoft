package com.posco.hanmadang.controller.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.ProgramTimeInfo;
import com.posco.hanmadang.service.ProgramService;

@Controller
@RequestMapping("/program")
public class ProgramController extends CommonController{

	@Autowired
	private ProgramService programService;
	
	/**
	 * 전체운영시간
	 * @return
	 */
	@RequestMapping(value="/time/all", method=RequestMethod.GET)
	public String time(){
		return "web/program/program_time";
	}
	
	/**
	 * 수강프로그램시간
	 * @return
	 */
	@RequestMapping(value="/time/item/{type}", method=RequestMethod.GET)
	public String time_type(Model model, @PathVariable("type") int type){
		ProgramTimeInfo info = programService.get(type);
		model.addAttribute("info", info);
		model.addAttribute("type", type);
		
		return "web/program/program_time2";
	}
	
	/**
	 * 1:1강습시간
	 * @return
	 */
	@RequestMapping(value="/time/one", method=RequestMethod.GET)
	public String one(Model model){
		ProgramTimeInfo info = programService.get(100);
		model.addAttribute("info", info);
		return "web/program/program_time3";
	}
	
	/**
	 * 분기 회원제 금액
	 * @return
	 */
	@RequestMapping(value="/amount", method=RequestMethod.GET)
	public String amount(){
		return "web/program/program_amount";
	}
	
	/**
	 * 경기장 이용 안내
	 * @return
	 */
	@RequestMapping(value="/stadium", method=RequestMethod.GET)
	public String stadium(){
		return "web/program/program_stadium";
	}
	
	/**
	 * 이용수칙안내
	 * @return
	 */
	@RequestMapping(value="/rule", method=RequestMethod.GET)
	public String rule(){
		return "web/program/program_rule";
	}
	
}
