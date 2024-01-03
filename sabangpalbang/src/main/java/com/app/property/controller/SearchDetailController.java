package com.app.property.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.property.service.SearchDetailService;

@Controller
public class SearchDetailController {

	@Autowired
	private SearchDetailService detailservice;

	@GetMapping("/property/searchDetail")
	public String searchDetail(@RequestParam("keyword") String keyword, Model m) {
		m.addAttribute("detail", detailservice.getDetail(keyword));
		return "/property/searchDetail";
	}
}
