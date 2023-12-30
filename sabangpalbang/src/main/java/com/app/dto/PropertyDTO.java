package com.app.dto;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class PropertyDTO {

	private int property_id;
    private int p_service_type;
    private String image;
    private int price;
    private int feet;
    private String pname;
    private int deposit;
    private int charge;
    private int count;
    private Date registration_date;
    private Date move_date;
    private String address;
    
    UserDTO userDTO;
    PropertyTypeDTO propertyTypeDTO;
}
