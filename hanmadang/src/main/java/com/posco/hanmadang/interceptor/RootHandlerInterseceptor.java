package com.posco.hanmadang.interceptor;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.posco.hanmadang.common.Constant;

public class RootHandlerInterseceptor implements HandlerInterceptor {
	public Logger logger = LoggerFactory.getLogger(this.getClass());

	@Value("${dev.mode}")
	private boolean dev_mode = false;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		request.setAttribute("ADMIN_PATH", Constant.ADMIN_PATH);

		logger.info("==========================================");
		logger.info("getRequestURL {}", request.getRequestURL());
		
		if(Arrays.asList("weespk.iptime.org","local.run","localhost").contains(request.getServerName())) {
			return true;
			
		} else if (request.isSecure()) {
		} else {
			String url = "https://" + request.getServerName();
			response.sendRedirect(url);
			return false;
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
