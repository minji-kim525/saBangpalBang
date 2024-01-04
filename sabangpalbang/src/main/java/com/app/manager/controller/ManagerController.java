package com.app.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.manager.dto.PropertyResponseDto;
import com.app.manager.service.ManagerService;
import com.app.security.config.SecurityUser;

@Controller
public class ManagerController {

	@Autowired
	ManagerService service;
	
	@GetMapping("/manager/property")
	public String getPropertyManage(@AuthenticationPrincipal SecurityUser user,Model model) {
		List<PropertyResponseDto>list=service.getPropertyManage();
		if(user.getUsers().getRole().equals("ADMIN")&&!list.isEmpty())
			{
			model.addAttribute("list", list);
			}else if(!user.getUsers().getRole().equals("ADMIN")){
				throw new IllegalArgumentException("접근 권한이 없습니다.");
			}else {
				model.addAttribute("listcheck",0);
			}
		
		return "manager/propertyManage";
	}
	
	@DeleteMapping("/manager/property")
	public String deleteProperty(@RequestParam("property_service_id")int property_service_id,
			@AuthenticationPrincipal SecurityUser user) {
		service.deleteProperty(property_service_id);
		return "redirect:/manager/property";
	}
	
}
