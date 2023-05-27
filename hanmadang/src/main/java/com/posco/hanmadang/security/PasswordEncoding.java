package com.posco.hanmadang.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoding implements PasswordEncoder {
	private PasswordEncoder passwordEncoder;

	public PasswordEncoding() { 
		this.passwordEncoder = new BCryptPasswordEncoder(); 
	}
		
	public PasswordEncoding(PasswordEncoder passwordEncoder) { 
		this.passwordEncoder = passwordEncoder; 
	}
		
	@Override
	public String encode(CharSequence rawPassword) {
		// TODO Auto-generated method stub
		return passwordEncoder.encode(rawPassword);
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		// TODO Auto-generated method stub
		return passwordEncoder.matches(rawPassword, encodedPassword);
	}

}
