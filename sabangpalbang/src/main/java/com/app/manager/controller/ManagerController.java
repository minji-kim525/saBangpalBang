package com.app.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.PagingResponseDto;
import com.app.dto.SearchDto;
import com.app.manager.dto.PropertyResponseDto;
import com.app.manager.dto.UsersResponseDto;
import com.app.manager.service.ManagerService;
import com.app.security.config.SecurityUser;

@Controller
public class ManagerController {

	@Autowired
	ManagerService service;
	
	//업로드 게시글 조회 및 검색
	@GetMapping("/manager/property/search")
	public String searchPropertyManage(@AuthenticationPrincipal SecurityUser user,
			@ModelAttribute SearchDto searchDto,Model model) {
		PagingResponseDto<PropertyResponseDto>list=service.searchPropertyManage(searchDto);
		model.addAttribute("loginId", user.getUsername());
    	model.addAttribute("loginEmail", user.getUsers().getEmail());
		if(user.getUsers().getRole().equals("ROLE_ADMIN")&&!list.getList().isEmpty())
			{
			model.addAttribute("list", list.getList());
			model.addAttribute("pagination",list.getPaginationDto());
			}else if(!user.getUsers().getRole().equals("ROLE_ADMIN")){
				throw new IllegalArgumentException("접근 권한이 없습니다.");
			}else {
				model.addAttribute("listcheck",0);
			}
		return "manager/propertyManage";
	}
	
	//게시글 삭제
	@DeleteMapping("/manager/property/search")
	public String deleteProperty(@RequestParam("property_service_id")int property_service_id,
			@AuthenticationPrincipal SecurityUser user) {
		service.deleteProperty(property_service_id);
		return "redirect:/manager/property/search";
	}
	
	//승인요청 검색 및 조회
		@GetMapping("/manager/confirm/search")
		public String getConfirm(@AuthenticationPrincipal SecurityUser user,
				@ModelAttribute SearchDto searchDto,Model model) {
			PagingResponseDto<PropertyResponseDto>list=service.getConfirm(searchDto);
			model.addAttribute("loginId", user.getUsername());
	    	model.addAttribute("loginEmail", user.getUsers().getEmail());
			if(user.getUsers().getRole().equals("ROLE_ADMIN")&&!list.getList().isEmpty())
				{
				model.addAttribute("list", list.getList());
				model.addAttribute("pagination",list.getPaginationDto());
				}else if(!user.getUsers().getRole().equals("ROLE_ADMIN")){
					throw new IllegalArgumentException("접근 권한이 없습니다.");
				}else {
					model.addAttribute("listcheck",0);
				}
			return "manager/confirm";
		}
		
	//승인 및 반려
		@PutMapping("/manager/confirm/search")
		public String updatePrivate(
				@RequestParam(value="property_service_id") int property_service_id,
				@RequestParam(value="confirmcheck")int confirmcheck) {
			 service.updateConfirm(property_service_id,confirmcheck);
			 return "redirect:/manager/confirm/search";
		}
		
		//사용자 조회 및 검색
		@GetMapping("manager/users/search")
		public String getUsers(@AuthenticationPrincipal SecurityUser user,
				@ModelAttribute SearchDto searchDto,Model model) {
			PagingResponseDto<UsersResponseDto>list=service.getUsers(searchDto);
			model.addAttribute("loginId", user.getUsername());
	    	model.addAttribute("loginEmail", user.getUsers().getEmail());
			if(user.getUsers().getRole().equals("ROLE_ADMIN")&&!list.getList().isEmpty())
				{
				model.addAttribute("list", list.getList());
				model.addAttribute("pagination",list.getPaginationDto());
				}else if(!user.getUsers().getRole().equals("ROLE_ADMIN")){
					throw new IllegalArgumentException("접근 권한이 없습니다.");
				}else {
					model.addAttribute("listcheck",0);
				}
			return "manager/usersManage";
		}
		
		//사용자 삭제
		@DeleteMapping("/manager/users/search")
		public String deleteUser(@RequestParam("user_id")int user_id) {
			service.deleteUser(user_id);
			return "redirect:/manager/users/search";
		}
		
		
		
}
