package com.app.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PropertyServiceDTO {

	private int property_id;
    private int ps_service_type;
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
   
}
