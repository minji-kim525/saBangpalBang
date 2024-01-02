package com.app.mypage.dto;

import com.app.dto.ImagesDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
public class MyUploadResponseDto {

	private int property_service_id;
	private int ps_service_type;
	private int property_type_id;
    private int price;
    private boolean private_property;
    private String pname;
	
	private ImagesDTO images;
	
}
