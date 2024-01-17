package com.app.question.dto;

import java.util.Date;

import jakarta.validation.constraints.NotBlank;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class AnswerDto {
	private int answer_id;
	private int question_id;
	private String title;
	private String content;
	private int user_id;
	private Date created_at;
	private Date updated_at;

}
