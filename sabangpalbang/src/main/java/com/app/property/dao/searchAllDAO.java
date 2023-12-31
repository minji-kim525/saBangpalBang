package com.app.property.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.app.dto.PropertyDTO;

public interface searchAllDAO {
	
	List<PropertyDTO> searchAll(@Param("keyword") String keyword);

	List<PropertyDTO> getAllProperties();
}