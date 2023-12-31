package com.app.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ConsultationDetailDTO {
	
	private int c_detail_id;
	private String message;
	private Timestamp created_at;
	private boolean chat_check;
	
	ConsultationDTO consultation_id;
}
