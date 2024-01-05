package com.app.property.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.ImagesDTO;
import com.app.property.dto.PropertyResultDTO;

@Mapper
public interface SearchAllDAO {
	
//	List<PropertyDTO> searchAll(@Param("keyword") String keyword);

	List<PropertyResultDTO> getAllProperties(@Param("keyword") String keyword);
	
	ImagesDTO getImage(@Param("id1") int id, @Param("id2") int ps_type);
}