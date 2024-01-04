package com.app.property.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.PropertyDTO;
import com.app.property.dto.PropertyResultDTO;
import com.app.property.service.SearchAllService;

@Controller
public class SearchAllController {

	@Autowired
	SearchAllService allservice;

	//검색창
	@GetMapping("/searchAll")
	public String searchAll() {
		return "property/searchAll";
	}

	//검색결과
	@GetMapping("/property/searchAllResult")
	public String searchResult(@RequestParam("keyword") String keyword, Model m) {
		List<PropertyResultDTO> allProperties = allservice.getAllProperties(keyword);
		m.addAttribute("allProperties", allProperties);
		m.addAttribute("keyword", keyword);
		return "property/searchAllResult";
	}

}
	
	