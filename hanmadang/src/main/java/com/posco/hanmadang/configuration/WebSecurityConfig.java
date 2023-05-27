package com.posco.hanmadang.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;


@Configuration
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.headers().frameOptions().sameOrigin().and()
    		.csrf().disable()
	    	.authorizeRequests()
	    		.antMatchers("/**").permitAll()
	    		.anyRequest().hasRole("USER");
  }
  
}
