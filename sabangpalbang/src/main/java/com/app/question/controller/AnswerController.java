package com.app.question.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.PagingResponseDto;
import com.app.dto.QuestionDTO;
import com.app.dto.SearchDto;
import com.app.question.dto.AnswerDto;
import com.app.question.dto.titleDto;
import com.app.question.service.AnswerService;
import com.app.question.service.QuestionService;
import com.app.security.config.SecurityUser;

import jakarta.validation.Valid;

@Controller
public class AnswerController {

	@Autowired
	AnswerService service;
	
	@Autowired
	QuestionService qservice;
	
	@GetMapping("answer/test")
	public String test() {
		
		return "answer/test";
	}
	// =========답변 수정 ==================
	@PostMapping("question/answer/update")
	public String updateContent(AnswerDto dto) {
		service.updateAnswer(dto);
		return "redirect:/question/"+dto.getQuestion_id();
	}
	@PostMapping("question/answer/updatepage")
	public String updatePage(AnswerDto dto ,Model m) {
		titleDto clist = qservice.contentSelect(dto.getQuestion_id());
		m.addAttribute("content", clist);
		m.addAttribute("answer", dto.getContent());
		m.addAttribute("answer_id", dto.getAnswer_id());
		m.addAttribute("question_id", dto.getQuestion_id());
		return "answer/updatepage";
	}
	// ========답변 삭제 ============
	@PostMapping("question/answerdelete")
	public String deleteAnswer(AnswerDto dto) {
		service.deleteContent(dto.getAnswer_id());
		return "redirect:/question/"+dto.getQuestion_id();
	}
    // =========관리자 답변=========
	@PostMapping("question/answer/insert")
	public String insertAnswer(@ModelAttribute("dto")AnswerDto dto,Model m) {
		service.answerInsert(dto); 
		return "redirect:/question/"+dto.getQuestion_id();
	}

	@PostMapping("question/answer")
	public String insertPage(AnswerDto dto ,Model m) {
		titleDto clist = qservice.contentSelect(dto.getQuestion_id());
		m.addAttribute("content", clist);	
		return "answer/insert";
	}
    //=========관리자 문의 페이지 호출=========
	@GetMapping("answer/title")
	public String titleSelect(@ModelAttribute SearchDto searchDto,@AuthenticationPrincipal SecurityUser user,Model model) {
		if(user.getUsers().getRole().equals("ROLE_ADMIN")) {
			PagingResponseDto<titleDto>list=service.titleSelect(searchDto);
			model.addAttribute("list", list.getList());
			model.addAttribute("pagination",list.getPaginationDto());
		return "answer/title";
		}else {
			return "redirect:/question/title";
		}
	}
	
}
