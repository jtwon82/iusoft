package com.posco.hanmadang.mapper.posco;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Employee;

@Mapper
public interface EmployeeMapper {
	Employee select(@Param("idx_no") long idx_no);
	Employee selectNo(@Param("em_no") String em_no);
	
	List<Employee> listPaged(@Param("firstOffset") int firstOffset,@Param("lastOffset") int lastOffset, 
			@Param("op") String op, @Param("keyword") String keyword);
	int countPaged(@Param("op") String op, @Param("keyword") String keyword);
	
	int update(Employee employee);
	int delete(@Param("idx_no") long idx_no);
	
	int truncate();
	int insert(@Param("list") List<Employee> list);
}
