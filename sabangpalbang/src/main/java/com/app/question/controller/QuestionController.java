package com.app.question.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.app.question.dto.InsertDto;
import com.app.question.dto.titleDto;
import com.app.question.service.AnswerService;
import com.app.question.service.QuestionService;
import com.app.security.config.SecurityUser;

import jakarta.validation.Valid;

@Controller
public class QuestionController {

	@Autowired
	QuestionService service;

	@Autowired
	AnswerService aservice; 
	

	// 문의 수정
	@PostMapping("question/updatepage")
	public String updateContent(QuestionDTO dto) {
		service.updateQuestion(dto);
		return "redirect:/question/" + dto.getQuestion_id();
	}

	// 문의 수정 페이지호출
	@PostMapping("question/update")
	public String getPage(@RequestParam("question_id") int question_id, @AuthenticationPrincipal SecurityUser user,
			Model m) {
		titleDto clist = service.contentSelect(question_id);
		m.addAttribute("content", clist);
		m.addAttribute("id", user.getUsers().getId()); 
		return "question/updatepage";
	}

	// 문의 삭제
	@PostMapping("question/delete/{question_id}")
	public String deleteContent(@PathVariable(name = "question_id") int question_id) {
		service.deleteContent(question_id);
		return "redirect:/question/title";
	}

	// 문의 내용
	@GetMapping("question/{question_id}")
	public String contentSelect(@PathVariable(name = "question_id") int question_id,
			@AuthenticationPrincipal SecurityUser user, Model m) {
		try {// ============ 문의내용 ================================
			titleDto clist = service.contentSelect(question_id);
			m.addAttribute("content", clist);
			m.addAttribute("id", user.getUsers().getId());
			m.addAttribute("role", user.getUsers().getRole());
			// ============ 답변내용 ================================
			List<AnswerDto> alist = aservice.answerSelect(question_id);
			int count = aservice.count(question_id);
			m.addAttribute("alist", alist);
			m.addAttribute("count", count);
			return "question/content";
		} catch (NullPointerException e) {
			// ============ 문의내용 ================================
			titleDto clist = service.contentSelect(question_id);
			m.addAttribute("content", clist);
			// ============ 답변내용 ================================
			List<AnswerDto> alist = aservice.answerSelect(question_id);
			int count = aservice.count(question_id);
			m.addAttribute("alist", alist);
			m.addAttribute("count", count);
			return "question/content";
		}
	}


	// 문의 등록
	@PostMapping("question/insert")
	public String insert(@ModelAttribute("dto")@Valid InsertDto dto, BindingResult error,
			 @AuthenticationPrincipal SecurityUser user, Model m) {
		if (error.hasErrors()) {
			return "question/insert";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user.getUsers().getUser_id());
		map.put("title", dto.getTitle());
		map.put("content", dto.getContent());
		map.put("question_type", dto.getQuestion());
		service.addQuestion(map);
		

		return "redirect:/question/" + map.get("question_id");
		}
	

	@GetMapping("question/insert")
	public String view(@AuthenticationPrincipal SecurityUser user) {
		try {
			if (user.getUsers().getId().equals(null)) {
				return "redirect:/login";
			} else {
				return "question/insert";
			}
		} catch (NullPointerException e) {
			return "redirect:/login";
		}
	}

	// 문의 목록
	@GetMapping("question/title")
	public String titleSelect(@ModelAttribute SearchDto searchDto, Model model) {
		PagingResponseDto<titleDto>list=service.titleSelect(searchDto);
		model.addAttribute("list", list.getList());
		model.addAttribute("pagination",list.getPaginationDto());
		return "question/title";
	} 
}
