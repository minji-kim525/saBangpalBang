package com.app.mypage.dto;

import lombok.Data;

@Data
public class NotifyResponseDto {

	private int notify_id;
	private int notify_check;
	private Integer question_id;
	private Integer confirm_id;
	private int confirm_check;
	private int property_service_id;
    private int ps_service_type;
    private String title;
    private String pname;
    private String address;
}
