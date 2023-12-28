package com.app.question;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.app.dto.QuestionDTO;
import com.app.dto.UserDTO;

@Mapper
public interface QuestionDao {
	
	@Select("select user_id from users where id like #{id}")
	UserDTO idSelect(UserDTO id);

}
