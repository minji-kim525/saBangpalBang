package com.app.dto;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PropertyDTO {

	private int property_id;
    private int p_service_type; // 무조건 2
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
    private String description;
    private int floor;
    private int property_type_id;
    private String telephone;
    private int month_price;
    
    UserDTO userDTO;
    PropertyTypeDTO propertyTypeDTO;
    private ImagesDTO images;
}
