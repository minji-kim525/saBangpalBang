package com.app.mypage.dto;

import java.util.List;

import com.app.question.dto.titleDto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UploadAndQuestionDto {
	private List<MyUploadResponseDto> list;
	private List<titleDto>qlist;

}
