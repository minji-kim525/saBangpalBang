package com.app.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.app.security.dao.UserDao;
import com.app.dto.UserDTO;

@Service
public class UserService {
	
	@Autowired
	UserDao dao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	public int insertUser(UserDTO users) {
		
		//암호화(BCrypt 알고리즘 )
		users.setPassword(encoder.encode(users.getPassword()));
	
//		users.setRole(Role.ROLE_ADMIN);
		
		int i = dao.insertUser(users);
		System.out.println(i);
		
		return i;
	}
}