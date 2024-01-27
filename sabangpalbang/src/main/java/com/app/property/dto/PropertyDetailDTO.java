package com.app.property.dto;
import java.sql.Date;
import java.util.List;

import com.app.dto.ConfirmDTO;
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
	private Date move_date;
	private String description;
	private int property_type_id;
	private int charge;
	private int p_service_type;
	private int ps_service_type;
    private String telephone;
    private int month_price;

	private List<ImagesDTO> images;
	
	public String getAddress() {
        return address;
    }
	public String getPname() {
		return pname;
	}
}
