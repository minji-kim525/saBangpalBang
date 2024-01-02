package com.app.question.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;
import com.app.property.dto.InsertDto;
import com.app.question.dao.QuestionDao;
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
	
	public List<titleDto> titleSelect(){
		return dao.titleSelect();
	}
	
	public titleDto contentSelect(int question_id){
		return dao.contentSelect(question_id);
	}
	
	public int deleteContent(int question_id) {
		return dao.deleteContent(question_id);
	}
	
	
	
	
	
	
   

}
