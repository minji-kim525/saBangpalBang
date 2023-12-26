package com.app.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PropertyDTO {

	private int property_id;
    private int service_type;
    private int user_id;
    private int property_type_id;
    private String image;
    private int price;
    private int feet;
    private String pname;
    private int deposit;
    private int charge;
    private int count;
    private Timestamp registration_date;
    private Timestamp move_date;
    private String address;
}
