package com.app.property.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.ConfirmDTO;
import com.app.dto.PropertyDTO;
import com.app.dto.PropertyServiceDTO;
import com.app.dto.TransactionPriceDTO;
import com.app.property.dto.PropertyDetailDTO;
import com.app.property.dto.PropertyResultDTO;
import com.app.property.service.SearchAllService;
import com.app.security.config.SecurityUser;

@Controller
public class SearchAllController {

	@Autowired
	SearchAllService allservice;

	// 검색창
	@GetMapping("/searchAll")
	public String searchAll() {
		return "property/searchAll";
	}

	// 검색결과
	@GetMapping("/property/searchAllResult")
	public String searchResult(@RequestParam("keyword") String keyword, Model m) {
		List<PropertyResultDTO> allProperties = allservice.getAllProperties(keyword);
//		ConfirmDTO confirm = allservice.getConfirm();
//		System.out.println("keyword : "+ keyword);
		m.addAttribute("allProperties", allProperties);
		m.addAttribute("keyword", keyword);
		return "property/searchAllResult";
	}

	// 서비스매물 상세정보
	@GetMapping("/property/psDetail")
	public String psDetail(@AuthenticationPrincipal SecurityUser user, @RequestParam("propertyId") int propertyId,
			@RequestParam("ps_service_type") int psServiceType, Model m) {
		PropertyDetailDTO psdetail = allservice.getpsDetail(propertyId, psServiceType);
		m.addAttribute("psdetail", psdetail);
//		System.out.println(psdetail);
		return "property/psDetail";
	}

	// 크롤링매물 상세정보
	@GetMapping("/property/pDetail")
	public String pDetail(@RequestParam("propertyId") int propertyId, @RequestParam("p_service_type") int pServiceType,
			Model m) {
		PropertyDetailDTO pdetail = allservice.getpDetail(propertyId, pServiceType);
		m.addAttribute("pdetail", pdetail);
//		System.out.println(pdetail);
		return "property/pDetail";
	}

	// 메인
	@GetMapping("/main")
	public String Main(Model m) {
		List<PropertyDTO> getProperties = allservice.getProperties();
		List<PropertyServiceDTO> getServiceProperties = allservice.getServiceProperties();
		m.addAttribute("getProperties", getProperties);
		m.addAttribute("getServiceProperties", getServiceProperties);
 		return "main/main";
	}

	// chart test
	@GetMapping("/chart")
	public String getConfirm(Model m) {
		List<TransactionPriceDTO> chart = allservice.getTransaction();
		m.addAttribute("chart", chart);
		return "property/chart";
	}

}
