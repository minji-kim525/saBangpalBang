package com.app.property.dto;

import lombok.Data;

@Data
public class InsertDto {
	
	private int question_id;
	private int user_id;
	private String title;
	private String content;
	private String id;

}
