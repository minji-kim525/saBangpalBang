package com.app.question;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.QuestionDTO;

@Service
public class QuestionService {
	@Autowired
	QuestionDao dao;
	
	public QuestionDTO idSelect(String id) {
		return dao.idSelect(id);
	}
	
	
	
   

}
