package com.app.question.controller;

import java.util.HashMap;
import java.util.List;
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
import com.app.question.dto.InsertDto;
import com.app.question.dto.titleDto;
import com.app.question.service.QuestionService;

@Controller
public class QuestionContoller {
	
	@Autowired
	QuestionService service;
	
	// 문의 삭제
    @PostMapping("question/{question_id}")
    public String deleteContent(@PathVariable(name = "question_id") int question_id) {
        service.deleteContent(question_id);
        return "redirect:/question/title";
    }
	
    // 문의 내용
	@GetMapping("question/{question_id}")
	public String contentSelect(@PathVariable(name = "question_id") 
	       int question_id,Model m) {
		titleDto clist = service.contentSelect(question_id);
		int cid = clist.getQuestion_id();
		if(cid != 0) {
			m.addAttribute("content", clist);
			return "question/content";
		}else {
			return "question/alert";
		}
								
	}
	
	// 문의 목록
	@GetMapping("question/title")
	public String titleSelect(Model m) {
		List<titleDto> tlist = service.titleSelect();
		m.addAttribute("tlist", tlist);
		return "question/title";
	}
	
	
	// 문의 등록
	@PostMapping("question/insert")
	public void insert(InsertDto dto) {
		Map<String, Object> map = new HashMap<String, Object>();
		UserDTO id = service.idSelect(dto.getId());
		map.put("user_id", id.getUser_id());
		map.put("title", dto.getTitle());
		map.put("content", dto.getContent());
		service.addQuestion(map);		
	}	
	@GetMapping("question/insert")
	public String view(){
		return "question/insert";
	}
}
