package com.app.property.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.PropertyDTO;
import com.app.property.dto.PropertyDetailDTO;
import com.app.property.service.SearchDetailService;

@Controller
public class PDetailController {

	@Autowired
	private SearchDetailService detailservice;

	@GetMapping("/property/pDetail")
	public String searchDetail(Model m) {
		List<PropertyDetailDTO> pdetail = detailservice.getDetail(); 
		m.addAttribute("pdetail", pdetail);
		return "/property/pDetail";
	}
}
