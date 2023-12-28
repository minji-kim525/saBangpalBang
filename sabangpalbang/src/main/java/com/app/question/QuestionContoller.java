package com.app.question;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.resource.HttpResource;

@Controller
public class QuestionContoller {
	
	QuestionService service;
	
	@GetMapping("/test")
	public String view(){
		return "test";
	}
	
	@PostMapping("/test")
	public String select(Model m ,String id) {
		service.idSelect(id);
		m.addAttribute("id", id);
		
		return "select";
	
	}
	


}
