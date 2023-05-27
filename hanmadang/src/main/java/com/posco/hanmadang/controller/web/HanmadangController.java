package com.posco.hanmadang.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.posco.hanmadang.controller.CommonController;

@Controller
@RequestMapping("/hanmadang")
public class HanmadangController extends CommonController{

	@RequestMapping(value="/info", method=RequestMethod.GET)
	public String info(){
		return "web/hanmadang/hanmadang_info";
	}
	
	@RequestMapping(value="/facility/f1", method=RequestMethod.GET)
	public String f1(){
		return "web/hanmadang/hanmadang_facility_f1";
	}
	
	@RequestMapping(value="/facility/f2", method=RequestMethod.GET)
	public String f2(){
		return "web/hanmadang/hanmadang_facility_f2";
	}
	
	@RequestMapping(value="/facility/f3", method=RequestMethod.GET)
	public String f3(){
		return "web/hanmadang/hanmadang_facility_f3";
	}
	
	@RequestMapping(value="/facility/b1", method=RequestMethod.GET)
	public String b1(){
		return "web/hanmadang/hanmadang_facility_b1";
	}
	
	@RequestMapping(value="/map", method=RequestMethod.GET)
	public String map(){
		return "web/map/hanmadang_map";
	}
}
