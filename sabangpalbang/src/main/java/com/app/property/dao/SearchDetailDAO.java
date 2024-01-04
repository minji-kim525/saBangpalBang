package com.app.property.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.app.property.dto.PropertyDetailDTO;

@Mapper
public interface SearchDetailDAO {
	List<PropertyDetailDTO> getDetail();
}
