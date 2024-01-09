package com.app.security.config;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import com.app.dto.UserDTO;


public class SecurityUser extends User {
	private static final long serialVersionUID = 1L;
	private final String email;

	private UserDTO users;
	
	public SecurityUser(UserDTO users) {
		super(users.getId().toString(), users.getPassword().toString(),
				AuthorityUtils.createAuthorityList(users.getRole().toString()));
		this.email = users.getEmail();
		this.users = users;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public UserDTO getUsers() {
		return users;
	}
	
	
}