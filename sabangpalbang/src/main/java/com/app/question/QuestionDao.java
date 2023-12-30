package com.app.question;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;
import com.app.property.dto.InsertDto;

@Mapper
public interface QuestionDao {
	
	int addQuestion(Map<String, Object> map);
	
	UserDTO idSelect(String id);
	
			

}
