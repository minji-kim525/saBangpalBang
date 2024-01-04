package com.app.manager.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PropertyResponseDto {

	private int user_id;
	private String id;
	private Date registration_date;
	private String pname;
	private String address;
	private int property_service_id;
	private int ps_service_type;
	private int property_type_id;
}
