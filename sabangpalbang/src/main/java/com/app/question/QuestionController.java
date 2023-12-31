package com.app.question;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.resource.HttpResource;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;

@Controller
public class QuestionController {
	
	@Autowired
	QuestionService service;
	
	@GetMapping("/test")
	public String view(){
		return "test";
	}
	
	@PostMapping("/test")
	public String select(Model m , UserDTO id) {
		UserDTO a = service.idSelect(id);
		m.addAttribute("id", a);
		System.out.println(a.getUser_id());
		
		return "select";
	
	}
	


}
