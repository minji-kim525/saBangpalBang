package com.app.property.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.property.dto.PropertyDetailDTO;
import com.app.property.service.SearchDetailService;

@Controller
public class PsDetailController {

	@Autowired
	private SearchDetailService detailservice;

	@GetMapping("/property/psDetail")
	public String searchDetail(Model m) {
		List<PropertyDetailDTO> psdetail = detailservice.getDetail(); 
		m.addAttribute("psdetail", psdetail);
		return "/property/psDetail";
	}
}
