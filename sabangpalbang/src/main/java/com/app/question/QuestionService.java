package com.app.question;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;
import com.app.property.dto.InsertDto;

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
	
	
	
	
	
	
	
   

}
