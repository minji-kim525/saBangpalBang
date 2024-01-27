package com.app.map.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.app.map.dto.Region;
import com.app.map.service.MapService;

@RestController
public class MapController {
	
	 @Autowired
	 private MapService mapService;

	 @ResponseBody
	 @PostMapping("/map")
	 public List<Region> getRegion(@RequestParam("swLat") double swLat,
	                                @RequestParam("swLon") double swLon,
	                                @RequestParam("neLat") double neLat,
	                                @RequestParam("neLon") double neLon,
	                                @RequestParam("mapLevel")int mapLevel) {
	     return mapService.getRegions(swLat, swLon, neLat, neLon, mapLevel);
	  }
}