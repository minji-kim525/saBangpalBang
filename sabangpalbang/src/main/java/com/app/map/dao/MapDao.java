package com.app.map.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.map.dto.Region;

@Mapper
public interface  MapDao {

	List<Region> getRegions(
			@Param("swLat")double swLat,
			@Param("swLon")double swLon, 
			@Param("neLat")double neLat,
			@Param("neLon") double neLon,
			@Param("mapLevel")int mapLevel);

}
