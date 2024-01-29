package com.app.map.dto;

import java.sql.Date;

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
//	private Date registration_date;
//	private Date move_date;
	private String description;
	private int property_type_id;
	private int charge;
	private int p_service_type;
	private int ps_service_type;
    private String telephone;
    private int month_price;
    private String filepath;

}
