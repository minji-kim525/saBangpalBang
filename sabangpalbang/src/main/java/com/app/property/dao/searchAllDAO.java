package com.app.property.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.app.dto.PropertyDTO;

@Mapper
public interface searchAllDAO {

	@Select("select p.pname, ps.pname from property p, property_service ps "
			+ "where p.property_type_id = ps.property_type_id"
			+ "AND (p.pname LIKE CONCAT('%', #{keyword}, '%') OR ps.pname LIKE CONCAT('%', #{keyword}, '%'))")
	List<PropertyDTO> searchAll(@Param("keyword") String keyword);
	//keyword = 검색어
	
}
