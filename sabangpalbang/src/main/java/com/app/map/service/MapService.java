package com.app.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.map.dao.MapDao;
import com.app.map.dto.AddressDto;
import com.app.map.dto.Region;

@Service
public class MapService {
	
	@Autowired
	private MapDao mapDao;

	public List<Region> getRegions(double swLat, double swLon, double neLat, double neLon, int mapLevel) {
		return mapDao.getRegions( swLat, swLon, neLat, neLon,mapLevel);
	}

	public List<AddressDto> getAddress(String sigungu) {
        String keyword = "서울특별시";
		int index=sigungu.indexOf(keyword);

		 if (index != -1) {
	            // '서울특별시' 이후의 문자열을 추출합니다.
	            String result = sigungu.substring(index + keyword.length()).trim();
	            List<AddressDto>list= mapDao.getAddress( result);
	            
	            return list;
	        } else {
	         List<AddressDto>list=mapDao.getAddress("서울");
	         return list;
	        }
	}

}
