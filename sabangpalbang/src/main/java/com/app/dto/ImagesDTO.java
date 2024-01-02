package com.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
public class ImagesDTO {

	private int image_id;
	private String filename;
	private String filepath;
	
	private int property_id;
	private int property_service_id;
	private int p_service_type;
	private int ps_service_type;
	
	public ImagesDTO(String filename, String filepath,int ps_service_type) {
		this.filename=filename;
		this.filepath=filepath;
		this.ps_service_type=ps_service_type;
	}
}
