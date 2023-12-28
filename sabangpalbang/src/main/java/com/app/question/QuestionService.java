package com.app.question;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;

@Service
public class QuestionService {
	@Autowired
	QuestionDao dao;
	
	public UserDTO idSelect(UserDTO id) {
		return dao.idSelect(id);
	}
	
	
	
   

}
