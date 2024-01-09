package com.app.property.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.PropertyDTO;
import com.app.property.service.searchAllService;

@Controller
public class searchAllController {

	@Autowired
	searchAllService allservice;

	@GetMapping("/searchAll")
	public String searchAll() {
		return "property/searchAll";
	}

	@GetMapping("/property/searchAllResult")
	public String searchResult(@RequestParam("keyword") String keyword, Model m) {
		List<PropertyDTO> allProperties = allservice.searchAll(keyword);
		m.addAttribute("allProperties", allProperties);
		m.addAttribute("keyword", keyword);
		return "property/searchAllResult";
	}
}
	
	