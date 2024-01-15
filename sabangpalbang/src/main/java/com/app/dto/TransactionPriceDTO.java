package com.app.dto;

import lombok.Data;

@Data
public class TransactionPriceDTO {
	private int transaction_price_id;
    private int regional_cd;
    private String dong;
    private String jibun;
    private String apartment_name;
    private int floor;
    private int deal_amount;
    private int deal_year;
    private int deal_month;
    private int deal_day;
    private int dong_cd;
    private int apart_cd;
    
    PropertyTypeDTO property_type_id;

}
