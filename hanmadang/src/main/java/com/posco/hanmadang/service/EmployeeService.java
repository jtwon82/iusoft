package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.Employee;
import com.posco.hanmadang.model.EmployeePagedList;

public interface EmployeeService{
	Employee find(long idx_no);
	Employee find(String em_no);
	EmployeePagedList getPagedList(int pageNumber, String op, String keyword);
	
	ServiceResult remove(long idx_no);
	
	ServiceResult add(Employee employee);
	ServiceResult addNewAll(List<Employee> list);
}
