package com.posco.hanmadang.service;

import com.posco.hanmadang.model.Test;

public interface TestService{
	Test find(String user_id);
	
	Test findEmail(String email);
}
