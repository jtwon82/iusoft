package com.posco.hanmadang.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

public abstract class CommonController {
	public Logger logger = LoggerFactory.getLogger(this.getClass());

	@Value("${dev.mode}")
	public boolean dev_mode = false;
	
	@ExceptionHandler(Exception.class)
	@ResponseStatus (HttpStatus.INTERNAL_SERVER_ERROR)
	protected String handlException(Exception e, Model model) {
		
		logger.error(e.toString());
//		String reason= HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase();;
//        HttpStatus statusCode= HttpStatus.INTERNAL_SERVER_ERROR;
//        
//		ResponseStatus annotation = e.getClass().getAnnotation(ResponseStatus.class);
//		 
//        if(annotation!=null){
//            reason = e.getMessage();
//            statusCode = annotation.value();
//        }
		model.addAttribute("msg", e.toString());

		return "error";
	}
}
