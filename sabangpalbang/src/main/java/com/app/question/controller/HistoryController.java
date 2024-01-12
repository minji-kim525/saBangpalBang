package com.app.question.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HistoryController {

	@GetMapping("history")
	public String historyView(@CookieValue(value = "onjCounter", defaultValue = "0") String onjCounter,
			HttpServletResponse response) {
		onjCounter = "http://localhost:8081/question/59";
		 Cookie cookie = new Cookie("onjCounter", 
				 onjCounter.toString());
				response.addCookie(cookie);
				 return "history/history";

	}

}
