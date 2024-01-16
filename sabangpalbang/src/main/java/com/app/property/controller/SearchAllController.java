package com.app.property.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		m.addAttribute("allProperties", allProperties);
		m.addAttribute("keyword", keyword);
		return "property/searchAllResult";
	}

	// 서비스매물 상세정보
	@GetMapping("/property/psDetail")
	public String psDetail(@AuthenticationPrincipal SecurityUser user, @RequestParam("propertyId") int propertyId,
			@RequestParam("ps_service_type") int psServiceType, 
			@RequestParam("address") String address, @RequestParam("pname") String pname, Model m) {
		PropertyDetailDTO psdetail = allservice.getpsDetail(propertyId, psServiceType);
		List<TransactionPriceDTO> chart = allservice.getTransaction(address, pname);
		m.addAttribute("chart", chart);
		m.addAttribute("psdetail", psdetail);
//		System.out.println(chart);
		return "property/psDetail";
	}
	
	@GetMapping("/property/psDetailJson")
	@ResponseBody
	public PropertyDetailDTO psDetailJson(@AuthenticationPrincipal SecurityUser user,
			@RequestParam("propertyId") int propertyId, @RequestParam("ps_service_type") int psServiceType) {
		return allservice.getpsDetail(propertyId, psServiceType);
	}
	
	@GetMapping("/property/getApartJson")
	@ResponseBody
	public List<TransactionPriceDTO> psApartJson(@RequestParam String address,
	                                      @RequestParam String pname) {
	    return allservice.getTransaction(address, pname);
	}
	
	// 크롤링매물 상세정보
	@GetMapping("/property/pDetail")
	public String pDetail(@RequestParam("propertyId") int propertyId, @RequestParam("p_service_type") int pServiceType,
			@RequestParam("address") String address, @RequestParam("pname") String pname, Model m) {
		PropertyDetailDTO pdetail = allservice.getpDetail(propertyId, pServiceType);
		List<TransactionPriceDTO> chart = allservice.getTransaction(address, pname);
		m.addAttribute("chart", chart);
		m.addAttribute("pdetail", pdetail);
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

	// 실거래가 비교
	@GetMapping("/transaction")
//	@ResponseBody
	public String getAllTransaction() {
		return "/property/transaction";
	}
	
	@GetMapping("/transactionJson")
	@ResponseBody
	public List<TransactionPriceDTO> getTransGraph(@RequestParam("regional_cd") int regcd, @RequestParam("dong_cd") int dongcd,
			@RequestParam("apart_cd") int apartcd) {
		return allservice.getTransGraph(regcd, dongcd, apartcd);
	}

	// 동 이름 목록
	@GetMapping("/getDongsJson")
	@ResponseBody
	public List<TransactionPriceDTO> getDongsJson(@RequestParam("regional_cd") int regcd) {
		return allservice.getAllDong(regcd);
	}

	// 아파트 이름 목록
	@GetMapping("/getApartmentsJson")
	@ResponseBody
	public List<TransactionPriceDTO> getApartmentsJson(@RequestParam("regional_cd") int regcd,
			@RequestParam("dong_cd") int dongcd) {
		return allservice.getAllName(regcd, dongcd);
	}
}
