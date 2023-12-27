package com.app.dto;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class QuestionDTO {
    private int question_id;
    private String title;
    private String content;
    private Date created_at;
    private Date updated_at;
    
    UserDTO user_id;

}

