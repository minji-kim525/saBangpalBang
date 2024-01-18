package com.app.question.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.dto.AnswerDTO;
import com.app.dto.PaginationDto;
import com.app.dto.PagingResponseDto;
import com.app.dto.QuestionDTO;
import com.app.dto.SearchDto;
import com.app.question.dao.AnswerDao;
import com.app.question.dto.AnswerDto;
import com.app.question.dto.titleDto;

@Service
public class AnswerService {
	@Autowired
	AnswerDao dao;
	
	public PagingResponseDto<titleDto> titleSelect(SearchDto searchDto){
		int count = dao.selectCount(searchDto);
		if(count<1) {
			return new PagingResponseDto<>(Collections.emptyList(),null);
		}
		PaginationDto paginationDto = new PaginationDto(count,searchDto);
		searchDto.setPaginationDto(paginationDto);
		
		List<titleDto> list=dao.titleSelect(searchDto);
		return new PagingResponseDto<>(list, paginationDto);
	}

	@Transactional
	public void answerInsert(AnswerDto dto) {
		
		dao.answerInsert(dto);
		//알림
		dao.insertNotifyAnswer(dto.getQuestion_id(), dto.getUser_id());
	}

	public List<AnswerDto> answerSelect(int question_id) {
		return dao.answerSelect(question_id);
	}

	public int count(int question_id) {
		return dao.count(question_id);
	};
	
	public int deleteContent(int answer_id) {
		return dao.deleteContent(answer_id);
	}
	
	public int updateAnswer(AnswerDto dto){
		return dao.updateAnswer(dto);
	}
	

}
