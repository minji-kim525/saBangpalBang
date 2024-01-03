package com.app.property.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.PropertyDTO;

@Mapper
public interface SearchAllDAO {
	
//	List<PropertyDTO> searchAll(@Param("keyword") String keyword);

	List<PropertyDTO> getAllProperties(@Param("keyword") String keyword);
}