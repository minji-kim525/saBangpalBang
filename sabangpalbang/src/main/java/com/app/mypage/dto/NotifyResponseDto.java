package com.app.mypage.dto;

import lombok.Data;

@Data
public class NotifyResponseDto {

	private int notify_id;
	private int notify_check;
	private int question_id;
	private int confirm_id;
	private int confirm_check;
}
