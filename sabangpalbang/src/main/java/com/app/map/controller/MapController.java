package com.app.map.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.dto.MainSearchDto;
import com.app.dto.PagingResponseDto;
import com.app.map.dto.AddressDto;
import com.app.map.dto.Region;
import com.app.map.service.MapService;
import com.app.property.dto.PropertyResultDTO;
import com.app.property.service.SearchAllService;

@Controller
public class MapController {
	
	 @Autowired
	 private MapService mapService;
	 
	 @Autowired
	 private SearchAllService allservice;

	 @ResponseBody
	 @PostMapping("/map")
	 public List<Region> getRegion(@RequestParam("swLat") double swLat,
	                                @RequestParam("swLon") double swLon,
	                                @RequestParam("neLat") double neLat,
	                                @RequestParam("neLon") double neLon,
	                                @RequestParam("mapLevel")int mapLevel) {
	     return mapService.getRegions(swLat, swLon, neLat, neLon, mapLevel);
	  }
	 
	 
	 @ResponseBody
	 @PostMapping("/getAddress")
	    public List<AddressDto> getAddress(@RequestParam("sigungu") String sigungu) {
	     
		 return mapService.getAddress(sigungu);
	    }
	 
	
}