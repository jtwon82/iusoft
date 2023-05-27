package com.posco.hanmadang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController extends CommonController{
	
	@RequestMapping("/{code}")
	public String error(Model model, @PathVariable("code") String code){
		model.addAttribute("code", code);
		return "error/error";
	}
	
}
