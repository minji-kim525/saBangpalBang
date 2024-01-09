package com.app.security.service;

import com.app.dto.UserDTO;
import com.app.security.config.SecurityUser;
import com.app.security.dao.UserDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserDao userMapper;

    @Autowired
	private PasswordEncoder encoder;

    public List<UserDTO> getUserList() {
        return userMapper.getUserList();
    }

    public UserDTO getUserById(String id) {
        return userMapper.getUserById(id);
    }

    public UserDTO getUserByEmail(String email) {
        return userMapper.getUserByEmail(email);
    }

    public void signup(UserDTO userVo) { // 회원 가입
        if (!userVo.getId().equals("")) {
            userVo.setPassword(encoder.encode(userVo.getPassword()));
            userMapper.insertUser(userVo);
        }
    }

    public void edit(UserDTO userVo,String id) { // 회원 정보 수정
    	userVo.setId(id);  	
        userVo.setPassword(encoder.encode(userVo.getPassword()));
        userMapper.updateUser(userVo);
    }

    public void withdraw(String id) { // 회원 탈퇴
        userMapper.deleteUser(id);
    }

    public PasswordEncoder passwordEncoder() {
        return this.encoder;
    }
    
    public boolean pwcheck(String password, String dbPassword) {
    	return encoder.matches(password, dbPassword);
    }
   

}