package com.app.property.dto;

import lombok.Data;

@Data
public class propertyResultDTO {

	private int property_id;
	private int property_service_id;
	private int p_service_type;
	private int ps_service_type;
	private String pname;
	private int charge;
	private int user_id;
	private int property_type_id;
}
