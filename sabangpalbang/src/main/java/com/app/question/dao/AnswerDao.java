package com.app.question.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.app.dto.AnswerDTO;
import com.app.question.dto.AnswerDto;
import com.app.question.dto.titleDto;

@Mapper
public interface AnswerDao {

	List<titleDto> titleSelect();
	
	int answerInsert(AnswerDto dto);
	
	List<AnswerDto> answerSelect(int question_id);
	
	int count(int question_id);
	
	int deleteContent(int answer_id);
	
	int updateAnswer(AnswerDto dto);
	
}
