package com.app.dto;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class AnswerDTO {
    private int answer_id;
    private String title;
    private String content;
    private Date created_at;
    private Date updated_at;
    
    QuestionDTO question_id;
    UserDTO user_id;
    ManagerDTO manager_id;
}