package com.app.security.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.app.security.config.SecurityUser;
import com.app.security.dao.UserDao;
import com.app.security.service.UserService;

import com.app.dto.UserDTO;

@Controller
public class SecurityController {
	
	@Autowired
	UserService service;
	
	@GetMapping("/")
	public String index() {
		System.out.println("index 요청입니다.");
		return "index";
	}

	@GetMapping("/user")
	public void forUser() {
		System.out.println("User 요청입니다.");
	}


	@GetMapping("/admin")
	public void forAdmin(@AuthenticationPrincipal SecurityUser user) {
		System.out.println(user.getUsers().getId());
		System.out.println("Admin 요청입니다.");
	}

	@GetMapping("/login")
	public void login() {
	}

	@GetMapping("/loginSuccess")
	public void loginSuccess() {
	}
		
	@GetMapping("/accessDenied")
	public void accessDenied() {		
	}
	
	@GetMapping("/insert")
	public void insert() {}
		
		
	@PostMapping("/insert")
	public String insert(UserDTO users) {
	service.insertUser(users);
					
	return "redirect:/";
	}
}