package com.app.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.manager.dto.PropertyResponseDto;

@Mapper
public interface ManagerDao {
	

	List<PropertyResponseDto> getPropertyManage();

	@Delete("delete from property_service where property_service_id = #{property_service_id}")
	int deleteProperty(@Param("property_service_id")int property_service_id);
}
