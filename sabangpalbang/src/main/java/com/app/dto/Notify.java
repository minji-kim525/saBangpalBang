package com.app.dto;

import lombok.Data;

@Data
public class Notify {
	
	private int notify_id;
	private boolean notify_check;
	
	AnswerDTO answer_id;
	UserDTO user_id;
	ConfirmDTO confirm_id;

}
