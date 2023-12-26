package com.app.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AnswerDTO {
    private int answer_id;
    private int question_id;
    private int user_id;
    private int manager_id;
    private String title;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;
}