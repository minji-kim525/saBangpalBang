package com.app.property.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.PropertyDTO;

public interface searchAllDAO {
	
	List<PropertyDTO> searchAll(@Param("keyword") String keyword);
	// keyword = 검색어
	
    List<PropertyDTO> getAllProperties();
	// 전체 데이터 저장

}

