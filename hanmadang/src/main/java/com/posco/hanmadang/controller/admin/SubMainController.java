package com.posco.hanmadang.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.posco.hanmadang.controller.CommonController;

@Controller
@RequestMapping("/rhksfl/vhtmzh/main")
public class SubMainController extends CommonController{

	/**
	 * 메인
	 * @return
	 */
	@RequestMapping(value="", method=RequestMethod.GET)
	public String login(Model model){
		return "admin/main/sub-main";
	}
}
