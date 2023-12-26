package com.app.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ConsultationDTO {
    private int consultation_id;
    private int user_id;
    private int manager_id;
    private String message;
    private Timestamp created_at;
}