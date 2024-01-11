package com.app.property.dto;

import lombok.Data;

@Data
public class TransactionGraphDTO {
	private String address;
	private String pname;
	private String dong;
	private String apartment_name;
	private int deal_amount;
	private int deal_year;
}
