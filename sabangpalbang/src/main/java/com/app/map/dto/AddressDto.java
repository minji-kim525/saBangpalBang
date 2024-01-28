package com.app.map.dto;

import lombok.Data;
@Data
public class AddressDto {
	
	private int property_id;
	private int property_service_id;
	private String address;
	private String pname;
	private int price;
	private int deposit;
	private int feet;
	private int floor; 
	private int count;
	private int property_type_id;
	private int p_service_type;
    private int month_price;

}
