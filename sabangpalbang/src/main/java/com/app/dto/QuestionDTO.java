package com.app.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QuestionDTO {
    private int question_id;
    private int user_id;
    private String title;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;
}

