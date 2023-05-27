package com.posco.hanmadang.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration 
public class ResourceHandlerConfig extends WebMvcConfigurerAdapter 
{ 
	@Value("${upload.file.path}")
	private String uploadFilePath = "";
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
		if(!StringUtils.isEmpty(uploadFilePath) && uploadFilePath.contains("file:///"))
			registry.addResourceHandler("/upload/**").addResourceLocations(uploadFilePath);
//		registry.addResourceHandler(".well-known/pki-validation/gsdv.txt").addResourceLocations("gsdv.txt");
		
//		registry.addResourceHandler("/robots.txt").addResourceLocations("robots.txt");
//		registry.addResourceHandler("/sitemap.xml").addResourceLocations("sitemap.xml");
	}
}