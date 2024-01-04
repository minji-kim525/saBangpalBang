package com.app.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.dto.PropertyDTO;
import com.app.dto.PropertyServiceDTO;
import com.app.main.service.PService;
import com.app.main.service.PsService;

@Controller
public class MainController {
	
	@Autowired
	PService pservice;
	
	@Autowired
	PsService psservice;

	//검색창
	@GetMapping("/main")
	public String pMain(Model m) {
		List<PropertyDTO> getProperties = pservice.getProperties();
		List<PropertyServiceDTO> getServiceProperties = psservice.getServiceProperties();
		
		m.addAttribute("getProperties", getProperties);
		m.addAttribute("getServiceProperties", getServiceProperties);
		
		return "/main/main";
	}

}
