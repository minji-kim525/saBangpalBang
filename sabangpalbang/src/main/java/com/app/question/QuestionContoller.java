package com.app.question;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.resource.HttpResource;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;
import com.app.property.dto.InsertDto;

@Controller
public class QuestionContoller {
	
	@Autowired
	QuestionService service;
	
	
	
	@PostMapping("/test")
	public void insert(InsertDto dto) {
		Map<String, Object> map = new HashMap<String, Object>();
		UserDTO id = service.idSelect(dto.getId());
		map.put("user_id", id.getUser_id());
		map.put("title", dto.getTitle());
		map.put("content", dto.getContent());
		service.addQuestion(map);		
	}	
	@GetMapping("/test")
	public String view(){
		return "test";
	}
}
