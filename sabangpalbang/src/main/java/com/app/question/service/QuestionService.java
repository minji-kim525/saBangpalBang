package com.app.question.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.PaginationDto;
import com.app.dto.PagingResponseDto;
import com.app.dto.QuestionDTO;
import com.app.dto.SearchDto;
import com.app.dto.UserDTO;
import com.app.manager.dto.PropertyResponseDto;
import com.app.question.dao.QuestionDao;
import com.app.question.dto.InsertDto;
import com.app.question.dto.titleDto;

@Service
public class QuestionService {
	@Autowired
	QuestionDao dao;
	
	public int addQuestion(Map<String, Object> map) {
		return dao.addQuestion(map);
	}
	
	public UserDTO idSelect(String id) {
		return dao.idSelect(id);
	}
	
	public PagingResponseDto<titleDto> titleSelect(SearchDto searchDto){
		int count = dao.count(searchDto);
		if(count<1) {
			return new PagingResponseDto<>(Collections.emptyList(),null);
		}
		PaginationDto paginationDto = new PaginationDto(count,searchDto);
		searchDto.setPaginationDto(paginationDto);
		
		List<titleDto> list=dao.titleSelect(searchDto);
		return new PagingResponseDto<>(list, paginationDto);
	}
	
	
	public titleDto contentSelect(int question_id){
		return dao.contentSelect(question_id);
	}
	
	public int deleteContent(int question_id) {
		return dao.deleteContent(question_id);
	}
	
	public int updateQuestion(QuestionDTO dto){
		return dao.updateQuestion(dto);
	}
	
	public int count() {
		return dao.count();
	}
	
	
	
	
	
   

}
