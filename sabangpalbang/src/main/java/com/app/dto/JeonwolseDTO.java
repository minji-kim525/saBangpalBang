package com.app.dto;

import lombok.Data;

@Data
public class JeonwolseDTO {
    private int transaction_price_id;
    private int property_type;
    private int property_type_id;
    private int regional_cd;
    private int dong;
    private int jibun;
    private String apartment_name;
    private int floor;
    private int deposit;
    private int deal_amount;
    private int deal_year;
    private int deal_month;
    private int deal_day;
}
