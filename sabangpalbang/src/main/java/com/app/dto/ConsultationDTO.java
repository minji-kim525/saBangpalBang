package com.app.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ConsultationDTO {
    private int consultation_id;
    private String message;
    private Date created_at;
    
    UserDTO user_id;
    ManagerDTO manager_id;
}