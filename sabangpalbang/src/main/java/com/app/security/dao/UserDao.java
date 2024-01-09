package com.app.security.dao;

import com.app.dto.UserDTO;
import com.app.security.config.SecurityUser;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserDao {
    List<UserDTO> getUserList(); // User 테이블 가져오기
    void insertUser(UserDTO users); // 회원 가입
    UserDTO getUserByEmail(String email); // 회원 정보 가져오기
    UserDTO getUserById(String id);
    void updateUser(UserDTO UserVo); // 회원 정보 수정
    void deleteUser(String id); // 회원 탈퇴	
	void deleteUser(SecurityUser user);
}