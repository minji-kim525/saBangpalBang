package com.app.property.dto;
import java.sql.Date;

import com.app.dto.ImagesDTO;

import lombok.Data;

@Data
public class PropertyDetailDTO {
	
	private int property_id;
	private int property_service_id;
	private String address;
	private String pname;
	private int price;
	private int deposit;
	private int feet;
	private int floor; 
	private int count;
	private Date registration_date;
	private String description;
	
	private ImagesDTO images;

}
