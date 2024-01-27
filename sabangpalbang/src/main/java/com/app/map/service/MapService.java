package com.app.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.map.dao.MapDao;
import com.app.map.dto.Region;

@Service
public class MapService {
	
	@Autowired
	private MapDao mapDao;

	public List<Region> getRegions(double swLat, double swLon, double neLat, double neLon, int mapLevel) {
		return mapDao.getRegions( swLat, swLon, neLat, neLon,mapLevel);
	}

}
