package com.app.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.app.dto.QuestionDTO;
import com.app.dto.SearchDto;
import com.app.dto.UserDTO;
import com.app.question.dto.InsertDto;
import com.app.question.dto.titleDto;


@Mapper
public interface QuestionDao {
	
	int addQuestion(Map<String, Object> map);
	
	UserDTO idSelect(String id);
	
	List<titleDto> titleSelect(SearchDto searchDto);
	
	int count(SearchDto searchDto );
	
	titleDto contentSelect(int question_id);
	
	int deleteContent(int question_id);	
	
	int updateQuestion(QuestionDTO dto);
	
	int count();
	
	
}
