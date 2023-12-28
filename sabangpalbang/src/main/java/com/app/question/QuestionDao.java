package com.app.question;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.app.dto.QuestionDTO;

@Mapper
public interface QuestionDao {
	
	@Select("select user_id from question where id = #{id}")
	QuestionDTO idSelect(String id);

}
