package com.app.question.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.SearchDto;
import com.app.question.dto.AnswerDto;
import com.app.question.dto.titleDto;

@Mapper
public interface AnswerDao {

	
	List<titleDto> titleSelect(SearchDto searchDto);
	
	int selectCount(SearchDto searchDto );
	
	int answerInsert(AnswerDto dto);
	
	List<AnswerDto> answerSelect(int question_id);
	
	int count(int question_id);
	
	int deleteContent(int answer_id);
	
	int updateAnswer(AnswerDto dto);
	
	int insertNotifyAnswer(@Param("question_id")int question_id,@Param("user_id")int user_id);
}
