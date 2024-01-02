package com.app.security.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.app.dto.UserDTO;

@Mapper
public interface UserDao {
	@Select("select * from users where id = #{id}")
	UserDTO findById(String id);
	
	@Insert("insert into users values (#{user_id}, #{password}, #{email}, #{id}, 'USER')")
	int insertUser(UserDTO user);
}
