package com.posco.hanmadang.service;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.ClassMapper;
import com.posco.hanmadang.mapper.posco.EmployeeMapper;
import com.posco.hanmadang.model.Employee;
import com.posco.hanmadang.model.EmployeePagedList;
import com.posco.hanmadang.util.Paging;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
	
	private static int ADMIN_ENTRY_COUNT_PER_ONE_PAGE = 10;
	private static int ADMIN_PAGE_COUNT_PER_PAGE_GROUP = 10;
	
	@Autowired EmployeeMapper employeeMapper;
	@Autowired ClassMapper classMapper;
	
	@Transactional(readOnly=true)
	public Employee find(long idx_no){
		return employeeMapper.select(idx_no);
	}
	
	@Transactional(readOnly=true)
	public Employee find(String em_no){
		return employeeMapper.selectNo(em_no);
	}
	
	@Transactional(readOnly=true)
	public EmployeePagedList getPagedList(int pageNumber, String op, String keyword){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<Employee> list = employeeMapper.listPaged(paging.getFirstOffset(), paging.getLastOffset(), op, keyword);
		EmployeePagedList pagedList = new EmployeePagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = employeeMapper.countPaged(op, keyword);
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional
	public ServiceResult remove(long idx_no){
		employeeMapper.delete(idx_no);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult add(Employee employee){
		if(employee.getIdx_no() > 0){
			employeeMapper.update(employee);
		}else{
			List<Employee> list = new ArrayList<Employee>();
			list.add(employee);
			
			employeeMapper.insert(list);
		}
		
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult addNewAll(List<Employee> list){
		employeeMapper.truncate();
		
		int curIdx = 0;
		if(list.size() > 0){
			while(curIdx <= list.size()){
				List<Employee> list1 = new ArrayList<Employee>(list.subList(curIdx, Math.min(curIdx + 200, list.size())));
				employeeMapper.insert(list1);
				
				curIdx += 200;
			}
		}
		
//		for(ClassInfo1 info : list) {
//			if("03".equals(info.getEm_type()))
//				classMapper.updatetemp2(info);
//			else
//				classMapper.updatetemp1(info);
//					
//		}
		
		return ServiceResult.SUCCESS;
	}

	
}
