package com.posco.hanmadang.configuration;

import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;


@Configuration 
public class ErrorConfiguration extends ServerProperties { 
	@Override 
	public void customize(ConfigurableEmbeddedServletContainer container) { 
		super.customize(container); 
		container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/error/404"));
		container.addErrorPages(new ErrorPage(HttpStatus.BAD_REQUEST, "/error/400"));
		container.addErrorPages(new ErrorPage(HttpStatus.FORBIDDEN, "/error/403"));
		container.addErrorPages(new ErrorPage(HttpStatus.METHOD_NOT_ALLOWED, "/error/405"));
//		container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/500"));
		container.addErrorPages(new ErrorPage("/error/common"));
	} 
}