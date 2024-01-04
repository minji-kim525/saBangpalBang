package com.app.property.dto;

import com.app.dto.ImagesDTO;

import lombok.Data;

@Data
public class PropertyResultDTO {

	private int property_id;
	private int property_service_id;
	private int p_service_type;
	private int ps_service_type;
	private String pname;
	private int price;
	private int user_id;
	private int property_type_id;
	private boolean private_property;
	
	private ImagesDTO images;
}
