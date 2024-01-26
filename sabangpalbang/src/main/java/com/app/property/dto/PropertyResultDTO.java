package com.app.property.dto;

import java.util.ArrayList;
import java.util.List;

import com.app.dto.ConfirmDTO;
import com.app.dto.ImagesDTO;

import lombok.Data;

@Data
public class PropertyResultDTO {

	private int property_id;
	private int property_service_id;
	private int p_service_type;
	private int ps_service_type;
	private String pname;
	private int price;
	private int user_id;
	private int property_type_id;
	private boolean private_property;
    private int confirm_check;
    private String address;
    private int deposit;
    private int month_price;
    private int count;
    private int floor;
    private int feet;
    private int charge;
    private String description;
    private ImagesDTO imageOne;
    
    ConfirmDTO confirmDTO;
	private List<ImagesDTO> imagesList;
	public void addImage(ImagesDTO imageDTO) {
		if (imagesList == null) {
			imagesList = new ArrayList<>();
		}
		imagesList.add(imageDTO);
	}
}
