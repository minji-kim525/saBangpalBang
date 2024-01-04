package com.app.main.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.ImagesDTO;
import com.app.dto.PropertyDTO;
import com.app.property.dto.PropertyResultDTO;

@Mapper
public interface PDAO {

	List<PropertyDTO> getProperties();

	ImagesDTO getImage(@Param("id1") int id, @Param("id2") int ps_type);
}
