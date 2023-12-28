package com.app.dto;

import lombok.Data;

@Data
public class UserDTO {
    private int user_id;
    private String password;
    private String email;
    private String id;
    private String role;
}