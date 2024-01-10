package com.app.dto;

import lombok.Data;

@Data
public class ConfirmDTO {
    private int confirm_id;
    private int confirm_check;
    private int ps_service_type=1;
    private int property_service_id;
    
    public ConfirmDTO(int confirm_check,int property_service_id) {
    	
    	this.confirm_check=confirm_check;
    	this.property_service_id=property_service_id;
    }
}