package com.app.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PropertyServiceDTO {

	private int property_service_id;
    private int ps_service_type; // 무조건 1
    private int price;
    private int feet;
    private String pname;
    private int deposit;
    private int charge;
    private int count;
    private Date registration_date;
    private Date move_date;
    private String address;
    private boolean private_property;
    private String description;
    private int floor;
    private int property_type_id;
    
    UserDTO userDTO;
    PropertyTypeDTO propertyTypeDTO;
	private ImagesDTO images;
   
}
