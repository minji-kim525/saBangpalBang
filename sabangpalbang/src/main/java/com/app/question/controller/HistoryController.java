package com.app.question.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.security.config.SecurityUser;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HistoryController {

	
	//최근 본 내역
	
	@GetMapping("history")
	public String historyView(@AuthenticationPrincipal SecurityUser user, Model m) {
		m.addAttribute("id", user.getUsers().getId());
		m.addAttribute("loginId", user.getUsername());
    	m.addAttribute("loginEmail", user.getUsers().getEmail());
		
				 return "history/history";
	}

}
