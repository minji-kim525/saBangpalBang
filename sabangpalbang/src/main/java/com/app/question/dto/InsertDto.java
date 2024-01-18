package com.app.question.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class InsertDto {
	
	private int question_id;
	private int user_id;
	@NotBlank(message = "제목을 입력해주세요")
	private String title;
	@NotBlank(message = "내용을 입력해주세요")
	private String content;
	private String id;
	private String question;

}
