package com.app.question.dto;

import java.util.Date;

import lombok.Data;

@Data
public class titleDto {
	
	private int question_id;
	private int user_id;
	private String title;
	private String content;
	private String id;
	private Date created_at;

}
