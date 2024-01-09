package com.app.mypage.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
public class UploadRequestDto {
	
	private int property_service_id;
	private int ps_service_type;
	private int property_type_id;
    private int price;
    private int feet;
    private int floor;
    private String pname;
    private int deposit;
    private int charge;
    private int count;
//    private Date registration_date;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date move_date;
    private String address;
    private String description;
    private int user_id;
    private boolean private_property;
    List<MultipartFile> files; 

}
