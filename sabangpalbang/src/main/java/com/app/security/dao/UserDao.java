package com.app.security.dao;

import com.app.dto.UserDTO;
import com.app.security.config.SecurityUser;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

@Mapper
public interface UserDao {
    List<UserDTO> getUserList(); // User 테이블 가져오기
    int idCheck(String id); // 아이디 중복 확인
    void insertUser(UserDTO users); // 회원 가입
    UserDTO getUserByEmail(String email); // 회원 정보 가져오기
    UserDTO getUserById(String id);
    void updateUser(UserDTO UserVo); // 회원 정보 수정
    void deleteUser(String id); // 회원 탈퇴	
	void deleteUser(SecurityUser user);
}